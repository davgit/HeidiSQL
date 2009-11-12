unit tabletools;


// -------------------------------------
// Table-diagnostics
// -------------------------------------


interface

uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls, ComCtrls, Buttons, Dialogs,
  WideStrings, WideStrUtils, VirtualTrees, ExtCtrls, mysql_connection, Contnrs, Graphics, TntStdCtrls;

type
  TfrmTableTools = class(TForm)
    btnClose: TButton;
    pnlTop: TPanel;
    TreeObjects: TVirtualStringTree;
    spltHorizontally: TSplitter;
    pnlRight: TPanel;
    ResultGrid: TVirtualStringTree;
    lblResults: TLabel;
    PageControlTools: TPageControl;
    tabMaintenance: TTabSheet;
    comboOperation: TComboBox;
    lblOperation: TLabel;
    chkQuick: TCheckBox;
    chkFast: TCheckBox;
    chkMedium: TCheckBox;
    chkExtended: TCheckBox;
    chkChanged: TCheckBox;
    btnExecuteMaintenance: TButton;
    chkUseFrm: TCheckBox;
    lblOptions: TLabel;
    btnHelp: TButton;
    tabFind: TTabSheet;
    lblFindText: TLabel;
    memoFindText: TTntMemo;
    btnFindText: TButton;
    comboDataTypes: TComboBox;
    lblDataTypes: TLabel;
    pnlSkipLargeTables: TPanel;
    lblSkipLargeTables: TLabel;
    editSkipLargeTables: TEdit;
    udSkipLargeTables: TUpDown;
    lblSkipLargeTablesMB: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure TreeObjectsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: WideString);
    procedure TreeObjectsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
    procedure TreeObjectsGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
      Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
    procedure TreeObjectsInitChildren(Sender: TBaseVirtualTree; Node: PVirtualNode; var ChildCount: Cardinal);
    procedure comboOperationChange(Sender: TObject);
    procedure ExecuteOperation(Sender: TObject);
    procedure ResultGridInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
    procedure ResultGridGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure ResultGridGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: WideString);
    procedure TreeObjectsChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure ResultGridHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure ResultGridCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
      Column: TColumnIndex; var Result: Integer);
    procedure ResultGridPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure ValidateControls(Sender: TObject);
  private
    { Private declarations }
    FResults: TObjectList;
    FRealResultCounter: Integer;
    procedure ProcessTableNode(Sender: TObject; Node: PVirtualNode);
    procedure AddResults(SQL: WideString);
    procedure AddNotes(Col1, Col2, Col3, Col4: WideString);
    procedure UpdateResultGrid;
  public
    { Public declarations }
    SelectedTables: TWideStringList;
  end;


implementation

uses main, helpers, mysql_structures;

const
  STRSKIPPED = 'Skipped - ';

{$R *.DFM}


procedure TfrmTableTools.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  // Restore GUI setup
  Width := GetRegValue(REGNAME_TOOLSWINWIDTH, Width);
  Height := GetRegValue(REGNAME_TOOLSWINHEIGHT, Height);
  TreeObjects.Width := GetRegValue(REGNAME_TOOLSTREEWIDTH, TreeObjects.Width);
  memoFindText.Text := Utf8Decode(GetRegValue(REGNAME_TOOLSFINDTEXT, ''));
  comboDatatypes.Items.Add('All data types');
  for i:=Low(DatatypeCategories) to High(DatatypeCategories) do
    comboDatatypes.Items.Add(DatatypeCategories[i].Name);
  comboDatatypes.ItemIndex := GetRegValue(REGNAME_TOOLSDATATYPE, 0);
  udSkipLargeTables.Position := GetRegValue(REGNAME_TOOLSSKIPMB, udSkipLargeTables.Position);
  SetWindowSizeGrip( Self.Handle, True );
  InheritFont(Font);
  FixVT(TreeObjects);
  FixVT(ResultGrid);
  FResults := TObjectList.Create;
  SelectedTables := TWideStringList.Create;
end;


procedure TfrmTableTools.FormDestroy(Sender: TObject);
begin
  // Save GUI setup
  OpenRegistry;
  MainReg.WriteInteger( REGNAME_TOOLSWINWIDTH, Width );
  MainReg.WriteInteger( REGNAME_TOOLSWINHEIGHT, Height );
  MainReg.WriteInteger( REGNAME_TOOLSTREEWIDTH, TreeObjects.Width);
  MainReg.WriteString( REGNAME_TOOLSFINDTEXT, Utf8Encode(memoFindText.Text));
  MainReg.WriteInteger( REGNAME_TOOLSSKIPMB, udSkipLargeTables.Position);
  MainReg.WriteInteger( REGNAME_TOOLSDATATYPE, comboDatatypes.ItemIndex);
end;


procedure TfrmTableTools.FormShow(Sender: TObject);
var
  DBNode, TableNode, FirstChecked: PVirtualNode;
begin
  // When this form is displayed the second time, databases may be deleted or filtered.
  // Also, checked nodes must be unchecked and unchecked nodes may need to be checked.
  TreeObjects.Clear;
  TreeObjects.RootNodeCount := Mainform.DBtree.RootNodeCount;

  DBNode := TreeObjects.GetFirstChild(TreeObjects.GetFirst);
  while Assigned(DBNode) do begin
    if TreeObjects.Text[DBNode, 0] = Mainform.ActiveDatabase then begin
      if SelectedTables.Count = 0 then begin
        // Preselect active database
        DBNode.CheckState := csCheckedNormal;
      end else begin
        DBNode.CheckState := csMixedNormal;
        // Expand db node so checked table nodes are visible
        TreeObjects.Expanded[DBNode] := true;
        TableNode := TreeObjects.GetFirstChild(DBNode);
        while Assigned(TableNode) do begin
          if SelectedTables.IndexOf(TreeObjects.Text[TableNode, 0]) > -1 then
            TableNode.CheckState := csCheckedNormal;
          TableNode := TreeObjects.GetNextSibling(TableNode);
        end;
      end;
    end;
    DBNode := TreeObjects.GetNextSibling(DBNode);
  end;

  FirstChecked := TreeObjects.GetFirstChecked;
  if Assigned(FirstChecked) then
    TreeObjects.ScrollIntoView(FirstChecked, True);
  // CHECKSUM available since MySQL 4.1.1
  if Mainform.Connection.ServerVersionInt < 40101 then
    comboOperation.Items[comboOperation.Items.IndexOf('Checksum')] := 'Checksum ('+STR_NOTSUPPORTED+')';
  comboOperation.OnChange(Sender);
end;


procedure TfrmTableTools.comboOperationChange(Sender: TObject);
var
  op: String;
begin
  // Only enable available options
  op := LowerCase(comboOperation.Text);
  chkQuick.Enabled := (op = 'check') or (op = 'checksum') or (op = 'repair');
  chkFast.Enabled := op = 'check';
  chkMedium.Enabled := op = 'check';
  chkExtended.Enabled := (op = 'check') or (op = 'checksum') or (op = 'repair');
  chkChanged.Enabled := op = 'check';
  chkUseFrm.Enabled := op = 'repair';
  ValidateControls(Sender);
end;


procedure TfrmTableTools.ValidateControls(Sender: TObject);
var
  SomeChecked: Boolean;
begin
  SomeChecked := TreeObjects.CheckedCount > 0;
  btnExecuteMaintenance.Enabled := (Pos(STR_NOTSUPPORTED, comboOperation.Text) = 0) and SomeChecked;
  btnFindText.Enabled := SomeChecked and (memoFindText.Text <> '');
  // CHECKSUM's options are mutually exclusive
  if comboOperation.Text = 'Checksum' then begin
    if (Sender = chkExtended) and chkExtended.Checked then chkQuick.Checked := False
    else if chkQuick.Checked then chkExtended.Checked := False;
  end;
end;


procedure TfrmTableTools.TreeObjectsChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  ValidateControls(Sender);
end;


procedure TfrmTableTools.TreeObjectsGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
begin
  Mainform.DBtreeGetImageIndex(Sender, Node, Kind, Column, Ghosted, ImageIndex);
end;


procedure TfrmTableTools.TreeObjectsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
begin
  Mainform.DBtreeGetText(Sender, Node, Column, TextType, CellText);
end;


procedure TfrmTableTools.TreeObjectsInitChildren(Sender: TBaseVirtualTree; Node: PVirtualNode;
  var ChildCount: Cardinal);
begin
  Mainform.DBtreeInitChildren(Sender, Node, ChildCount);
end;


procedure TfrmTableTools.TreeObjectsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Results: TMySQLQuery;
begin
  // Attach a checkbox to all nodes
  Mainform.DBtreeInitNode(Sender, ParentNode, Node, InitialStates);
  Node.CheckType := ctTriStateCheckBox;
  Node.CheckState := csUncheckedNormal;
  case Sender.GetNodeLevel(Node) of
    2: begin
      Results := Mainform.FetchDbTableList(Mainform.Databases[ParentNode.Index]);
      Results.RecNo := Node.Index;
      // No checkbox for stored routines
      if not (GetDBObjectType(Results) in [lntTable, lntCrashedTable, lntView]) then
        Node.CheckType := ctNone
    end;
  end;
  ValidateControls(Sender);
end;


procedure TfrmTableTools.btnHelpClick(Sender: TObject);
begin
  Mainform.CallSQLHelpWithKeyword(UpperCase(comboOperation.Text) + ' TABLE');
end;


procedure TfrmTableTools.ExecuteOperation(Sender: TObject);
var
  DBNode, TableNode: PVirtualNode;
begin
  Screen.Cursor := crHourGlass;
  ResultGrid.Clear;
  FResults.Clear;
  FRealResultCounter := 0;
  TreeObjects.SetFocus;
  DBNode := TreeObjects.GetFirstChild(TreeObjects.GetFirst);
  while Assigned(DBNode) do begin
    if not (DBNode.CheckState in [csUncheckedNormal, csUncheckedPressed]) then begin
      TableNode := TreeObjects.GetFirstChild(DBNode);
      while Assigned(TableNode) do begin
        ProcessTableNode(Sender, TableNode);
        TableNode := TreeObjects.GetNextSibling(TableNode);
      end;
    end;
    DBNode := TreeObjects.GetNextSibling(DBNode);
  end;
  Screen.Cursor := crDefault;
end;


procedure TfrmTableTools.ProcessTableNode(Sender: TObject; Node: PVirtualNode);
var
  SQL, db, table, QuotedTable: WideString;
  TableSize, RowsInTable: Int64;
  Results: TMySQLQuery;
  i: Integer;
  HasSelectedDatatype: Boolean;
begin
  // Prepare SQL for one table node
  if (csCheckedNormal in [Node.CheckState, Node.Parent.CheckState]) and (Node.CheckType <> ctNone) then begin
    db := TreeObjects.Text[Node.Parent, 0];
    table := TreeObjects.Text[Node, 0];
    QuotedTable := Mainform.mask(db)+'.'+Mainform.mask(table);
    // Find table in cashed dataset and check its size - perhaps it has to be skipped
    TableSize := 0;
    RowsInTable := 0;
    Results := Mainform.FetchDbTableList(db);
    while not Results.Eof do begin
      if (Results.Col(DBO_NAME) = table)
        and (GetDBObjectType(Results) in [lntTable, lntCrashedTable]) then begin
        TableSize := GetTableSize(Results);
        RowsInTable := MakeInt(Results.Col(DBO_ROWS));
        // Avoid division by zero in below SQL
        if RowsInTable = 0 then
          RowsInTable := 1;
        break;
      end;
      Results.Next;
    end;
    if (udSkipLargeTables.Position = 0) or ((TableSize div SIZE_MB) < udSkipLargeTables.Position) then try
      if Sender = btnExecuteMaintenance then begin
        SQL := UpperCase(comboOperation.Text) + ' TABLE ' + QuotedTable;
        if chkQuick.Enabled and chkQuick.Checked then SQL := SQL + ' QUICK';
        if chkFast.Enabled and chkFast.Checked then SQL := SQL + ' FAST';
        if chkMedium.Enabled and chkMedium.Checked then SQL := SQL + ' MEDIUM';
        if chkExtended.Enabled and chkExtended.Checked then SQL := SQL + ' EXTENDED';
        if chkChanged.Enabled and chkChanged.Checked then SQL := SQL + ' CHANGED';
        if chkUseFrm.Enabled and chkUseFrm.Checked then SQL := SQL + ' USE_FRM';
      end else if Sender = btnFindText then begin
        Results := Mainform.Connection.GetResults('SHOW COLUMNS FROM '+QuotedTable);
        SQL := '';
        while not Results.Eof do begin
          HasSelectedDatatype := comboDatatypes.ItemIndex = 0;
          if not HasSelectedDatatype then for i:=Low(Datatypes) to High(Datatypes) do begin
            HasSelectedDatatype := (LowerCase(getFirstWord(Results.Col('Type'))) = LowerCase(Datatypes[i].Name))
              and (Integer(Datatypes[i].Category)+1 = comboDatatypes.ItemIndex);
            if HasSelectedDatatype then
              break;
          end;
          if HasSelectedDatatype then
            SQL := SQL + Mainform.mask(Results.Col('Field')) + ' LIKE ' + esc('%'+memoFindText.Text+'%') + ' OR ';
          Results.Next;
        end;
        if SQL <> '' then begin
          Delete(SQL, Length(SQL)-3, 3);
          SQL := 'SELECT '''+db+''' AS `Database`, '''+table+''' AS `Table`, COUNT(*) AS `Found rows`, '
            + 'CONCAT(ROUND(100 / '+IntToStr(RowsInTable)+' * COUNT(*), 1), ''%'') AS `Relevance` FROM '+QuotedTable+' WHERE '
            + SQL;
        end;
      end;
      if SQL <> '' then
        AddResults(SQL)
      else
        AddNotes(db, table, STRSKIPPED+'table doesn''t have columns of selected type ('+comboDatatypes.Text+').', '');
    except
      // The above SQL can easily throw an exception, e.g. if a table is corrupted.
      // In such cases we create a dummy row, including the error message
      on E:Exception do
        AddNotes(db, table, 'error', E.Message);
    end else begin
      AddNotes(db, table, STRSKIPPED+FormatByteNumber(TableSize), '');
    end;
  end;
end;


procedure TfrmTableTools.AddResults(SQL: WideString);
var
  i: Integer;
  Col: TVirtualTreeColumn;
  Row: TWideStringlist;
  Results: TMySQLQuery;
begin
  // Execute query and append results into grid
  Results := Mainform.Connection.GetResults(SQL);
  if Results = nil then
    Exit;

  // Add missing columns
  for i:=ResultGrid.Header.Columns.Count to Results.ColumnCount-1 do begin
    Col := ResultGrid.Header.Columns.Add;
    Col.Width := 130;
  end;
  // Remove superfluous columns
  for i:=ResultGrid.Header.Columns.Count-1 downto Results.ColumnCount do
    ResultGrid.Header.Columns[i].Free;
  // Set column header names
  for i:=0 to Results.ColumnCount-1 do begin
    Col := ResultGrid.Header.Columns[i];
    Col.Text := Results.ColumnNames[i];
    if Results.DataType(i).Category in [dtcInteger, dtcIntegerNamed, dtcReal] then
      Col.Alignment := taRightJustify
    else
      Col.Alignment := taLeftJustify;
  end;
  Results.First;
  while not Results.Eof do begin
    Row := TWideStringlist.Create;
    for i:=0 to Results.ColumnCount-1 do begin
      Row.Add(Results.Col(i));
    end;
    FResults.Add(Row);
    Results.Next;
  end;
  Results.Free;

  Inc(FRealResultCounter);
  lblResults.Caption := IntToStr(FRealResultCounter)+' results:';
  lblResults.Repaint;
  UpdateResultGrid;
end;


procedure TfrmTableTools.AddNotes(Col1, Col2, Col3, Col4: WideString);
var
  Row: TWideStringlist;
begin
  // Adds a row with non SQL results
  Row := TWideStringlist.Create;
  Row.Add(Col1);
  Row.Add(Col2);
  Row.Add(Col3);
  Row.Add(Col4);
  FResults.Add(Row);
  UpdateResultGrid;
end;


procedure TfrmTableTools.UpdateResultGrid;
begin
  // Refresh resultgrid
  ResultGrid.RootNodeCount := FResults.Count;
  ResultGrid.FocusedNode := ResultGrid.GetLast;
  ResultGrid.Selected[ResultGrid.FocusedNode] := True;
  ResultGrid.Repaint;
end;

procedure TfrmTableTools.ResultGridCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
  Column: TColumnIndex; var Result: Integer);
begin
  Mainform.vstCompareNodes(Sender, Node1, Node2, Column, Result);
end;

procedure TfrmTableTools.ResultGridGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TWideStringList);
end;


procedure TfrmTableTools.ResultGridInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: ^TWideStringList;
begin
  // Bind string list to node
  Data := Sender.GetNodeData(Node);
  Data^ := FResults[Node.Index] as TWideStringList;
end;


procedure TfrmTableTools.ResultGridPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
var
  VT: TVirtualStringTree;
  Msg: WideString;
begin
  // Red text color for errors, purple for notes, grey for skipped tables
  if not (vsSelected in Node.States) then begin
    VT := Sender as TVirtualStringTree;
    Msg := VT.Text[Node, 2];
    if LowerCase(Msg) = 'note' then
      TargetCanvas.Font.Color := clPurple
    else if LowerCase(Msg) = 'error' then
      TargetCanvas.Font.Color := clRed
    else if Pos(STRSKIPPED, Msg) > 0 then
      TargetCanvas.Font.Color := clGray;
  end;
end;

procedure TfrmTableTools.ResultGridGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: WideString);
var
  Data: ^TWideStringList;
begin
  if Column > NoColumn then begin
    Data := Sender.GetNodeData(Node);
    if Data^.Count > Column then
      CellText := Data^[Column]
    else
      CellText := '';
  end;
end;


procedure TfrmTableTools.ResultGridHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
begin
  // Header column clicked to sort
  Mainform.vstHeaderClick(Sender, HitInfo);
end;

end.
