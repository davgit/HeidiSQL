unit Main;


// -------------------------------------
// Main-window
// -------------------------------------

{$I compilers.inc}

interface

uses
  Windows, SysUtils, Classes, Graphics, GraphUtil, Forms, Controls, Menus, StdCtrls, Dialogs, Buttons,
  Messages, ExtCtrls, ComCtrls, StdActns, ActnList, ImgList, ToolWin, Clipbrd, SynMemo,
  SynEdit, SynEditTypes, SynEditKeyCmds, VirtualTrees, DateUtils,
  ShlObj, SynEditMiscClasses, SynEditSearch, SynEditRegexSearch, SynCompletionProposal, SynEditHighlighter,
  SynHighlighterSQL, Tabs, SynUnicode, SynRegExpr, WideStrUtils, ExtActns,
  CommCtrl, Contnrs, Generics.Collections, SynEditExport, SynExportHTML, Math,
  routine_editor, trigger_editor, event_editor, options, EditVar, helpers, createdatabase, table_editor,
  TableTools, View, Usermanager, SelectDBObject, connections, sqlhelp, mysql_connection,
  mysql_api, insertfiles, searchreplace, loaddata, copytable, VTHeaderPopup;


type
  TQueryTab = class(TObject)
    Number: Integer;
    CloseButton: TSpeedButton;
    pnlMemo: TPanel;
    pnlHelpers: TPanel;
    lboxHelpers: TListBox;
    HelperListSelectedItems: Array[0..3] of Array of Integer;
    tabsetHelpers: TTabSet;
    Memo: TSynMemo;
    MemoFilename: String;
    MemoLineBreaks: TLineBreaks;
    spltHelpers: TSplitter;
    spltQuery: TSplitter;
    LabelResultInfo: TLabel;
    Grid: TVirtualStringTree;
    TabSheet: TTabSheet;
    GridResult: TGridResult;
    FilterText: String;
  end;

  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    Help1: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    menuAbout: TMenuItem;
    Edit1: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    actCopy: TAction;
    actPaste: TAction;
    actNewWindow: TAction;
    actExitApplication: TAction;
    Extra1: TMenuItem;
    FlushUserPrivileges1: TMenuItem;
    MenuCopyCSV: TMenuItem;
    MenuExport: TMenuItem;
    N5: TMenuItem;
    MenuImportTextFile: TMenuItem;
    Flush1: TMenuItem;
    MenuFlushLogs: TMenuItem;
    MenuFlushHosts: TMenuItem;
    MenuFlushTables: TMenuItem;
    MenuFlushTableswithreadlock: TMenuItem;
    MenuFlushStatus: TMenuItem;
    N6: TMenuItem;
    MenuUserManager: TMenuItem;
    MenuPreferences: TMenuItem;
    N7a: TMenuItem;
    menuReadme: TMenuItem;
    actUserManager: TAction;
    actAboutBox: TAction;
    actMaintenance: TAction;
    menuMaintenance: TMenuItem;
    ImExport1: TMenuItem;
    CopyContentsasHTMLTable1: TMenuItem;
    actCopyAsHTML: TAction;
    actCopyAsCSV: TAction;
    menuWebsite: TMenuItem;
    N9: TMenuItem;
    N11: TMenuItem;
    actPrintList: TAction;
    actCopyTable: TAction;
    ControlBar1: TControlBar;
    ToolBarStandard: TToolBar;
    ToolButton9: TToolButton;
    tlbSep1: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton12: TToolButton;
    tlbSep2: TToolButton;
    ButtonRefresh: TToolButton;
    ButtonImportTextfile: TToolButton;
    ButtonExport: TToolButton;
    ButtonUserManager: TToolButton;
    ToolBarData: TToolBar;
    actUndo: TEditUndo;
    ToolButton14: TToolButton;
    actExecuteQuery: TAction;
    actExecuteSelection: TAction;
    SaveDialog2: TSaveDialog;
    ExportSettings1: TMenuItem;
    Importsettings1: TMenuItem;
    OpenDialog2: TOpenDialog;
    menuSupportForum: TMenuItem;
    actCopyAsXML: TAction;
    actExportData: TAction;
    Exportdata1: TMenuItem;
    CopyasXMLdata1: TMenuItem;
    actExecuteLine: TAction;
    actHTMLview: TAction;
    actInsertFiles: TAction;
    InsertfilesintoBLOBfields1: TMenuItem;
    actExportTables: TAction;
    actDropObjects: TAction;
    actLoadSQL: TAction;
    ImportSQL1: TMenuItem;
    menuConnections: TPopupMenu;
    menuBugtracker: TMenuItem;
    menuFeaturetracker: TMenuItem;
    menuDownload: TMenuItem;
    btnSQLHelp: TToolButton;
    menuSQLHelp1: TMenuItem;
    N8a: TMenuItem;
    Import1: TMenuItem;
    tlbSep6: TToolButton;
    menuUpdateCheck: TMenuItem;
    ImageListMain: TImageList;
    actCreateView: TAction;
    ToolButton3: TToolButton;
    actDataFirst: TAction;
    actDataLast: TAction;
    actDataInsert: TAction;
    actDataDelete: TAction;
    actDataPostChanges: TAction;
    ToolButton4: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    actCreateTable: TAction;
    actEmptyTables: TAction;
    actCreateDatabase: TAction;
    actSQLhelp: TAction;
    actRefresh: TAction;
    actImportCSV: TAction;
    actCut: TAction;
    Cut1: TMenuItem;
    actExportSettings: TAction;
    actImportSettings: TAction;
    actSelectTreeBackground: TAction;
    actPreferences: TAction;
    actFlushHosts: TAction;
    actFlushLogs: TAction;
    actFlushPrivileges: TAction;
    actFlushTables: TAction;
    actFlushTableswithreadlock: TAction;
    actFlushStatus: TAction;
    actUpdateCheck: TAction;
    actWebMainsite: TAction;
    actWebDownloadpage: TAction;
    actWebForum: TAction;
    actWebIssuetracker: TAction;
    actWebChangelog: TAction;
    actReadme: TAction;
    actSaveSQL: TAction;
    actSaveSQLAs: TAction;
    actSaveSQLselection: TAction;
    actSaveSQLSnippet: TAction;
    actSaveSQLSelectionSnippet: TAction;
    actClearQueryEditor: TAction;
    actClearFilterEditor: TAction;
    actApplyFilter: TAction;
    actQueryStopOnErrors: TAction;
    actQueryWordWrap: TAction;
    actQueryFind: TAction;
    actQueryReplace: TAction;
    ToolBarQuery: TToolBar;
    btnExecuteQuery: TToolButton;
    btnLoadSQL: TToolButton;
    btnSaveSQL: TToolButton;
    btnSaveSQLSnippet: TToolButton;
    btnQueryFind: TToolButton;
    btnQueryReplace: TToolButton;
    btnStopOnErrors: TToolButton;
    btnQueryWordwrap: TToolButton;
    PopupQueryLoad: TPopupMenu;
    actSetDelimiter: TAction;
    btnSetDelimiter: TToolButton;
    actDataCancelChanges: TAction;
    ToolButton1: TToolButton;
    actRemoveFilter: TAction;
    actCopyAsSQL: TAction;
    CopyAsSQLdata: TMenuItem;
    panelTop: TPanel;
    pnlLeft: TPanel;
    DBtree: TVirtualStringTree;
    comboOnlyDBs: TComboBox;
    Splitter1: TSplitter;
    PageControlMain: TPageControl;
    tabData: TTabSheet;
    tabDatabase: TTabSheet;
    splitterTopBottom: TSplitter;
    tabQuery: TTabSheet;
    popupDB: TPopupMenu;
    menuRefreshDB: TMenuItem;
    tabHost: TTabSheet;
    PageControlHost: TPageControl;
    tabVariables: TTabSheet;
    tabProcessList: TTabSheet;
    ListVariables: TVirtualStringTree;
    ListProcesses: TVirtualStringTree;
    popupHost: TPopupMenu;
    Kill1: TMenuItem;
    ListTables: TVirtualStringTree;
    Refresh1: TMenuItem;
    pnlDataTop: TPanel;
    pnlQueryMemo: TPanel;
    SynSQLSyn1: TSynSQLSyn;
    SynMemoQuery: TSynMemo;
    spltQuery: TSplitter;
    OpenDialog1: TOpenDialog;
    TimerHostUptime: TTimer;
    N5a: TMenuItem;
    popupDataGrid: TPopupMenu;
    Refresh3: TMenuItem;
    popupResultGrid: TPopupMenu;
    Copyrecords1: TMenuItem;
    CopyasCSVData1: TMenuItem;
    N9a: TMenuItem;
    LabelResultinfo: TLabel;
    TimerConnected: TTimer;
    N12: TMenuItem;
    popupSqlLog: TPopupMenu;
    Clear2: TMenuItem;
    Copy1: TMenuItem;
    N15: TMenuItem;
    N17: TMenuItem;
    CopycontentsasHTML1: TMenuItem;
    CopycontentsasHTML2: TMenuItem;
    Copy3: TMenuItem;
    Paste2: TMenuItem;
    N4a: TMenuItem;
    DataGrid: TVirtualStringTree;
    QueryGrid: TVirtualStringTree;
    Copytableas1: TMenuItem;
    Delete1: TMenuItem;
    N6a: TMenuItem;
    QF1: TMenuItem;
    QF2: TMenuItem;
    menuQuickFilter: TMenuItem;
    QF3: TMenuItem;
    QF4: TMenuItem;
    N7: TMenuItem;
    DropFilter1: TMenuItem;
    PrintList2: TMenuItem;
    N1a: TMenuItem;
    SynMemoFilter: TSynMemo;
    TimerRefresh: TTimer;
    Saveastextfile1: TMenuItem;
    QF7: TMenuItem;
    QF5: TMenuItem;
    QF6: TMenuItem;
    QF8: TMenuItem;
    QF10: TMenuItem;
    QF11: TMenuItem;
    QF9: TMenuItem;
    QF12: TMenuItem;
    CopyasXMLdata3: TMenuItem;
    CopyasXMLdata2: TMenuItem;
    Exportdata3: TMenuItem;
    Exportdata2: TMenuItem;
    SaveDialogExportData: TSaveDialog;
    N11a: TMenuItem;
    Copy4: TMenuItem;
    N14: TMenuItem;
    DataInsertDateTime: TMenuItem;
    DataTimestamp: TMenuItem;
    DataDateTime: TMenuItem;
    DataTime: TMenuItem;
    DataDate: TMenuItem;
    DataYear: TMenuItem;
    ViewasHTML1: TMenuItem;
    HTMLview1: TMenuItem;
    InsertfilesintoBLOBfields3: TMenuItem;
    N19: TMenuItem;
    setNULL1: TMenuItem;
    menuExporttables: TMenuItem;
    popupListHeader: TVTHeaderPopupMenu;
    SynCompletionProposal: TSynCompletionProposal;
    OpenDialogSQLFile: TOpenDialog;
    SaveDialogSQLFile: TSaveDialog;
    SynEditSearch1: TSynEditSearch;
    SynEditRegexSearch1: TSynEditRegexSearch;
    tabCommandStats: TTabSheet;
    ListCommandStats: TVirtualStringTree;
    QF13: TMenuItem;
    QF14: TMenuItem;
    QF15: TMenuItem;
    QF16: TMenuItem;
    QF17: TMenuItem;
    QF18: TMenuItem;
    QF19: TMenuItem;
    N21: TMenuItem;
    pnlQueryHelpers: TPanel;
    tabsetQueryHelpers: TTabSet;
    lboxQueryHelpers: TListBox;
    popupQuery: TPopupMenu;
    MenuRun: TMenuItem;
    MenuRunSelection: TMenuItem;
    MenuRunLine: TMenuItem;
    MenuItem1: TMenuItem;
    menucopy: TMenuItem;
    menupaste: TMenuItem;
    menuload: TMenuItem;
    menusave: TMenuItem;
    menuSaveSQL: TMenuItem;
    menuclear: TMenuItem;
    MenuFind: TMenuItem;
    MenuReplace: TMenuItem;
    MenuItem2: TMenuItem;
    lblDataTop: TLabel;
    spltQueryHelpers: TSplitter;
    N22: TMenuItem;
    N23: TMenuItem;
    menuSaveSelectionToFile: TMenuItem;
    menuSaveAsSnippet: TMenuItem;
    menuSaveSelectionAsSnippet: TMenuItem;
    popupQueryHelpers: TPopupMenu;
    menuDeleteSnippet: TMenuItem;
    menuHelp: TMenuItem;
    menuLoadSnippet: TMenuItem;
    menuInsertSnippetAtCursor: TMenuItem;
    menuExplore: TMenuItem;
    menuSQLhelp2: TMenuItem;
    menuSQLhelpData: TMenuItem;
    menuLogToFile: TMenuItem;
    menuOpenLogFolder: TMenuItem;
    tabStatus: TTabSheet;
    ListStatus: TVirtualStringTree;
    Splitter3: TSplitter;
    pnlProcessViewBox: TPanel;
    pnlProcessView: TPanel;
    SynMemoProcessView: TSynMemo;
    pnlFilterVT: TPanel;
    editFilterVT: TButtonedEdit;
    lblFilterVT: TLabel;
    lblFilterVTInfo: TLabel;
    menuEditVariable: TMenuItem;
    menuTreeExpandAll: TMenuItem;
    menuTreeCollapseAll: TMenuItem;
    tlbDataButtons: TToolBar;
    tbtnDataSorting: TToolButton;
    tbtnDataColumns: TToolButton;
    tbtnDataFilter: TToolButton;
    pnlFilter: TPanel;
    btnFilterApply: TButton;
    lblTableFilter: TLabel;
    editFilterSearch: TEdit;
    btnFilterClear: TButton;
    popupFilter: TPopupMenu;
    menuFilterCopy: TMenuItem;
    menuFilterPaste: TMenuItem;
    N8: TMenuItem;
    menuFilterApply: TMenuItem;
    menuFilterClear: TMenuItem;
    SynMemoSQLLog: TSynMemo;
    Insert1: TMenuItem;
    Cancelediting1: TMenuItem;
    DataPost1: TMenuItem;
    menuShowSizeColumn: TMenuItem;
    CopygriddataasSQL1: TMenuItem;
    CopygriddataasSQL2: TMenuItem;
    menuSelectBGColor: TMenuItem;
    actPreviousTab: TPreviousTab;
    actNextTab: TNextTab;
    Nexttab1: TMenuItem;
    Previoustab1: TMenuItem;
    menuConnectTo: TMenuItem;
    actSelectAll: TAction;
    actSelectAll1: TMenuItem;
    N13: TMenuItem;
    ProgressBarStatus: TProgressBar;
    menuRecentFilters: TMenuItem;
    comboRecentFilters: TComboBox;
    lblRecentFilters: TLabel;
    Copy2: TMenuItem;
    N26: TMenuItem;
    actSessionManager: TAction;
    Sessionmanager1: TMenuItem;
    actCreateRoutine: TAction;
    btnExit: TToolButton;
    lblSorryNoData: TLabel;
    menuPrint: TMenuItem;
    menuEditObject: TMenuItem;
    menuCreateObject: TMenuItem;
    menuDeleteObject: TMenuItem;
    menuMaintenance2: TMenuItem;
    menuEmptyTables: TMenuItem;
    actEditObject: TAction;
    menuCreateDB: TMenuItem;
    menuCreateTable: TMenuItem;
    menuCreateTableCopy: TMenuItem;
    menuCreateView: TMenuItem;
    menuCreateRoutine: TMenuItem;
    tabEditor: TTabSheet;
    popupRefresh: TPopupMenu;
    menuAutoRefreshSetInterval: TMenuItem;
    menuAutoRefresh: TMenuItem;
    popupMainTabs: TPopupMenu;
    menuNewQueryTab: TMenuItem;
    menuCloseTab: TMenuItem;
    actNewQueryTab: TAction;
    actCloseQueryTab: TAction;
    Newquerytab1: TMenuItem;
    Closetab1: TMenuItem;
    pnlRight: TPanel;
    btnCloseFilterPanel: TSpeedButton;
    actFilterPanel: TAction;
    actFindInVT1: TMenuItem;
    TimerFilterVT: TTimer;
    actFindTextOnServer: TAction;
    actFindTextOnServer1: TMenuItem;
    Findtextonserver1: TMenuItem;
    actBulkTableEdit: TAction;
    menuBulkTableEdit: TMenuItem;
    menuQueryHelpersGenerateInsert: TMenuItem;
    menuQueryHelpersGenerateUpdate: TMenuItem;
    menuQueryHelpersGenerateDelete: TMenuItem;
    actCreateTrigger: TAction;
    menuCreateTrigger: TMenuItem;
    menuQueryCut: TMenuItem;
    menuQuerySelectall: TMenuItem;
    actDataDuplicateRow: TAction;
    Duplicaterow1: TMenuItem;
    Bulktableeditor1: TMenuItem;
    actSelectInverse: TAction;
    Inverseselection1: TMenuItem;
    actDataResetSorting: TAction;
    Resetsorting1: TMenuItem;
    actReformatSQL: TAction;
    ReformatSQL1: TMenuItem;
    btnReformatSQL: TToolButton;
    ReformatSQL2: TMenuItem;
    menuQueryInsertFunction: TMenuItem;
    menuFilterInsertFunction: TMenuItem;
    actBlobAsText: TAction;
    btnBlobAsText: TToolButton;
    actQueryFindAgain: TAction;
    Search1: TMenuItem;
    Findtext1: TMenuItem;
    actQueryFindAgain1: TMenuItem;
    Replacetext1: TMenuItem;
    lblExplainProcess: TLabel;
    menuExplainProcess: TMenuItem;
    ToolButton2: TToolButton;
    tbtnDataShowAll: TToolButton;
    tbtnDataNext: TToolButton;
    actDataShowNext: TAction;
    actDataShowAll: TAction;
    SynExporterHTML1: TSynExporterHTML;
    QFvalues: TMenuItem;
    tabDatabases: TTabSheet;
    ListDatabases: TVirtualStringTree;
    menuFetchDBitems: TMenuItem;
    actRunRoutines: TAction;
    Runroutines1: TMenuItem;
    actCreateEvent: TAction;
    Event1: TMenuItem;
    procedure actCreateDBObjectExecute(Sender: TObject);
    procedure menuConnectionsPopup(Sender: TObject);
    procedure actExitApplicationExecute(Sender: TObject);
    procedure WMCopyData(var Msg: TWMCopyData); message WM_COPYDATA;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Startup;
    procedure DoAfterConnect;
    procedure DoDisconnect;
    procedure FormResize(Sender: TObject);
    procedure actUserManagerExecute(Sender: TObject);
    procedure actAboutBoxExecute(Sender: TObject);
    procedure actApplyFilterExecute(Sender: TObject);
    procedure actClearEditorExecute(Sender: TObject);
    procedure actTableToolsExecute(Sender: TObject);
    procedure actCopyAsHTMLExecute(Sender: TObject);
    procedure actCopyAsCSVExecute(Sender: TObject);
    procedure actPrintListExecute(Sender: TObject);
    procedure actCopyTableExecute(Sender: TObject);
    procedure ShowStatusMsg(Msg: String=''; PanelNr: Integer=6);
    function mask(str: String) : String;
    procedure actExecuteQueryExecute(Sender: TObject);
    procedure actExecuteSelectionExecute(Sender: TObject);
    procedure actCopyAsXMLExecute(Sender: TObject);
    procedure actCreateDatabaseExecute(Sender: TObject);
    procedure actDataCancelChangesExecute(Sender: TObject);
    procedure actExportDataExecute(Sender: TObject);
    procedure actExecuteLineExecute(Sender: TObject);
    procedure actHTMLviewExecute(Sender: TObject);
    procedure actInsertFilesExecute(Sender: TObject);
    procedure actDataDeleteExecute(Sender: TObject);
    procedure actDataFirstExecute(Sender: TObject);
    procedure actDataInsertExecute(Sender: TObject);
    procedure actDataLastExecute(Sender: TObject);
    procedure actDataPostChangesExecute(Sender: TObject);
    procedure actDropObjectsExecute(Sender: TObject);
    procedure actEmptyTablesExecute(Sender: TObject);
    procedure actExportSettingsExecute(Sender: TObject);
    procedure actFlushExecute(Sender: TObject);
    procedure actImportCSVExecute(Sender: TObject);
    procedure actImportSettingsExecute(Sender: TObject);
    procedure actLoadSQLExecute(Sender: TObject);
    procedure actNewWindowExecute(Sender: TObject);
    procedure actSessionManagerExecute(Sender: TObject);
    procedure actPreferencesExecute(Sender: TObject);
    procedure actQueryFindReplaceExecute(Sender: TObject);
    procedure actQueryStopOnErrorsExecute(Sender: TObject);
    procedure actQueryWordWrapExecute(Sender: TObject);
    procedure actReadmeExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actRemoveFilterExecute(Sender: TObject);
    procedure actSaveSQLExecute(Sender: TObject);
    procedure actSaveSQLAsExecute(Sender: TObject);
    procedure actSaveSQLSnippetExecute(Sender: TObject);
    procedure actSetDelimiterExecute(Sender: TObject);
    procedure actSQLhelpExecute(Sender: TObject);
    procedure actUpdateCheckExecute(Sender: TObject);
    procedure actWebbrowse(Sender: TObject);
    procedure actCopyAsSQLExecute(Sender: TObject);
    procedure actSelectTreeBackgroundExecute(Sender: TObject);
    procedure popupQueryPopup(Sender: TObject);
    procedure lboxQueryHelpersClick(Sender: TObject);
    procedure lboxQueryHelpersDblClick(Sender: TObject);
    procedure tabsetQueryHelpersChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure btnDataClick(Sender: TObject);
    procedure ListTablesChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure SynCompletionProposalAfterCodeCompletion(Sender: TObject;
      const Value: String; Shift: TShiftState; Index: Integer; EndToken: Char);
    procedure SynCompletionProposalCodeCompletion(Sender: TObject;
      var Value: String; Shift: TShiftState; Index: Integer; EndToken: Char);
    procedure SynCompletionProposalExecute(Kind: SynCompletionType;
      Sender: TObject; var CurrentInput: String; var x, y: Integer;
      var CanExecute: Boolean);
    procedure PageControlMainChange(Sender: TObject);
    procedure PageControlHostChange(Sender: TObject);
    procedure ValidateControls(Sender: TObject);
    procedure ValidateQueryControls(Sender: TObject);
    procedure RefreshQueryHelpers;
    procedure DataGridBeforePaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas);
    procedure LogSQL(Msg: String; Category: TMySQLLogCategory=lcInfo);
    procedure KillProcess(Sender: TObject);
    procedure ExecSQLClick(Sender: TObject; Selection: Boolean = false;
      CurrentLine: Boolean=false);
    procedure SynMemoQueryStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure TimerHostUptimeTimer(Sender: TObject);
    procedure ListTablesNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
        Column: TColumnIndex; NewText: String);
    procedure TimerConnectedTimer(Sender: TObject);
    procedure Clear2Click(Sender: TObject);
    procedure QuickFilterClick(Sender: TObject);
    procedure AutoRefreshSetInterval(Sender: TObject);
    procedure AutoRefreshToggle(Sender: TObject);
    procedure SynMemoQueryDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure SynMemoQueryDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure SynMemoQueryDropFiles(Sender: TObject; X, Y: Integer; AFiles: TStrings);
    procedure popupHostPopup(Sender: TObject);
    procedure Saveastextfile1Click(Sender: TObject);
    procedure popupDBPopup(Sender: TObject);
    procedure SaveDialogExportDataTypeChange(Sender: TObject);
    procedure popupDataGridPopup(Sender: TObject);
    procedure QFvaluesClick(Sender: TObject);
    procedure InsertDate(Sender: TObject);
    procedure setNULL1Click(Sender: TObject);
    function QueryLoad( filename: String; ReplaceContent: Boolean = true ): Boolean;
    procedure DataGridChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure DataGridCreateEditor(Sender: TBaseVirtualTree; Node: PVirtualNode;
        Column: TColumnIndex; out EditLink: IVTEditLink);
    procedure DataGridEditCancelled(Sender: TBaseVirtualTree; Column: TColumnIndex);
    procedure DataGridEdited(Sender: TBaseVirtualTree; Node: PVirtualNode; Column:
        TColumnIndex);
    procedure DataGridEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column:
        TColumnIndex; var Allowed: Boolean);
    procedure DataGridFocusChanging(Sender: TBaseVirtualTree; OldNode, NewNode:
        PVirtualNode; OldColumn, NewColumn: TColumnIndex; var Allowed: Boolean);
    procedure AnyGridGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column:
        TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure DataGridHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure AnyGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DataGridNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column:
        TColumnIndex; NewText: String);
    procedure AnyGridPaintText(Sender: TBaseVirtualTree; const TargetCanvas:
        TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    procedure menuDeleteSnippetClick(Sender: TObject);
    procedure menuExploreClick(Sender: TObject);
    procedure menuInsertSnippetAtCursorClick(Sender: TObject);
    procedure menuLoadSnippetClick(Sender: TObject);
    procedure vstGetNodeDataSize(Sender: TBaseVirtualTree; var
        NodeDataSize: Integer);
    procedure vstInitNode(Sender: TBaseVirtualTree; ParentNode, Node:
        PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
        Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure vstGetImageIndex(Sender: TBaseVirtualTree; Node:
        PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted:
        Boolean; var ImageIndex: Integer);
    procedure vstHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure vstCompareNodes(Sender: TBaseVirtualTree; Node1, Node2:
        PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vstHeaderDraggedOut(Sender: TVTHeader; Column: TColumnIndex;
        DropPosition: TPoint);
    procedure vstIncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: String;
      var Result: Integer);
    procedure DBtreeFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex);
    procedure DBtreeDblClick(Sender: TObject);
    procedure DBtreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
        Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var
        ImageIndex: Integer);
    procedure DBtreeGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize:
        Integer);
    procedure DBtreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column:
        TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure DBtreeInitChildren(Sender: TBaseVirtualTree; Node: PVirtualNode; var
        ChildCount: Cardinal);
    procedure DBtreeInitNode(Sender: TBaseVirtualTree; ParentNode, Node:
        PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure DBtreePaintText(Sender: TBaseVirtualTree; const TargetCanvas:
        TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    procedure editFilterSearchChange(Sender: TObject);
    procedure editFilterSearchEnter(Sender: TObject);
    procedure editFilterSearchExit(Sender: TObject);
    procedure menuLogToFileClick(Sender: TObject);
    procedure menuOpenLogFolderClick(Sender: TObject);
    procedure vstGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
        Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle; var
        HintText: String);
    procedure ListCommandStatsBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure ListTablesBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
      var ContentRect: TRect);
    procedure ListProcessesBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
      var ContentRect: TRect);
    procedure ListProcessesFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure editFilterVTChange(Sender: TObject);
    procedure ListVariablesDblClick(Sender: TObject);
    procedure menuEditVariableClick(Sender: TObject);
    procedure menuTreeCollapseAllClick(Sender: TObject);
    procedure menuTreeExpandAllClick(Sender: TObject);
    procedure SynMemoFilterStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure DataGridAfterCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
    procedure menuShowSizeColumnClick(Sender: TObject);
    procedure AnyGridBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure QueryGridFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure pnlQueryHelpersCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure pnlQueryMemoCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure DataGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure File1Click(Sender: TObject);
    procedure ListVariablesBeforePaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
    procedure ListStatusBeforePaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
    procedure ListProcessesBeforePaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
    procedure ListCommandStatsBeforePaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
    procedure ListTablesBeforePaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
    procedure ListTablesGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
      Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
    procedure ListTablesGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure ListTablesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure ListTablesInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstAfterPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
    procedure actCopyOrCutExecute(Sender: TObject);
    procedure actPasteExecute(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);
    procedure EnumerateRecentFilters;
    procedure LoadRecentFilter(Sender: TObject);
    procedure ListTablesEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure DBtreeChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure actEditObjectExecute(Sender: TObject);
    procedure ListTablesDblClick(Sender: TObject);
    procedure panelTopDblClick(Sender: TObject);
    procedure PageControlMainMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure actNewQueryTabExecute(Sender: TObject);
    procedure actCloseQueryTabExecute(Sender: TObject);
    procedure menuCloseQueryTab(Sender: TObject);
    procedure CloseQueryTab(PageIndex: Integer);
    procedure CloseButtonOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CloseButtonOnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    function GetMainTabAt(X, Y: Integer): Integer;
    procedure FixQueryTabCloseButtons;
    function ActiveQueryTab: TQueryTab;
    function ActiveQueryMemo: TSynMemo;
    function ActiveQueryHelpers: TListBox;
    function ActiveQueryTabset: TTabset;
    function QueryTabActive: Boolean;
    function IsQueryTab(PageIndex: Integer; IncludeFixed: Boolean): Boolean;
    procedure popupMainTabsPopup(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure comboOnlyDBsChange(Sender: TObject);
    procedure comboOnlyDBsExit(Sender: TObject);
    procedure comboOnlyDBsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
    procedure comboOnlyDBsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure comboOnlyDBsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actFilterPanelExecute(Sender: TObject);
    procedure TimerFilterVTTimer(Sender: TObject);
    procedure PageControlMainContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure menuQueryHelpersGenerateStatementClick(Sender: TObject);
    procedure actDataDuplicateRowExecute(Sender: TObject);
    procedure actSelectInverseExecute(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
      var Handled: Boolean);
    procedure actDataResetSortingExecute(Sender: TObject);
    procedure actReformatSQLExecute(Sender: TObject);
    procedure DBtreeFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure actBlobAsTextExecute(Sender: TObject);
    procedure SynMemoQueryReplaceText(Sender: TObject; const ASearch,
      AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction);
    procedure SynMemoQueryPaintTransient(Sender: TObject; Canvas: TCanvas;
      TransientType: TTransientType);
    procedure actQueryFindAgainExecute(Sender: TObject);
    procedure vstScroll(Sender: TBaseVirtualTree; DeltaX, DeltaY: Integer);
    procedure lblExplainProcessClick(Sender: TObject);
    procedure actDataShowNextExecute(Sender: TObject);
    procedure actDataShowAllExecute(Sender: TObject);
    procedure AnyGridInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure editFilterVTRightButtonClick(Sender: TObject);
    procedure DataGridFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex);
    procedure ListTablesKeyPress(Sender: TObject; var Key: Char);
    procedure DBtreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure ListDatabasesBeforePaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
    procedure ListDatabasesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure ListDatabasesInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
    procedure ListDatabasesGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure ListDatabasesBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
      var ContentRect: TRect);
    procedure menuFetchDBitemsClick(Sender: TObject);
    procedure ListDatabasesGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
    procedure ListDatabasesDblClick(Sender: TObject);
    procedure actRunRoutinesExecute(Sender: TObject);
  private
    FDelimiter: String;
    FileNameSessionLog: String;
    FileHandleSessionLog: Textfile;
    FLastMouseUpOnPageControl: Cardinal;
    FLastTabNumberOnMouseUp: Integer;
    FLastMouseDownCloseButton: TObject;
    // Filter text per tab for filter panel
    FilterTextDatabases,
    FilterTextVariables,
    FilterTextStatus,
    FilterTextProcessList,
    FilterTextCommandStats,
    FilterTextDatabase,
    FilterTextData: String;
    PreviousFocusedNode: PVirtualNode;
    FCmdlineFilenames: TStringlist;
    FCmdlineConnectionParams: TConnectionParameters;
    FCmdlineSessionName: String;
    FSearchReplaceExecuted: Boolean;
    procedure ParseCommandLineParameters(Parameters: TStringlist);
    procedure SetDelimiter(Value: String);
    procedure DisplayRowCountStats;
    procedure insertFunction(Sender: TObject);
    function GetActiveDatabase: String;
    function GetSelectedTable: TDBObject;
    procedure SetSelectedDatabase(db: String);
    procedure ToggleFilterPanel(ForceVisible: Boolean = False);
    procedure AutoCalcColWidth(Tree: TVirtualStringTree; Column: TColumnIndex);
    procedure PlaceObjectEditor(Obj: TDBObject);
    procedure SetTabCaption(PageIndex: Integer; Text: String);
    function ConfirmTabClose(PageIndex: Integer): Boolean;
    procedure SaveQueryMemo(Tab: TQueryTab; Filename: String; OnlySelection: Boolean);
    procedure UpdateFilterPanel(Sender: TObject);
    procedure DatabaseChanged(Database: String);
    procedure DBObjectsCleared(Database: String);
    function GetBlobContent(Results: TMySQLQuery; Column: Integer): String;
    procedure DoSearchReplace;
    procedure UpdateLineCharPanel;
    procedure PaintColorBar(Value, Max: Extended; TargetCanvas: TCanvas; CellRect: TRect);
  public
    Connection: TMySQLConnection;
    SessionName: String;
    AllDatabases: TStringList;
    AllDatabasesDetails: TMySQLQuery;
    Databases: TStringList;
    btnAddTab: TSpeedButton;
    QueryTabs: TObjectList<TQueryTab>;
    DBObjectsMaxSize: Int64;
    DBObjectsMaxRows: Int64;
    ProcessListMaxTime: Int64;
    ActiveObjectEditor: TDBObjectEditor;

    // Cached forms
    TableToolsDialog: TfrmTableTools;
    UserManagerForm: TUserManagerForm;
    SelectDBObjectForm: TfrmSelectDBObject;
    SQLHelpForm: TfrmSQLhelp;
    OptionsForm: Toptionsform;
    SessionManager: TConnForm;
    CreateDatabaseForm: TCreateDatabaseForm;
    InsertFiles: TfrmInsertFiles;
    EditVariableForm: TfrmEditVariable;
    SearchReplaceDialog: TfrmSearchReplace;
    ImportTextfileDialog: Tloaddataform;
    CopyTableDialog: TCopyTableForm;

    // Virtual Tree data arrays
    VTRowDataListVariables,
    VTRowDataListStatus,
    VTRowDataListProcesses,
    VTRowDataListCommandStats: TVTreeDataArray;

    // Variables set by preferences dialog
    prefRememberFilters: Boolean;
    prefLogsqlnum: Integer;
    prefLogSqlWidth: Integer;
    prefDirnameSessionLogs: String;
    prefMaxColWidth: Integer;
    prefGridRowcountStep: Integer;
    prefGridRowcountMax: Integer;
    prefGridRowsLineCount: Word;
    prefCSVSeparator: String;
    prefCSVEncloser: String;
    prefCSVTerminator: String;
    prefLogToFile: Boolean;
    prefLogErrors: Boolean;
    prefLogUserSQL: Boolean;
    prefLogSQL: Boolean;
    prefLogInfos: Boolean;
    prefLogDebug: Boolean;
    prefEnableBinaryEditor: Boolean;
    prefEnableDatetimeEditor: Boolean;
    prefEnableEnumEditor: Boolean;
    prefEnableSetEditor: Boolean;
    prefEnableNullBG: Boolean;
    prefExportLocaleNumbers: Boolean;
    prefNullColorDefault: TColor;
    prefNullBG: TColor;
    prefDisplayBars: Boolean;
    prefBarColor: TColor;
    prefCompletionProposal: Boolean;

    // Data grid related stuff
    DataGridHiddenColumns: TStringList;
    DataGridSortColumns: TOrderColArray;
    DataGridWantedRowCount: Int64;
    DataGridDB: String;
    DataGridTable: String;
    DataGridFocusedCell: TStringList;
    DataGridFocusedNodeIndex: Int64;
    DataGridFocusedColumnName: String;
    DataGridHasChanges: Boolean;
    DataGridResult: TGridResult;
    DataGridFullRowMode: Boolean;
    SelectedTableCreateStatement: String;
    SelectedTableColumns: TTableColumnList;
    SelectedTableKeys: TTableKeyList;
    SelectedTableForeignKeys: TForeignKeyList;
    FilterPanelManuallyOpened: Boolean;

    // Executable file details
    AppVerMajor: Integer;
    AppVerMinor: Integer;
    AppVerRelease: Integer;
    AppVerRevision: Integer;
    AppVersion: String;
    AppDescription: String;

    // Common directories
    DirnameCommonAppData: String;
    DirnameUserAppData: String;
    DirnameSnippets: String;

    property Delimiter: String read FDelimiter write SetDelimiter;
    procedure CallSQLHelpWithKeyword( keyword: String );
    procedure AddOrRemoveFromQueryLoadHistory( filename: String;
      AddIt: Boolean = true; CheckIfFileExists: Boolean = true );
    procedure popupQueryLoadClick( sender: TObject );
    procedure FillPopupQueryLoad;
    procedure PopupQueryLoadRemoveAbsentFiles( sender: TObject );
    procedure SessionConnect(Sender: TObject);
    function InitConnection(Params: TConnectionParameters; Session: String): Boolean;
    function ActiveGrid: TVirtualStringTree;
    function GridResult(Grid: TBaseVirtualTree): TGridResult; overload;
    function GridResult(PageIndex: Integer): TGridResult; overload;
    property ActiveDatabase : String read GetActiveDatabase write SetSelectedDatabase;
    property SelectedTable : TDBObject read GetSelectedTable;
    procedure TestVTreeDataArray( P: PVTreeDataArray );
    function GetVTreeDataArray( VT: TBaseVirtualTree ): PVTreeDataArray;
    procedure ActivateFileLogging;
    procedure DeactivateFileLogging;
    procedure TrimSQLLog;
    function GetTreeNodeType(Tree: TBaseVirtualTree; Node: PVirtualNode): TListNodeType;
    function GetFocusedTreeNodeType: TListNodeType;
    procedure RefreshTree(DoResetTableCache: Boolean; SelectDatabase: String = '');
    procedure RefreshTreeDB(db: String; FocusObjectName: String=''; FocusObjectType: TListNodeType=lntNone);
    function FindDBNode(db: String): PVirtualNode;
    function GridPostUpdate(Sender: TBaseVirtualTree): Boolean;
    function GridPostInsert(Sender: TBaseVirtualTree): Boolean;
    function GridPostDelete(Sender: TBaseVirtualTree): Boolean;
    function DataGridPostUpdateOrInsert(Node: PVirtualNode): Boolean;
    procedure GridFinalizeEditing(Sender: TBaseVirtualTree);
    function GetWhereClause(Row: PGridRow; Columns: PGridColumns): String;
    function GetKeyColumns: TStringList;
    procedure DataGridInsertRow(CopyValuesFromNode: PVirtualNode);
    procedure DataGridCancel(Sender: TObject);
    procedure CalcNullColors;
    procedure HandleDataGridAttributes(RefreshingData: Boolean);
    function GetRegKeyTable: String;
    procedure SaveListSetup( List: TVirtualStringTree );
    procedure RestoreListSetup( List: TVirtualStringTree );
    procedure UpdateEditorTab;
    procedure SetWindowCaption;
    procedure OnMessageHandler(var Msg: TMsg; var Handled: Boolean);
    procedure DefaultHandler(var Message); override;
    function MaskMulti(str: String): String;
    procedure SelectDBObject(Text: String; NodeType: TListNodeType);
    procedure SetupSynEditors;
    procedure ParseSelectedTableStructure;
    function DataGridEnsureFullRow(Grid: TVirtualStringTree; Node: PVirtualNode): Boolean;
    procedure DataGridEnsureFullRows(Grid: TVirtualStringTree; SelectedOnly: Boolean);
    function DataGridRowHasFullData(Node: PVirtualNode): Boolean;
end;


var
  MainForm: TMainForm;
  SecondInstMsgId: UINT = 0;

const
  // Customized messages
  MSG_UPDATECHECK = WM_USER + 1;
  MSG_ABOUT = WM_USER + 2;

{$I const.inc}


implementation

uses
  About, printlist, mysql_structures, UpdateCheck, uVistaFuncs, runsqlfile,
  column_selection, data_sorting, grideditlinks;


{$R *.DFM}


procedure TMainForm.ShowStatusMsg(Msg: String=''; PanelNr: Integer=6);
begin
  // Show message in some statusbar panel
  StatusBar.Panels[PanelNr].Text := Msg;
  StatusBar.Repaint;
end;

procedure TMainForm.actExitApplicationExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.actFlushExecute(Sender: TObject);
var
  flushwhat: String;
begin
  flushwhat := UpperCase(TAction(Sender).Caption);
  delete(flushwhat, pos('&', flushwhat), 1);
  try
    Connection.Query('FLUSH ' + flushwhat);
    if Sender = actFlushTableswithreadlock then begin
      MessageDlg(
        'Tables have been flushed and read lock acquired.'#10 +
        'Perform backup or snapshot of table data files now.'#10 +
        'Press OK to unlock when done...',
        mtInformation, [mbOk], 0
      );
      Connection.Query('UNLOCK TABLES');
    end;
  except
    on E:Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i: Integer;
begin
  // Prompt on modified changes
  CanClose := True;
  // Unsaved changes in some query tab?
  for i:=0 to QueryTabs.Count-1 do begin
    CanClose := ConfirmTabClose(i+tabQuery.PageIndex);
    if not CanClose then
      Exit;
  end;
  // Unsaved modified table, trigger, view or routine?
  if Assigned(ActiveObjectEditor) then
    CanClose := not (ActiveObjectEditor.DeInit in [mrAbort, mrCancel]);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  filename, WinState: String;
  i: Integer;
begin
  // Destroy editors and dialogs. Must be done before connection gets closed, as some destructors do SQL stuff.
  FreeAndNil(ActiveObjectEditor);
  FreeAndNil(TableToolsDialog);
  FreeAndNil(UserManagerForm);
  FreeAndNil(SelectDBObjectForm);
  FreeAndNil(SQLHelpForm);
  FreeAndNil(OptionsForm);
  FreeAndNil(SessionManager);
  FreeAndNil(CreateDatabaseForm);
  FreeAndNil(SearchReplaceDialog);

  // Close database connection
  DoDisconnect;

  // Clearing query and browse data.
  SetLength(DataGridResult.Rows, 0);
  SetLength(DataGridResult.Columns, 0);

  // Save various settings
  OpenRegistry;
  MainReg.WriteInteger(REGNAME_TOOLBAR2LEFT, ToolBarStandard.Left);
  MainReg.WriteInteger(REGNAME_TOOLBAR2TOP, ToolBarStandard.Top);
  MainReg.WriteInteger(REGNAME_TOOLBARDATALEFT, ToolBarData.Left);
  MainReg.WriteInteger(REGNAME_TOOLBARDATATOP, ToolBarData.Top);
  MainReg.WriteInteger(REGNAME_TOOLBARQUERYLEFT, ToolBarQuery.Left);
  MainReg.WriteInteger(REGNAME_TOOLBARQUERYTOP, ToolBarQuery.Top);
  MainReg.WriteBool(REGNAME_STOPONERRORSINBATCH, actQueryStopOnErrors.Checked);
  MainReg.WriteBool(REGNAME_BLOBASTEXT, actBlobAsText.Checked);
  MainReg.WriteString( REGNAME_DELIMITER, Delimiter );
  MainReg.WriteInteger( REGNAME_QUERYMEMOHEIGHT, pnlQueryMemo.Height );
  MainReg.WriteInteger( REGNAME_QUERYHELPERSWIDTH, pnlQueryHelpers.Width );
  MainReg.WriteInteger( REGNAME_DBTREEWIDTH, pnlLeft.width );
  MainReg.WriteInteger( REGNAME_SQLOUTHEIGHT, SynMemoSQLLog.Height );
  MainReg.WriteBool(REGNAME_FILTERACTIVE, pnlFilterVT.Tag=Integer(True));
  // Convert set to string.
  case WindowState of
    wsMinimized: WinState := 'Minimized';
    wsMaximized: WinState := 'Maximized';
    else WinState := 'Normal';
  end;
  MainReg.WriteString(REGNAME_WINDOWSTATE, WinState);
  // Window dimensions are only valid when WindowState is normal.
  if WindowState = wsNormal then begin
    MainReg.WriteInteger(REGNAME_WINDOWLEFT, Left);
    MainReg.WriteInteger(REGNAME_WINDOWTOP, Top);
    MainReg.WriteInteger(REGNAME_WINDOWWIDTH, Width);
    MainReg.WriteInteger(REGNAME_WINDOWHEIGHT, Height);
  end else begin
    // Ensure Left + Top values are at least set to the right monitor area for the next start
    i := GetRegValue(REGNAME_WINDOWLEFT, Left);
    if (i < Monitor.Left) or (i > Monitor.Left+Monitor.Width) then
      MainReg.WriteInteger(REGNAME_WINDOWLEFT, Monitor.Left);
    i := GetRegValue(REGNAME_WINDOWTOP, Top);
    if (i < Monitor.Top) or (i > Monitor.Top+Monitor.Height) then
      MainReg.WriteInteger(REGNAME_WINDOWTOP, Monitor.Top);
  end;
  SaveListSetup(ListDatabases);
  SaveListSetup(ListVariables);
  SaveListSetup(ListStatus);
  SaveListSetup(ListProcesses);
  SaveListSetup(ListCommandStats);
  SaveListSetup(ListTables);

  filename := GetTempDir+'\'+APPNAME+'-preview.';
  if FileExists(filename+'html') then
    deletefile(filename+'html');
  if FileExists(filename+'jpg') then
    deletefile(filename+'jpg');
  if FileExists(filename+'gif') then
    deletefile(filename+'gif');
  if FileExists(filename+'bmp') then
    deletefile(filename+'bmp');
  if MainReg <> nil then begin
    MainReg.CloseKey;
    // Export settings into textfile in portable mode.
    HandlePortableSettings(False);
    MainReg.Free;
  end;
end;


{***
  OnCreate Event
  Important to set the windowstate here instead of in OnShow
  because possible windowstate-switching is done with an animation
  if set in Windows. This animation takes some milliseconds
  to complete and can be annoying.
}
procedure TMainForm.FormCreate(Sender: TObject);
var
  i: Integer;
  datafontname, WinState: String;
  datafontsize : Integer;
  DisableProcessWindowsGhostingProc: procedure;
  QueryTab: TQueryTab;
  Action: TAction;
  dwInfoSize,           // Size of VERSIONINFO structure
  dwVerSize,            // Size of Version Info Data
  dwWnd: DWORD;         // Handle for the size call.
  FI: PVSFixedFileInfo; // Delphi structure; see WINDOWS.PAS
  ptrVerBuf, Translation, Info: Pointer;
  DpiScaleFactor: Double;
begin
  caption := APPNAME;
  setLocales;

  // Detect version
  dwInfoSize := GetFileVersionInfoSize(PChar(Application.ExeName), dwWnd);
  GetMem(ptrVerBuf, dwInfoSize);
  GetFileVersionInfo(PChar(Application.ExeName), dwWnd, dwInfoSize, ptrVerBuf);
  VerQueryValue(ptrVerBuf, '\', Pointer(FI), dwVerSize );
  AppVerMajor := HiWord(FI.dwFileVersionMS);
  AppVerMinor := LoWord(FI.dwFileVersionMS);
  AppVerRelease := HiWord(FI.dwFileVersionLS);
  AppVerRevision := LoWord(FI.dwFileVersionLS);
  AppVersion := Format('%d.%d.%d.%d', [AppVerMajor, AppVerMinor, AppVerRelease, AppVerRevision]);
  // Fetch language code and file description
  VerQueryValue(ptrVerBuf,'\\VarFileInfo\\Translation', Translation, dwInfoSize);
  VerQueryValue(ptrVerBuf,
    PChar(Format('\\StringFileInfo\\%.4x%.4x\\%s',
      [LoWord(Longint(translation^)), HiWord(Longint(Translation^)), 'FileDescription'])),
    Info,
    dwInfoSize);
  SetString(AppDescription, PChar(Info), dwInfoSize-1);
  FreeMem(ptrVerBuf);

  // "All users" folder for HeidiSQL's data (All Users\Application Data)
  DirnameCommonAppData := GetShellFolder(CSIDL_COMMON_APPDATA) + '\' + APPNAME + '\';

  // User folder for HeidiSQL's data (<user name>\Application Data)
  DirnameUserAppData := GetShellFolder(CSIDL_APPDATA) + '\' + APPNAME + '\';
  // Ensure directory exists
  ForceDirectories(DirnameUserAppData);

  // Folder which contains snippet-files
  DirnameSnippets := DirnameCommonAppData + 'Snippets\';

  // SQLFiles-History
  FillPopupQueryLoad;

  Delimiter := GetRegValue(REGNAME_DELIMITER, DEFAULT_DELIMITER);

  // Delphi work around to force usage of Vista's default font (other OSes will be unaffected)
  SetVistaFonts(Font);
  InheritFont(Font);
  InheritFont(tabsetQueryHelpers.Font);
  InheritFont(SynCompletionProposal.Font);
  // Simulated link label, has non inherited blue font color
  InheritFont(lblExplainProcess.Font);

  StatusBar.Height := GetTextHeight(StatusBar.Font)+4;
  // Upscale panels in non-96-DPI mode
  DpiScaleFactor := Screen.PixelsPerInch / FORMS_DPI;
  for i:=StatusBar.Panels.Count-1 downto 1 do
    StatusBar.Panels[i].Width := Round(StatusBar.Panels[i].Width * DpiScaleFactor);

  // Enable auto completion in data tab, filter editor
  SynCompletionProposal.AddEditor(SynMemoFilter);

  // Fix node height on Virtual Trees for current DPI settings
  FixVT(DBTree);
  FixVT(ListDatabases);
  FixVT(ListVariables);
  FixVT(ListStatus);
  FixVT(ListProcesses);
  FixVT(ListCommandStats);
  FixVT(ListTables);

  // Window dimensions
  Left := GetRegValue(REGNAME_WINDOWLEFT, Left);
  Top := GetRegValue(REGNAME_WINDOWTOP, Top);
  Width := GetRegValue(REGNAME_WINDOWWIDTH, Width);
  Height := GetRegValue(REGNAME_WINDOWHEIGHT, Height);
  // Move window to left and/or top edge of monitor, if screen resolution has been decreased
  if Left > Monitor.Left+Monitor.Width-100 then
    Left := 0;
  if Top > Monitor.Top+Monitor.Height-100 then
    Top := 0;
  WinState := GetRegValue(REGNAME_WINDOWSTATE, '');
  if WinState = 'Minimized' then WindowState := wsMinimized else
  if WinState = 'Maximized' then WindowState := wsMaximized else
  WindowState := wsNormal;

  // Position of Toolbars
  ToolBarStandard.Left := GetRegValue(REGNAME_TOOLBAR2LEFT, ToolBarStandard.Left);
  ToolBarStandard.Top := GetRegValue(REGNAME_TOOLBAR2TOP, ToolBarStandard.Top);
  ToolBarData.Left := GetRegValue(REGNAME_TOOLBARDATALEFT, ToolBarData.Left);
  ToolBarData.Top := GetRegValue(REGNAME_TOOLBARDATATOP, ToolBarData.Top);
  ToolBarQuery.Left := GetRegValue(REGNAME_TOOLBARQUERYLEFT, ToolBarQuery.Left);
  ToolBarQuery.Top := GetRegValue(REGNAME_TOOLBARQUERYTOP, ToolBarQuery.Top);
  actQueryStopOnErrors.Checked := GetRegValue(REGNAME_STOPONERRORSINBATCH, DEFAULT_STOPONERRORSINBATCH);
  actBlobAsText.Checked := GetRegValue(REGNAME_BLOBASTEXT, DEFAULT_BLOBASTEXT);

  pnlQueryMemo.Height := GetRegValue(REGNAME_QUERYMEMOHEIGHT, pnlQueryMemo.Height);
  pnlQueryHelpers.Width := GetRegValue(REGNAME_QUERYHELPERSWIDTH, pnlQueryHelpers.Width);
  pnlLeft.Width := GetRegValue(REGNAME_DBTREEWIDTH, pnlLeft.Width);
  SynMemoSQLLog.Height := GetRegValue(REGNAME_SQLOUTHEIGHT, SynMemoSQLLog.Height);
  // Force status bar position to below log memo 
  StatusBar.Top := SynMemoSQLLog.Top + SynMemoSQLLog.Height;
  prefMaxColWidth := GetRegValue(REGNAME_MAXCOLWIDTH, DEFAULT_MAXCOLWIDTH);
  prefGridRowcountMax := GetRegValue(REGNAME_MAXTOTALROWS, DEFAULT_MAXTOTALROWS);
  prefGridRowcountStep := GetRegValue(REGNAME_ROWSPERSTEP, DEFAULT_ROWSPERSTEP);
  prefGridRowsLineCount := GetRegValue(REGNAME_GRIDROWSLINECOUNT, DEFAULT_GRIDROWSLINECOUNT);
  actDataShowNext.Hint := 'Show next '+FormatNumber(prefGridRowcountStep)+' rows ...';
  actAboutBox.Caption := 'About '+APPNAME+' '+AppVersion;
  // Fix registry entry from older versions which can have 0 here which makes no sense
  // since the autosetting was removed
  if prefMaxColWidth <= 0 then
    prefMaxColWidth := DEFAULT_MAXCOLWIDTH;
  prefLogsqlnum := GetRegValue(REGNAME_LOGSQLNUM, DEFAULT_LOGSQLNUM);
  prefLogSqlWidth := GetRegValue(REGNAME_LOGSQLWIDTH, DEFAULT_LOGSQLWIDTH);
  prefDirnameSessionLogs := GetRegValue(REGNAME_LOGDIR, DirnameUserAppData + 'Sessionlogs\');
  prefCSVSeparator := GetRegValue(REGNAME_CSV_SEPARATOR, DEFAULT_CSV_SEPARATOR);
  prefCSVEncloser := GetRegValue(REGNAME_CSV_ENCLOSER, DEFAULT_CSV_ENCLOSER);
  prefCSVTerminator := GetRegValue(REGNAME_CSV_TERMINATOR, DEFAULT_CSV_TERMINATOR);
  prefExportLocaleNumbers := GetRegValue(REGNAME_EXPORT_LOCALENUMBERS, DEFAULT_EXPORT_LOCALENUMBERS);
  prefRememberFilters := GetRegValue(REGNAME_REMEMBERFILTERS, DEFAULT_REMEMBERFILTERS);
  prefLogErrors := GetRegValue(REGNAME_LOG_ERRORS, DEFAULT_LOG_ERRORS);
  prefLogUserSQL := GetRegValue(REGNAME_LOG_USERSQL, DEFAULT_LOG_USERSQL);
  prefLogSQL := GetRegValue(REGNAME_LOG_SQL, DEFAULT_LOG_SQL);
  prefLogInfos := GetRegValue(REGNAME_LOG_INFOS, DEFAULT_LOG_INFOS);
  prefLogDebug := GetRegValue(REGNAME_LOG_DEBUG, DEFAULT_LOG_DEBUG);
  prefDisplayBars := GetRegValue(REGNAME_DISPLAYBARS, DEFAULT_DISPLAYBARS);
  prefBarColor := GetRegValue(REGNAME_BARCOLOR, DEFAULT_BARCOLOR);
  prefCompletionProposal := GetRegValue(REGNAME_COMPLETIONPROPOSAL, DEFAULT_COMPLETIONPROPOSAL);

  // Data-Font:
  datafontname := GetRegValue(REGNAME_DATAFONTNAME, DEFAULT_DATAFONTNAME);
  datafontsize := GetRegValue(REGNAME_DATAFONTSIZE, DEFAULT_DATAFONTSIZE);
  DataGrid.Font.Name := datafontname;
  QueryGrid.Font.Name := datafontname;
  DataGrid.Font.Size := datafontsize;
  QueryGrid.Font.Size := datafontsize;
  FixVT(DataGrid, prefGridRowsLineCount);
  FixVT(QueryGrid, prefGridRowsLineCount);
  // Load color settings
  DatatypeCategories[Integer(dtcInteger)].Color := GetRegValue(REGNAME_FIELDCOLOR_NUMERIC, DEFAULT_FIELDCOLOR_NUMERIC);
  DatatypeCategories[Integer(dtcReal)].Color := GetRegValue(REGNAME_FIELDCOLOR_NUMERIC, DEFAULT_FIELDCOLOR_NUMERIC);
  DatatypeCategories[Integer(dtcText)].Color := GetRegValue(REGNAME_FIELDCOLOR_TEXT, DEFAULT_FIELDCOLOR_TEXT);
  DatatypeCategories[Integer(dtcBinary)].Color := GetRegValue(REGNAME_FIELDCOLOR_BINARY, DEFAULT_FIELDCOLOR_BINARY);
  DatatypeCategories[Integer(dtcTemporal)].Color := GetRegValue(REGNAME_FIELDCOLOR_DATETIME, DEFAULT_FIELDCOLOR_DATETIME);
  DatatypeCategories[Integer(dtcIntegerNamed)].Color := GetRegValue(REGNAME_FIELDCOLOR_ENUM, DEFAULT_FIELDCOLOR_ENUM);
  DatatypeCategories[Integer(dtcSet)].Color := GetRegValue(REGNAME_FIELDCOLOR_SET, DEFAULT_FIELDCOLOR_SET);
  DatatypeCategories[Integer(dtcSetNamed)].Color := GetRegValue(REGNAME_FIELDCOLOR_SET, DEFAULT_FIELDCOLOR_SET);
  prefNullBG := GetRegValue(REGNAME_BG_NULL, DEFAULT_BG_NULL);
  CalcNullColors;
  // Editor enablings
  prefEnableBinaryEditor := GetRegValue(REGNAME_FIELDEDITOR_BINARY, DEFAULT_FIELDEDITOR_BINARY);
  prefEnableDatetimeEditor := GetRegValue(REGNAME_FIELDEDITOR_DATETIME, DEFAULT_FIELDEDITOR_DATETIME);
  prefEnableEnumEditor := GetRegValue(REGNAME_FIELDEDITOR_ENUM, DEFAULT_FIELDEDITOR_ENUM);
  prefEnableSetEditor := GetRegValue(REGNAME_FIELDEDITOR_SET, DEFAULT_FIELDEDITOR_SET);
  prefEnableNullBG := GetRegValue(REGNAME_BG_NULL_ENABLED, DEFAULT_BG_NULL_ENABLED);

  // Switch off/on displaying table/db sized in tree
  menuShowSizeColumn.Checked := GetRegValue(REGNAME_SIZECOL_TREE, DEFAULT_SIZECOL_TREE);
  if menuShowSizeColumn.Checked then
    DBtree.Header.Columns[1].Options := DBtree.Header.Columns[1].Options + [coVisible]
  else
    DBtree.Header.Columns[1].Options := DBtree.Header.Columns[1].Options - [coVisible];

  // Restore width of columns of all VirtualTrees
  RestoreListSetup(ListDatabases);
  RestoreListSetup(ListVariables);
  RestoreListSetup(ListStatus);
  RestoreListSetup(ListProcesses);
  RestoreListSetup(ListCommandStats);
  RestoreListSetup(ListTables);

  // Shortcuts
  for i:=0 to ActionList1.ActionCount-1 do begin
    Action := TAction(ActionList1.Actions[i]);
    Action.ShortCut := GetRegValue(REGPREFIX_SHORTCUT1+Action.Name, Action.ShortCut);
  end;

  // Place progressbar on the statusbar
  ProgressBarStatus.Parent := StatusBar;
  ProgressBarStatus.Visible := False;

  // Work around Vistas ghosting feature breaking the GUI
  DisableProcessWindowsGhostingProc := GetProcAddress(
    GetModuleHandle('user32.dll'),
    'DisableProcessWindowsGhosting');
  if Assigned(DisableProcessWindowsGhostingProc) then
    DisableProcessWindowsGhostingProc;

  QueryTab := TQueryTab.Create;
  QueryTab.TabSheet := tabQuery;
  QueryTab.Number := 1;
  QueryTab.pnlMemo := pnlQueryMemo;
  QueryTab.pnlHelpers := pnlQueryHelpers;
  QueryTab.lboxHelpers := lboxQueryHelpers;
  QueryTab.tabsetHelpers := tabsetQueryHelpers;
  QueryTab.Memo := SynMemoQuery;
  QueryTab.MemoLineBreaks := lbsNone;
  QueryTab.spltHelpers := spltQueryHelpers;
  QueryTab.spltQuery := spltQuery;
  QueryTab.LabelResultInfo := LabelResultInfo;
  QueryTab.Grid := QueryGrid;
  QueryTab.GridResult := TGridResult.Create;

  QueryTabs := TObjectList<TQueryTab>.Create;
  QueryTabs.Add(QueryTab);

  // SynMemo font, hightlighting and shortcuts
  SetupSynEditors;

  DataGridResult := TGridResult.Create;

  btnAddTab := TSpeedButton.Create(PageControlMain);
  btnAddTab.Parent := PageControlMain;
  ImageListMain.GetBitmap(actNewQueryTab.ImageIndex, btnAddTab.Glyph);
  btnAddTab.Height := PageControlMain.TabRect(0).Bottom - PageControlMain.TabRect(0).Top - 2;
  btnAddTab.Width := btnAddTab.Height;
  btnAddTab.Flat := True;
  btnAddTab.Hint := actNewQueryTab.Hint;
  btnAddTab.OnClick := actNewQueryTab.OnExecute;

  // Filter panel
  ImageListMain.GetBitmap(134, btnCloseFilterPanel.Glyph);
  if GetRegValue(REGNAME_FILTERACTIVE, DEFAULT_FILTERACTIVE) then
    actFilterPanelExecute(nil);
  lblFilterVTInfo.Caption := '';

  SelectedTableColumns := TTableColumnList.Create;
  SelectedTableKeys := TTableKeyList.Create;
  SelectedTableForeignKeys := TForeignKeyList.Create;
end;


{**
  Check for connection parameters on commandline or show connections form.
}
procedure TMainForm.Startup;
var
  CmdlineParameters: TStringlist;
  LoadedParams: TConnectionParameters;
  LastUpdatecheck, LastStatsCall, LastConnect: TDateTime;
  UpdatecheckInterval, i: Integer;
  DefaultLastrunDate, LastSession, StatsURL: String;
  frm : TfrmUpdateCheck;
  Connected, DecideForStatistic: Boolean;
  StatsCall: TDownloadUrl2;
  SessionNames: TStringlist;
  DlgResult: TModalResult;
begin
  DefaultLastrunDate := '2000-01-01';

  // Do an updatecheck if checked in settings
  if GetRegValue(REGNAME_DO_UPDATECHECK, DEFAULT_DO_UPDATECHECK) then begin
    try
      LastUpdatecheck := StrToDateTime( GetRegValue(REGNAME_LAST_UPDATECHECK, DefaultLastrunDate) );
    except
      LastUpdatecheck := StrToDateTime( DefaultLastrunDate );
    end;
    UpdatecheckInterval := GetRegValue(REGNAME_UPDATECHECK_INTERVAL, DEFAULT_UPDATECHECK_INTERVAL);
    if DaysBetween(Now, LastUpdatecheck) >= UpdatecheckInterval then begin
      frm := TfrmUpdateCheck.Create(Self);
      frm.AutoClose := True;
      frm.CheckForBuildsInAutoMode := GetRegValue(REGNAME_DO_UPDATECHECK_BUILDS, DEFAULT_DO_UPDATECHECK_BUILDS);
      frm.ShowModal;
      FreeAndNil(frm);
    end;
  end;

  // Call user statistics if checked in settings
  if GetRegValue(REGNAME_DO_STATISTICS, DEFAULT_DO_STATISTICS) then begin
    try
      LastStatsCall := StrToDateTime( GetRegValue(REGNAME_LAST_STATSCALL, DefaultLastrunDate) );
    except
      LastStatsCall := StrToDateTime( DefaultLastrunDate );
    end;
    if DaysBetween(Now, LastStatsCall) >= 30 then begin
      // Report used SVN revision
      StatsURL := APPDOMAIN + 'savestats.php?c=' + IntToStr(AppVerRevision);
      // Enumerate actively used server versions
      SessionNames := TStringlist.Create;
      if MainReg.OpenKey(REGPATH + REGKEY_SESSIONS, true) then
        MainReg.GetKeyNames(SessionNames);
      for i:=0 to SessionNames.Count-1 do begin
        try
          LastConnect := StrToDateTime(GetRegValue(REGNAME_LASTCONNECT, DefaultLastrunDate, SessionNames[i]));
        except
          LastConnect := StrToDateTime(DefaultLastrunDate);
        end;
        if LastConnect > LastStatsCall then begin
          StatsURL := StatsURL + '&s[]=' + IntToStr(GetRegValue(REGNAME_SERVERVERSION, 0, SessionNames[i]));
        end;
      end;
      StatsCall := TDownloadUrl2.Create(Self);
      StatsCall.URL := StatsURL;
      StatsCall.SetUserAgent(APPNAME + ' ' + AppVersion);
      try
        StatsCall.ExecuteTarget(nil);
        OpenRegistry;
        MainReg.WriteString(REGNAME_LAST_STATSCALL, DateTimeToStr(Now));
      except
        // Silently ignore it when the url could not be called over the network.
      end;
      FreeAndNil(StatsCall);
    end;
  end;

  // Ask if we shall activate statistic calls. Would be used by noone otherwise.
  OpenRegistry;
  if not Mainreg.ValueExists(REGNAME_DO_STATISTICS) then begin
    DecideForStatistic := MessageDlg(APPNAME + ' has a new statistics feature: If activated, server and client versions '+
      'are reported once per month and displayed on heidisql.com.'+CRLF+CRLF+'Activate this feature?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes;
    Mainreg.WriteBool(REGNAME_DO_STATISTICS, DecideForStatistic);
  end;


  Connected := False;

  CmdlineParameters := TStringList.Create;
  for i:=1 to ParamCount do
    CmdlineParameters.Add(ParamStr(i));
  ParseCommandLineParameters(CmdlineParameters);
  if Assigned(FCmdlineConnectionParams) then begin
    // Minimal parameter for command line mode is hostname
    Connected := InitConnection(FCmdlineConnectionParams, FCmdlineSessionName);
  end else if GetRegValue(REGNAME_AUTORECONNECT, DEFAULT_AUTORECONNECT) then begin
    // Auto connection via preference setting
    // Do not autoconnect if we're in commandline mode and the connection was not successful
    LastSession := GetRegValue(REGNAME_LASTSESSION, '');
    if LastSession <> '' then begin
      LoadedParams := LoadConnectionParams(LastSession);
      Connected := InitConnection(LoadedParams, LastSession);
    end;
  end;

  // Display session manager
  if not Connected then begin
    // Cannot be done in OnCreate because we need ready forms here:
    if not Assigned(SessionManager) then
      SessionManager := TConnForm.Create(Self);
    DlgResult := mrCancel;
    try
      DlgResult := SessionManager.ShowModal;
    except
      // Work around VCL bug: Suppress access violation in TCustomForm.IsFormSizeStored
      // when closing dialog via Alt+F4
    end;
    if DlgResult = mrCancel then begin
      Free;
      Exit;
    end;
  end;

  DoAfterConnect;

  // Load SQL file(s) by command line
  for i:=0 to FCmdlineFilenames.Count-1 do begin
    if i>0 then
      actNewQueryTabExecute(Self);
    if not QueryLoad(FCmdlineFilenames[i]) then
      actCloseQueryTabExecute(Self);
  end;
end;


procedure TMainForm.ParseCommandLineParameters(Parameters: TStringlist);
var
  rx: TRegExpr;
  AllParams, Host, User, Pass, Socket: String;
  i, Port: Integer;

  function GetParamValue(ShortName, LongName: String): String;
  begin
    Result := '';
    rx.Expression := '\s(\-'+ShortName+'|\-\-'+LongName+')\s*\=?\s*([^\-]\S*)';
    if rx.Exec(AllParams) then
      Result := rx.Match[2];
  end;

begin
  // Initialize and clear variables
  if not Assigned(FCmdlineFilenames) then
    FCmdlineFilenames := TStringlist.Create;
  FCmdlineFilenames.Clear;
  FCmdlineSessionName := '';
  FreeAndNil(FCmdlineConnectionParams);

  // Prepend a space, so the regular expression can request a mandantory space
  // before each param name including the first one
  AllParams := ' ' + ImplodeStr(' ', Parameters);
  rx := TRegExpr.Create;
  FCmdlineSessionName := GetParamValue('d', 'description');
  if FCmdlineSessionName <> '' then begin
    try
      FCmdlineConnectionParams := LoadConnectionParams(FCmdlineSessionName);
    except
      on E:Exception do begin
        // Session params not found in registry
        LogSQL(E.Message);
        FCmdlineSessionName := '';
      end;
    end;

  end;

  // Test if params were passed. If given, override previous values loaded from registry.
  // Enables the user to log into a session with a different, non-stored user: -dSession -uSomeOther
  Host := GetParamValue('h', 'host');
  User := GetParamValue('u', 'user');
  Pass := GetParamValue('p', 'password');
  Socket := GetParamValue('S', 'socket');
  Port := StrToIntDef(GetParamValue('P', 'port'), 0);
  // Leave out support for startup script, seems reasonable for command line connecting

  if (Host <> '') or (User <> '') or (Pass <> '') or (Port <> 0) or (Socket <> '') then begin
    if not Assigned(FCmdlineConnectionParams) then
      FCmdlineConnectionParams := TConnectionParameters.Create;
    if Host <> '' then FCmdlineConnectionParams.Hostname := Host;
    if User <> '' then FCmdlineConnectionParams.Username := User;
    if Pass <> '' then FCmdlineConnectionParams.Password := Pass;
    if Port <> 0 then FCmdlineConnectionParams.Port := Port;
    if Socket <> '' then begin
      FCmdlineConnectionParams.Hostname := Socket;
      FCmdlineConnectionParams.NetType := ntNamedPipe;
    end;
    // Ensure we have a session name to pass to InitConnection
    if (FCmdlineSessionName = '') and (FCmdlineConnectionParams.Hostname <> '') then
      FCmdlineSessionName := FCmdlineConnectionParams.Hostname;
  end;

  // Check for valid filename(s) in parameters
  for i:=0 to Parameters.Count-1 do begin
    if FileExists(Parameters[i]) then
      FCmdlineFilenames.Add(Parameters[i]);
  end;
end;


procedure TMainForm.actSessionManagerExecute(Sender: TObject);
begin
  if not Assigned(SessionManager) then
    SessionManager := TConnForm.Create(Self);
  if SessionManager.ShowModal <> mrCancel then
    DoAfterConnect;
end;


procedure TMainForm.DoAfterConnect;
var
  i, j: Integer;
  lastUsedDB, StartupScript, StartupSQL: String;
  functioncats, StartupBatch: TStringList;
  miGroup,
  miFilterGroup,
  miFunction,
  miFilterFunction: TMenuItem;
begin
  DataGridHasChanges := False;

  // Activate logging
  if GetRegValue(REGNAME_LOGTOFILE, DEFAULT_LOGTOFILE) then
    ActivateFileLogging;

  tabHost.Caption := 'Host: '+Connection.Parameters.HostName;
  ShowStatusMsg('MySQL '+Connection.ServerVersionStr, 3);

  // Save server version
  OpenRegistry(SessionName);
  Mainreg.WriteInteger(REGNAME_SERVERVERSION, Connection.ServerVersionInt);
  Mainreg.WriteString(REGNAME_LASTCONNECT, DateTimeToStr(Now));

  comboOnlyDBs.Items.Text := GetRegValue(REGNAME_ONLYDBS, '', SessionName);
  if comboOnlyDBs.Items.Count > 0 then
    comboOnlyDBs.ItemIndex := 0
  else
    comboOnlyDBs.Text := '';

  // Remove db and table nodes, force host node to initialize again
  DBtree.ResetNode(DBTree.GetFirst);

  DBTree.Color := GetRegValue(REGNAME_TREEBACKGROUND, clWindow, SessionName);

  // Process startup script
  StartupScript := Trim(Connection.Parameters.StartupScriptFilename);
  if StartupScript <> '' then begin
    if not FileExists(StartupScript) then
      MessageDlg('Error: Startup script file not found: '+StartupScript, mtError, [mbOK], 0)
    else begin
      StartupSQL := ReadTextfile(StartupScript);
      StartupBatch := ParseSQL(StartupSQL);
      for i:=0 to StartupBatch.Count-1 do try
        Connection.Query(StartupBatch[i]);
      except
        // Suppress popup, errors get logged into SQL log
      end;
      StartupBatch.Free;
    end;
  end;

  // Reselect last used database
  if GetRegValue( REGNAME_RESTORELASTUSEDDB, DEFAULT_RESTORELASTUSEDDB ) then begin
    lastUsedDB := GetRegValue(REGNAME_LASTUSEDDB, '', SessionName);
    if lastUsedDB <> '' then try
      ActiveDatabase := lastUsedDB;
    except
      // Suppress exception message when db was dropped externally or
      // the session was just opened with "OnlyDBs" in place and the
      // last db is not contained in this list.
    end;
  end;
  // By default, select the host node
  if not Assigned(DBtree.FocusedNode) then begin
    DBtree.Selected[DBtree.GetFirst] := true;
    DBtree.FocusedNode := DBtree.GetFirst;
  end;

  // Create function menu items in popupQuery and popupFilter
  menuQueryInsertFunction.Clear;
  menuFilterInsertFunction.Clear;
  functioncats := GetFunctionCategories;
  for i:=0 to functioncats.Count-1 do begin
    // Create a menu item which gets subitems later
    miGroup := TMenuItem.Create(popupQuery);
    miGroup.Caption := functioncats[i];
    menuQueryInsertFunction.Add(miGroup);
    miFilterGroup := TMenuItem.Create(popupFilter);
    miFilterGroup.Caption := miGroup.Caption;
    menuFilterInsertFunction.Add(miFilterGroup);
    for j:=0 to Length(MySqlFunctions)-1 do begin
      if MySqlFunctions[j].Category <> functioncats[i] then
        continue;
      miFunction := TMenuItem.Create(popupQuery);
      miFunction.Caption := MySqlFunctions[j].Name;
      miFunction.ImageIndex := 13;
      // Prevent generating a hotkey
      miFunction.Caption := StringReplace(miFunction.Caption, '&', '&&', [rfReplaceAll]);
      // Prevent generating a seperator line
      if miFunction.Caption = '-' then
        miFunction.Caption := '&-';
      miFunction.Hint := MySqlFunctions[j].Name + MySqlFunctions[j].Declaration;
      // Take care of needed server version
      if MySqlFunctions[j].Version <= Connection.ServerVersionInt then begin
        if MySqlFunctions[j].Description <> '' then
          miFunction.Hint := miFunction.Hint + ' - ' + Copy(MySqlFunctions[j].Description, 0, 200 );
        miFunction.Tag := j;
        // Place menuitem on menu
        miFunction.OnClick := insertFunction;
      end else begin
        miFunction.Hint := miFunction.Hint + ' - ('+STR_NOTSUPPORTED+', needs >= '+Connection.ConvertServerVersion(MySqlFunctions[j].Version)+')';
        miFunction.Enabled := False;
      end;
      // Prevent generating a seperator for ShortHint and LongHint
      miFunction.Hint := StringReplace( miFunction.Hint, '|', '�', [rfReplaceAll] );
      miGroup.Add(miFunction);
      // Create a copy of the menuitem for popupFilter
      miFilterFunction := TMenuItem.Create(popupFilter);
      miFilterFunction.Caption := miFunction.Caption;
      miFilterFunction.Hint := miFunction.Hint;
      miFilterFunction.ImageIndex := miFunction.ImageIndex;
      miFilterFunction.Tag := miFunction.Tag;
      miFilterFunction.OnClick := miFunction.OnClick;
      miFilterFunction.Enabled := miFunction.Enabled;
      miFilterGroup.Add(miFilterFunction);
    end;
  end;
end;


procedure TMainForm.DoDisconnect;
begin
  // Do nothing in case user clicked Cancel on session manager
  if (not Assigned(Connection)) or (not Connection.Active) then
    Exit;

  // Open server-specific registry-folder.
  // relative from already opened folder!
  OpenRegistry(SessionName);
  MainReg.WriteString( REGNAME_LASTUSEDDB, Connection.Database );
  MainReg.WriteString( REGNAME_ONLYDBS, comboOnlyDBs.Items.Text );

  // Post pending UPDATE
  if DataGridHasChanges then
    actDataPostChangesExecute(Self);

  // Clear database and table lists
  DBtree.ClearSelection;
  DBtree.FocusedNode := nil;
  PreviousFocusedNode := nil;
  FreeAndNil(AllDatabases);
  FreeAndNil(AllDatabasesDetails);
  FreeAndNil(DataGridHiddenColumns);
  SynMemoFilter.Clear;
  SetLength(DataGridSortColumns, 0);

  // Closing connection
  Connection.Active := False;

  if prefLogToFile then
    DeactivateFileLogging;

  // Invalidate list contents
  InvalidateVT(ListDatabases, VTREE_NOTLOADED, False);
  InvalidateVT(ListVariables, VTREE_NOTLOADED, False);
  InvalidateVT(ListStatus, VTREE_NOTLOADED, False);
  InvalidateVT(ListProcesses, VTREE_NOTLOADED, False);
  InvalidateVT(ListCommandstats, VTREE_NOTLOADED, False);
  InvalidateVT(ListTables, VTREE_NOTLOADED, False);

  Application.Title := APPNAME;
end;


procedure TMainForm.actCreateDatabaseExecute(Sender: TObject);
var
  newdb: String;
begin
  // Create database:
  // Create modal form once on demand
  if CreateDatabaseForm = nil then
    CreateDatabaseForm := TCreateDatabaseForm.Create(Self);

  // Rely on the modalresult being set correctly
  if CreateDatabaseForm.ShowModal = mrOK then
  begin
    newdb := CreateDatabaseForm.editDBName.Text;
    // Add new DB to database filter if it's not empty
    if comboOnlyDBs.Text <> '' then begin
      comboOnlyDBs.Text := comboOnlyDBs.Text + ';' + newdb;
      comboOnlyDBs.Items.Insert(0, comboOnlyDBs.Text);
    end;
	FreeAndNil(AllDatabases);
    // reload db nodes and switch to new one
    RefreshTree(False, newdb);
  end;
end;


procedure TMainForm.actImportCSVExecute(Sender: TObject);
begin
  // Import Textfile
  if not Assigned(ImportTextfileDialog) then
    ImportTextfileDialog := Tloaddataform.Create(Self);
  ImportTextfileDialog.ShowModal;
end;

procedure TMainForm.actPreferencesExecute(Sender: TObject);
begin
  // Preferences
  if OptionsForm = nil then
    OptionsForm := Toptionsform.Create(Self);
  OptionsForm.ShowModal;
end;

procedure TMainForm.actReadmeExecute(Sender: TObject);
begin
  // show readme.txt
  ShellExec( 'readme.txt', ExtractFilePath(paramstr(0)) );
end;

procedure TMainForm.FormResize(Sender: TObject);
var
  i, room: Integer;
  PanelRect: TRect;
begin
  // Exit early when user pressed "Cancel" on connection dialog
  if csDestroying in ComponentState then
    Exit;
  room := 0;
  for i := 1 to Statusbar.Panels.Count - 1 do
    inc(room, Statusbar.Panels[i].Width);
  StatusBar.Panels[0].Width := Statusbar.Width - room;
  // Retreive the rectancle of the statuspanel (in our case the fifth panel)
  SendMessage(StatusBar.Handle, SB_GETRECT, 5, Integer(@PanelRect));
  // Position the progressbar over the panel on the statusbar
  with PanelRect do
    ProgressBarStatus.SetBounds(Left, Top, Right-Left, Bottom-Top);
  lblDataTop.Width := pnlDataTop.Width - tlbDataButtons.Width - 10;
  FixQueryTabCloseButtons;
end;

procedure TMainForm.actUserManagerExecute(Sender: TObject);
begin
  if UserManagerForm = nil then
    UserManagerForm := TUserManagerForm.Create(Self);
  if UserManagerForm.TestUserAdmin then
    UserManagerForm.ShowModal;
end;

procedure TMainForm.actAboutBoxExecute(Sender: TObject);
var
  Box: TAboutBox;
begin
  // Info-Box
  Box := TAboutBox.Create(Self);
  Box.ShowModal;
  Box.Free;
end;

procedure TMainForm.actClearEditorExecute(Sender: TObject);
var
  m: TSynMemo;
begin
  if Sender = actClearQueryEditor then
    m := ActiveQueryMemo
  else begin
    m := SynMemoFilter;
    editFilterSearch.Clear;
  end;
  m.SelectAll;
  m.SelText := '';
  m.SelStart := 0;
  m.SelEnd := 0;
  if QueryTabActive then begin
    SetTabCaption(PageControlMain.ActivePageIndex, '');
    ActiveQueryTab.MemoFilename := '';
    ActiveQueryTab.Memo.Modified := False;
  end;
  if m = SynMemoFilter then
    InvalidateVT(DataGrid, VTREE_NOTLOADED_PURGECACHE, False);
end;

procedure TMainForm.actTableToolsExecute(Sender: TObject);
var
  Act: TAction;
  InDBTree: Boolean;
  Node: PVirtualNode;
begin
  // Show table tools dialog
  if TableToolsDialog = nil then
    TableToolsDialog := TfrmTableTools.Create(Self);
  Act := Sender as TAction;
  InDBTree := (Act.ActionComponent is TMenuItem)
    and (TPopupMenu((Act.ActionComponent as TMenuItem).GetParentMenu).PopupComponent = DBTree);
  if InDBTree then
    TableToolsDialog.SelectedTables.Text := SelectedTable.Name
  else begin
    TableToolsDialog.SelectedTables.Clear;
    Node := ListTables.GetFirstSelected;
    while Assigned(Node) do begin
      TableToolsDialog.SelectedTables.Add(ListTables.Text[Node, 0]);
      Node := ListTables.GetNextSelected(Node);
    end;
  end;
  if Sender = actMaintenance then
    TableToolsDialog.ToolMode := tmMaintenance
  else if Sender = actFindTextOnServer then
    TableToolsDialog.ToolMode := tmFind
  else if Sender = actExportTables then
    TableToolsDialog.ToolMode := tmSQLExport
  else if Sender = actBulkTableEdit then
    TableToolsDialog.ToolMode := tmBulkTableEdit;
  TableToolsDialog.ShowModal;
end;


{**
  Edit view
}
procedure TMainForm.actPrintListExecute(Sender: TObject);
var
  f: TForm;
begin
  // Print contents of a list or grid
  f := TPrintlistForm.Create(Self);
  f.ShowModal;
  FreeAndNil(f);
end;


procedure TMainForm.actCopyTableExecute(Sender: TObject);
begin
  // copy table
  if not Assigned(CopyTableDialog) then
    CopyTableDialog := TCopyTableForm.Create(Self);
  CopyTableDialog.ShowModal;
end;


procedure TMainForm.menuConnectionsPopup(Sender: TObject);
var
  i: integer;
  item: TMenuItem;
  Connections: TStringList;
begin
  // Delete dynamically added connection menu items.
  for i := menuConnections.Items.Count - 1 downto 0 do begin
    menuConnections.Items.Delete(i);
  end;

  // "Session manager" and "New window" items
  item := TMenuItem.Create(menuConnections);
  item.Action := actSessionManager;
  item.Default := True;
  menuConnections.Items.Add(item);
  item := TMenuItem.Create(menuConnections);
  item.Action := actNewWindow;
  menuConnections.Items.Add(item);

  // All sessions
  if MainReg.OpenKey(REGPATH + REGKEY_SESSIONS, False) then begin
    Connections := TStringList.Create;
    MainReg.GetKeyNames(Connections);
    for i := 0 to Connections.Count - 1 do begin
      item := TMenuItem.Create(menuConnections);
      item.Caption := Connections[i];
      item.OnClick := SessionConnect;
      item.ImageIndex := 37;
      if Connections[i] = SessionName then begin
        item.Checked := True;
        item.ImageIndex := -1;
      end;
      menuConnections.Items.Add(item);
    end;
  end;

end;


procedure TMainForm.File1Click(Sender: TObject);
var
  Item: TMenuItem;
  i: Integer;
  Connections: TStringList;
begin
  // Decide if "Connect to" menu should be enabled
  menuConnectTo.Enabled := False;
  if MainReg.OpenKey(REGPATH + REGKEY_SESSIONS, False) then begin
    menuConnectTo.Enabled := MainReg.HasSubKeys;
    if menuConnectTo.Enabled then begin
      // Add all sessions to submenu
      for i := menuConnectTo.Count - 1 downto 0 do
        menuConnectTo.Delete(i);
      Connections := TStringList.Create;
      MainReg.GetKeyNames(Connections);
      for i := 0 to Connections.Count - 1 do begin
        Item := TMenuItem.Create(menuConnectTo);
        Item.Caption := Connections[i];
        Item.OnClick := SessionConnect;
        Item.ImageIndex := 37;
        if Connections[i] = SessionName then begin
          Item.Checked := True;
          Item.ImageIndex := -1;
        end;
        menuConnectTo.Add(Item);
      end;
    end;
  end;
end;


procedure TMainForm.actWebbrowse(Sender: TObject);
begin
  // Browse to URL (hint)
  ShellExec( TAction(Sender).Hint );
end;


// Escape database, table, field, index or key name.
function TMainform.mask(str: String) : String;
begin
  result := Connection.QuoteIdent(str);
end;


// Quote identifier, probably with multiple segments, e.g. db.table.column
function TMainform.MaskMulti(str: String): String;
var
  Segments: TStringList;
  i: Integer;
begin
  Segments := Explode('.', str);
  Result := '';
  for i:=0 to Segments.Count-1 do
    Result := Result + mask(Segments[i]) + '.';
  FreeAndNil(Segments);
  Delete(Result, Length(Result), 1);
end;


procedure TMainForm.actExportSettingsExecute(Sender: TObject);
begin
  // Export settings to .reg-file
  if SaveDialog2.Execute then
    ShellExec('regedit.exe', '', '/e "'+SaveDialog2.FileName+'" HKEY_CURRENT_USER'+REGPATH);
end;

procedure TMainForm.actImportSettingsExecute(Sender: TObject);
begin
  // Import settings from .reg-file
  if OpenDialog2.Execute then
    ShellExec('regedit.exe', '', '"'+OpenDialog2.FileName+'"');
end;

procedure TMainForm.actExecuteQueryExecute(Sender: TObject);
begin
  ExecSqlClick(sender, false);
end;

procedure TMainForm.actExecuteSelectionExecute(Sender: TObject);
begin
  ExecSqlClick(sender, true);
end;

procedure TMainForm.actExecuteLineExecute(Sender: TObject);
begin
  ExecSqlClick(sender, false, true);
end;


procedure TMainForm.actCopyAsCSVExecute(Sender: TObject);
var
  S: TMemoryStream;
begin
  // Copy data in focused grid as CSV
  Screen.Cursor := crHourglass;
  S := TMemoryStream.Create;
  try
    GridToCsv(ActiveGrid, prefCSVSeparator, prefCSVEncloser, prefCSVTerminator, S);
    StreamToClipboard(S, nil, False);
  finally
    ShowStatusMsg('Freeing data...');
    S.Free;
    ShowStatusMsg(STATUS_MSG_READY);
    Screen.Cursor := crDefault;
  end;
end;


procedure TMainForm.actCopyAsHTMLExecute(Sender: TObject);
var
  S: TMemoryStream;
  Title: String;
begin
  // Copy data in focused grid as HTML table
  Screen.Cursor := crHourglass;
  S := TMemoryStream.Create;
  if ActiveGrid = DataGrid then Title := SelectedTable.Name
  else Title := 'SQL query';
  try
    GridToHtml(ActiveGrid, Title, S);
    StreamToClipboard(S, S, True);
  finally
    ShowStatusMsg('Freeing data...');
    S.Free;
    ShowStatusMsg(STATUS_MSG_READY);
    Screen.Cursor := crDefault;
  end;
end;


procedure TMainForm.actCopyAsXMLExecute(Sender: TObject);
var
  S: TMemoryStream;
  Root: String;
begin
  // Copy data in focused grid as XML
  Screen.Cursor := crHourglass;
  S := TMemoryStream.Create;
  if ActiveGrid = DataGrid then Root := SelectedTable.Name
  else Root := 'SQL query';
  try
    GridToXml(ActiveGrid, Root, S);
    StreamToClipboard(S, nil, False);
  finally
    ShowStatusMsg('Freeing data...');
    S.Free;
    ShowStatusMsg(STATUS_MSG_READY);
    Screen.Cursor := crDefault;
  end;
end;


procedure TMainForm.actCopyAsSQLExecute(Sender: TObject);
var
  S, HTML: TMemoryStream;
  Tablename: String;
  Content: AnsiString;
begin
  // Copy data in focused grid as SQL
  Screen.Cursor := crHourglass;
  S := TMemoryStream.Create;
  if ActiveGrid = DataGrid then Tablename := SelectedTable.Name
  else Tablename := 'unknown';
  try
    GridToSql(ActiveGrid, Tablename, S);
    SetLength(Content, S.Size);
    S.Position := 0;
    S.Read(PAnsiChar(Content)^, S.Size);
    SynExporterHTML1.ExportAll(Explode(CRLF, UTF8ToString(Content)));
    HTML := TMemoryStream.Create;
    SynExporterHTML1.SaveToStream(HTML);
    StreamToClipboard(S, HTML, False);
  finally
    ShowStatusMsg('Freeing data...');
    S.Free;
    ShowStatusMsg(STATUS_MSG_READY);
    Screen.Cursor := crDefault;
  end;
end;


procedure TMainForm.actExportDataExecute(Sender: TObject);
var
  Dialog: TSaveDialog;
  FS: TFileStream;
  Title: String;
begin
  // Save data in current dataset as CSV, HTML or XML
  Dialog := SaveDialogExportData;

  if ActiveGrid = DataGrid then
    Title := SelectedTable.Name
  else
    Title := 'SQL query';

  Dialog.FileName := Title;
  Dialog.Title := 'Export result set from '+Dialog.Filename+'...';

  if Dialog.Execute and (Dialog.FileName <> '') then try
    Screen.Cursor := crHourGlass;
    FS := TFileStream.Create(Dialog.FileName, fmCreate or fmOpenWrite);
    case Dialog.FilterIndex of
      1: GridToCsv(ActiveGrid, prefCSVSeparator, prefCSVEncloser, prefCSVTerminator, FS);
      2: GridToHtml(ActiveGrid, Title, FS);
      3: GridToXml(ActiveGrid, Title, FS);
      4: GridToSql(ActiveGrid, Title, FS);
    end;
    ShowStatusMsg('Freeing data...');
    FS.Free;
  finally
    ShowStatusMsg(STATUS_MSG_READY);
    Screen.Cursor := crDefault;
  end;
end;



// view HTML
procedure TMainForm.actHTMLviewExecute(Sender: TObject);
const
  msgNotBinary = 'Non-binary field selected. Only binary fields containing JPEG, PNG, GIF and BMP images are supported.';
  msgNotImage = 'Unrecognized image format.  Only JPEG, PNG, GIF and BMP are supported.';
var
  g               : TVirtualStringTree;
  filename        : String;
  f               : Textfile;
  Header, Content : AnsiString;
  IsBinary        : Boolean;
  SaveBinary      : Boolean;
begin
  g := ActiveGrid;
  if g = nil then begin messagebeep(MB_ICONASTERISK); exit; end;
  Screen.Cursor := crHourGlass;
  ShowStatusMsg('Saving contents to file...');
  IsBinary := GridResult(ActiveGrid).Columns[g.FocusedColumn].DatatypeCat = dtcBinary;

  DataGridEnsureFullRow(g, g.FocusedNode);
  Header := WideHexToBin(Copy(g.Text[g.FocusedNode, g.FocusedColumn], 3, 20));
  SaveBinary := false;
  filename := GetTempDir+'\'+APPNAME+'-preview.';
  if IsBinary and (Copy(Header, 7, 4) = 'JFIF') then begin
    SaveBinary := true;
    filename := filename + 'jpeg';
  end else if IsBinary and (Copy(Header, 2, 3) = 'PNG') then begin
    SaveBinary := true;
    filename := filename + 'png';
  end else if IsBinary and (Copy(Header, 1, 3) = 'GIF') then begin
    SaveBinary := true;
    filename := filename + 'gif';
  end else if IsBinary and (Copy(Header, 1, 2) = 'BM') then begin
    SaveBinary := true;
    filename := filename + 'bmp';
  end else if IsBinary and (Copy(Header, 3, 2) = #42#0) then begin
    SaveBinary := true;
    filename := filename + 'tif';
  end;

  if not IsBinary then begin
    MessageDlg(msgNotBinary, mtWarning, [mbOk], 0);
  end else if not SaveBinary then begin
    MessageDlg(msgNotImage, mtWarning, [mbOk], 0);
  end;

  if SaveBinary then begin
    Content := WideHexToBin(Copy(g.Text[g.FocusedNode, g.FocusedColumn], 3, High(Integer)));
    AssignFile(f, filename);
    Rewrite(f);
    Write(f, Content);
    CloseFile(f);
  end;
  ShowStatusMsg( STATUS_MSG_READY );
  Screen.Cursor := crDefault;
  ShellExec( filename );
end;

procedure TMainForm.actInsertFilesExecute(Sender: TObject);
begin
  if not Assigned(InsertFiles) then
    InsertFiles := TfrmInsertFiles.Create(Self);
  InsertFiles.ShowModal;
end;

// Drop Table(s)
procedure TMainForm.actDropObjectsExecute(Sender: TObject);
var
  msg, activeDB : String;
  InDBTree: Boolean;
  Act: TAction;
  Node: PVirtualNode;
  Obj: PDBObject;
  DBObject: TDBObject;
  ObjectList: TDBObjectList;
begin
  debug('drop objects activated');
  // Set default database name to to ActiveDatabase.
  // Can be overwritten when someone selects a table in dbtree from different database
  activeDB := ActiveDatabase;

  ObjectList := TDBobjectList.Create(False);

  Act := Sender as TAction;
  InDBTree := (Act.ActionComponent is TMenuItem)
    and (TPopupMenu((Act.ActionComponent as TMenuItem).GetParentMenu).PopupComponent = DBTree);
  if InDBTree then begin
    // drop table selected in tree view.
    case GetFocusedTreeNodeType of
      lntDb: begin
        if MessageDlg('Drop Database "'+activeDB+'"?' + crlf + crlf + 'WARNING: You will lose all objects in database '+activeDB+'!', mtConfirmation, [mbok,mbcancel], 0) <> mrok then
          Abort;
        try
          Connection.Query('DROP DATABASE ' + mask(activeDB));
          Node := DBTree.FocusedNode;
          SelectNode(DBTree, DBtree.GetFirst);
          Connection.ClearDbObjects(activeDB);
          FreeAndNil(AllDatabases);
          DBTree.DeleteNode(Node);
          RefreshTree(False);
        except
          on E:Exception do
            MessageDlg(E.Message, mtError, [mbOK], 0);
        end;
        Exit;
      end;
      else ObjectList.Add(SelectedTable);
    end;
  end else begin
    // Invoked from database tab
    Node := ListTables.GetFirstSelected;
    while Assigned(Node) do begin
      Obj := ListTables.GetNodeData(Node);
      ObjectList.Add(Obj^);
      Node := ListTables.GetNextSelected(Node);
    end;
  end;

  // Fix actions temporarily enabled for popup menu.
  ValidateControls(Sender);

  // Safety stop to avoid firing DROP TABLE without tablenames
  if ObjectList.Count = 0 then
    Exit;

  // Ask user for confirmation to drop selected objects
  msg := 'Drop ' + IntToStr(ObjectList.Count) + ' object(s) in database "'+activeDB+'"?' + CRLF + CRLF;
  for DBObject in ObjectList do
    msg := msg + DBObject.Name + ', ';
  Delete(msg, Length(msg)-1, 2);
  if MessageDlg(msg, mtConfirmation, [mbok,mbcancel], 0) <> mrok then
    Exit;

  try
    // Compose and run DROP [TABLE|VIEW|...] queries
    for DBObject in ObjectList do
      Connection.Query('DROP '+UpperCase(DBObject.ObjType)+' '+Mask(DBObject.Name));
    // Refresh ListTables + dbtree so the dropped tables are gone:
    RefreshTreeDB(ActiveDatabase);
  except
    on E:Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
  ObjectList.Free;
end;


// Load SQL-file, make sure that SheetQuery is activated
procedure TMainForm.actLoadSQLExecute(Sender: TObject);
var
  i: Integer;
begin
  if OpenDialogSQLfile.Execute then begin
    for i:=0 to OpenDialogSQLfile.Files.Count-1 do begin
      if i > 0 then
        actNewQueryTabExecute(Sender);
      QueryLoad(OpenDialogSQLfile.Files[i]);
    end;
  end;
end;



procedure TMainForm.SessionConnect(Sender: TObject);
var
  Session: String;
  Params: TConnectionParameters;
begin
  Session := (Sender as TMenuItem).Caption;
  Params := LoadConnectionParams(Session);
  if InitConnection(Params, Session) then
    DoAfterConnect;
end;


{**
  Receive connection parameters and create the mdi-window
  Paremeters are either sent by connection-form or by commandline.
}
function TMainform.InitConnection(Params: TConnectionParameters; Session: String): Boolean;
var
  ConnectionAttempt: TMySQLConnection;
  SessionExists: Boolean;
begin
  ConnectionAttempt := TMySQLConnection.Create(Self);
  ConnectionAttempt.OnLog := LogSQL;
  ConnectionAttempt.OnDatabaseChanged := DatabaseChanged;
  ConnectionAttempt.OnDBObjectsCleared := DBObjectsCleared;
  ConnectionAttempt.ObjectNamesInSelectedDB := SynSQLSyn1.TableNames;
  ConnectionAttempt.Parameters := Params;
  try
    ConnectionAttempt.Active := True;
  except
    on E:Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;

  // attempt to establish connection
  SessionExists := MainReg.KeyExists(REGPATH + REGKEY_SESSIONS + Session);
  if not ConnectionAttempt.Active then begin
    // attempt failed
    if SessionExists then begin
      // Save "refused" counter
      OpenRegistry(Session);
      MainReg.WriteInteger(REGNAME_REFUSEDCOUNT, GetRegValue(REGNAME_REFUSEDCOUNT, 0, Session)+1);
    end;
    Result := False;
    FreeAndNil(ConnectionAttempt);
  end else begin
    if SessionExists then begin
      // Save "refused" counter
      OpenRegistry(Session);
      MainReg.WriteInteger(REGNAME_CONNECTCOUNT, GetRegValue(REGNAME_CONNECTCOUNT, 0, Session)+1);
      // Save last session name in root folder
      OpenRegistry;
      MainReg.WriteString(REGNAME_LASTSESSION, Session);
    end;

    Result := True;
    DoDisconnect;
    FreeAndNil(Connection);
    Connection := ConnectionAttempt;
    SessionName := Session;
  end;
  ShowStatusMsg( STATUS_MSG_READY );
end;


procedure TMainForm.actDataDeleteExecute(Sender: TObject);
begin
  // Delete row(s)
  if (DataGrid.SelectedCount = 1) and
    (DataGridResult.Rows[DataGrid.GetFirstSelected.Index].State = grsInserted)
    then begin
    // Deleting the virtual row which is only in memory by stopping edit mode
    actDataCancelChanges.Execute;
  end else begin
    // The "normal" case: Delete existing rows
    if DataGrid.SelectedCount = 0 then
      MessageDLG('Please select one or more rows to delete them.', mtError, [mbOK], 0)
    else if MessageDLG('Delete '+inttostr(DataGrid.SelectedCount)+' row(s)?',
        mtConfirmation, [mbOK, mbCancel], 0) = mrOK then begin
      GridPostDelete(DataGrid);
    end;
  end;
end;


procedure TMainForm.actUpdateCheckExecute(Sender: TObject);
var
  frm : TfrmUpdateCheck;
begin
  frm := TfrmUpdateCheck.Create(Self);
  frm.ShowModal;
  FreeAndNil(frm);
end;


procedure TMainForm.actCreateDBObjectExecute(Sender: TObject);
var
  Obj: TDBObject;
  a: TAction;
begin
  // Create a new table, view, etc.
  tabEditor.TabVisible := True;
  PagecontrolMain.ActivePage := tabEditor;
  a := Sender as TAction;
  Obj := TDBObject.Create;
  if a = actCreateTable then Obj.NodeType := lntTable
  else if a = actCreateView then Obj.NodeType := lntView
  else if a = actCreateRoutine then Obj.NodeType := lntProcedure
  else if a = actCreateTrigger then Obj.NodeType := lntTrigger
  else if a = actCreateEvent then Obj.NodeType := lntEvent;
  PlaceObjectEditor(Obj);
end;


procedure TMainForm.actEmptyTablesExecute(Sender: TObject);
var
  t: TStringList;
  i: Integer;
  sql_pattern: String;
begin
  // Add selected items/tables to helper list
  if ListTables.Focused then
    t := GetVTCaptions(ListTables, True)
  else if DBTree.Focused then begin
    t := TStringList.Create;
    t.Add(SelectedTable.Name);
  end else
    Exit;
  if t.Count = 0 then
    Exit;

  if MessageDlg('Empty ' + IntToStr(t.count) + ' table(s) ?' + CRLF + '(' + implodestr(', ', t) + ')',
    mtConfirmation, [mbOk, mbCancel], 0) <> mrOk then
    exit;

  Screen.Cursor := crHourglass;
  {**
    @note ansgarbecker: Empty table using faster TRUNCATE statement on newer servers
    @see http://dev.mysql.com/doc/refman/5.0/en/truncate.html
    @see https://sourceforge.net/tracker/index.php?func=detail&aid=1644143&group_id=164593&atid=832350
  }
  if Connection.ServerVersionInt < 50003 then
    sql_pattern := 'DELETE FROM '
  else
    sql_pattern := 'TRUNCATE ';

  try
    for i:=0 to t.count-1 do
      Connection.Query( sql_pattern + mask(t[i]) );
    actRefresh.Execute;
  except
    on E:Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
  t.Free;
  Screen.Cursor := crDefault;
end;


procedure TMainForm.actRunRoutinesExecute(Sender: TObject);
var
  Tab: TQueryTab;
  Query, ParamInput, ProcOrFunc,
  Returns, DataAccess, Security, Comment, Body: String;
  Deterministic: Boolean;
  i: Integer;
  pObj: PDBObject;
  Obj: TDBObject;
  Objects: TDBObjectList;
  Node: PVirtualNode;
  Parameters: TRoutineParamList;
begin
  // Run stored function(s) or procedure(s)
  Objects := TDBObjectList.Create(False);
  if ListTables.Focused then begin
    Node := ListTables.GetFirstSelected;
    while Assigned(Node) do begin
      pObj := ListTables.GetNodeData(Node);
      if pObj.NodeType in [lntProcedure, lntFunction] then
        Objects.Add(pObj^);
      Node := ListTables.GetNextSelected(Node);
    end;
  end else
    Objects.Add(SelectedTable);

  if Objects.Count = 0 then
    MessageDlg('Please select one or more stored function(s) or routine(s).', mtError, [mbOK], 0);

  for Obj in Objects do begin
    actNewQueryTab.Execute;
    Tab := QueryTabs[MainForm.QueryTabs.Count-1];
    case Obj.NodeType of
      lntProcedure: begin
        Query := 'CALL ';
        ProcOrFunc := 'PROCEDURE';
      end;
      lntFunction: begin
        Query := 'SELECT ';
        ProcOrFunc := 'FUNCTION';
      end;
    end;
    Parameters := TRoutineParamList.Create;
    ParseRoutineStructure(Connection.GetVar('SHOW CREATE '+ProcOrFunc+' '+mask(Obj.Name), 2),
      Parameters,
      Deterministic, Returns, DataAccess, Security, Comment, Body
      );
    Query := Query + mask(Obj.Name);
    ParamInput := '';
    for i:=0 to Parameters.Count-1 do begin
      if ParamInput <> '' then
        ParamInput := ParamInput + ', ';
      ParamInput := ParamInput + '''' + InputBox(Obj.Name, 'Parameter #'+IntToStr(i+1)+': '+Parameters[i].Name+' ('+Parameters[i].Datatype+')', '') + '''';
    end;
    Parameters.Free;
    Query := Query + '('+ParamInput+')';
    Tab.Memo.Text := Query;
    actExecuteQueryExecute(Sender);
  end;
end;


procedure TMainForm.actNewWindowExecute(Sender: TObject);
begin
  debug('perf: new connection clicked.');
  ShellExec( ExtractFileName(paramstr(0)), ExtractFilePath(paramstr(0)) );
end;


procedure TMainForm.actQueryFindReplaceExecute(Sender: TObject);
var
  DlgResult: TModalResult;
begin
  // Display search + replace dialog
  if not Assigned(SearchReplaceDialog) then
    SearchReplaceDialog := TfrmSearchReplace.Create(Self);
  SearchReplaceDialog.Editor := ActiveQueryMemo;
  SearchReplaceDialog.chkReplace.Checked := Sender = actQueryReplace;
  DlgResult := SearchReplaceDialog.ShowModal;
  case DlgResult of
    mrOK, mrAll: begin
      DoSearchReplace;
      FSearchReplaceExecuted := True; // Helper for later F3 hits
    end;
    mrCancel: Exit;
  end;
end;


procedure TMainForm.actQueryFindAgainExecute(Sender: TObject);
begin
  // F3 - search or replace again, using previous settings
  if not FSearchReplaceExecuted then
    actQueryFindReplaceExecute(Sender)
  else begin
    SearchReplaceDialog.Editor := ActiveQueryMemo;
    DoSearchReplace;
  end;
end;


procedure TMainForm.DoSearchReplace;
var
  Occurences: Integer;
  OldCaretXY: TBufferCoord;
begin
  if SearchReplaceDialog.chkRegularExpression.Checked then
    SearchReplaceDialog.Editor.SearchEngine := SynEditRegexSearch1
  else
    SearchReplaceDialog.Editor.SearchEngine := SynEditSearch1;
  OldCaretXY := SearchReplaceDialog.Editor.CaretXY;
  SearchReplaceDialog.Editor.BeginUpdate;
  ShowStatusMsg('Searching ...');
  Occurences := SearchReplaceDialog.Editor.SearchReplace(
    SearchReplaceDialog.comboSearch.Text,
    SearchReplaceDialog.comboReplace.Text,
    SearchReplaceDialog.Options
    );
  SearchReplaceDialog.Editor.EndUpdate;
  ShowStatusMsg(STATUS_MSG_READY);
  if ssoReplaceAll in SearchReplaceDialog.Options then
    ShowStatusMsg('Text "'+SearchReplaceDialog.comboSearch.Text+'" '+FormatNumber(Occurences)+' times replaced.', 0)
  else begin
    if (OldCaretXY.Char = SearchReplaceDialog.Editor.CaretXY.Char) and
      (OldCaretXY.Line = SearchReplaceDialog.Editor.CaretXY.Line) then
      MessageDlg('Text "'+SearchReplaceDialog.comboSearch.Text+'" not found.', mtInformation, [mbOk], 0);
  end;
end;


procedure TMainForm.SynMemoQueryReplaceText(Sender: TObject; const ASearch,
  AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction);
begin
  // Fires when "Replace all" in search dialog was pressed with activated "Prompt on replace"
  case MessageDlg('Replace this occurrence of "'+sstr(ASearch, 100)+'"?', mtConfirmation, [mbYes, mbYesToAll, mbNo, mbCancel], 0) of
    mrYes: Action := raReplace;
    mrYesToAll: Action := raReplaceAll;
    mrNo: Action := raSkip;
    mrCancel: Action := raCancel;
  end;
end;


procedure TMainForm.actRefreshExecute(Sender: TObject);
var
  tab1, tab2: TTabSheet;
  List: TVirtualStringTree;
begin
  // Refresh
  // Force data tab update when appropriate.
  tab1 := PageControlMain.ActivePage;
  if ActiveControl = DBtree then
    RefreshTree(True)
  else if tab1 = tabHost then begin
    tab2 := PageControlHost.ActivePage;
    if tab2 = tabDatabases then
      List := ListDatabases
    else if tab2 = tabVariables then
      List := ListVariables
    else if tab2 = tabStatus then
      List := ListStatus
    else if tab2 = tabProcessList then
      List := ListProcesses
    else
      List := ListCommandStats;
    InvalidateVT(List, VTREE_NOTLOADED_PURGECACHE, True);
  end else if tab1 = tabDatabase then
    InvalidateVT(ListTables, VTREE_NOTLOADED_PURGECACHE, False)
  else if tab1 = tabData then
    InvalidateVT(DataGrid, VTREE_NOTLOADED_PURGECACHE, False);
end;


procedure TMainForm.actSQLhelpExecute(Sender: TObject);
var
  keyword : String;
  Col: TTableColumn;
begin
  // Call SQL Help from various places
  if Connection.ServerVersionInt < 40100 then
    exit;

  keyword := '';
  // Query-Tab
  if ActiveControl is TSynMemo then
    keyword := TSynMemo(ActiveControl).WordAtCursor
  // Data-Tab
  else if (PageControlMain.ActivePage = tabData)
    and Assigned(DataGrid.FocusedNode) then begin
    Col := TTableColumn(SelectedTableColumns[DataGrid.FocusedColumn]);
    keyword := Col.DataType.Name;
  end
  else if QueryTabActive and ActiveQueryHelpers.Focused then
  begin
    // Makes only sense if one of the tabs "SQL fn" or "SQL kw" was selected
    if ActiveQueryTabset.TabIndex in [1,2] then
    begin
      keyword := ActiveQueryHelpers.Items[ActiveQueryHelpers.ItemIndex];
    end;
  end;

  // Clean existing paranthesis, fx: char(64)
  if Pos( '(', keyword ) > 0 then
  begin
    keyword := Copy( keyword, 1, Pos( '(', keyword )-1 );
  end;

  // Show the window
  CallSQLHelpWithKeyword( keyword );
end;


{***
  Show SQL Help window directly using a keyword
  @param String SQL-keyword
  @see FieldeditForm.btnDatatypeHelp
}
procedure TMainform.CallSQLHelpWithKeyword( keyword: String );
begin
  if SQLHelpForm = nil then
    SQLHelpForm := TfrmSQLhelp.Create(Self);
  SQLHelpForm.Show;
  SQLHelpForm.Keyword := keyword;
end;


procedure TMainForm.actSaveSQLAsExecute(Sender: TObject);
var
  i: Integer;
  CanSave: TModalResult;
begin
  // Save SQL
  CanSave := mrNo;
  while (CanSave = mrNo) and SaveDialogSQLFile.Execute do begin
    // Save complete content or just the selected text,
    // depending on the tag of calling control
    CanSave := mrYes;
    for i:=0 to QueryTabs.Count-1 do begin
      if QueryTabs[i].MemoFilename = SaveDialogSQLFile.FileName then begin
        CanSave := MessageDlg('File '+CRLF+'"'+SaveDialogSQLFile.FileName+'"'+CRLF+'is already open in query tab #'+IntToStr(QueryTabs[i].Number)+'. Overwrite it?',
          mtWarning, [mbYes, mbNo, mbCancel], 0);
        break;
      end;
    end;
  end;
  if CanSave = mrYes then begin
    SaveQueryMemo(ActiveQueryTab, SaveDialogSQLFile.FileName, (Sender as TAction).Tag = 1);
    for i:=0 to QueryTabs.Count-1 do begin
      if QueryTabs[i] = ActiveQueryTab then
        continue;
      if QueryTabs[i].MemoFilename = SaveDialogSQLFile.FileName then
        QueryTabs[i].Memo.Modified := True;
    end;
    ValidateQueryControls(Sender);
  end;
end;


procedure TMainForm.actSaveSQLExecute(Sender: TObject);
var
  i: Integer;
begin
  if ActiveQueryTab.MemoFilename <> '' then begin
    SaveQueryMemo(ActiveQueryTab, ActiveQueryTab.MemoFilename, False);
    for i:=0 to QueryTabs.Count-1 do begin
      if QueryTabs[i] = ActiveQueryTab then
        continue;
      if QueryTabs[i].MemoFilename = ActiveQueryTab.MemoFilename then
        QueryTabs[i].Memo.Modified := True;
    end;
    ValidateQueryControls(Sender);
  end else
    actSaveSQLAsExecute(Sender);
end;


procedure TMainForm.SaveQueryMemo(Tab: TQueryTab; Filename: String; OnlySelection: Boolean);
var
  Text, LB: String;
begin
  Screen.Cursor := crHourGlass;
  if OnlySelection then
    Text := Tab.Memo.SelText
  else
    Text := Tab.Memo.Text;
  LB := '';
  case Tab.MemoLineBreaks of
    lbsUnix: LB := LB_UNIX;
    lbsMac: LB := LB_MAC;
    lbsWide: LB := LB_WIDE;
  end;
  if LB <> '' then
    Text := StringReplace(Text, CRLF, LB, [rfReplaceAll]);
  SaveUnicodeFile( Filename, Text );
  SetTabCaption(Tab.Number+tabData.PageIndex, ExtractFilename(Filename));
  Tab.MemoFilename := Filename;
  Tab.Memo.Modified := False;
  Screen.Cursor := crDefault;
end;


procedure TMainForm.actSaveSQLSnippetExecute(Sender: TObject);
var
  snippetname : String;
  mayChange   : Boolean;
  Text, LB: String;
begin
  // Save snippet
  if InputQuery( 'Save snippet', 'Snippet name:', snippetname) then
  begin
    if Copy( snippetname, Length(snippetname)-4, 4 ) <> '.sql' then
      snippetname := snippetname + '.sql';
    // cleanup snippetname from special characters
    snippetname := DirnameSnippets + goodfilename(snippetname);
    if FileExists( snippetname ) then
    begin
      if MessageDlg( 'Overwrite existing snippet '+snippetname+'?', mtConfirmation, [mbOK, mbCancel], 0 ) <> mrOK then
        exit;
    end;
    Screen.Cursor := crHourglass;
    // Save complete content or just the selected text,
    // depending on the tag of calling control
    case (Sender as TComponent).Tag of
      0: Text := ActiveQueryMemo.Text;
      1: Text := ActiveQueryMemo.SelText;
    end;
    LB := '';
    case ActiveQueryTab.MemoLineBreaks of
      lbsUnix: LB := LB_UNIX;
      lbsMac: LB := LB_MAC;
      lbsWide: LB := LB_WIDE;
    end;
    if LB <> '' then
      Text := StringReplace(Text, CRLF, LB, [rfReplaceAll]);
    if not DirectoryExists(DirnameSnippets) then
      ForceDirectories(DirnameSnippets);
    SaveUnicodeFile( snippetname, Text );
    FillPopupQueryLoad;
    if ActiveQueryTabset.TabIndex = 3 then begin
      // SQL Snippets selected in query helper, refresh list
      mayChange := True; // Unused; satisfies callee parameter collection which is probably dictated by tabset.
      tabsetQueryHelpersChange(Sender, 3, mayChange);
    end;
    Screen.Cursor := crDefault;
  end;
end;


procedure TMainForm.actQueryStopOnErrorsExecute(Sender: TObject);
begin
  // Weird fix: dummy routine to avoid the sending action getting disabled
end;


procedure TMainForm.actQueryWordWrapExecute(Sender: TObject);
begin
  ActiveQueryMemo.WordWrap := TAction(Sender).Checked;
end;


procedure TMainform.FillPopupQueryLoad;
var
  i, j: Integer;
  menuitem, snippetsfolder: TMenuItem;
  snippets: TStringList;
  sqlFilename: String;
begin
  // Fill the popupQueryLoad menu
  popupQueryLoad.Items.Clear;

  // Snippets
  snippets := getFilesFromDir( DirnameSnippets, '*.sql', true );
  snippetsfolder := TMenuItem.Create( popupQueryLoad );
  snippetsfolder.Caption := 'Snippets';
  popupQueryLoad.Items.Add(snippetsfolder);
  for i := 0 to snippets.Count - 1 do begin
    menuitem := TMenuItem.Create( snippetsfolder );
    menuitem.Caption := snippets[i];
    menuitem.OnClick := popupQueryLoadClick;
    snippetsfolder.Add(menuitem);
  end;

  // Separator
  menuitem := TMenuItem.Create( popupQueryLoad );
  menuitem.Caption := '-';
  popupQueryLoad.Items.Add(menuitem);

  // Recent files
  j := 0;
  for i:=0 to 19 do begin
    sqlFilename := GetRegValue( 'SQLFile'+IntToStr(i), '' );
    if sqlFilename = '' then
      continue;
    inc(j);
    menuitem := TMenuItem.Create( popupQueryLoad );
    menuitem.Caption := IntToStr(j) + ' ' + sqlFilename;
    menuitem.OnClick := popupQueryLoadClick;
    popupQueryLoad.Items.Add(menuitem);
  end;

  // Separator + "Remove absent files"
  menuitem := TMenuItem.Create( popupQueryLoad );
  menuitem.Caption := '-';
  popupQueryLoad.Items.Add(menuitem);
  menuitem := TMenuItem.Create( popupQueryLoad );
  menuitem.Caption := 'Remove absent files';
  menuitem.OnClick := PopupQueryLoadRemoveAbsentFiles;
  popupQueryLoad.Items.Add(menuitem);

end;


procedure TMainform.PopupQueryLoadRemoveAbsentFiles( sender: TObject );
begin
  AddOrRemoveFromQueryLoadHistory( '', false, true );
  FillPopupQueryLoad;
end;

procedure TMainform.popupQueryLoadClick( sender: TObject );
var
  filename : String;
  p        : Integer;
begin
  // Click on the popupQueryLoad
  filename := (Sender as TMenuItem).Caption;
  if Pos( '\', filename ) = 0 then
  begin // assuming we load a snippet
    filename := DirnameSnippets + filename + '.sql';
  end
  else
  begin // assuming we load a file from the recent-list
    p := Pos( ' ', filename ) + 1;
    filename := Copy(filename, p, Length(filename));
  end;
  filename := Stringreplace(filename, '&', '', [rfReplaceAll]);
  QueryLoad( filename );
end;


procedure TMainform.AddOrRemoveFromQueryLoadHistory( filename: String; AddIt: Boolean = true; CheckIfFileExists: Boolean = true );
var
  i                     : Integer;
  Values, newfilelist   : TStringList;
  savedfilename         : String;
begin
  // Add or remove filename to/from history, avoiding duplicates

  newfilelist := TStringList.create;
  Values := TStringList.create;
  OpenRegistry;
  MainReg.GetValueNames( Values );

  // Add new filename
  if AddIt then
    newfilelist.Add( filename );

  // Add all other filenames
  for i:=0 to Values.Count-1 do begin
    if Pos( 'SQLFile', Values[i] ) <> 1 then
      continue;
    savedfilename := GetRegValue( Values[i], '' );
    MainReg.DeleteValue( Values[i] );
    if CheckIfFileExists and (not FileExists( savedfilename )) then
      continue;
    if (savedfilename <> filename) and (newfilelist.IndexOf(savedfilename)=-1) then
      newfilelist.add( savedfilename );
  end;

  // Save new list
  for i := 0 to newfilelist.Count-1 do begin
    if i >= 20 then
      break;
    MainReg.WriteString( 'SQLFile'+IntToStr(i), newfilelist[i] );
  end;
end;


{**
  Change default delimiter for SQL execution
}
procedure TMainForm.actSetDelimiterExecute(Sender: TObject);
var
  newVal: String;
  ok: Boolean;
begin
  // Use a while loop to redisplay the input dialog after setting an invalid value
  ok := False;
  while not ok do begin
    newVal := delimiter;
    if InputQuery('Set delimiter', 'SQL statement delimiter (default is ";"):', newVal) then try
      // Set new value
      Delimiter := newVal;
      ok := True;
    except on E:Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end else // Cancel clicked
      ok := True;
  end;
end;


{**
  Validates and sets the Delimiter property plus updates the hint on actSetDelimiter
}
procedure TMainForm.SetDelimiter(Value: String);
var
  ErrMsg: String;
begin
  ErrMsg := '';
  Value := Trim(Value);
  // Test for empty delimiter.
  if Value = '' then ErrMsg := 'DELIMITER must be followed by a non-comment character or string';
  // Disallow backslash, because the MySQL CLI does so for some reason.
  // Then again, is there any reason to be bug-per-bug compatible with some random SQL parser?
  if Pos('\', Value) > 0 then ErrMsg := 'Backslash disallowed in DELIMITER (because the MySQL CLI does not accept it)';
  // Disallow stuff which would be negated by the comment parsing logic.
  if
    (Pos('/*', Value) > 0) or
    (Pos('--', Value) > 0) or
    (Pos('#', Value) > 0)
  then ErrMsg := 'Start-of-comment tokens disallowed in DELIMITER (because it would be ignored)';
  // Disallow stuff which would be negated by the SQL parser (and could slightly confuse it, if at end-of-string).
  if
    (Pos('''', Value) > 0) or
    (Pos('`', Value) > 0) or
    (Pos('"', Value) > 0)
  then ErrMsg := 'String literal markers disallowed in DELIMITER (because it would be ignored)';

  // Reset an invalid delimiter loaded from registry at startup to the default value
  if (ErrMsg <> '') and (Delimiter = '') then begin
    Value := DEFAULT_DELIMITER;
    ErrMsg := '';
  end;
  // Raise or set it
  if ErrMsg <> '' then begin
    ErrMsg := Format('Invalid delimiter %s: %s.', [Value, ErrMsg]);
    LogSQL(ErrMsg);
    Raise Exception.Create(ErrMsg);
  end else begin
    FDelimiter := Value;
    LogSQL(Format('Delimiter changed to %s.', [Delimiter]));
    actSetDelimiter.Hint := actSetDelimiter.Caption + ' (current value: '+Delimiter+')';
  end;
end;


procedure TMainForm.actApplyFilterExecute(Sender: TObject);
var
  i, nr: Integer;
  OldNumbers, Filters: TStringList;
  val: String;
begin
  // If filter box is empty but filter generator box not, most users expect
  // the filter to be auto generated on button click
  if (SynMemoFilter.GetTextLen = 0) and (editFilterSearch.Text <> '') then
    editFilterSearchChange(editFilterSearch);

  if SynMemoFilter.GetTextLen > 0 then begin
    // Recreate recent filters list
    Filters := TStringList.Create;
    OldNumbers := TStringList.Create;
    Filters.Add(Trim(SynMemoFilter.Text));
    MainReg.OpenKey(GetRegKeyTable+'\'+REGNAME_FILTERS, True);
    MainReg.GetValueNames(OldNumbers);
    OldNumbers.CustomSort(CompareNumbers);
    // Add old filters
    for i := 0 to OldNumbers.Count - 1 do begin
      nr := MakeInt(OldNumbers[i]);
      if nr = 0 then continue; // Not a valid entry, ignore that
      val := MainReg.ReadString(OldNumbers[i]);
      if Filters.IndexOf(val) = -1 then
        Filters.Add(val);
      MainReg.DeleteValue(OldNumbers[i]);
    end;
    for i := 1 to Filters.Count do begin
      MainReg.WriteString(IntToStr(i), Filters[i-1]);
      // Avoid too much registry spam with mega old filters
      if i = 20 then break;
    end;
    FreeAndNil(OldNumbers);
    FreeAndNil(Filters);
  end;
  InvalidateVT(DataGrid, VTREE_NOTLOADED_PURGECACHE, False);
end;


procedure TMainForm.actDataFirstExecute(Sender: TObject);
var
  Node: PVirtualNode;
begin
  Node := DataGrid.GetFirst;
  if Assigned(Node) then begin
    DataGrid.ClearSelection;
    DataGrid.FocusedNode := Node;
    DataGrid.Selected[Node] := True;
  end;
end;

procedure TMainForm.actDataInsertExecute(Sender: TObject);
begin
  DataGridInsertRow(nil);
end;


procedure TMainForm.actDataDuplicateRowExecute(Sender: TObject);
begin
  DataGridEnsureFullRow(DataGrid, DataGrid.FocusedNode);
  DataGridInsertRow(DataGrid.FocusedNode);
end;


procedure TMainForm.actDataLastExecute(Sender: TObject);
var
  Node: PVirtualNode;
begin
  // Be sure to have all rows
  if DatagridWantedRowCount < prefGridRowcountMax then
    actDataShowAll.Execute;
  Node := DataGrid.GetLast;
  if Assigned(Node) then
    SelectNode(DataGrid, Node);
end;

procedure TMainForm.actDataPostChangesExecute(Sender: TObject);
begin
  DataGridPostUpdateOrInsert(Datagrid.FocusedNode);
end;

procedure TMainForm.actRemoveFilterExecute(Sender: TObject);
begin
  actClearFilterEditor.Execute;
  InvalidateVT(DataGrid, VTREE_NOTLOADED_PURGECACHE, False);
end;


procedure TMainForm.actDataCancelChangesExecute(Sender: TObject);
begin
  DataGridCancel(Sender);
end;


procedure TMainForm.actSelectTreeBackgroundExecute(Sender: TObject);
var
  cs: TColorSelect;
begin
  // Select database tree background color
  cs := TColorSelect.Create(Self);
  cs.Dialog.Color := DBtree.Color;
  if cs.Execute then begin
    DBtree.Color := cs.Dialog.Color;
    OpenRegistry(SessionName);
    MainReg.WriteInteger(REGNAME_TREEBACKGROUND, cs.Dialog.Color);
  end;
end;


{**
  Add a SQL-command or comment to SynMemoSQLLog
}
procedure TMainForm.LogSQL(Msg: String; Category: TMySQLLogCategory=lcInfo);
var
  snip, IsSQL: Boolean;
begin
  if csDestroying in ComponentState then
    Exit;

  // Log only wanted events
  case Category of
    lcError: if not prefLogErrors then Exit;
    lcUserFiredSQL: if not prefLogUserSQL then Exit;
    lcSQL: if not prefLogSQL then Exit;
    lcInfo: if not prefLogInfos then Exit;
    lcDebug: if not prefLogDebug then Exit;
  end;

  // Shorten very long messages
  snip := (prefLogSqlWidth > 0) and (Length(Msg) > prefLogSqlWidth);
  IsSQL := Category in [lcSQL, lcUserFiredSQL];
  if snip then begin
    Msg :=
      Copy(Msg, 0, prefLogSqlWidth) +
      '/* large SQL query, snipped at  ' +
      FormatNumber(prefLogSqlWidth) +
      ' characters */';
  end else if (not snip) and IsSQL then
    Msg := Msg + Delimiter;
  if not IsSQL then
    Msg := '/* ' + Msg + ' */';

  Msg := StringReplace(Msg, #9, ' ', [rfReplaceAll]);
  Msg := StringReplace(Msg, #10, ' ', [rfReplaceAll]);
  Msg := StringReplace(Msg, #13, ' ', [rfReplaceAll]);
  Msg := StringReplace(Msg, '  ', ' ', [rfReplaceAll]);
  SynMemoSQLLog.Lines.Add(Msg);
  TrimSQLLog;

  // Scroll to last line and repaint
  SynMemoSQLLog.GotoLineAndCenter(SynMemoSQLLog.Lines.Count);
  SynMemoSQLLog.Repaint;

  // Log to file?
  if prefLogToFile then
  try
    WriteLn(FileHandleSessionLog, Format('/* %s */ %s', [DateTimeToStr(Now), msg]));
  except
    DeactivateFileLogging;
    MessageDlg('Error writing to session log file:'+CRLF+FileNameSessionLog+CRLF+CRLF+'Logging is disabled now.', mtError, [mbOK], 0);
  end;
end;


{**
  Delete first line(s) in SQL log and adjust LineNumberStart in gutter
  Called by LogSQL and preferences dialog
}
procedure TMainForm.TrimSQLLog;
var
  i : Integer;
begin
  i := 0;
  while SynMemoSQLLog.Lines.Count > prefLogsqlnum do
  begin
    SynMemoSQLLog.Lines.Delete(0);
    inc(i);
  end;
  // Increase first displayed number in gutter so it doesn't lie about the log entries
  if i > 0 then
    SynMemoSQLLog.Gutter.LineNumberStart := SynMemoSQLLog.Gutter.LineNumberStart + i;
end;


procedure TMainForm.actDataShowNextExecute(Sender: TObject);
var
  OldRowCount: Int64;
begin
  // Show next X rows in datagrid
  OldRowCount := DatagridWantedRowCount;
  Inc(DatagridWantedRowCount, prefGridRowcountStep);
  DataGridWantedRowCount := Min(DataGridWantedRowCount, prefGridRowcountMax);
  InvalidateVT(DataGrid, VTREE_NOTLOADED, True);
  SelectNode(DataGrid, OldRowCount);
end;


procedure TMainForm.actDataShowAllExecute(Sender: TObject);
begin
  // Remove LIMIT clause
  DatagridWantedRowCount := prefGridRowcountMax;
  InvalidateVT(DataGrid, VTREE_NOTLOADED, True);
end;


function TMainForm.DataGridEnsureFullRow(Grid: TVirtualStringTree; Node: PVirtualNode): Boolean;
var
  i: Integer;
  Row: PGridRow;
  Select: String;
  Data: TMySQLQuery;
begin
  // Load remaining data on a partially loaded row in data grid
  if Grid <> DataGrid then begin
    Result := True;
    Exit;
  end;
  Row := @DataGridResult.Rows[Node.Index];
  if not DataGridRowHasFullData(Node) then begin
    Select := 'SELECT ';
    for i:=0 to Length(DataGridResult.Columns)-1 do
      Select := Select + mask(DataGridResult.Columns[i].Name) + ', ';
    Delete(Select, Length(Select)-1, 2);
    Select := Select +
      ' FROM '+mask(SelectedTable.Name) +
      ' WHERE '+GetWhereClause(Row, @DataGridResult.Columns) +
      ' LIMIT 1';
    try
      Data := Connection.GetResults(Select);
      if Data.RecordCount = 0 then
        raise Exception.Create('Unable to find row.');
      for i:=0 to Length(DataGridResult.Columns)-1 do begin
        case DataGridResult.Columns[i].DatatypeCat of
          dtcInteger, dtcReal: Row.Cells[i].Text := FormatNumber(Data.Col(i), False);
          dtcBinary: Row.Cells[i].Text := GetBlobContent(Data, i);
          else Row.Cells[i].Text := Data.Col(i);
        end;
        Row.Cells[i].IsNull := Data.IsNull(i);
      end;
      Row.HasFullData := True;
    except On E:Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  Result := Row.HasFullData;
end;


procedure TMainForm.DataGridEnsureFullRows(Grid: TVirtualStringTree; SelectedOnly: Boolean);
var
  Node: PVirtualNode;
begin
  // Load remaining data of all grid rows
  if Grid <> DataGrid then
    Exit;
  if SelectedOnly then
    Node := Grid.GetFirstSelected
  else
    Node := Grid.GetFirst;
  while Assigned(Node) do begin
    if not DataGridRowHasFullData(Node) then begin
      DataGridFullRowMode := True;
      InvalidateVT(Grid, VTREE_NOTLOADED_PURGECACHE, True);
      break;
    end;
    if SelectedOnly then
      Node := Grid.GetNextSelected(Node)
    else
      Node := Grid.GetNext(Node);
  end;
end;


function TMainForm.DataGridRowHasFullData(Node: PVirtualNode): Boolean;
var
  i: Integer;
  HasFullData: Boolean;
  Row: PGridRow;
begin
  Row := @DataGridResult.Rows[Node.Index];
  if not Row.HasFullData then begin
    HasFullData := True;
    for i:=0 to Length(DataGridResult.Columns)-1 do begin
      HasFullData := Length(Row.Cells[i].Text) < GRIDMAXDATA;
      if not HasFullData then
        break;
    end;
    Row.HasFullData := HasFullData;
  end;
  Result := Row.HasFullData;
end;


procedure TMainForm.DataGridBeforePaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
var
  vt: TVirtualStringTree;
  Data: TMySQLQuery;
  Select: String;
  RefreshingData, IsKeyColumn: Boolean;
  i, j, Offset, ColLen, ColWidth: Integer;
  KeyCols, ColWidths: TStringList;
  WantedColumns: TTableColumnList;
  Cell: PGridCell;
  c: TTableColumn;

  procedure InitColumn(idx: Integer; TblCol: TTableColumn);
  var
    k: Integer;
    Col: TVirtualTreeColumn;
  begin
    SetLength(DataGridResult.Columns, idx+1);
    DataGridResult.Columns[idx].Name := TblCol.Name;
    col := vt.Header.Columns.Add;
    col.Text := TblCol.Name;
    col.Hint := TblCol.Comment;
    col.Options := col.Options + [coSmartResize];
    if DatagridHiddenColumns.IndexOf(TblCol.Name) > -1 then
      col.Options := col.Options - [coVisible];
    // Sorting color and title image
    for k:=0 to Length(DataGridSortColumns)-1 do begin
      if DataGridSortColumns[k].ColumnName = TblCol.Name then begin
        col.Color := ColorAdjustBrightness(col.Color, COLORSHIFT_SORTCOLUMNS);
        case DataGridSortColumns[k].SortDirection of
          ORDER_ASC:  col.ImageIndex := 109;
          ORDER_DESC: col.ImageIndex := 110;
        end;
      end;
    end;
    if col.ImageIndex = -1 then begin
      for k:=0 to SelectedTableKeys.Count-1 do begin
        if SelectedTableKeys[k].Columns.IndexOf(TblCol.Name) > -1 then begin
          col.ImageIndex := GetIndexIcon(SelectedTableKeys[k].IndexType);
          break;
        end;
      end;
    end;

    // Data type
    DataGridResult.Columns[idx].DatatypeCat := TblCol.DataType.Category;
    DataGridResult.Columns[idx].Datatype := TblCol.DataType.Index;
    col.Alignment := taLeftJustify;
    case DataGridResult.Columns[idx].DatatypeCat of
      dtcInteger, dtcReal: col.Alignment := taRightJustify;
      dtcText: begin
        if TblCol.LengthSet <> '' then
          DataGridResult.Columns[idx].MaxLength := MakeInt(TblCol.LengthSet)
        else case TblCol.DataType.Index of
          // 255 is the width in bytes. If characters that use multiple bytes are
          // contained, the width in characters is decreased below this number.
          dtTinyText: DataGridResult.Columns[idx].MaxLength := 255;
          dtText: DataGridResult.Columns[idx].MaxLength := 65535;
          dtMediumText: DataGridResult.Columns[idx].MaxLength := 16777215;
          dtLongText: DataGridResult.Columns[idx].MaxLength := 4294967295;
        end;
      end;
      dtcIntegerNamed: begin
        DataGridResult.Columns[idx].ValueList := TStringList.Create;
        DataGridResult.Columns[idx].ValueList.QuoteChar := '''';
        DataGridResult.Columns[idx].ValueList.Delimiter := ',';
        DataGridResult.Columns[idx].ValueList.DelimitedText := TblCol.LengthSet;
      end;
      dtcSetNamed: begin
        DataGridResult.Columns[idx].ValueList := TStringList.Create;
        DataGridResult.Columns[idx].ValueList.QuoteChar := '''';
        DataGridResult.Columns[idx].ValueList.Delimiter := ',';
        DataGridResult.Columns[idx].ValueList.DelimitedText := TblCol.LengthSet;
      end;
      else DataGridResult.Columns[idx].MaxLength := MaxInt; // Fallback for unknown column types
    end;
    DataGridResult.Columns[idx].IsPriPart := Data.ColIsPrimaryKeyPart(idx);
  end;

begin
  // Load data into data tab grid
  vt := Sender as TVirtualStringTree;
  if vt.Tag = VTREE_LOADED then
    Exit;
  Screen.Cursor := crHourglass;

  // No data for routines
  if SelectedTableColumns.Count = 0 then begin
    vt.Enabled := False;
    pnlDataTop.Enabled := False;
    pnlFilter.Enabled := False;
    lblSorryNoData.Parent := DataGrid;
  end else begin
    vt.Enabled := True;
    pnlDataTop.Enabled := True;
    pnlFilter.Enabled := True;
    lblSorryNoData.Parent := tabData;

    // Indicates whether the current table data is just refreshed or if we're in another table
    RefreshingData := (ActiveDatabase = DataGridDB) and (SelectedTable.Name = DataGridTable);

    // Load last view settings
    HandleDataGridAttributes(RefreshingData);

    DataGridDB := SelectedTable.Database;
    DataGridTable := SelectedTable.Name;

    Select := 'SELECT ';
    // Ensure key columns are included to enable editing
    KeyCols := GetKeyColumns;
    WantedColumns := TTableColumnList.Create(False);
    for i:=0 to SelectedTableColumns.Count-1 do begin
      c := SelectedTableColumns[i];
      IsKeyColumn := KeyCols.IndexOf(c.Name) > -1;
      ColLen := MakeInt(c.LengthSet);
      if (DatagridHiddenColumns.IndexOf(c.Name) = -1)
        or (IsKeyColumn)
        or (KeyCols.Count = 0)
        then begin
        if not DataGridFullRowMode
          and (KeyCols.Count > 0) // We need a sufficient key to be able to load remaining row data
          and (c.DataType.Category in [dtcText, dtcBinary])
          and (not IsKeyColumn) // We need full length of any key column, so DataGridLoadFullRow() has the chance to fetch the right row
          and ((ColLen > GRIDMAXDATA) or (ColLen = 0)) // No need to blow SQL with LEFT() if column is shorter anyway
          then
            Select := Select + ' LEFT(' + Mask(c.Name) + ', ' + IntToStr(GRIDMAXDATA) + '), '
          else
            Select := Select + ' ' + Mask(c.Name) + ', ';
        WantedColumns.Add(c);
      end;
    end;
    // Cut last comma
    Delete(Select, Length(Select)-1, 2);
    // Include db name for cases in which dbtree is switching databases and pending updates are in process
    Select := Select + ' FROM '+mask(ActiveDatabase)+'.'+mask(SelectedTable.Name);

    // Signal for the user if we hide some columns
    if WantedColumns.Count = SelectedTableColumns.Count then
      tbtnDataColumns.ImageIndex := 107
    else
      tbtnDataColumns.ImageIndex := 108;

    // Append WHERE clause
    if SynMemoFilter.GetTextLen > 0 then begin
      Select := Select + ' WHERE ' + SynMemoFilter.Text;
      tbtnDataFilter.ImageIndex := 108;
    end else
      tbtnDataFilter.ImageIndex := 107;

    // Append ORDER clause
    if Length(DataGridSortColumns) > 0 then begin
      Select := Select + ' ORDER BY ' + ComposeOrderClause(DataGridSortColumns);
      tbtnDataSorting.ImageIndex := 108;
    end else
      tbtnDataSorting.ImageIndex := 107;

    // Append LIMIT clause
    if RefreshingData and (vt.Tag <> VTREE_NOTLOADED_PURGECACHE) then
      Offset := Length(DataGridResult.Rows)
    else
      Offset := 0;
    Select := Select + ' LIMIT '+IntToStr(Offset)+', '+IntToStr(DatagridWantedRowCount-Offset);

    try
      ShowStatusMsg('Fetching rows ...');
      Data := Connection.GetResults(Select);
    except
      // Wrong WHERE clause in most cases
      On E:Exception do
        MessageDlg(E.Message, mtError, [mbOK], 0);
    end;

    if Assigned(Data) then begin

      // Set up grid column headers
      ShowStatusMsg('Setting up columns ...');
      ColWidths := TStringList.Create;
      for i:=0 to vt.Header.Columns.Count-1 do
        ColWidths.Values[vt.Header.Columns[i].Text] := IntToStr(vt.Header.Columns[i].Width);
      SetLength(DataGridResult.Columns, Data.ColumnCount);
      vt.Header.Columns.BeginUpdate;
      vt.Header.Columns.Clear;
      for i:=0 to WantedColumns.Count-1 do
        InitColumn(i, WantedColumns[i]);

      // Set up grid rows and data array
      ShowStatusMsg('Copying rows to internal structure ...');
      vt.BeginUpdate;
      SetLength(DataGridResult.Rows, Offset+Data.RecordCount);
      for i:=Offset to Offset+Data.RecordCount-1 do begin
        DataGridResult.Rows[i].HasFullData := DataGridFullRowMode or (KeyCols.Count = 0);
        for j:=0 to Length(DataGridResult.Columns)-1 do begin
          SetLength(DataGridResult.Rows[i].Cells, Data.ColumnCount);
          Cell := @DataGridResult.Rows[i].Cells[j];
          case DataGridResult.Columns[j].DatatypeCat of
            dtcInteger, dtcReal: Cell.Text := FormatNumber(Data.Col(j), False);
            dtcBinary: Cell.Text := GetBlobContent(Data, j);
            else Cell.Text := Data.Col(j);
          end;
          Cell.IsNull := Data.IsNull(j);
        end;
        Data.Next;
      end;
      ShowStatusMsg('Freeing memory ...');
      FreeAndNil(Data);
      vt.RootNodeCount := Length(DataGridResult.Rows);

      // Autoset or restore column width
      for i:=0 to vt.Header.Columns.Count-1 do begin
        ColWidth := 0;
        if RefreshingData then
          ColWidth := StrToIntDef(ColWidths.Values[vt.Header.Columns[i].Text], ColWidth);
        if ColWidth > 0 then
          vt.Header.Columns[i].Width := ColWidth
        else
          AutoCalcColWidth(vt, i);
      end;
      ColWidths.Free;

      vt.Header.Columns.EndUpdate;
      vt.EndUpdate;
      // Do not steel filter while writing filters
      if not SynMemoFilter.Focused then
        vt.SetFocus;

      if not RefreshingData then begin
        // Scroll to top left if switched to another table
        vt.OffsetXY := Point(0, 0);
      end;
      if vt.RootNodeCount > DataGridFocusedNodeIndex then begin
        SelectNode(vt, DataGridFocusedNodeIndex);
        for i:=0 to vt.Header.Columns.Count-1 do begin
          if vt.Header.Columns[i].Text = DataGridFocusedColumnName then begin
            vt.FocusedColumn := i;
            break;
          end;
        end;
      end;

      DisplayRowCountStats;
      actDataShowNext.Enabled := (vt.RootNodeCount = DatagridWantedRowCount) and (DatagridWantedRowCount < prefGridRowcountMax);
      actDataShowAll.Enabled := actDataShowNext.Enabled;
      EnumerateRecentFilters;
      if Integer(vt.RootNodeCount) = prefGridRowcountMax then
        LogSQL('Browsing is currently limited to a maximum of '+FormatNumber(prefGridRowcountMax)+' rows. To see more rows, decrease this maximum in Tools > Preferences > Data .', lcInfo);
    end;
  end;
  vt.Tag := VTREE_LOADED;
  DataGridFullRowMode := False;
  Screen.Cursor := crDefault;
  ShowStatusMsg(STATUS_MSG_READY);
end;


{***
  Calculate + display total rowcount and found rows matching to filter
  in data-tab
}
procedure TMainForm.DisplayRowCountStats;
var
  DBObject: TDBObject;
  IsFiltered, IsLimited: Boolean;
  cap: String;
  RowsTotal: Int64;
begin
  DBObject := SelectedTable;
  cap := ActiveDatabase + '.' + DBObject.Name;
  IsLimited := DataGridWantedRowCount <= Datagrid.RootNodeCount;
  IsFiltered := SynMemoFilter.GetTextLen > 0;
  if DBObject.NodeType = lntTable then begin
    if (not IsLimited) and (not IsFiltered) then
      RowsTotal := DataGrid.RootNodeCount // No need to fetch via SHOW TABLE STATUS
    else
      RowsTotal := MakeInt(Connection.GetVar('SHOW TABLE STATUS LIKE '+esc(DBObject.Name), 'Rows'));
    if RowsTotal > -1 then begin
      cap := cap + ': ' + FormatNumber(RowsTotal) + ' rows total';
      if DBObject.Engine = 'InnoDB' then
        cap := cap + ' (approximately)';
      // Display either LIMIT or WHERE effect, not both at the same time
      if IsLimited then
        cap := cap + ', limited to ' + FormatNumber(Datagrid.RootNodeCount)
      else if IsFiltered then begin
        if Datagrid.RootNodeCount = RowsTotal then
          cap := cap + ', all rows match to filter'
        else
          cap := cap + ', ' + FormatNumber(Datagrid.RootNodeCount) + ' rows match to filter';
      end;
    end;
  end;
  lblDataTop.Caption := cap;
end;


procedure TMainForm.AnyGridInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  // Display multiline grid rows
  if prefGridRowsLineCount = DEFAULT_GRIDROWSLINECOUNT then
    Exclude(Node.States, vsMultiLine)
  else
    Include(Node.States, vsMultiLine);
end;


{***
  Occurs when active tab has changed.
}
procedure TMainForm.PageControlMainChange(Sender: TObject);
var
  tab: TTabSheet;
begin
  tab := PageControlMain.ActivePage;

  // Move focus to relevant controls in order for them to receive keyboard events.
  // Do this only if the user clicked the new tab. Not on automatic tab changes.
  if Sender = PageControlMain then begin
    if tab = tabHost then PageControlHostChange(Sender)
    else if tab = tabDatabase then ListTables.SetFocus
    else if tab = tabData then begin
      if DataGrid.CanFocus then
        DataGrid.SetFocus;
    end else if IsQueryTab(tab.PageIndex, True) then begin
      ActiveQueryMemo.SetFocus;
      ActiveQueryMemo.WordWrap := actQueryWordWrap.Checked;
      SynMemoQueryStatusChange(ActiveQueryMemo, []);
    end;
  end;

  // Filter panel has one text per tab, which we need to update
  UpdateFilterPanel(Sender);

  // Ensure controls are in a valid state
  ValidateControls(Sender);
  FixQueryTabCloseButtons;
end;


procedure TMainForm.PageControlHostChange(Sender: TObject);
var
  tab: TTabSheet;
  list: TBaseVirtualTree;
begin
  tab := PageControlHost.ActivePage;
  if tab = tabDatabases then list := ListDatabases
  else if tab = tabVariables then list := ListVariables
  else if tab = tabStatus then list := ListStatus
  else if tab = tabProcesslist then list := ListProcesses
  else if tab = tabCommandStats then list := ListCommandStats
  else Exit; // Silence compiler warning
  list.SetFocus;
  UpdateFilterPanel(Sender);
end;


procedure TMainForm.ListTablesBeforePaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
var
  i, NumObj: Integer;
  Obj: TDBObject;
  Objects: TDBObjectList;
  NumObjects: TStringList;
  Msg: String;
  vt: TVirtualStringTree;
begin
  // DB-Properties
  vt := Sender as TVirtualStringTree;
  if vt.Tag = VTREE_LOADED then
    Exit;

  Screen.Cursor := crHourGlass;

  ShowStatusMsg( 'Displaying objects from "' + ActiveDatabase + '" ...' );
  Objects := Connection.GetDBObjects(ActiveDatabase, vt.Tag = VTREE_NOTLOADED_PURGECACHE);
  ListTables.BeginUpdate;
  ListTables.RootNodeCount := Objects.Count;
  ListTables.ReinitChildren(nil, false);
  ListTables.EndUpdate;
  vt.Tag := VTREE_LOADED;

  NumObjects := TStringList.Create;
  DBObjectsMaxSize := 1;
  DBObjectsMaxRows := 1;
  for i:=0 to Objects.Count-1 do begin
    Obj := Objects[i];
    NumObj := StrToIntDef(NumObjects.Values[Obj.ObjType], 0);
    Inc(NumObj);
    NumObjects.Values[Obj.ObjType] := IntToStr(NumObj);
    if Obj.Size > DBObjectsMaxSize then DBObjectsMaxSize := Obj.Size;
    if Obj.Rows > DBObjectsMaxRows then DBObjectsMaxRows := Obj.Rows;
  end;
  Msg := ActiveDatabase + ': ' + FormatNumber(Objects.Count) + ' ';
  if NumObjects.Count = 1 then
    Msg := Msg + LowerCase(NumObjects.Names[0])
  else
    Msg := Msg + 'object';
  if Objects.Count <> 1 then Msg := Msg + 's';
  if (NumObjects.Count > 1) and (Objects.Count > 0) then begin
    Msg := Msg + ' (';
    for i:=0 to NumObjects.Count-1 do begin
      NumObj := StrToIntDef(NumObjects.ValueFromIndex[i], 0);
      if NumObj = 0 then
        Continue;
      Msg := Msg + FormatNumber(NumObj) + ' ' + LowerCase(NumObjects.Names[i]);
      if NumObj <> 1 then Msg := Msg + 's';
      Msg := Msg + ', ';
    end;
    Delete(Msg, Length(Msg)-1, 2);
    Msg := Msg + ')';
  end;
  ShowStatusMsg(Msg, 0);
  ShowStatusMsg(STATUS_MSG_READY);
  Screen.Cursor := crDefault;
  // Ensure tree db node displays its chidren initialized
  DBtree.ReinitChildren(FindDBNode(ActiveDatabase), False);
  ValidateControls(Self);
end;


procedure TMainForm.ListTablesGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  Obj: PDBObject;
begin
  if not (Kind in [ikNormal, ikSelected]) then
    Exit;
  if Column <> (Sender as TVirtualStringTree).Header.MainColumn then
    Exit;
  Obj := Sender.GetNodeData(Node);
  ImageIndex := Obj.ImageIndex;
end;


procedure TMainForm.ListTablesGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TDBObject);
end;


procedure TMainForm.ListTablesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Obj: PDBObject;
begin
  Obj := Sender.GetNodeData(Node);
  CellText := '';
  case Column of
    0: CellText := Obj.Name;
    1: if Obj.Rows > -1 then CellText := FormatNumber(Obj.Rows);
    2: if Obj.Size > -1 then CellText := FormatByteNumber(Obj.Size);
    3: if Obj.Created <> 0 then CellText := DateTimeToStr(Obj.Created);
    4: if Obj.Updated <> 0 then CellText := DateTimeToStr(Obj.Updated);
    5: CellText := Obj.Engine;
    6: CellText := Obj.Comment;
    7: if Obj.Version > -1 then CellText := IntToStr(Obj.Version);
    8: CellText := Obj.RowFormat;
    9: if Obj.AvgRowLen > -1 then CellText := FormatByteNumber(Obj.AvgRowLen);
    10: if Obj.MaxDataLen > -1 then CellText := FormatByteNumber(Obj.MaxDataLen);
    11: if Obj.IndexLen > -1 then CellText := FormatByteNumber(Obj.IndexLen);
    12: if Obj.DataFree > -1 then CellText := FormatByteNumber(Obj.DataFree);
    13: if Obj.AutoInc > -1 then CellText := FormatNumber(Obj.AutoInc);
    14: if Obj.LastChecked <> 0 then CellText := DateTimeToStr(Obj.LastChecked);
    15: CellText := Obj.Collation;
    16: if Obj.Checksum > -1 then CellText := IntToStr(Obj.Checksum);
    17: CellText := Obj.CreateOptions;
    18: CellText := Obj.ObjType;
  end;
end;


procedure TMainForm.ListTablesInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Obj: PDBObject;
  Objects: TDBObjectList;
begin
  Obj := Sender.GetNodeData(Node);
  Objects := Connection.GetDBObjects(ActiveDatabase);
  Obj^ := Objects[Node.Index];
end;



{***
  Selection in ListTables is changing
}
procedure TMainForm.ListTablesChange(Sender: TBaseVirtualTree; Node:
    PVirtualNode);
begin
  ValidateControls(Sender);
end;



{***
  Enable/disable various buttons and menu items.
  Invoked when
    - active sheet changes
    - highlighted database changes
    ...
}
procedure TMainForm.ValidateControls(Sender: TObject);
var
  inDataGrid, inDataTab, inDataOrQueryTab, inDataOrQueryTabNotEmpty: Boolean;
  SelectedNodes: TNodeArray;
begin
  inDataTab := PageControlMain.ActivePage = tabData;
  inDataGrid := ActiveControl = DataGrid;
  inDataOrQueryTab := (PageControlMain.ActivePage = tabData) or QueryTabActive;
  inDataOrQueryTabNotEmpty := inDataOrQueryTab and (ActiveGrid.RootNodeCount > 0);

  SelectedNodes := ListTables.GetSortedSelection(False);

  actSQLhelp.Enabled := Connection.ServerVersionInt >= 40100;
  actImportCSV.Enabled := Connection.ServerVersionInt >= 32206;

  // Data tab - if query results are made editable, these will need
  //            to be changed to look at which tab is focused.
  actDataInsert.Enabled := inDataGrid;
  actDataDuplicateRow.Enabled := inDataGrid and Assigned(ActiveGrid.FocusedNode);
  actDataDelete.Enabled := inDataGrid and (DataGrid.SelectedCount > 0);
  actDataFirst.Enabled := inDataGrid;
  actDataLast.Enabled := inDataGrid;
  actDataPostChanges.Enabled := inDataGrid and DataGridHasChanges;
  actDataCancelChanges.Enabled := inDataGrid and DataGridHasChanges;
  if (not inDataTab) and DataGrid.IsEditing then
    DataGrid.EndEditNode;

  // Activate export-options if we're on Data- or Query-tab
  actCopyAsCSV.Enabled := inDataOrQueryTabNotEmpty;
  actCopyAsHTML.Enabled := inDataOrQueryTabNotEmpty;
  actCopyAsXML.Enabled := inDataOrQueryTabNotEmpty;
  actCopyAsSQL.Enabled := inDataOrQueryTabNotEmpty;
  actExportData.Enabled := inDataOrQueryTabNotEmpty;
  actHTMLView.Enabled := inDataOrQueryTabNotEmpty and Assigned(ActiveGrid.FocusedNode);
  setNull1.Enabled := inDataGrid and Assigned(DataGrid.FocusedNode);

  // Query tab
  // Manually invoke OnChange event of tabset to fill helper list with data
  if QueryTabActive then RefreshQueryHelpers;

  ValidateQueryControls(Sender);
  UpdateLineCharPanel;
end;

procedure TMainForm.RefreshQueryHelpers;
var
  dummy: Boolean;
begin
  dummy := True;
  ActiveQueryTabset.OnChange(Self, ActiveQueryTabset.TabIndex, dummy);
end;

procedure TMainForm.ValidateQueryControls(Sender: TObject);
var
  NotEmpty, HasSelection: Boolean;
  Tab: TQueryTab;
  cap: String;
  InQueryTab: Boolean;
  i: Integer;
begin
  InQueryTab := QueryTabActive;
  Tab := ActiveQueryTab;
  NotEmpty := InQueryTab and (Tab.Memo.GetTextLen > 0);
  HasSelection := InQueryTab and Tab.Memo.SelAvail;
  actExecuteQuery.Enabled := InQueryTab and NotEmpty;
  actExecuteSelection.Enabled := InQueryTab and HasSelection;
  actExecuteLine.Enabled := InQueryTab and (Tab.Memo.LineText <> '');
  actSaveSQLAs.Enabled := InQueryTab and NotEmpty;
  actSaveSQL.Enabled := actSaveSQLAs.Enabled and Tab.Memo.Modified;
  actSaveSQLselection.Enabled := InQueryTab and HasSelection;
  actSaveSQLSnippet.Enabled := InQueryTab and NotEmpty;
  actSaveSQLSelectionSnippet.Enabled := InQueryTab and HasSelection;
  actQueryFind.Enabled := InQueryTab;
  actQueryReplace.Enabled := InQueryTab;
  actQueryFindAgain.Enabled := InQueryTab;
  // We need a pressed button which somehow does not work in conjunction with Enabled=False
  // actQueryStopOnErrors.Enabled := QueryTabActive;
  actQueryWordWrap.Enabled := InQueryTab;
  actClearQueryEditor.Enabled := InQueryTab and NotEmpty;
  actSetDelimiter.Enabled := InQueryTab;
  actCloseQueryTab.Enabled := IsQueryTab(PageControlMain.ActivePageIndex, False);
  for i:=0 to QueryTabs.Count-1 do begin
    cap := trim(QueryTabs[i].TabSheet.Caption);
    if cap[Length(cap)] = '*' then
      cap := copy(cap, 1, Length(cap)-1);
    if QueryTabs[i].Memo.Modified then
      cap := cap + '*';
    if QueryTabs[i].TabSheet.Caption <> cap then
      SetTabCaption(QueryTabs[i].TabSheet.PageIndex, cap);
  end;
end;


procedure TMainForm.KillProcess(Sender: TObject);
var t : Boolean;
  ProcessIDs : TStringList;
  i : Integer;
begin
  t := TimerRefresh.Enabled;
  TimerRefresh.Enabled := false; // prevent av (ListProcesses.selected...)
  ProcessIDs := GetVTCaptions( ListProcesses, True );
  if MessageDlg('Kill '+inttostr(ProcessIDs.count)+' Process(es)?', mtConfirmation, [mbok,mbcancel], 0) = mrok then
  begin
    try
      for i:=0 to ProcessIDs.Count-1 do begin
        // Don't kill own process
        if ProcessIDs[i] = IntToStr(Connection.ThreadId) then
          LogSQL('Ignoring own process id '+ProcessIDs[i]+' when trying to kill it.')
        else
          Connection.Query('KILL '+ProcessIDs[i]);
      end;
    except
      on E:Exception do
        MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
    InvalidateVT(ListProcesses, VTREE_NOTLOADED, True);
  end;
  TimerRefresh.Enabled := t; // re-enable autorefresh timer
end;


procedure TMainForm.ExecSQLClick(Sender: TObject; Selection: Boolean=false; CurrentLine: Boolean=false);
var
  SQL: TStringList;
  i, j, QueryCount: Integer;
  SQLTime, SQLNetTime: Cardinal;
  Results: TMySQLQuery;
  ColName, Text, LB: String;
  col: TVirtualTreeColumn;
  ResultLabel: TLabel;
  ActiveGridResult: TGridResult;
  cap: String;
begin
  ResultLabel := ActiveQueryTab.LabelResultInfo;
  if CurrentLine then Text := ActiveQueryMemo.LineText
  else if Selection then Text := ActiveQueryMemo.SelText
  else Text := ActiveQueryMemo.Text;
  // Give text back its original linebreaks if possible
  case ActiveQueryTab.MemoLineBreaks of
    lbsUnix: LB := LB_UNIX;
    lbsMac: LB := LB_MAC;
    lbsWide: LB := LB_WIDE;
  end;
  if LB <> '' then
    Text := StringReplace(Text, CRLF, LB, [rfReplaceAll]);
  ShowStatusMsg('Initializing SQL...');
  SQL := parseSQL(Text);
  if SQL.Count = 0 then begin
    ResultLabel.Caption := '(nothing to do)';
    Exit;
  end;

  ResultLabel.Caption := '';
  FreeAndNil(Results);
  actExecuteQuery.Enabled := false;
  actExecuteSelection.Enabled := false;
  EnableProgressBar(SQL.Count);
  ShowStatusMsg('Executing SQL...');
  SQLtime := 0;
  SQLNetTime := 0;
  QueryCount := 0;
  Results := TMySQLQuery.Create(Self);
  Results.Connection := Connection;
  Results.LogCategory := lcUserFiredSQL;
  for i:=0 to SQL.Count-1 do begin
    ProgressBarStatus.StepIt;
    ProgressBarStatus.Repaint;
    try
      // Immediately free results for all but last query
      Results.SQL := SQL[i];
      Results.StoreResult := i = SQL.Count-1;
      Results.Execute;
      Inc(SQLtime, Connection.LastQueryDuration);
      Inc(SQLNetTime, Connection.LastQueryNetworkDuration);
      Inc(QueryCount);
      if Assigned(Results) and Results.HasResult then
        ResultLabel.Caption := FormatNumber(Results.ColumnCount) +' column(s) x '+FormatNumber(Results.RecordCount) +' row(s) in last result set.'
      else
        ResultLabel.Caption := FormatNumber(Connection.RowsAffected) +' row(s) affected by last query.';
    except
      on E:Exception do begin
        if actQueryStopOnErrors.Checked or (i = SQL.Count - 1) then begin
          Screen.Cursor := crDefault;
          MessageDlg( E.Message, mtError, [mbOK], 0 );
          Break;
        end;
      end;
    end;
  end;

  if ResultLabel.Caption <> '' then begin
    cap := ' Duration for ';
    cap := cap + IntToStr(QueryCount);
    if QueryCount < SQL.Count then
      cap := cap + ' of ' + IntToStr(SQL.Count);
    if SQL.Count = 1 then
      cap := cap + ' query'
    else
      cap := cap + ' queries';
    cap := cap + ': '+FormatNumber(SQLTime/1000, 3) +' sec.';
    if SQLNetTime > 0 then
      cap := cap + ' (+ '+FormatNumber(SQLNetTime/1000, 3) +' sec. network)';
    ResultLabel.Caption := ResultLabel.Caption + cap;
  end;

  // Avoid excessive GridHighlightChanged() when flicking controls.
  ProgressBarStatus.Hide;

  if Assigned(Results) and Results.HasResult then begin
    ActiveGrid.BeginUpdate;
    // Reset filter if filter panel was disabled
    UpdateFilterPanel(Sender);
    ActiveGrid.Header.Options := ActiveGrid.Header.Options + [hoVisible];
    ActiveGrid.Header.Columns.BeginUpdate;
    ActiveGrid.Header.Columns.Clear;
    debug('mem: clearing and initializing query columns.');
    ActiveGridResult := GridResult(ActiveGrid);
    SetLength(ActiveGridResult.Columns, 0);
    SetLength(ActiveGridResult.Columns, Results.ColumnCount);
    for i:=0 to Results.ColumnCount-1 do begin
      ColName := Results.ColumnNames[i];
      col := ActiveGrid.Header.Columns.Add;
      col.Text := ColName;
      col.Options := col.Options - [coAllowClick];
      ActiveGridResult.Columns[i].Name := ColName;
      ActiveGridResult.Columns[i].DatatypeCat := Results.DataType(i).Category;
      if ActiveGridResult.Columns[i].DatatypeCat in [dtcInteger, dtcReal] then
        col.Alignment := taRightJustify;
      ActiveGridResult.Columns[i].IsPriPart := Results.ColIsPrimaryKeyPart(i);
    end;
    debug('mem: query column initialization complete.');
    debug('mem: clearing and initializing query rows (internal data).');
    SetLength(ActiveGridResult.Rows, 0);
    SetLength(ActiveGridResult.Rows, Results.RecordCount);
    Results.First;
    for i:=0 to Results.RecordCount-1 do begin
      SetLength(ActiveGridResult.Rows[i].Cells, Results.ColumnCount);
      for j:=0 to Results.ColumnCount-1 do begin
        case ActiveGridResult.Columns[j].DatatypeCat of
          dtcInteger, dtcReal: ActiveGridResult.Rows[i].Cells[j].Text := FormatNumber(Results.Col(j), False);
          dtcBinary: ActiveGridResult.Rows[i].Cells[j].Text := GetBlobContent(Results, j);
          else ActiveGridResult.Rows[i].Cells[j].Text := Results.Col(j);
        end;
        ActiveGridResult.Rows[i].Cells[j].IsNull := Results.IsNull(j);
      end;
      Results.Next;
    end;
    Results.Free;
    debug('mem: initializing query rows (grid).');
    ActiveGrid.RootNodeCount := Length(ActiveGridResult.Rows);
    debug('mem: query row initialization complete.');
    ActiveGrid.Header.Columns.EndUpdate;
    ActiveGrid.ClearSelection;
    ActiveGrid.OffsetXY := Point(0, 0);
    for i:=0 to ActiveGrid.Header.Columns.Count-1 do
      AutoCalcColWidth(ActiveGrid, i);
    ActiveGrid.EndUpdate;
  end;
  // Ensure controls are in a valid state
  ValidateControls(Sender);
  Screen.Cursor := crDefault;
  ShowStatusMsg( STATUS_MSG_READY );
end;


{ Proposal about to insert a String into synmemo }
procedure TMainForm.SynCompletionProposalCodeCompletion(Sender: TObject;
  var Value: String; Shift: TShiftState; Index: Integer; EndToken: Char);
begin
  (Sender as TSynCompletionProposal).Form.CurrentEditor.UndoList.AddGroupBreak;
end;


procedure TMainForm.SynCompletionProposalAfterCodeCompletion(Sender: TObject;
  const Value: String; Shift: TShiftState; Index: Integer; EndToken: Char);
begin
  (Sender as TSynCompletionProposal).Form.CurrentEditor.UndoList.AddGroupBreak;
end;


{ Proposal-Combobox pops up }
procedure TMainForm.SynCompletionProposalExecute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: String; var x, y: Integer;
  var CanExecute: Boolean);
var
  i,j              : Integer;
  Results          : TMySQLQuery;
  DBObjects        : TDBObjectList;
  sql, TableClauses: String;
  Tables           : TStringList;
  tablename        : String;
  rx               : TRegExpr;
  PrevShortToken,
  PrevLongToken,
  Token            : UnicodeString;
  Start,
  TokenTypeInt     : Integer;
  Attri            : TSynHighlighterAttributes;
  Proposal         : TSynCompletionProposal;
  Editor           : TCustomSynEdit;
  Queries          : TStringList;

  procedure addTable(Obj: TDBObject);
  begin
    Proposal.InsertList.Add(Obj.Name);
    Proposal.ItemList.Add( Format(SYNCOMPLETION_PATTERN, [Obj.ImageIndex, LowerCase(Obj.ObjType), Obj.Name]) );
  end;

  procedure addColumns( tablename: String );
  var
    dbname : String;
    Columns: TMySQLQuery;
  begin
    dbname := ActiveDatabase;
    if Pos( '.', tablename ) > -1 then
    begin
      dbname := Copy( tablename, 0, Pos( '.', tablename )-1 );
      tablename := Copy( tablename, Pos( '.', tablename )+1, Length(tablename) );
    end;
    // Do not mask db and table name to avoid double masking.
    // Rely on what the user typed is already a valid masked/quoted identifier.
    if dbname <> '' then
      tablename := dbname + '.' + tablename;
    try
      Columns := Connection.GetResults('SHOW COLUMNS FROM '+tablename);
    except
      Exit;
    end;
    while not Columns.Eof do begin
      Proposal.InsertList.Add(Columns.Col('Field'));
      Proposal.ItemList.Add(Format(SYNCOMPLETION_PATTERN, [ICONINDEX_FIELD, GetFirstWord(Columns.Col('Type')), Columns.Col('Field')]) );
      Columns.Next;
    end;
    FreeAndNil(Columns);
  end;

begin
  if not prefCompletionProposal then begin
    CanExecute := False;
    Exit;
  end;

  Proposal := Sender as TSynCompletionProposal;
  Editor := Proposal.Form.CurrentEditor;
  Editor.GetHighlighterAttriAtRowColEx(Editor.CaretXY, Token, TokenTypeInt, Start, Attri);
  if TtkTokenKind(TokenTypeInt) = tkString then begin
    CanExecute := False;
    Exit;
  end;

  Proposal.InsertList.Clear;
  Proposal.ItemList.Clear;
  PrevShortToken := Proposal.PreviousToken;
  PrevShortToken := WideDequotedStr(PrevShortToken, '`');

  rx := TRegExpr.Create;

  // Find longer token, ignore EndOfTokenChars, just the last chars up to a whitespace, comma or paranthesis
  rx.Expression := '([^\s,\(\)]+)$';
  PrevLongToken := Copy(Editor.LineText, 1, Editor.CaretX-2);
  if rx.Exec(PrevLongToken) then
    PrevLongToken := rx.Match[1]
  else
    PrevLongToken := '';

  // Display list of variables
  rx.Expression := '^@@(SESSION|GLOBAL)$';
  rx.ModifierI := True;
  if rx.Exec(PrevLongToken) then begin
    try
      Results := Connection.GetResults('SHOW '+UpperCase(rx.Match[1])+' VARIABLES');
      while not Results.Eof do begin
        Proposal.InsertList.Add(Results.Col(0));
        Proposal.ItemList.Add(Format(SYNCOMPLETION_PATTERN, [ICONINDEX_PRIMARYKEY, 'variable', Results.Col(0)+'   \color{clSilver}= '+StringReplace(Results.Col(1), '\', '\\', [rfReplaceAll])] ) );
        Results.Next;
      end;
    except
      // Just log error in sql log, do not disturb user while typing
    end;
    Exit;
  end;

  // Get column-names into the proposal pulldown
  // when we write sql like "SELECT t.|col FROM table [AS] t"
  // Current limitation: Identifiers (masked or not) containing
  // spaces are not detected correctly.

  // 1. find the currently edited sql-statement around the cursor position in synmemo
  if Editor = SynMemoFilter then begin
    // Concat query segments, so the below regular expressions can find structure
    sql := 'SELECT * FROM `'+SelectedTable.Name+'` WHERE ' + Editor.Text;
  end else begin
    // Proposal in one of the query tabs
    Queries := parsesql(Editor.Text);
    j := 0;
    for i:=0 to Queries.Count-1 do begin
      Inc(j, Length(Queries[i])+1);
      if (j >= Editor.SelStart) or (i = Queries.Count-1) then begin
        sql := Queries[i];
        break;
      end;
    end;
    FreeAndNil(Queries);
  end;

  // 2. Parse FROM clause to detect relevant table/view, probably aliased
  rx.ModifierG := True;
  rx.Expression := '\b(FROM|INTO|UPDATE)\s+(.+)(WHERE|HAVING|ORDER|GROUP)?';
  if rx.Exec(sql) then begin
    TableClauses := rx.Match[2];
    // Ensure tables in JOIN clause(s) are splitted by comma
    TableClauses := StringReplace(TableClauses, 'JOIN', ',', [rfReplaceAll, rfIgnoreCase]);
    // Split table clauses by commas
    Tables := TStringList.Create;
    Tables.Delimiter := ',';
    Tables.StrictDelimiter := true;
    Tables.DelimitedText := TableClauses;
    rx.Expression := '(\S+)\s+(AS\s+)?(\S+)';

    for i := 0 to Tables.Count - 1 do begin
      // If the just typed word equals the alias of this table or the
      // tablename itself, set tablename var and break loop
      if rx.Exec(Tables[i]) then while true do begin
        if PrevShortToken = WideDequotedStr(rx.Match[3],'`') then begin
          tablename := rx.Match[1];
          break;
        end;
        if not rx.ExecNext then
          break;
      end;
      if tablename <> '' then
        break;
    end;
  end;
  rx.Free;

  if (tablename <> '') then begin
    // add columns to proposal
    addColumns( tablename );
  end else if PrevLongToken <> '' then begin
    // assuming previoustoken itself is a table
    addColumns( PrevLongToken );
  end;


  if Length(CurrentInput) = 0 then // makes only sense if the user has typed "database."
  begin
    i := Databases.IndexOf(PrevShortToken);
    if i > -1 then begin
      // Only display tables from specified db
      Screen.Cursor := crHourGlass;
      DBObjects := Connection.GetDBObjects(Databases[i]);
      for j:=0 to DBObjects.Count-1 do
        addTable(DBObjects[j]);
      Screen.Cursor := crDefault;
    end;
  end;

  if Proposal.ItemList.count = 0 then begin
    // Add databases
    for i := 0 to Databases.Count - 1 do begin
      Proposal.InsertList.Add(Databases[i]);
      Proposal.ItemList.Add(Format(SYNCOMPLETION_PATTERN, [ICONINDEX_DB, 'database', Databases[i]]));
    end;

    if ActiveDatabase <> '' then begin
      // Display tables from current db
      DBObjects := Connection.GetDBObjects(ActiveDatabase);
      for j:=0 to DBObjects.Count-1 do
        addTable(DBObjects[j]);
      if Length(CurrentInput) = 0 then // assume that we have already a dbname in memo
        Proposal.Position := Databases.Count;
    end;

    // Add functions
    for i := 0 to Length(MySQLFunctions) - 1 do begin
      // Don't display unsupported functions here
      if MySqlFunctions[i].Version > Connection.ServerVersionInt then
        continue;
      Proposal.InsertList.Add( MySQLFunctions[i].Name + MySQLFunctions[i].Declaration );
      Proposal.ItemList.Add( Format(SYNCOMPLETION_PATTERN, [ICONINDEX_FUNCTION, 'function', MySQLFunctions[i].Name + '\color{clSilver}' + MySQLFunctions[i].Declaration] ) );
    end;

    // Add keywords
    for i := 0 to MySQLKeywords.Count - 1 do begin
      Proposal.InsertList.Add( MySQLKeywords[i] );
      Proposal.ItemList.Add( Format(SYNCOMPLETION_PATTERN, [ICONINDEX_KEYWORD, 'keyword', MySQLKeywords[i]] ) );
    end;

  end;

end;


procedure TMainForm.SynMemoQueryStatusChange(Sender: TObject; Changes:
    TSynStatusChanges);
begin
  ValidateQueryControls(Sender);
  UpdateLineCharPanel;
end;



procedure TMainForm.TimerHostUptimeTimer(Sender: TObject);
begin
  // Display server uptime
  if Assigned(Connection) then
    ShowStatusMsg('Uptime: '+FormatTimeNumber(Connection.ServerUptime), 4)
  else
    ShowStatusMsg('', 4);
end;


procedure TMainForm.ListTablesEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  Obj: PDBObject;
begin
  // Tables and views can be renamed, routines cannot
  Obj := Sender.GetNodeData(Node);
  Allowed := Obj.NodeType in [lntTable, lntView];
end;


{***
  Rename table after checking the new name for invalid characters
}
procedure TMainForm.ListTablesNewText(Sender: TBaseVirtualTree; Node:
    PVirtualNode; Column: TColumnIndex; NewText: String);
var
  Obj: PDBObject;
begin
  // Fetch data from node
  Obj := Sender.GetNodeData(Node);

  // Try to rename, on any error abort and don't rename ListItem
  try
    ensureValidIdentifier( NewText );
    // rename table
    Connection.Query('RENAME TABLE ' + mask(Obj.Name) + ' TO ' + mask(NewText));

    if SynSQLSyn1.TableNames.IndexOf( NewText ) = -1 then begin
      SynSQLSyn1.TableNames.Add(NewText);
    end;
    // Update nodedata
    Obj.Name := NewText;
    // Now the active tree db has to be updated. But calling RefreshTreeDB here causes an AV
    // so we do it manually here
    DBTree.InvalidateChildren(FindDBNode(ActiveDatabase), True);
  except
    on E:Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;


procedure TMainForm.TimerConnectedTimer(Sender: TObject);
begin
  if Assigned(Connection) and Connection.Active then begin
    // calculate and display connection-time
    ShowStatusMsg('Connected: ' + FormatTimeNumber(Connection.ConnectionUptime), 2);
  end else begin
    ShowStatusMsg('Disconnected.', 2);
  end;
end;


procedure TMainForm.Clear2Click(Sender: TObject);
begin
  // clear history-memo
  Screen.Cursor := crHourglass;
  SynMemoSQLLog.Gutter.LineNumberStart := SynMemoSQLLog.Gutter.LineNumberStart + SynMemoSQLLog.Lines.Count;
  SynMemoSQLLog.Lines.Clear;
  Screen.Cursor := crDefault;
end;


procedure TMainForm.QuickFilterClick(Sender: TObject);
var
  Filter, Val, Col: String;
  Item : TMenuItem;
begin
  // Set filter for "where..."-clause
  Item := Sender as TMenuItem;
  Col := DataGrid.Header.Columns[DataGrid.FocusedColumn].Text;
  Filter := '';

  if Item.Tag = 1 then begin
    // Item needs prompt
    Val := InputBox('Specify filter-value...', Item.Caption, 'Value');
    if Val = 'Value' then
      Filter := ''
    else if Item = QF8 then
      Filter := mask(Col) + ' = ''' + Val + ''''
    else if Item = QF9 then
      Filter := mask(Col) + ' != ''' + Val + ''''
    else if Item = QF10 then
      Filter := mask(Col) + ' > ''' + Val + ''''
    else if Item = QF11 then
      Filter := mask(Col) + ' < ''' + Val + ''''
    else if Item = QF12 then
      Filter := mask(Col) + ' LIKE ''%' + Val + '%''';
  end else
    Filter := Item.Hint;

  if Filter <> '' then begin
    SynMemoFilter.UndoList.AddGroupBreak;
    SynMemoFilter.SelectAll;
    SynmemoFilter.SelText := filter;
    ToggleFilterPanel(True);
    actApplyFilterExecute(Sender);
  end;
end;


procedure TMainForm.popupQueryPopup(Sender: TObject);
begin
  // Sets cursor into memo and activates TAction(s) like paste
  ActiveQueryMemo.SetFocus;
end;

procedure TMainForm.AutoRefreshSetInterval(Sender: TObject);
var
  seconds : String;
  secondsInt : Integer;
begin
  // set interval for autorefresh-timer
  seconds := IntToStr(TimerRefresh.interval div 1000);
  if inputquery('Auto refresh','Refresh list every ... second(s):', seconds) then begin
    secondsInt := StrToIntDef(seconds, 0);
    if secondsInt > 0 then begin
      TimerRefresh.Interval := secondsInt * 1000;
      TimerRefresh.Enabled := true;
      menuAutoRefresh.Checked := true;
    end
    else
      MessageDLG('Seconds must be between 1 and ' + IntToStr(maxint) + '.', mtError, [mbOK], 0);
  end;
end;

procedure TMainForm.AutoRefreshToggle(Sender: TObject);
begin
  // enable autorefresh-timer
  TimerRefresh.Enabled := not TimerRefresh.Enabled;
  menuAutoRefresh.Checked := TimerRefresh.Enabled;
end;

procedure TMainForm.SynMemoQueryDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  src : TControl;
  Memo: TSynMemo;
begin
  // dragging an object over the query-memo
  Memo := ActiveQueryMemo;
  src := Source as TControl;
  // Accepting drag's from DBTree and QueryHelpers
  Accept := (src = DBtree) or (src = ActiveQueryHelpers);
  // set x-position of cursor
  Memo.CaretX := (x - Memo.Gutter.Width) div Memo.CharWidth - 1 + Memo.LeftChar;
  // set y-position of cursor
  Memo.CaretY := y div Memo.LineHeight + Memo.TopLine;
  if not Memo.Focused then
    Memo.SetFocus;
end;


procedure TMainForm.SynMemoQueryDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  src : TControl;
  Text, ItemText: String;
  LoadText, ShiftPressed: Boolean;
  i: Integer;
begin
  // dropping a tree node or listbox item into the query-memo
  ActiveQueryMemo.UndoList.AddGroupBreak;
  src := Source as TControl;
  Text := 'Error: Unspecified source control in drag''n drop operation!';
  LoadText := True;
  ShiftPressed := KeyPressed(VK_SHIFT);
  // Check for allowed controls as source has already
  // been performed in OnDragOver. So, only do typecasting here.
  if src = DBtree then begin
    // Insert table or database name. If a table is dropped and Shift is pressed, prepend the db name.
    Text := mask(DBtree.Text[DBtree.FocusedNode, 0]);
    if (DBtree.GetNodeLevel(DBtree.FocusedNode)=2) and ShiftPressed then
      Text := mask(DBtree.Text[DBtree.FocusedNode.Parent, 0]) + '.' + Text;
  end else if (src = ActiveQueryHelpers) and (ActiveQueryHelpers.ItemIndex > -1) then begin
    // Snippets tab
    if tabsetQueryHelpers.TabIndex = 3 then begin
      QueryLoad( DirnameSnippets + ActiveQueryHelpers.Items[ActiveQueryHelpers.ItemIndex] + '.sql', False );
      LoadText := False;
    // All other tabs
    end else begin
      Text := '';
      for i := 0 to ActiveQueryHelpers.Items.Count - 1 do begin
        if ActiveQueryHelpers.Selected[i] then begin
          ItemText := ActiveQueryHelpers.Items[i];
          if tabsetQueryHelpers.TabIndex = 0 then
            ItemText := mask(ItemText); // Quote column names
          if ShiftPressed then
            Text := Text + ItemText + ',' + CRLF
          else
            Text := Text + ItemText + ', ';
        end;
      end;
      Delete(Text, Length(Text)-1, 2);
    end;
  end;
  // Only insert text if no previous action did the job.
  // Should be false when dropping a snippet-file here
  if LoadText then
    ActiveQueryMemo.SelText := Text;
  ActiveQueryMemo.UndoList.AddGroupBreak;
  // Requires to set focus, as doubleclick actions also call this procedure
  ActiveQueryMemo.SetFocus;
end;



procedure TMainForm.SynMemoQueryDropFiles(Sender: TObject; X, Y: Integer;
  AFiles: TUnicodeStrings);
var
  i: Integer;
begin
  // One or more files from explorer or somewhere else was dropped onto the
  // query-memo - load their contents into seperate tabs
  for i:=0 to AFiles.Count-1 do begin
    if i > 0 then
      actNewQueryTab.Execute;
    QueryLoad(AFiles[i], false);
  end;
end;


procedure TMainForm.SynMemoQueryPaintTransient(Sender: TObject; Canvas: TCanvas; TransientType: TTransientType);
var
  Editor : TSynEdit;
  OpenChars: array of Char;
  CloseChars: array of Char;
  P: TBufferCoord;
  Pix: TPoint;
  D: TDisplayCoord;
  S: String;
  I: Integer;
  Attri: TSynHighlighterAttributes;
  ArrayLength: Integer;
  start: Integer;
  TmpCharA, TmpCharB: Char;

  function IsCharBracket(AChar: Char): Boolean;
  begin
    Result := CharInSet(AChar, ['{','[','(','<','}',']',')','>']);
  end;

  function CharToPixels(P: TBufferCoord): TPoint;
  begin
    Result := Editor.RowColumnToPixels(Editor.BufferToDisplayPos(P));
  end;
begin
  // Highlight matching brackets
  Editor := TSynEdit(Sender);
  if Editor.SelAvail then exit;
  ArrayLength := 3;

  SetLength(OpenChars, ArrayLength);
  SetLength(CloseChars, ArrayLength);
  for i := 0 to ArrayLength - 1 do
    Case i of
      0: begin OpenChars[i] := '('; CloseChars[i] := ')'; end;
      1: begin OpenChars[i] := '{'; CloseChars[i] := '}'; end;
      2: begin OpenChars[i] := '['; CloseChars[i] := ']'; end;
      3: begin OpenChars[i] := '<'; CloseChars[i] := '>'; end;
    end;

  P := Editor.CaretXY;
  D := Editor.DisplayXY;

  Start := Editor.SelStart;

  if (Start > 0) and (Start <= length(Editor.Text)) then
    TmpCharA := Editor.Text[Start]
  else
    TmpCharA := #0;

  if (Start < length(Editor.Text)) then
    TmpCharB := Editor.Text[Start + 1]
  else
    TmpCharB := #0;

  if not IsCharBracket(TmpCharA) and not IsCharBracket(TmpCharB) then
    Exit;
  S := TmpCharB;
  if not IsCharBracket(TmpCharB) then begin
    P.Char := P.Char - 1;
    S := TmpCharA;
  end;
  Editor.GetHighlighterAttriAtRowCol(P, S, Attri);

  if (Editor.Highlighter.SymbolAttribute = Attri) then begin
    for i:=Low(OpenChars) to High(OpenChars) do begin
      if (S = OpenChars[i]) or (S = CloseChars[i]) then begin
        Pix := CharToPixels(P);

        Editor.Canvas.Brush.Style := bsSolid;
        Editor.Canvas.Font.Assign(Editor.Font);
        Editor.Canvas.Font.Style := Attri.Style;

        if (TransientType = ttAfter) then begin
          Editor.Canvas.Font.Color := clBlack;
          Editor.Canvas.Brush.Color := clAqua;
        end else begin
          Editor.Canvas.Font.Color := Attri.Foreground;
          Editor.Canvas.Brush.Color := Attri.Background;
        end;
        if Editor.Canvas.Font.Color = clNone then
          Editor.Canvas.Font.Color := Editor.Font.Color;
        if Editor.Canvas.Brush.Color = clNone then
          Editor.Canvas.Brush.Color := Editor.Color;

        Editor.Canvas.TextOut(Pix.X, Pix.Y, S);
        P := Editor.GetMatchingBracketEx(P);

        if (P.Char > 0) and (P.Line > 0) then begin
          Pix := CharToPixels(P);
          if Pix.X > Editor.Gutter.Width then begin
            if S = OpenChars[i] then
              Editor.Canvas.TextOut(Pix.X, Pix.Y, CloseChars[i])
            else Editor.Canvas.TextOut(Pix.X, Pix.Y, OpenChars[i]);
          end;
        end;

      end;
    end;
    Editor.Canvas.Brush.Style := bsSolid;
  end;
end;


procedure TMainForm.popupHostPopup(Sender: TObject);
begin
  menuFetchDBitems.Enabled := (PageControlHost.ActivePage = tabDatabases) and (ListDatabases.SelectedCount > 0);
  Kill1.Enabled := (PageControlHost.ActivePage = tabProcessList) and (ListProcesses.SelectedCount > 0);
  menuEditVariable.Enabled := False;
  if Connection.ServerVersionInt >= 40003 then
    menuEditVariable.Enabled := (PageControlHost.ActivePage = tabVariables) and Assigned(ListVariables.FocusedNode)
  else
    menuEditVariable.Hint := STR_NOTSUPPORTED;
end;

procedure TMainForm.Saveastextfile1Click(Sender: TObject);
begin
  with TSaveDialog.Create(self) do begin
    Filter := 'Textfiles (*.txt)|*.txt|All Files (*.*)|*.*';
    DefaultExt := 'txt';
    FilterIndex := 1;
    Options := [ofOverwritePrompt,ofHideReadOnly,ofEnableSizing];
    if Execute then begin
      Screen.Cursor := crHourglass;
      SynMemoSQLLog.Lines.SaveToFile(Filename);
      Screen.Cursor := crdefault;
    end;
  end;
end;

procedure TMainForm.popupDBPopup(Sender: TObject);
var
  L: Cardinal;
  HasFocus, InDBTree: Boolean;
  Obj: PDBObject;
  NodeType: TListNodeType;
begin
  // DBtree and ListTables both use popupDB as menu. Find out which of them was rightclicked.
  if Sender is TPopupMenu then
    InDBTree := (Sender as TPopupMenu).PopupComponent = DBTree
  else if Sender is TMenuItem then
    InDBTree := TPopupMenu((Sender as TMenuItem).GetParentMenu).PopupComponent = DBTree
  else
    InDBTree := False;

  if InDBtree then begin
    HasFocus := Assigned(DBtree.FocusedNode);
    if HasFocus then
      L := DBtree.GetNodeLevel(DBtree.FocusedNode)
    else
      L := 0;
    NodeType := GetFocusedTreeNodeType;
    actCreateDatabase.Enabled := L = 0;
    actCreateTable.Enabled := L in [1,2];
    actCreateView.Enabled := L in [1,2];
    actCreateRoutine.Enabled := L in [1,2];
    actCreateTrigger.Enabled := L in [1,2];
    actCreateEvent.Enabled := L in [1,2];
    actDropObjects.Enabled := L in [1,2];
    actCopyTable.Enabled := HasFocus and (NodeType in [lntTable, lntView]);
    actEmptyTables.Enabled := HasFocus and (NodeType in [lntTable, lntView]);
    actRunRoutines.Enabled := HasFocus and (NodeType in [lntProcedure, lntFunction]);
    actEditObject.Enabled := L > 0;
    // Show certain items which are valid only here
    menuTreeExpandAll.Visible := True;
    menuTreeCollapseAll.Visible := True;
    menuShowSizeColumn.Visible := True;
    actSelectTreeBackground.Visible := True;
  end else begin
    HasFocus := Assigned(ListTables.FocusedNode);
    actCreateDatabase.Enabled := False;
    actCreateTable.Enabled := True;
    actCreateView.Enabled := True;
    actCreateRoutine.Enabled := True;
    actCreateTrigger.Enabled := True;
    actCreateEvent.Enabled := True;
    actDropObjects.Enabled := ListTables.SelectedCount > 0;
    actEmptyTables.Enabled := False;
    actRunRoutines.Enabled := True;
    if HasFocus then begin
      Obj := ListTables.GetNodeData(ListTables.FocusedNode);
      actEmptyTables.Enabled := Obj.NodeType in [lntTable, lntView];
    end;
    actEditObject.Enabled := HasFocus;
    // Show certain items which are valid only here
    actCopyTable.Enabled := actEmptyTables.Enabled;
    menuTreeExpandAll.Visible := False;
    menuTreeCollapseAll.Visible := False;
    menuShowSizeColumn.Visible := False;
    actSelectTreeBackground.Visible := False;
  end;
  actCreateView.Enabled := actCreateView.Enabled and (Connection.ServerVersionInt >= 50001);
  actCreateRoutine.Enabled := actCreateRoutine.Enabled and (Connection.ServerVersionInt >= 50003);
  actCreateTrigger.Enabled := actCreateTrigger.Enabled and (Connection.ServerVersionInt >= 50002);
  actCreateEvent.Enabled := actCreateEvent.Enabled and (Connection.ServerVersionInt >= 50100);
end;




function TMainForm.QueryLoad( filename: String; ReplaceContent: Boolean = true ): Boolean;

var
  filecontent: String;
  msgtext: String;
  LineBreaks: TLineBreaks;
  RunFileDialog: TRunSQLFileForm;
begin
  Result := False;

  if not FileExists(filename) then begin
    MessageDlg('File not found: "'+filename+'"', mtError, [mbOK], 0);
    Exit;
  end;

  // Ask for action when loading a big file
  if _GetFileSize( filename ) > 5*SIZE_MB then
  begin
    msgtext := 'The file you are about to load is bigger than '+FormatByteNumber(5*SIZE_MB, 0)+'.' + CRLF + CRLF +
      'Do you want to just run the file to avoid loading it completely into the query-editor ( = memory ) ?' + CRLF + CRLF +
      'Press' + CRLF +
      '  [Yes] to run the file without loading it into the editor' + CRLF +
      '  [No] to load the file into the query editor' + CRLF +
      '  [Cancel] to cancel file opening.';
    case MessageDlg( msgtext, mtWarning, [mbYes, mbNo, mbCancel], 0 ) of
      // Run the file, don't load it into the editor
      mrYes:
        begin
          RunFileDialog := TRunSQLFileForm.Create(Self);
          RunFileDialog.SQLFileName := filename;
          RunFileDialog.ShowModal;
          RunFileDialog.Free;
          // Add filename to history menu
          if Pos( DirnameSnippets, filename ) = 0 then
            AddOrRemoveFromQueryLoadHistory( filename, true );
          // Don't load into editor
          Abort;
        end;
      // Do nothing here, go ahead and load the file normally into the editor
      mrNo:;
      // Cancel opening file
      mrCancel: Abort;
    end;
  end;

  // Load file and add that to the undo-history of SynEdit.
  // Normally we would do a simple SynMemo.Lines.LoadFromFile but
  // this would prevent SynEdit from adding this step to the undo-history
  // so we have to do it by replacing the SelText property
  Screen.Cursor := crHourGlass;
  if not QueryTabActive then
    PagecontrolMain.ActivePage := tabQuery;
  LogSQL('Loading file "'+filename+'" into query tab #'+IntToStr(ActiveQueryTab.Number)+' ...', lcInfo);
  try
    filecontent := ReadTextfile(filename);
    if Pos( DirnameSnippets, filename ) = 0 then
      AddOrRemoveFromQueryLoadHistory( filename, true );
    FillPopupQueryLoad;
    ActiveQueryMemo.UndoList.AddGroupBreak;

    if ScanNulChar(filecontent) then begin
      filecontent := RemoveNulChars(filecontent);
      MessageDlg(SContainsNulCharFile, mtInformation, [mbOK], 0);
    end;

    ActiveQueryMemo.BeginUpdate;
    LineBreaks := ScanLineBreaks(filecontent);
    if ReplaceContent then begin
      ActiveQueryMemo.SelectAll;
      ActiveQueryTab.MemoLineBreaks := LineBreaks;
    end else begin
      if (ActiveQueryTab.MemoLineBreaks <> lbsNone) and (ActiveQueryTab.MemoLineBreaks <> LineBreaks) then
        ActiveQueryTab.MemoLineBreaks := lbsMixed
      else
        ActiveQueryTab.MemoLineBreaks := LineBreaks;
    end;
    if ActiveQueryTab.MemoLineBreaks = lbsMixed then
      MessageDlg('This file contains mixed linebreaks. They have been converted to Windows linebreaks (CR+LF).', mtInformation, [mbOK], 0);

    ActiveQueryMemo.SelText := filecontent;
    ActiveQueryMemo.SelStart := ActiveQueryMemo.SelEnd;
    ActiveQueryMemo.EndUpdate;
    SetTabCaption(PageControlMain.ActivePageIndex, sstr(ExtractFilename(filename), 70));
    ActiveQueryMemo.Modified := False;
    ActiveQueryTab.MemoFilename := filename;
    Result := True;
  except on E:Exception do
    // File does not exist, is locked or broken
    MessageDlg(E.message, mtError, [mbOK], 0);
  end;
  Screen.Cursor := crDefault;
end;




procedure TMainForm.SaveDialogExportDataTypeChange(Sender: TObject);
begin
  // Set default file-extension of saved file and options on the dialog to show
  with SaveDialogExportData do begin
    Case FilterIndex of
      1: DefaultExt := 'csv';
      2: DefaultExt := 'html';
      3: DefaultExt := 'xml';
      4: DefaultExt := 'sql';
    end;
  end;
end;


procedure TMainForm.popupDataGridPopup(Sender: TObject);
var
  y,m,d,h,i,s,ms : Word;
  cpText, Col, value : String;
  CellFocused: Boolean;
const
  CLPBRD : String = 'CLIPBOARD';
begin
  CellFocused := Assigned(DataGrid.FocusedNode) and (DataGrid.FocusedColumn > NoColumn);
  DataInsertDateTime.Enabled := CellFocused;
  QFvalues.Enabled := CellFocused;
  if not CellFocused then
    Exit;

  decodedate(now, y, m, d);
  decodetime(now, h, i, s, ms);
  DataDateTime.Caption := Format('%.4d-%.2d-%.2d %.2d:%.2d:%.2d', [y,m,d,h,i,s]);
  DataDate.Caption := Format('%.4d-%.2d-%.2d', [y,m,d]);
  DataTime.Caption := Format('%.2d:%.2d:%.2d', [h,i,s]);
  DataTimestamp.caption := Format('%.4d%.2d%.2d%.2d%.2d%.2d', [y,m,d,h,i,s]);
  DataYear.Caption := Format('%.4d', [y]);

  // Manipulate the Quick-filter menuitems
  DataGridEnsureFullRow(DataGrid, DataGrid.FocusedNode);
  Col := mask(DataGrid.Header.Columns[DataGrid.FocusedColumn].Text);
  // 1. block: include selected columnname and value from datagrid in caption
  if DataGridResult.Rows[DataGrid.FocusedNode.Index].Cells[DataGrid.FocusedColumn].IsNull then begin
    QF1.Hint := Col + ' IS NULL';
    QF2.Hint := Col + ' IS NOT NULL';
    QF3.Visible := False;
    QF4.Visible := False;
    QF5.Visible := False;
    QF6.Visible := False;
    QF7.Visible := False;
  end else begin
    value := DataGrid.Text[DataGrid.FocusedNode, DataGrid.FocusedColumn];
    QF1.Hint := Col + ' = ' + esc( value );
    QF2.Hint := Col + ' != ' + esc( value );
    QF3.Hint := Col + ' > ' + esc( value );
    QF4.Hint := Col + ' < ' + esc( value );
    QF5.Hint := Col + ' LIKE ''' + esc( value, true ) + '%''';
    QF6.Hint := Col + ' LIKE ''%' + esc( value, true ) + '''';
    QF7.Hint := Col + ' LIKE ''%' + esc( value, true ) + '%''';
    QF3.Visible := True;
    QF4.Visible := True;
    QF5.Visible := True;
    QF6.Visible := True;
    QF7.Visible := True;
  end;

  // 2. block: include only selected columnname in caption
  QF8.Hint := Col + ' = "..."';
  QF9.Hint := Col + ' != "..."';
  QF10.Hint := Col + ' > "..."';
  QF11.Hint := Col + ' < "..."';
  QF12.Hint := Col + ' LIKE "%...%"';
  QF13.Hint := Col + ' IS NULL';
  QF14.Hint := Col + ' IS NOT NULL';

  // 3. block: include selected columnname and clipboard-content in caption for one-click-filtering
  cpText := Clipboard.AsText;
  if Length(cpText) < SIZE_KB then begin
    QF15.Enabled := true; QF15.Hint := Col + ' = ' + esc( cpText );
    QF16.Enabled := true; QF16.Hint := Col + ' != ' + esc( cpText );
    QF17.Enabled := true; QF17.Hint := Col + ' > ' + esc( cpText );
    QF18.Enabled := true; QF18.Hint := Col + ' < ' + esc( cpText );
    QF19.Enabled := true; QF19.Hint := Col + ' LIKE ''%' + esc( cpText, true ) + '%''';
  end else begin
    QF15.Enabled := false; QF15.Hint := Col + ' = ' + CLPBRD;
    QF16.Enabled := false; QF16.Hint := Col + ' != ' + CLPBRD;
    QF17.Enabled := false; QF17.Hint := Col + ' > ' + CLPBRD;
    QF18.Enabled := false; QF18.Hint := Col + ' < ' + CLPBRD;
    QF19.Enabled := false; QF19.Hint := Col + ' LIKE %' + CLPBRD + '%';
  end;

  for i:=0 to menuQuickFilter.Count-1 do begin
    if (menuQuickFilter[i].Caption <> '-') // Not a separator
      and (menuQuickFilter[i].Count = 0) // Not a menu with subitems
      and (menuQuickFilter[i].Action = nil) // Not some special item
      then
      menuQuickFilter[i].Caption := sstr(menuQuickFilter[i].Hint, 100);
  end;

end;


procedure TMainForm.QFvaluesClick(Sender: TObject);
var
  Data: TMySQLQuery;
  Col: String;
  Item: TMenuItem;
  i: Integer;
begin
  // Create a list of distinct column values in selected table
  for i:=QFvalues.Count-1 downto 1 do
    QFvalues.Delete(i);
  QFvalues[0].Caption := '';
  QFvalues[0].Hint := '';
  QFvalues[0].OnClick := nil;
  if DataGrid.FocusedColumn = NoColumn then
    Exit;
  Col := DataGridResult.Columns[DataGrid.FocusedColumn].Name;
  ShowStatusMsg('Fetching distinct values ...');
  Data := Connection.GetResults('SELECT '+mask(Col)+', COUNT(*) AS c FROM '+mask(SelectedTable.Name)+
    ' GROUP BY '+mask(Col)+' ORDER BY c DESC, '+mask(Col)+' LIMIT 30');
  for i:=0 to Data.RecordCount-1 do begin
    if QFvalues.Count > i then
      Item := QFvalues[i]
    else begin
      Item := TMenuItem.Create(QFvalues);
      QFvalues.Add(Item);
    end;
    Item.Hint := mask(Col)+'='+esc(Data.Col(Col));
    Item.Caption := sstr(Item.Hint, 100) + ' (' + FormatNumber(Data.Col('c')) + ')';
    Item.OnClick := QuickFilterClick;
    Data.Next;
  end;
  ShowStatusMsg(STATUS_MSG_READY);
end;


procedure TMainForm.InsertDate(Sender: TObject);
var d : String;
begin
  // Insert date/time-value into table
  d := (sender as TMenuItem).Caption;
  delete(d, Pos('&', d), 1);
  DataGrid.Text[DataGrid.FocusedNode, DataGrid.FocusedColumn] := d;
end;


function TMainForm.GetActiveDatabase: String;
var
  s: PVirtualNode;
begin
  // Find currently selected database node in database tree,
  // or the parent if a table is currently selected.
  if csDestroying in ComponentState then
    Exit;
  s := DBtree.FocusedNode;
  if not Assigned(s) then Result := ''
  else case DBtree.GetNodeLevel(s) of
    2: Result := Databases[s.Parent.Index];
    1: Result := Databases[s.Index];
    else Result := '';
  end;
end;


function TMainForm.GetSelectedTable: TDBObject;
var
  Node: PVirtualNode;
  DBObjects: TDBObjectList;
begin
  Node := DBtree.FocusedNode;
  Result := TDBObject.Create;
  if Assigned(Node) and (DBtree.GetNodeLevel(Node)=2) then begin
    DBObjects := Connection.GetDBObjects(ActiveDatabase);
    Result.Assign(DBObjects[Node.Index]);
  end;
end;


function TMainForm.GetTreeNodeType(Tree: TBaseVirtualTree; Node: PVirtualNode): TListNodeType;
var
  DBObjects: TDBObjectList;
begin
  Result := lntNone;
  if Assigned(Node) then case Tree.GetNodeLevel(Node) of
    1: Result := lntDb;
    2: begin
      DBObjects := Connection.GetDBObjects((Tree as TVirtualStringTree).Text[Node.Parent, 0]);
      Result := DBObjects[Node.Index].NodeType;
    end;
  end;
end;

function TMainForm.GetFocusedTreeNodeType: TListNodeType;
begin
  Result := GetTreeNodeType(DBTree, DBtree.FocusedNode);
end;


procedure TMainForm.SelectDBObject(Text: String; NodeType: TListNodeType);
var
  dbnode, tnode, snode: PVirtualNode;
begin
  debug('SelectDBObject()');
  // Detect db node
  case DBtree.GetNodeLevel(DBtree.FocusedNode) of
    1: dbnode := DBtree.FocusedNode;
    2: dbnode := DBtree.FocusedNode.Parent;
    else raise Exception.Create('No selection in tree, could not determine active db.');
  end;
  snode := nil;
  // 1st search, case sensitive for lower-case-tablenames=0 servers
  tnode := DBtree.GetFirstChild(dbnode);
  while Assigned(tnode) do begin
    // Select table node if it has the wanted caption
    if (DBtree.Text[tnode, 0] = Text) and (GetTreeNodeType(DBTree, tnode) = NodeType) then begin
      snode := tnode;
      break;
    end;
    tnode := DBtree.GetNextSibling(tnode);
  end;
  // 2nd search, case insensitive now
  if not Assigned(snode) then begin
    tnode := DBtree.GetFirstChild(dbnode);
    while Assigned(tnode) do begin
      // Select table node if it has the wanted caption
      if (AnsiCompareText(DBtree.Text[tnode, 0], Text) = 0) and (GetTreeNodeType(DBtree, tnode) = NodeType) then begin
        snode := tnode;
        break;
      end;
      tnode := DBtree.GetNextSibling(tnode);
    end;
  end;
  if Assigned(snode) then begin
    // Ensure table node will be visible
    DBTree.ScrollIntoView(snode, False);
    DBtree.Expanded[dbnode] := True;
    DBtree.Selected[snode] := True;
    // Implicitely calls OnFocusChanged:
    DBTree.FocusedNode := nil;
    DBTree.FocusedNode := snode;
    exit;
  end;
  raise Exception.Create('Table node ' + Text + ' not found in tree.');
end;


procedure TMainForm.SetSelectedDatabase(db: String);
var
  n, f: PVirtualNode;
begin
  if db = '' then
    n := DBtree.GetFirst
  else
    n := FindDBNode(db);
  if Assigned(n) then begin
    // Set focus to db node, if current focus is outside
    f := DBtree.FocusedNode;
    if (not Assigned(f)) or (f.Parent <> n) then
      SelectNode(DBtree, n);
  end else
    raise Exception.Create('Database node ' + db + ' not found in tree.');
end;


{**
  Column selection for datagrid
}
procedure TMainForm.btnDataClick(Sender: TObject);
var
  btn : TToolButton;
  frm : TForm;
begin
  btn := (Sender as TToolButton);

  if (btn = tbtnDataColumns) or (btn = tbtnDataSorting) then begin
    // Create desired form for SELECT and ORDER buttons
    btn.Down := not btn.Down;
    if not btn.Down then Exit;
    if btn = tbtnDataColumns then
      frm := TColumnSelectionForm.Create(self)
    else if btn = tbtnDataSorting then
      frm := TDataSortingForm.Create(self)
    else
      frm := TForm.Create(self); // Dummy fallback, should never get created
    // Position new form relative to btn's position
    frm.Top := btn.ClientOrigin.Y + btn.Height;
    frm.Left := btn.ClientOrigin.X + btn.Width - frm.Width;
    // Display form
    frm.Show;
  end else if btn = tbtnDataFilter then begin
    // Unhide inline filter panel
    ToggleFilterPanel;
    FilterPanelManuallyOpened := pnlFilter.Visible;
    if FilterPanelManuallyOpened then
      SynMemoFilter.SetFocus;
  end;
end;


{**
  Tabset right to query-memo was clicked
}
procedure TMainForm.tabsetQueryHelpersChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
var
  i, idx : Integer;
  SnippetsAccessible : Boolean;
  Files: TStringList;
  Col: TTableColumn;
begin
  ActiveQueryHelpers.Items.BeginUpdate;
  ActiveQueryHelpers.Items.Clear;
  // By default sorted alpabetically
  ActiveQueryHelpers.Sorted := True;
  // By default disable all items in popupmenu, enable them when needed
  menuQueryHelpersGenerateInsert.Enabled := False;
  menuQueryHelpersGenerateUpdate.Enabled := False;
  menuQueryHelpersGenerateDelete.Enabled := False;
  menuInsertSnippetAtCursor.Enabled := False;
  menuLoadSnippet.Enabled := False;
  menuDeleteSnippet.Enabled := False;
  menuExplore.Enabled := False;
  menuHelp.Enabled := False;
  ActiveQueryHelpers.MultiSelect := True;

  case NewTab of
    0: // Cols
    begin
      // Keep native order of columns
      ActiveQueryHelpers.Sorted := False;
      case SelectedTable.NodeType of
        lntTable, lntView: begin
          menuQueryHelpersGenerateInsert.Enabled := True;
          menuQueryHelpersGenerateUpdate.Enabled := True;
          menuQueryHelpersGenerateDelete.Enabled := True;
          for i:=0 to SelectedTableColumns.Count-1 do begin
            Col := TTableColumn(SelectedTableColumns[i]);
            ActiveQueryHelpers.Items.Add(Col.Name);
          end;
        end;
        lntFunction, lntProcedure: if Assigned(ActiveObjectEditor) then begin
          for i:=0 to TfrmRoutineEditor(ActiveObjectEditor).Parameters.Count-1 do
            ActiveQueryHelpers.Items.Add(TfrmRoutineEditor(ActiveObjectEditor).Parameters[i].Name);
        end;
      end;
    end;

    1: // SQL functions
    begin
      // State of items in popupmenu
      menuHelp.Enabled := True;
      for i := 0 to Length(MySQLFunctions) - 1 do
      begin
        // Don't display unsupported functions here
        if MySqlFunctions[i].Version > Connection.ServerVersionInt then
          continue;
        ActiveQueryHelpers.Items.Add( MySQLFunctions[i].Name + MySQLFunctions[i].Declaration );
      end;
    end;

    2: // SQL keywords
    begin
      // State of items in popupmenu
      menuHelp.Enabled := True;
      for i := 0 to MySQLKeywords.Count - 1 do
        ActiveQueryHelpers.Items.Add(MySQLKeywords[i]);
    end;

    3: // SQL Snippets
    begin
      ActiveQueryHelpers.MultiSelect := False;
      Files := getFilesFromDir( DirnameSnippets, '*.sql', true );
      for i := 0 to Files.Count - 1 do
        ActiveQueryHelpers.Items.Add(Files[i]);
	  Files.Free;
      // State of items in popupmenu
      SnippetsAccessible := ActiveQueryHelpers.Items.Count > 0;
      menuDeleteSnippet.Enabled := SnippetsAccessible;
      menuInsertSnippetAtCursor.Enabled := SnippetsAccessible;
      menuLoadSnippet.Enabled := SnippetsAccessible;
      menuExplore.Enabled := True;
    end;

  end;

  // Restore last selected item in tab
  for i := 0 to Length(ActiveQueryTab.HelperListSelectedItems[NewTab]) - 1 do begin
    idx := ActiveQueryTab.HelperListSelectedItems[NewTab][i];
    if idx < ActiveQueryHelpers.Count then
      ActiveQueryHelpers.Selected[idx] := True;
  end;

  ActiveQueryHelpers.Items.EndUpdate;
end;



{**
  Insert string from listbox with query helpers into SQL
  memo at doubleclick
}
procedure TMainForm.lboxQueryHelpersDblClick(Sender: TObject);
var
  m: TSynMemo;
begin
  m := ActiveQueryMemo;
  m.DragDrop(Sender, m.CaretX, m.CaretY);
end;


{**
  Remember last used items in query helper tabs
}
procedure TMainForm.lboxQueryHelpersClick(Sender: TObject);
var
  i, s, idx: Integer;
begin
  s := ActiveQueryTabset.TabIndex;
  SetLength(ActiveQueryTab.HelperListSelectedItems[s], 0);
  for i := 0 to ActiveQueryHelpers.Count - 1 do if ActiveQueryHelpers.Selected[i] then begin
    idx := Length(ActiveQueryTab.HelperListSelectedItems[s]);
    SetLength(ActiveQueryTab.HelperListSelectedItems[s], idx+1);
    ActiveQueryTab.HelperListSelectedItems[s][idx] := i;
  end;
end;


{**
  Insert function name from popupmenu to query memo
}
procedure TMainForm.insertFunction(Sender: TObject);
var
  f : String;
  sm : TSynMemo;
begin
  // Detect which memo is focused
  if SynMemoFilter.Focused then
    sm := SynMemoFilter
  else
    sm := ActiveQueryMemo;
  // Restore function name from array
  f := MySQLFunctions[TControl(Sender).tag].Name
    + MySQLFunctions[TControl(Sender).tag].Declaration;
  sm.UndoList.AddGroupBreak;
  sm.SelText := f;
  sm.UndoList.AddGroupBreak;
  if not SynMemoFilter.Focused then
    ValidateQueryControls(Sender);
end;


{**
  Delete a snippet file
}
procedure TMainForm.menuDeleteSnippetClick(Sender: TObject);
var
  snippetfile : String;
  mayChange : Boolean;
begin
  // Don't do anything if no item was selected
  if ActiveQueryHelpers.ItemIndex = -1 then
    abort;

  snippetfile := DirnameSnippets + ActiveQueryHelpers.Items[ ActiveQueryHelpers.ItemIndex ] + '.sql';
  if MessageDlg( 'Delete snippet file? ' + CRLF + snippetfile, mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
  begin
    Screen.Cursor := crHourGlass;
    if DeleteFile( snippetfile ) then
    begin
      // Refresh list with snippets
      mayChange := True; // Unused; satisfies callee parameter collection which is probably dictated by tabset.
      tabsetQueryHelpersChange( Sender, ActiveQueryTabset.TabIndex, mayChange );
      FillPopupQueryLoad;
    end
    else
    begin
      Screen.Cursor := crDefault;
      MessageDlg( 'Failed deleting ' + snippetfile, mtError, [mbOK], 0 );
    end;
    Screen.Cursor := crDefault;
  end;
end;


{**
  Load snippet at cursor
}
procedure TMainForm.menuInsertSnippetAtCursorClick(Sender: TObject);
begin
  QueryLoad( DirnameSnippets + ActiveQueryHelpers.Items[ActiveQueryHelpers.ItemIndex] + '.sql', False );
end;


{**
  Load snippet and replace content
}
procedure TMainForm.menuLoadSnippetClick(Sender: TObject);
begin
  QueryLoad( DirnameSnippets + ActiveQueryHelpers.Items[ActiveQueryHelpers.ItemIndex] + '.sql', True );
end;


{**
  Open snippets-directory in Explorer
}
procedure TMainForm.menuExploreClick(Sender: TObject);
begin
  // Normally the snippets folder is created at installation. But it sure
  // can be the case that it has been deleted or that the application was
  // not installed properly. Ask if we should create the folder now.
  if DirectoryExists( DirnameSnippets ) then
    ShellExec( '', DirnameSnippets )
  else
    if MessageDlg( 'Snippets folder does not exist: ' + DirnameSnippets + CRLF + CRLF + 'This folder is normally created when you install '+appname+'.' + CRLF + CRLF + 'Shall it be created now?',
      mtWarning, [mbYes, mbNo], 0 ) = mrYes then
    try
      Screen.Cursor := crHourglass;
      ForceDirectories( DirnameSnippets );
    finally
      Screen.Cursor := crDefault;
    end;
end;


procedure TMainForm.menuFetchDBitemsClick(Sender: TObject);
var
  Node: PVirtualNode;
  db: String;
begin
  // Fill db object cache of selected databases
  try
    Screen.Cursor := crHourglass;
    Node := ListDatabases.GetFirstSelected;
    while Assigned(Node) do begin
      db := ListDatabases.Text[Node, 0];
      Connection.GetDBObjects(db, True);
      ListDatabases.RepaintNode(Node);
      DBtree.RepaintNode(FindDBNode(db));
      Node := ListDatabases.GetNextSelected(Node);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;


{**
  Tell a VirtualStringTree the mem size to allocate per node
}
procedure TMainForm.vstGetNodeDataSize(Sender: TBaseVirtualTree; var
    NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TVTreeData);
end;


{**
  Various lists initialize their nodes by calling the following procedure
  once per node
}
procedure TMainForm.vstInitNode(Sender: TBaseVirtualTree; ParentNode,
    Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  NodeData : PVTreeData;
  a : TVTreeDataArray;
begin
  // Get the pointer to the node data
  NodeData := Sender.GetNodeData(Node);
  // Fetch data array
  a := GetVTreeDataArray( Sender )^;
  // Bind data to node
  NodeData.Captions := a[Node.Index].Captions;
  NodeData.ImageIndex := a[Node.Index].ImageIndex;
  NodeData.NodeType := a[Node.Index].NodeType;
end;


{**
  Free data of a node
}
procedure TMainForm.vstFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  b : PVTreeDataArray;
begin
  // Detect which global array should be processed
  b := GetVTreeDataArray( Sender );
  // TODO: If you optimize 'b' out of the code, the compiler will
  //       sometimes generate code that causes a new array here instead of
  //       a reference to the global array, thus breaking SetLength.  Find
  //       out why...
  //TestVTreeDataArray(b);
  if (Low(b^) < 0) or (High(b^) < 0) then raise Exception.Create('Internal error: unsupported array bounds.');
  if Node.Index + 1 < Cardinal(High(b^)) then
  begin
    // Delete node somewhere in the middle of the array
    // Taken from http://delphi.about.com/cs/adptips2004/a/bltip0204_2.htm
    System.Move(
      b^[Node.Index + 1],
      b^[Node.Index],
      (Cardinal(Length(b^)) - (Node.Index - Cardinal(Low(b^))) - 1) * SizeOf(TVTreeData)
    );
  end;
  SetLength(b^, Length(b^) - 1);
end;


{**
  A node in a VirtualStringTree gets visible and asks which text it shall display
}
procedure TMainForm.vstGetText(Sender: TBaseVirtualTree; Node:
    PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
var
  NodeData : PVTreeData;
  i : Integer;
begin
  // Get pointer to node which gets displayed
  NodeData := Sender.GetNodeData(Node);
  // Column is -1 if no column headers are defined
  if Column = -1 then
    i := 0
  else
    i := Column;
  // Avoid AV, don't exceed Captions content
  if NodeData.Captions.Count > i then
    CellText := NodeData.Captions[i]
  else
    CellText := '';
end;


{**
  A node in a VirtualStringTree gets visible and asks which icon it shall display
}
procedure TMainForm.vstGetImageIndex(Sender: TBaseVirtualTree; Node:
    PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted:
    Boolean; var ImageIndex: Integer);
var
  NodeData : PVTreeData;
begin
  // Display icon only for leftmost cell (0) or for tree nodes (-1)
  if Column > 0 then
    exit;
  // Prevent state images, overlaying the normal image
  if not (Kind in [ikNormal, ikSelected]) then Exit;
  // Get pointer to node which gets displayed
  NodeData := Sender.GetNodeData(Node);
  ImageIndex := NodeData.ImageIndex;
end;


{**
  A column header of a VirtualStringTree was clicked:
  Toggle the sort direction
}
procedure TMainForm.vstHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
begin
  // Don't call sorting procedure on right click
  // Some list-headers have a contextmenu which should popup then.
  if HitInfo.Button = mbRight then
    Exit;
  // Beginning with VT's r181, this proc is also called when doubleclicking-to-autofit
  // Seems buggy in VT as this suddenly calls it with Column=-1 in those cases.
  // See also issue #1150
  if HitInfo.Column = NoColumn then
    Exit;

  if Sender.SortColumn <> HitInfo.Column then
    Sender.SortColumn := HitInfo.Column
  else if Sender.SortDirection = sdAscending then
    Sender.SortDirection := sdDescending
  else
    Sender.SortDirection := sdAscending;
  Sender.Treeview.SortTree( HitInfo.Column, Sender.SortDirection );
end;


{**
  Sorting a column of a VirtualTree by comparing two cells
}
procedure TMainForm.vstCompareNodes(Sender: TBaseVirtualTree; Node1,
    Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  VT: TVirtualStringTree;
  CellText1, CellText2 : String;
  Number1, Number2 : Extended;
begin
  VT := Sender as TVirtualStringTree;
  CellText1 := VT.Text[Node1, Column];
  CellText2 := VT.Text[Node2, Column];

  // Map value "0" to "N/A" strings
  if CellText1 = '' then
    CellText1 := '0';
  if CellText2 = '' then
    CellText2 := '0';

  // Apply different comparisons for numbers and text
  if StrToIntDef( copy(CellText1,0,1), -1 ) <> -1 then
  begin
    // Assuming numeric values
    Number1 := MakeFloat( CellText1 );
    Number2 := MakeFloat( CellText2 );
    if Number1 > Number2 then
      Result := 1
    else if Number1 = Number2 then
      Result := 0
    else if Number1 < Number2 then
      Result := -1;
  end
  else begin
    // Compare Strings
    Result := CompareText( CellText1, CellText2 );
  end;
end;


{**
  VirtualTree was painted. Adjust background color of sorted column.
}
procedure TMainForm.vstAfterPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas);
var
  i: Integer;
  h: TVTHeader;
  NewColor: TColor;
begin
  h := (Sender as TVirtualStringTree).Header;
  for i:=0 to h.Columns.Count-1 do begin
    NewColor := clWindow;
    if h.SortColumn = i then
      NewColor := ColorAdjustBrightness(NewColor, COLORSHIFT_SORTCOLUMNS);
    h.Columns[i].Color := NewColor;
  end;
end;


{**
  Return the data array which belongs to a VirtualTree component
}
function TMainForm.GetVTreeDataArray( VT: TBaseVirtualTree ): PVTreeDataArray;
begin
  if VT = ListVariables then
    Result := @VTRowDataListVariables
  else if VT = ListStatus then
    Result := @VTRowDataListStatus
  else if VT = ListCommandStats then
    Result := @VTRowDataListCommandStats
  else if VT = ListProcesses then
    Result := @VTRowDataListProcesses
  else begin
    raise Exception.Create( VT.ClassName + ' "' + VT.Name + '" doesn''t have an assigned array with data.' );
  end;
end;


{**
  Internal: Test quality of code/compiler.
}
procedure TMainForm.TestVTreeDataArray( P: PVTreeDataArray );
begin
  if P = @VTRowDataListVariables then Exit;
  if P = @VTRowDataListStatus then Exit;
  if P = @VTRowDataListCommandStats then Exit;
  if P = @VTRowDataListProcesses then Exit;
  raise Exception.Create('Assertion failed: Invalid global VT array.');
end;


{**
  Save setup of a VirtualStringTree to registry
}
procedure TMainForm.SaveListSetup( List: TVirtualStringTree );
var
  i : Byte;
  ColWidths, ColsVisible, ColPos, Regname: String;
  OwnerForm: TWinControl;
begin
  ColWidths := '';
  ColsVisible := '';
  ColPos := '';
  for i := 0 to List.Header.Columns.Count - 1 do
  begin
    // Column widths
    if ColWidths <> '' then
      ColWidths := ColWidths + ',';
    ColWidths := ColWidths + IntToStr(List.Header.Columns[i].Width);

    // Column visibility
    if coVisible in List.Header.Columns[i].Options then
    begin
      if ColsVisible <> '' then
        ColsVisible := ColsVisible + ',';
      ColsVisible := ColsVisible + IntToStr(i);
    end;

    // Column position
    if ColPos <> '' then
      ColPos := ColPos + ',';
    ColPos := ColPos + IntToStr(List.Header.Columns[i].Position);

  end;

  // Lists can have the same name over different forms or frames. Find parent form or frame,
  // so we can prepend its name into the registry value name.
  OwnerForm := GetParentFormOrFrame(List);
  // On a windows shutdown, GetParentForm() seems sporadically unable to find the owner form
  // In that case we would cause an exception when accessing it. Emergency break in that case.
  // See issue #1462
  // TODO: Test this, probably fixed by implementing GetParentFormOrFrame, and then again, probably not.
  if not Assigned(OwnerForm) then
    Exit;
  Regname := OwnerForm.Name + '.' + List.Name;
  OpenRegistry;
  MainReg.WriteString( REGPREFIX_COLWIDTHS + Regname, ColWidths );
  MainReg.WriteString( REGPREFIX_COLSVISIBLE + Regname, ColsVisible );
  MainReg.WriteString( REGPREFIX_COLPOS + Regname, ColPos );
end;


{**
  Restore setup of VirtualStringTree from registry
}
procedure TMainForm.RestoreListSetup( List: TVirtualStringTree );
var
  i : Byte;
  colwidth, colpos : Integer;
  Value : String;
  ValueList : TStringList;
  Regname: String;
  OwnerForm: TWinControl;
begin
  ValueList := TStringList.Create;

  // Column widths
  OwnerForm := GetParentFormOrFrame(List);
  Regname := OwnerForm.Name + '.' + List.Name;
  Value := GetRegValue(REGPREFIX_COLWIDTHS + Regname, '');
  if Value <> '' then begin
    ValueList := Explode( ',', Value );
    for i := 0 to ValueList.Count - 1 do
    begin
      colwidth := MakeInt(ValueList[i]);
      // Check if column number exists and width is at least 1 pixel
      if (List.Header.Columns.Count > i) and (colwidth > 0) then
        List.Header.Columns[i].Width := colwidth;
    end;
  end;

  // Column visibility
  Value := GetRegValue(REGPREFIX_COLSVISIBLE + Regname, '');
  if Value <> '' then begin
    ValueList := Explode( ',', Value );
    for i:=0 to List.Header.Columns.Count-1 do begin
      if ValueList.IndexOf( IntToStr(i) ) > -1 then
        List.Header.Columns[i].Options := List.Header.Columns[i].Options + [coVisible]
      else
        List.Header.Columns[i].Options := List.Header.Columns[i].Options - [coVisible];
    end;
  end;

  // Column position
  Value := GetRegValue(REGPREFIX_COLPOS + Regname, '');
  if Value <> '' then begin
    ValueList := Explode( ',', Value );
    for i := 0 to ValueList.Count - 1 do
    begin
      colpos := MakeInt(ValueList[i]);
      // Check if column number exists
      if List.Header.Columns.Count > i then
        List.Header.Columns[i].Position := colpos;
    end;
  end;

  ValueList.Free;
end;


{**
  Start writing logfile.
  Called either in FormShow or after closing preferences dialog
}
procedure TMainForm.ActivateFileLogging;
var
  LogfilePattern : String;
  i : Integer;
begin
  // Ensure directory exists
  if prefDirnameSessionLogs[Length(prefDirnameSessionLogs)] <> '\' then
    prefDirnameSessionLogs := prefDirnameSessionLogs + '\';
  ForceDirectories(prefDirnameSessionLogs);

  // Determine free filename
  LogfilePattern := '%s %.6u.log';
  i := 1;
  FileNameSessionLog := prefDirnameSessionLogs + goodfilename(Format(LogfilePattern, [SessionName, i]));
  while FileExists( FileNameSessionLog ) do
  begin
    inc(i);
    FileNameSessionLog := prefDirnameSessionLogs + goodfilename(Format(LogfilePattern, [SessionName, i]));
  end;

  // Create file handle for writing
  AssignFile( FileHandleSessionLog, FileNameSessionLog );
  {$I-} // Supress errors
  if FileExists(FileNameSessionLog) then
    Append(FileHandleSessionLog)
  else
    Rewrite(FileHandleSessionLog);
  {$I+}
  if IOResult <> 0 then
  begin
    MessageDlg('Error opening session log file:'+CRLF+FileNameSessionLog+CRLF+CRLF+'Logging is disabled now.', mtError, [mbOK], 0);
    prefLogToFile := False;
  end else
    prefLogToFile := True;
  // Update popupMenu items
  menuLogToFile.Checked := prefLogToFile;
  menuOpenLogFolder.Enabled := prefLogToFile;
end;


{**
  Close logfile.
  Called in FormClose, in ActivateFileLogging and on closing preferences dialog
}
procedure TMainForm.DeactivateFileLogging;
begin
  prefLogToFile := False;
  {$I-} // Supress errors
  CloseFile(FileHandleSessionLog);
  {$I+}
  // Reset IOResult so later checks in ActivateFileLogging doesn't get an old value
  IOResult;
  // Update popupMenu items
  menuLogToFile.Checked := prefLogToFile;
  menuOpenLogFolder.Enabled := prefLogToFile;
end;


{**
  Display tooltips in VirtualTrees. Imitates default behaviour of TListView.
}
procedure TMainForm.vstGetHint(Sender: TBaseVirtualTree; Node:
    PVirtualNode; Column: TColumnIndex; var LineBreakStyle:
    TVTTooltipLineBreakStyle; var HintText: String);
var
  r : TRect;
  DisplayedWidth,
  NeededWidth : Integer;
  Tree: TVirtualStringTree;
begin
  Tree := TVirtualStringTree(Sender);
  HintText := Tree.Text[Node, Column];
  HintText := sstr(HintText, SIZE_KB);
  LineBreakStyle := hlbForceMultiLine;
  // Check if the list has shortened the text
  r := Tree.GetDisplayRect(Node, Column, True);
  DisplayedWidth := r.Right-r.Left;
  NeededWidth := Canvas.TextWidth(HintText) + Tree.TextMargin*2;
  //debug(format('need: %d, given: %d, font: %s %d', [NeededWidth, DisplayedWidth, canvas.Font.Name, canvas.Font.Size]));
  // Disable displaying hint if text is displayed completely in list
  if NeededWidth <= DisplayedWidth then
    HintText := '';
end;


{**
  Enable/disable file logging by popupmenuclick
}
procedure TMainForm.menuLogToFileClick(Sender: TObject);
var
  OldprefLogToFile: Boolean;
begin
  OldprefLogToFile := prefLogToFile;
  if not prefLogToFile then
    ActivateFileLogging
  else
    DeactivateFileLogging;

  // Save option
  if prefLogToFile <> OldprefLogToFile then
  begin
    OpenRegistry;
    MainReg.WriteBool('LogToFile', prefLogToFile);
  end;
end;


{**
  Open folder with session logs
}
procedure TMainForm.menuOpenLogFolderClick(Sender: TObject);
begin
  ShellExec('', prefDirnameSessionLogs);
end;


{**
  A header column of a VirtualTree was "dragged out", which means:
  dragged down or up, not to the left or right.
  We imitate the behaviour of various applications (fx Outlook) and
  hide this dragged column
}
procedure TMainForm.vstHeaderDraggedOut(Sender: TVTHeader; Column:
    TColumnIndex; DropPosition: TPoint);
begin
  // Hide the draggedout column
  Sender.Columns[Column].Options := Sender.Columns[Column].Options - [coVisible];
end;


procedure TMainForm.vstIncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode;
  const SearchText: String; var Result: Integer);
var
  CellText: String;
  VT: TVirtualStringTree;
begin
  // Override VT's default incremental search behaviour. Make it case insensitive.
  VT := Sender as TVirtualStringTree;
  if VT.FocusedColumn = NoColumn then
    Exit;
  CellText := VT.Text[Node, VT.FocusedColumn];
  Result := StrLIComp(PChar(CellText), PChar(SearchText), Length(SearchText));
end;


{**
  A cell in ListCommandStats gets painted.
  Draw a progress bar on it to visualize its percentage value.
}
procedure TMainForm.ListCommandStatsBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  NodeData: PVTreeData;
begin
  // Only paint bar in percentage column
  if Column = 4 then begin
    NodeData := Sender.GetNodeData(Node);
    PaintColorBar(MakeFloat(NodeData.Captions[Column]), 100, TargetCanvas, CellRect);
  end;
end;


procedure TMainForm.ListTablesBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
  var ContentRect: TRect);
var
  Obj: PDBObject;
begin
  // Only paint bar in rows + size column
  if Column in [1, 2] then begin
    Obj := Sender.GetNodeData(Node);
    case Column of
      1: PaintColorBar(Obj.Rows, DBObjectsMaxRows, TargetCanvas, CellRect);
      2: PaintColorBar(Obj.Size, DBObjectsMaxSize, TargetCanvas, CellRect);
    end;
  end;
end;

procedure TMainForm.ListProcessesBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
  var ContentRect: TRect);
var
  NodeData: PVTreeData;
begin
  if Column = 5 then begin
    NodeData := Sender.GetNodeData(Node);
    PaintColorBar(MakeFloat(NodeData.Captions[Column]), ProcessListMaxTime, TargetCanvas, CellRect);
  end;
end;


procedure TMainForm.PaintColorBar(Value, Max: Extended; TargetCanvas: TCanvas; CellRect: TRect);
var
  BarWidth, CellWidth: Integer;
begin
  if not prefDisplayBars then
    Exit;

  // Add minimal margin to cell edges
  InflateRect(CellRect, -1, -1);
  CellWidth := CellRect.Right - CellRect.Left;
  BarWidth := Round(CellWidth / Max * Value);

  if BarWidth > 0 then begin
    TargetCanvas.Brush.Color := prefBarColor;
    TargetCanvas.Pen.Color := ColorAdjustBrightness(TargetCanvas.Brush.Color, -40);
    TargetCanvas.RoundRect(CellRect.Left, CellRect.Top, CellRect.Left+BarWidth, CellRect.Bottom, 2, 2);
  end;
end;


{**
  A row in the process list was selected. Fill SynMemoProcessView with
  the SQL of that row.
}
procedure TMainForm.ListProcessesFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  NodeData : PVTreeData;
  enableSQLView : Boolean;
begin
  enableSQLView := Assigned(Node);
  SynMemoProcessView.Enabled := enableSQLView;
  pnlProcessView.Enabled := enableSQLView;
  if enableSQLView then begin
    NodeData := ListProcesses.GetNodeData(Node);
    SynMemoProcessView.Highlighter := SynSQLSyn1;
    SynMemoProcessView.Text := NodeData.Captions[7];
    SynMemoProcessView.Color := clWindow;
  end else begin
    SynMemoProcessView.Highlighter := nil;
    SynMemoProcessView.Text := 'Please select a process in the above list.';
    SynMemoProcessView.Color := clBtnFace;
  end;
  lblExplainProcess.Enabled := enableSQLView
    and (UpperCase(GetFirstWord(SynMemoProcessView.Text)) <> 'SHOW')
    and (SynMemoProcessView.GetTextLen > 0);
  menuExplainProcess.Enabled := lblExplainProcess.Enabled;
end;


{***
  Apply a filter to a Virtual Tree.
}
procedure TMainForm.editFilterVTChange(Sender: TObject);
begin
  // Reset typing timer
  TimerFilterVT.Enabled := False;
  TimerFilterVT.Enabled := True;
  editFilterVT.RightButton.Enabled := editFilterVT.Text <> '';
end;


procedure TMainForm.editFilterVTRightButtonClick(Sender: TObject);
begin
  (Sender as TButtonedEdit).Clear;
end;


procedure TMainForm.TimerFilterVTTimer(Sender: TObject);
var
  Node : PVirtualNode;
  VT : TVirtualStringTree;
  i : Integer;
  match : Boolean;
  search : String;
  tab: TTabSheet;
  VisibleCount: Cardinal;
  CellText: String;
begin
  // Disable timer to avoid filtering in a loop
  TimerFilterVT.Enabled := False;
  // Find the correct VirtualTree that shall be filtered
  tab := PageControlMain.ActivePage;
  if tab = tabHost then
    tab := PageControlHost.ActivePage;
  VT := nil;
  if tab = tabDatabases then begin
    VT := ListDatabases;
    FilterTextDatabases := editFilterVT.Text;
  end else if tab = tabVariables then begin
    VT := ListVariables;
    FilterTextVariables := editFilterVT.Text;
  end else if tab = tabStatus then begin
    VT := ListStatus;
    FilterTextStatus := editFilterVT.Text;
  end else if tab = tabProcesslist then begin
    VT := ListProcesses;
    FilterTextProcessList := editFilterVT.Text;
  end else if tab = tabCommandStats then begin
    VT := ListCommandStats;
    FilterTextCommandStats := editFilterVT.Text;
  end else if tab = tabDatabase then begin
    VT := ListTables;
    FilterTextDatabase := editFilterVT.Text;
  end else if tab = tabData then begin
    VT := DataGrid;
    FilterTextData := editFilterVT.Text;
  end else if QueryTabActive and (tab = ActiveQueryTab.TabSheet) then begin
    VT := ActiveGrid;
    ActiveQueryTab.FilterText := editFilterVT.Text;
  end;
  if not Assigned(VT) then
    Exit;
  // Loop through all nodes and hide non matching
  Node := VT.GetFirst;
  search := LowerCase( editFilterVT.Text );
  VisibleCount := 0;
  while Assigned(Node) do begin
    // Don't filter anything if the filter text is empty
    match := search = '';
    // Search for given text in node's captions
    if not match then for i := 0 to VT.Header.Columns.Count - 1 do begin
      CellText := VT.Text[Node, i];
      if Pos( search, LowerCase(CellText)) > 0 then begin
        match := True;
        break;
      end;
    end;
    VT.IsVisible[Node] := match;
    if match then
      inc(VisibleCount);
    Node := VT.GetNext(Node);
  end;
  if search <> '' then begin
    lblFilterVTInfo.Caption := IntToStr(VisibleCount)+' out of '+IntToStr(VT.RootNodeCount)+' matching. '
      + IntToStr(VT.RootNodeCount - VisibleCount) + ' hidden.';
  end else
    lblFilterVTInfo.Caption := '';
  VT.Repaint;
end;


procedure TMainForm.ListVariablesDblClick(Sender: TObject);
begin
  menuEditVariable.Click;
end;


{**
  Edit a server variable
}
procedure TMainForm.menuEditVariableClick(Sender: TObject);
var
  NodeData: PVTreeData;
begin
  if EditVariableForm = nil then
    EditVariableForm := TfrmEditVariable.Create(Self);
  NodeData := ListVariables.GetNodeData(ListVariables.FocusedNode);
  EditVariableForm.VarName := NodeData.Captions[0];
  EditVariableForm.VarValue := NodeData.Captions[1];
  // Refresh relevant list node
  if EditVariableForm.ShowModal = mrOK then
    NodeData.Captions[1] := Connection.GetVar('SHOW VARIABLES LIKE '+esc(NodeData.Captions[0]), 1);
end;


{**
  The database tree doesn't use any structure for its nodes.
}
procedure TMainForm.DBtreeGetNodeDataSize(Sender: TBaseVirtualTree; var
    NodeDataSize: Integer);
begin
  NodeDataSize := 0;
end;


{**
  Set text of a treenode before it gets displayed or fetched in any way
}
procedure TMainForm.DBtreeGetText(Sender: TBaseVirtualTree; Node:
    PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
var
  DBObjects: TDBObjectList;
  db: String;
  i: Integer;
  Bytes: Int64;
  AllListsCached: Boolean;
begin
  case Column of
    0: case Sender.GetNodeLevel(Node) of
        0: CellText := Connection.Parameters.Username + '@' + Connection.Parameters.Hostname;
        1: CellText := Databases[Node.Index];
        2: begin
            DBObjects := Connection.GetDBObjects(Databases[Node.Parent.Index]);
            CellText := DBObjects[Node.Index].Name;
          end;
      end;
    1: case GetTreeNodeType(Sender, Node) of
        // Calculate and display the sum of all table sizes in ALL dbs if all table lists are cached
        lntNone: begin
            AllListsCached := true;
            for i := 0 to Databases.Count - 1 do begin
              if not Connection.DbObjectsCached(Databases[i]) then begin
                AllListsCached := false;
                break;
              end;
            end;
            // Will be also set to a negative value by GetTableSize and results of SHOW TABLES
            Bytes := -1;
            if AllListsCached then begin
              Bytes := 0;
              for i:=0 to Databases.Count-1 do begin
                DBObjects := Connection.GetDBObjects(Databases[i]);
                Inc(Bytes, DBObjects.DataSize);
              end;
            end;
            if Bytes >= 0 then CellText := FormatByteNumber(Bytes)
            else CellText := '';
          end;
        // Calculate and display the sum of all table sizes in ONE db, if the list is already cached.
        lntDb: begin
            db := (Sender as TVirtualStringTree).Text[Node, 0];
            if not Connection.DbObjectsCached(db) then
              CellText := ''
            else begin
              DBObjects := Connection.GetDBObjects(db);
              CellText := FormatByteNumber(DBObjects.DataSize);
            end;
          end;
        lntTable: begin
          db := (Sender as TVirtualStringTree).Text[Node.Parent, 0];
          DBObjects := Connection.GetDBObjects(db);
          CellText := FormatByteNumber(DBObjects[Node.Index].Size);
        end
        else CellText := ''; // Applies for views and crashed tables
      end;
  end;
end;


{**
  Set icon of a treenode before it gets displayed
}
procedure TMainForm.DBtreeGetImageIndex(Sender: TBaseVirtualTree; Node:
    PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted:
    Boolean; var ImageIndex: Integer);
var
  DBObjects: TDBObjectList;
  vt: TVirtualStringTree;
  db: String;
begin
  if Column > 0 then
    Exit;
  // Prevent state images, overlaying the normal image
  if not (Kind in [ikNormal, ikSelected]) then Exit;
  vt := Sender as TVirtualStringTree;
  case Sender.GetNodeLevel(Node) of
    0: ImageIndex := ICONINDEX_SERVER;
    1: begin
      db := vt.Text[Node, 0];
      if ActiveDatabase = db then
        ImageIndex := ICONINDEX_DB_HIGHLIGHT
      else
        ImageIndex := ICONINDEX_DB;
      Ghosted := not Connection.DbObjectsCached(db);
    end;
    2: begin
        DBObjects := Connection.GetDBObjects(Databases[Node.Parent.Index]);
        // Various bug reports refer to this location where we reference a db object which is outside the range
        // of DBObjects. Probably a timing issue. Work around that by doing a safety check here.
        if Node.Index >= Cardinal(DBObjects.Count) then
          Exit;
        ImageIndex := DBObjects[Node.Index].ImageIndex;
      end;
  end;
end;


{**
  Set childcount of an expanding treenode
}
procedure TMainForm.DBtreeInitChildren(Sender: TBaseVirtualTree; Node:
    PVirtualNode; var ChildCount: Cardinal);
var
  VT: TVirtualStringTree;
  i, j: Integer;
  DatabasesWanted: TStringList;
  rx: TRegExpr;
  FilterError: Boolean;
begin
  VT := Sender as TVirtualStringTree;
  case VT.GetNodeLevel(Node) of
    // Root node has only one single child (user@host)
    0: begin
        Screen.Cursor := crHourglass;
        try
          if not Assigned(AllDatabases) then begin
            ShowStatusMsg( 'Reading Databases...' );
            AllDatabases := Connection.GetCol('SHOW DATABASES');
            InvalidateVT(ListDatabases, VTREE_NOTLOADED, False);
          end;
          if not Assigned(Databases) then
            Databases := TStringList.Create;
          Databases.Clear;
          DatabasesWanted := Explode(';', comboOnlyDBs.Text);
          FilterError := False;
          if DatabasesWanted.Count > 0 then begin
            // Add dbs by regular expression, avoiding duplicates
            rx := TRegExpr.Create;
            rx.Expression := '('+ImplodeStr('|', DatabasesWanted)+')';
            for j:=0 to AllDatabases.Count-1 do try
              // The regular expression can have syntax errors which lead to an AV
              if rx.Exec(AllDatabases[j]) then
                Databases.Add(AllDatabases[j]);
            except
              FilterError := True;
              break;
            end;
            rx.Free;
            if Databases.Count = 0 then
              FilterError := True;
          end;
          if FilterError then
            comboOnlyDBs.Color := clWebPink
          else
            comboOnlyDBs.Color := clWindow;
          FreeAndNil(DatabasesWanted);
          if Databases.Count = 0 then
            Databases.Assign(AllDatabases);
          Databases.Sort;

          // Prioritised position of virtual system database
          i := Databases.IndexOf(DBNAME_INFORMATION_SCHEMA);
          if i > -1 then
            Databases.Move(i, 0);

          ShowStatusMsg( IntToStr( Databases.Count ) + ' Databases', 0 );
          ChildCount := Databases.Count;
        finally
          ShowStatusMsg( STATUS_MSG_READY );
          Screen.Cursor := crDefault;
        end;
      end;
    // DB node expanding
    1: begin
        Screen.Cursor := crHourglass;
        ShowStatusMsg( 'Reading objects ...' );
        try
          ChildCount := Connection.GetDBObjects(Databases[Node.Index]).Count;
        finally
          ShowStatusMsg( STATUS_MSG_READY );
          Screen.Cursor := crDefault;
        end;
      end;
    else Exit;
  end;
end;


{**
  Set initial options of a treenode
}
procedure TMainForm.DBtreeInitNode(Sender: TBaseVirtualTree; ParentNode, Node:
    PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  level: Cardinal;
begin
  level := Sender.GetNodeLevel(Node);
  // Ensure plus sign is visible for root and dbs
  if level in [0,1] then
    Include( InitialStates, ivsHasChildren);
  // Host node is always expanded
  if level = 0 then
    Include( InitialStates, ivsExpanded );
end;


{**
  Selection in database tree has changed
}
procedure TMainForm.DBtreeFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  newDb, oldDb, newDbObject: String;
begin
  debug('DBtreeFocusChanged()');
  SelectedTableCreateStatement := '';
  if not Assigned(Node) then
    Exit;
  // Post pending UPDATE
  if DataGridHasChanges then
    actDataPostChangesExecute(Sender);
  case Sender.GetNodeLevel(Node) of
    0: begin
      if (not DBtree.Dragging) and (not QueryTabActive) then begin
        PageControlMain.ActivePage := tabHost;
        PageControlMain.OnChange(Sender);
        PageControlHost.ActivePage := tabDatabases;
      end;
      tabDatabase.TabVisible := False;
      tabEditor.TabVisible := False;
      tabData.TabVisible := False;
    end;
    1: begin
        newDb := Databases[Node.Index];
        // Selecting a database can cause an SQL error if the db was deleted from outside. Select previous node in that case.
        try
          Connection.Database := newDb;
        except on E:Exception do begin
            MessageDlg(E.Message, mtError, [mbOK], 0);
            SelectNode(DBtree, PreviousFocusedNode);
            Exit;
          end;
        end;
        if (not DBtree.Dragging) and (not QueryTabActive) then begin
          PageControlMain.ActivePage := tabDatabase;
          PageControlMain.OnChange(Sender);
        end;
        tabDatabase.TabVisible := true;
        tabEditor.TabVisible := false;
        tabData.TabVisible := false;
      end;
    2: begin
        newDb := Databases[Node.Parent.Index];
        try
          Connection.Database := newDb;
        except on E:Exception do begin
            MessageDlg(E.Message, mtError, [mbOK], 0);
            SelectNode(DBtree, PreviousFocusedNode);
            Exit;
          end;
        end;
        newDbObject := SelectedTable.Name;
        tabEditor.TabVisible := SelectedTable.NodeType in [lntTable, lntView, lntProcedure, lntFunction, lntTrigger, lntEvent];
        tabData.TabVisible := SelectedTable.NodeType in [lntTable, lntView];
        ParseSelectedTableStructure;
        if tabEditor.TabVisible then begin
          actEditObjectExecute(Sender);
          // When a table is clicked in the tree, and the current
          // tab is a Host or Database tab, switch to showing table columns.
          if (PagecontrolMain.ActivePage = tabHost) or (PagecontrolMain.ActivePage = tabDatabase) then begin
            PagecontrolMain.ActivePage := tabEditor;
            PageControlMain.OnChange(Sender);
          end;
          InvalidateVT(DataGrid, VTREE_NOTLOADED, False);
          // When a table is clicked in the tree, and the query
          // tab is active, update the list of columns
          if QueryTabActive then
            RefreshQueryHelpers;
        end;
      end;
  end;
  if Assigned(PreviousFocusedNode) then case DBTree.GetNodeLevel(PreviousFocusedNode) of
    0: oldDb := '';
    1: oldDb := DBTree.Text[PreviousFocusedNode, 0];
    2: oldDb := DBTree.Text[PreviousFocusedNode.Parent, 0];
  end;
  if newDb <> oldDb then begin
    tabDatabase.Caption := sstr('Database: ' + newDb, 30);
    ListTables.ClearSelection;
    ListTables.FocusedNode := nil;
    InvalidateVT(ListTables, VTREE_NOTLOADED, False);
  end;
  PreviousFocusedNode := DBTree.FocusedNode;
  FixQueryTabCloseButtons;
  SetWindowCaption;
end;


procedure TMainForm.DBtreeFocusChanging(Sender: TBaseVirtualTree; OldNode,
  NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  debug('DBtreeFocusChanging');
  // Check if some editor has unsaved changes
  if Assigned(ActiveObjectEditor) and Assigned(NewNode) and (NewNode <> OldNode) then begin
    Allowed := not (ActiveObjectEditor.DeInit in [mrAbort, mrCancel]);
    DBTree.Selected[DBTree.FocusedNode] := not Allowed;
  end else
    Allowed := True;
end;


procedure TMainForm.DBtreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  // Keep track of the previously selected tree node's state, to avoid AVs in OnFocusChanged()
  if Node = PreviousFocusedNode then
    PreviousFocusedNode := nil;
end;


procedure TMainForm.ParseSelectedTableStructure;
begin
  SelectedTableColumns.Clear;
  SelectedTableKeys.Clear;
  SelectedTableForeignKeys.Clear;
  InvalidateVT(DataGrid, VTREE_NOTLOADED_PURGECACHE, False);
  try
    case SelectedTable.NodeType of
      lntTable: begin
        SelectedTableCreateStatement := Connection.GetVar('SHOW CREATE TABLE '+Mainform.mask(SelectedTable.Name), 1);
        ParseTableStructure(SelectedTableCreateStatement, SelectedTableColumns, SelectedTableKeys, SelectedTableForeignKeys);
      end;
      lntView: ParseViewStructure(SelectedTable.Name, SelectedTableColumns);
    end;
  except on E:Exception do
    MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;


procedure TMainForm.DatabaseChanged(Database: String);
begin
  if (Database='') or (Databases.IndexOf(Database) > -1) then
    ActiveDatabase := Database;
end;


procedure TMainForm.DBObjectsCleared(Database: String);
begin
  if (Database='') or (ActiveDatabase=Database) then
    InvalidateVT(ListTables, VTREE_NOTLOADED, False);
end;


procedure TMainForm.DBtreeDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  m: TSynMemo;
begin
  // Paste DB or table name into query window on treeview double click.
  Node := DBtree.FocusedNode;
  if not Assigned(Node) then Exit;
  if DBtree.GetNodeLevel(Node) = 0 then Exit;
  if not QueryTabActive then Exit;
  m := ActiveQueryMemo;
  m.DragDrop(Sender, m.CaretX, m.CaretY);
end;


procedure TMainForm.DBtreePaintText(Sender: TBaseVirtualTree; const
    TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType:
    TVSTTextType);
begin
  // Grey out rather unimportant "Size" column
  if Column <> 1 then
    Exit;
  case Sender.GetNodeLevel(Node) of
    0, 1: TargetCanvas.Font.Color := clWindowText;
    2: TargetCanvas.Font.Color := $00444444;
  end;
end;


{**
  Refresh the whole tree
}
procedure TMainForm.RefreshTree(DoResetTableCache: Boolean; SelectDatabase: String = '');
var
  oldActiveDatabase, oldSelectedTableName: String;
  oldSelectedTableType: TListNodeType;
begin
  // Remember currently active database and table
  debug('RefreshTree()');
  oldActiveDatabase := ActiveDatabase;
  oldSelectedTableName := SelectedTable.Name;
  oldSelectedTableType := SelectedTable.NodeType;
  DBtree.FocusedNode := nil;

  // ReInit tree population
  if DoResetTableCache then begin
    Connection.ClearAllDbObjects;
    FreeAndNil(AllDatabases);
  end;
  DBtree.ResetNode(DBTree.GetFirst);

  // Reselect active or new database if present. Could have been deleted or renamed.
  try
    if SelectDatabase <> '' then
      ActiveDatabase := SelectDatabase
    else if oldActiveDatabase <> '' then
      ActiveDatabase := oldActiveDatabase;
    if oldSelectedTableName <> '' then
      SelectDBObject(oldSelectedTableName, oldSelectedTableType);
  except
  end;
  // Select "host" node if database was deleted outside and node is gone
  if not Assigned(DBtree.FocusedNode) then
    SelectNode(DBtree, DBtree.GetFirst);
end;


{**
  Refresh one database node in the db tree
}
procedure TMainForm.RefreshTreeDB(db: String; FocusObjectName: String=''; FocusObjectType: TListNodeType=lntNone);
var
  oldActiveDatabase: String;
  DBNode, FNode: PVirtualNode;
  TableHereHadFocus: Boolean;
  DBObjects: TDBObjectList;
  i: Integer;
  FocusFound: Boolean;
  FocusChangeEvent: procedure(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex) of object;
  FocusChangingEvent: procedure(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode; OldColumn,
    NewColumn: TColumnIndex; var Allowed: Boolean) of object;
begin
  debug('RefreshTreeDB()');
  DBNode := FindDBNode(db);
  FNode := DBtree.FocusedNode;
  TableHereHadFocus := Assigned(FNode) and ((FNode.Parent = DBNode) or (FocusObjectName <> ''));
  oldActiveDatabase := ActiveDatabase;
  if FocusObjectName = '' then begin
    // Most cases just go here and focus the old table afterwards
    FocusObjectName := SelectedTable.Name;
    FocusObjectType := SelectedTable.NodeType;
  end;
  // Suspend focus changing event, to avoid tab jumping
  FocusChangingEvent := DBtree.OnFocusChanging;
  FocusChangeEvent := DBtree.OnFocusChanged;
  DBtree.OnFocusChanging := nil;
  DBtree.OnFocusChanged := nil;
  // Refresh db node
  Connection.ClearDbObjects(db);
  DBTree.ReinitNode(DBNode, true);
  DBtree.InvalidateChildren(DBNode, false);
  // Set focus on previously focused table node
  FocusFound := False;
  if TableHereHadFocus then begin
    DBObjects := Connection.GetDBObjects(db);
    for i:=0 to DBObjects.Count-1 do begin
      // Need to check if table was renamed, in which case oldSelectedTable is no longer available
      if (DBObjects[i].Name = FocusObjectName)
        and (DBObjects[i].NodeType = FocusObjectType) then begin
        FocusFound := True;
        SelectDBObject(FocusObjectName, FocusObjectType);
        break;
      end;
    end;
  end;
  // Reactivate focus changing event
  DBtree.OnFocusChanging := FocusChangingEvent;
  DBtree.OnFocusChanged := FocusChangeEvent;
  // If old table was deleted, set focus on parent database node
  if TableHereHadFocus and (not FocusFound) and (Databases.IndexOf(oldActiveDatabase) > -1) then
    SelectNode(DBtree, FindDBNode(oldActiveDatabase));
end;


{**
  Find a database node in the tree by passing its name
}
function TMainForm.FindDBNode(db: String): PVirtualNode;
var
  i, s: Integer;
  n: PVirtualNode;
begin
  Result := nil;
  // Ensure Databases list is instantiated (by DBtree.InitChildren)
  if Databases = nil then
    DBtree.ReinitNode(DBtree.GetFirst, False);
  // TStringList.CaseSensitive= True|False is only used in .IndexOf and .Sort procs,
  // it does not avoid or remove duplicate items
  Databases.CaseSensitive := True;
  s := Databases.IndexOf(db);
  if s = -1 then begin
    Databases.CaseSensitive := False;
    s := Databases.IndexOf(db);
  end;
  if s > -1 then begin
    n := DBtree.GetFirstChild(DBtree.GetFirst);
    for i := 0 to DBtree.GetFirst.ChildCount - 1 do begin
      if Integer(n.Index) = s then begin
        Result := n;
        Exit;
      end;
      n := DBtree.GetNextSibling(n);
    end;
  end;
end;


{**
  Expand all db nodes
}
procedure TMainForm.menuTreeExpandAllClick(Sender: TObject);
begin
  DBtree.FullExpand;
  DBtree.ScrollIntoView(DBtree.FocusedNode, False);
end;

{**
  Collapse all db nodes
}
procedure TMainForm.menuTreeCollapseAllClick(Sender: TObject);
var
  n: PVirtualNode;
  i: Integer;
begin
  n := DBtree.GetFirstChild(DBtree.GetFirst);
  for i := 0 to DBtree.GetFirst.ChildCount - 1 do begin
    DBtree.FullCollapse(n);
    n := DBtree.GetNextSibling(n);
  end;
  DBtree.ScrollIntoView(DBtree.FocusedNode, False);
end;


procedure TMainForm.editFilterSearchChange(Sender: TObject);
var
  Add, Clause: String;
  i: Integer;
  ed: TEdit;
  Col: TTableColumn;
begin
  ed := TEdit(Sender);
  Clause := '';
  Add := '';
  if ed.Text <> '' then begin
    for i:=0 to SelectedTableColumns.Count-1 do begin
      Col := TTableColumn(SelectedTableColumns[i]);
      if i > 0 then
        Add := Add + ' OR ';
      Add := Add + mask(Col.Name) + ' LIKE ' + esc('%'+ed.Text+'%');
      if Length(Add) > 45 then begin
        Clause := Clause + Add + CRLF;
        Add := '';
      end;
    end;
    if Add <> '' then
      Clause := Clause + Add;
  end;
  SynMemoFilter.UndoList.AddGroupBreak;
  SynMemoFilter.SelectAll;
  SynMemoFilter.SelText := Clause;
end;


procedure TMainForm.SynMemoFilterStatusChange(Sender: TObject; Changes: TSynStatusChanges);
begin
  actClearFilterEditor.Enabled := (Sender as TSynMemo).GetTextLen > 0;
end;


procedure TMainForm.ToggleFilterPanel(ForceVisible: Boolean = False);
var
  ShowIt: Boolean;
begin
  ShowIt := ForceVisible or (not pnlFilter.Visible);
  tbtnDataFilter.Down := ShowIt;
  pnlFilter.Visible := ShowIt;
end;


procedure TMainForm.editFilterSearchEnter(Sender: TObject);
begin
  // Enables triggering apply button with Enter
  btnFilterApply.Default := True;
end;


procedure TMainForm.editFilterSearchExit(Sender: TObject);
begin
  btnFilterApply.Default := False;
end;



{**
  A grid cell fetches its text content
}
procedure TMainForm.AnyGridGetText(Sender: TBaseVirtualTree; Node:
    PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
var
  c: PGridCell;
  gr: TGridResult;
  EditingCell: Boolean;
begin
  if Column = -1 then
    Exit;
  gr := GridResult(Sender);

  c := @gr.Rows[Node.Index].Cells[Column];
  EditingCell := Sender.IsEditing and (Node = Sender.FocusedNode) and (Column = Sender.FocusedColumn);
  if c.Modified then begin
    if c.NewIsNull then begin
      if EditingCell then CellText := ''
      else CellText := TEXT_NULL;
    end else CellText := c.NewText;
  end else begin
    if c.IsNull then begin
      if EditingCell then CellText := ''
      else CellText := TEXT_NULL;
    end else begin
      CellText := c.Text;
      if (Sender = DataGrid) and (not DataGridRowHasFullData(Node)) and (Length(c.Text) = GRIDMAXDATA) then
        CellText := CellText + ' [...]';
    end;
  end;
end;


procedure TMainForm.CalcNullColors;
var
  i: Integer;
  h, l, s: Word;
begin
  for i:=Low(DatatypeCategories) to High(DatatypeCategories) do begin
    ColorRGBToHLS(DatatypeCategories[i].Color, h, l, s);
    Inc(l, COLORSHIFT_NULLFIELDS);
    s := Max(0, s-2*COLORSHIFT_NULLFIELDS);
    DatatypeCategories[i].NullColor := ColorHLSToRGB(h, l, s);
  end;
end;


{**
  Cell in data- or query grid gets painted. Colorize font. This procedure is
  called extremely often for repainting the grid cells. Keep it highly optimized.
}
procedure TMainForm.AnyGridPaintText(Sender: TBaseVirtualTree; const
    TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType:
    TVSTTextType);
var
  cl: TColor;
  r: TGridResult;
begin
  if Column = -1 then
    Exit;

  r := GridResult(Sender);

  // Make primary key columns bold
  if r.Columns[Column].IsPriPart then
    TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsBold];

  // Do not apply any color on a selected, highlighted cell to keep readability
  if (vsSelected in Node.States) and (Node = Sender.FocusedNode) and (Column = Sender.FocusedColumn) then
    cl := clHighlightText
  else if vsSelected in Node.States then
    cl := clBlack
  else if r.Rows[Node.Index].Cells[Column].IsNull then
    cl := DatatypeCategories[Integer(r.Columns[Column].DatatypeCat)].NullColor
  else
    cl := DatatypeCategories[Integer(r.Columns[Column].DatatypeCat)].Color;
  TargetCanvas.Font.Color := cl;
end;


procedure TMainForm.DataGridAfterCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);
begin
  // Don't waist time
  if Column = NoColumn then Exit;
  // Paint a red triangle at the top left corner of the cell
  if DataGridResult.Rows[Node.Index].Cells[Column].Modified then
    ImageListMain.Draw(TargetCanvas, CellRect.Left, CellRect.Top, 111);
end;


{**
  Header column in datagrid clicked.
  Left button: handle ORDER BY
  Right button: show column selection box
}
procedure TMainForm.DataGridHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
var
  frm: TForm;
  i, j, LeftColPos: Integer;
  columnexists : Boolean;
  ColName: String;
begin
  if HitInfo.Column = NoColumn then
    Exit;
  if HitInfo.Button = mbLeft then begin
    ColName := Sender.Columns[HitInfo.Column].Text;
    // Add a new order column after a columns title has been clicked
    // Check if order column is already existant
    columnexists := False;
    for i := Low(DataGridSortColumns) to High(DataGridSortColumns) do begin
      if DataGridSortColumns[i].ColumnName = ColName then begin
        // AddOrderCol is already in the list. Switch its direction:
        // ASC > DESC > [delete col]
        columnexists := True;
        if DataGridSortColumns[i].SortDirection = ORDER_ASC then
          DataGridSortColumns[i].SortDirection := ORDER_DESC
        else begin
          // Delete order col
          for j := i to High(DataGridSortColumns) - 1 do
            DataGridSortColumns[j] := DataGridSortColumns[j+1];
          SetLength(DataGridSortColumns, Length(DataGridSortColumns)-1);
        end;
        // We found the matching column, no need to loop further
        break;
      end;
    end;

    if not columnexists then begin
      i := Length(DataGridSortColumns);
      SetLength(DataGridSortColumns, i+1);
      DataGridSortColumns[i] := TOrderCol.Create;
      DataGridSortColumns[i].ColumnName := ColName;
      DataGridSortColumns[i].SortDirection := ORDER_ASC;
    end;
    // Refresh grid, and restore X scroll offset, so the just clicked column is still at the same place.
    LeftColPos := Sender.Columns[HitInfo.Column].Left;
    InvalidateVT(DataGrid, VTREE_NOTLOADED_PURGECACHE, True);
    Sender.Treeview.OffsetX := -(Sender.Columns[HitInfo.Column].Left - Sender.Treeview.OffsetX - LeftColPos);
  end else begin
    frm := TColumnSelectionForm.Create(self);
    // Position new form relative to btn's position
    frm.Top := HitInfo.Y + DataGrid.ClientOrigin.Y - Integer(DataGrid.Header.Height);
    frm.Left := HitInfo.X + DataGrid.ClientOrigin.X;
    // Display form
    frm.Show;
  end;
end;


{**
  Only allow grid editing if there is a good key available
}
procedure TMainForm.setNULL1Click(Sender: TObject);
begin
  // Internally calls OnNewText event:
  DataGrid.Text[DataGrid.FocusedNode, DataGrid.FocusedColumn] := '';
  DataGridResult.Rows[DataGrid.FocusedNode.Index].Cells[DataGrid.FocusedColumn].NewIsNull := True;
  DataGrid.RepaintNode(DataGrid.FocusedNode);
end;


{**
  Content of a grid cell was modified
}
procedure TMainForm.DataGridNewText(Sender: TBaseVirtualTree; Node:
    PVirtualNode; Column: TColumnIndex; NewText: String);
var
  Row: PGridRow;
begin
  Row := @DataGridResult.Rows[Node.Index];
  // Remember new value
  Row.Cells[Column].NewText := NewText;
  Row.Cells[Column].NewIsNull := False;
  Row.Cells[Column].Modified := True;
  // Set state of row for UPDATE mode, don't touch grsInserted
  if Row.State = grsDefault then
    DataGridResult.Rows[Node.Index].State := grsModified;
  DataGridHasChanges := True;
  ValidateControls(Sender);
end;


{**
  DataGrid: node focus has changed
}
procedure TMainForm.DataGridChange(Sender: TBaseVirtualTree; Node:
    PVirtualNode);
begin
  ValidateControls(Sender);
end;


{**
  DataGrid: node and/or column focus is about to change. See if we allow that.
}
procedure TMainForm.DataGridFocusChanging(Sender: TBaseVirtualTree; OldNode,
    NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex; var Allowed:
    Boolean);
begin
  // Detect changed focus and update row
  if Assigned(OldNode) and (OldNode <> NewNode) then
    Allowed := DataGridPostUpdateOrInsert(OldNode)
  else
    Allowed := True;
end;


procedure TMainForm.DataGridFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex);
begin
  UpdateLineCharPanel;
end;


{**
  DataGrid: invoke update or insert routine
}
function TMainForm.DataGridPostUpdateOrInsert(Node: PVirtualNode): Boolean;
begin
  Result := True;
  if not Assigned(Node) then
    Exit;
  if Cardinal(High(DataGridResult.Rows)) >= Node.Index then
    case DataGridResult.Rows[Node.Index].State of
      grsModified: Result := GridPostUpdate(DataGrid);
      grsInserted: Result := GridPostInsert(DataGrid);
    end;
end;


{**
  DataGrid: compose and fire UPDATE query
}
function TMainForm.GridPostUpdate(Sender: TBaseVirtualTree): Boolean;
var
  i: Integer;
  sql, Val: String;
  Row: PGridRow;
begin
  sql := 'UPDATE '+mask(DataGridTable)+' SET';
  Row := @DataGridResult.Rows[Sender.FocusedNode.Index];
  for i := 0 to Length(DataGridResult.Columns) - 1 do begin
    if Row.Cells[i].Modified then begin
      Val := Row.Cells[i].NewText;
      case DataGridResult.Columns[i].DatatypeCat of
        dtcInteger, dtcReal: Val := UnformatNumber(Val);
        dtcBinary: begin
          if actBlobAsText.Checked then
            Val := esc(Val)
          else begin
            CheckHex(Copy(Val, 3), 'Invalid hexadecimal string given in field "' + DataGridResult.Columns[i].Name + '".');
            if Val = '0x' then
              Val := esc('');
          end;
        end;
        else Val := esc(Val);
      end;
      if Row.Cells[i].NewIsNull then Val := 'NULL';
      sql := sql + ' ' + mask(DataGridResult.Columns[i].Name) + '=' + Val + ', ';
    end;
  end;
  // Cut trailing comma
  sql := Copy(sql, 1, Length(sql)-2);
  sql := sql + ' WHERE ' + GetWhereClause(Row, @DataGridResult.Columns) + ' LIMIT 1';
  try
    // Send UPDATE query
    Connection.Query(sql);
    if Connection.RowsAffected = 0 then begin
      MessageDlg('Your change did not affect any row! This can have several causes:' + CRLF + CRLF +
        'a) Your changes were silently converted by the server. For instance, if you tried to ' +
        'update an unsigned TINYINT field from its maximum value 255 to a higher value.' + CRLF + CRLF +
        'b) The server could not find the source row because it was deleted ' +
        'from outside.' + CRLF + CRLF +
        'c) The server could not find the source row because its primary key fields were modified ' +
        'from outside.',
        mtInformation, [mbOK], 0);
    end;
    Result := True;
  except
    on E:Exception do begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      Result := False;
    end;
  end;

  if Result then begin
    // Reselect just updated row in grid from server to ensure displaying
    // correct values which were silently converted by the server
    for i := 0 to Length(DataGridResult.Columns) - 1 do begin
      if not Row.Cells[i].Modified then
        Continue;
      Row.Cells[i].Text := Row.Cells[i].NewText;
      Row.Cells[i].IsNull := Row.Cells[i].NewIsNull;
    end;
    GridFinalizeEditing(Sender);
  end;
end;


{**
  Repaint edited node and reset state of grid row
}
procedure TMainForm.GridFinalizeEditing(Sender: TBaseVirtualTree);
var
  i, c: Integer;
begin
  c := Sender.FocusedNode.Index;
  DataGridResult.Rows[c].State := grsDefault;
  for i := 0 to Length(DataGridResult.Rows[c].Cells) - 1 do begin
    DataGridResult.Rows[c].Cells[i].NewText := '';
    DataGridResult.Rows[c].Cells[i].Modified := False;
  end;
  Sender.RepaintNode(Sender.FocusedNode);
  DataGridHasChanges := False;
  ValidateControls(Sender);
end;


{**
  Compose a WHERE clause used for UPDATEs and DELETEs
}
function TMainForm.GetWhereClause(Row: PGridRow; Columns: PGridColumns): String;
var
  i, j: Integer;
  KeyVal: String;
  KeyCols: TStringList;
begin
  Result := '';
  KeyCols := GetKeyColumns;

  if KeyCols.Count = 0 then begin
    // No key present - use all columns in that case
    for i:=0 to SelectedTableColumns.Count-1 do
      KeyCols.Add(SelectedTableColumns[i].Name);
  end;

  for i := 0 to KeyCols.Count - 1 do begin
    for j := 0 to Length(Columns^) - 1 do begin
      if Columns^[j].Name = KeyCols[i] then
        break;
    end;
    // Find old value of key column
    KeyVal := Row.Cells[j].Text;
    // Quote if needed
    case DataGridResult.Columns[j].DatatypeCat of
      dtcInteger, dtcReal: KeyVal := UnformatNumber(KeyVal);
      dtcBinary: begin
        if actBlobAsText.Checked then
          KeyVal := esc(KeyVal)
        else if KeyVal = '0x' then
          KeyVal := esc('');
      end
      else KeyVal := esc(KeyVal);
    end;

    if Row.Cells[j].IsNull then KeyVal := ' IS NULL'
    else KeyVal := '=' + KeyVal;
    Result := Result + mask(KeyCols[i]) + KeyVal + ' AND ';
  end;
  // Cut trailing AND
  Result := Copy(Result, 1, Length(Result)-5);
end;


{**
  Find key columns for a WHERE clause by analysing a SHOW KEYS FROM ... resultset
}
function TMainForm.GetKeyColumns: TStringList;
var
  i, j, k: Integer;
  AllowsNull: Boolean;
  Key: TTableKey;
  Col: TTableColumn;
begin
  Result := TStringList.Create;
  // Find best key for updates
  // 1. round: find a primary key
  for i:=0 to SelectedTableKeys.Count-1 do begin
    Key := TTableKey(SelectedTableKeys[i]);
    if Key.Name = 'PRIMARY' then begin
      Result := Key.Columns;
      Exit;
    end;
  end;
  // no primary key available -> 2. round: find a unique key
  for i:=0 to SelectedTableKeys.Count-1 do begin
    Key := TTableKey(SelectedTableKeys[i]);
    if Key.IndexType = UKEY then begin
      // We found a UNIQUE key - better than nothing. Check if one of the key
      // columns allows NULLs which makes it dangerous to use in UPDATES + DELETES.
      AllowsNull := False;
      for j:=0 to Key.Columns.Count-1 do begin
        for k:=0 to SelectedTableColumns.Count-1 do begin
          Col := TTableColumn(SelectedTableColumns[k]);
          if Col.Name = Key.Columns[j] then
            AllowsNull := Col.AllowNull;
          if AllowsNull then break;
        end;
        if AllowsNull then break;
      end;
      if not AllowsNull then begin
        Result := Key.Columns;
        break;
      end;
    end;
  end;
end;


{**
  DataGrid: compose and fire UPDATE query
}
procedure TMainForm.DataGridInsertRow(CopyValuesFromNode: PVirtualNode);
var
  i, j: Integer;
  OldRow: TGridRow;
begin
  // Scroll to the bottom to ensure we append the new row at the very last DataGridResult chunk
  DataGrid.FocusedNode := DataGrid.GetLast;
  DataGrid.Repaint;
  // Steeling focus now to invoke posting a pending row update
  DataGrid.FocusedNode := nil;
  i := Length(DataGridResult.Rows);
  SetLength(DataGridResult.Rows, i+1);
  SetLength(DataGridResult.Rows[i].Cells, Length(DataGridResult.Columns));
  DataGridResult.Rows[i].State := grsInserted;
  for j:=0 to Length(DataGridResult.Rows[i].Cells)-1 do begin
    DataGridResult.Rows[i].Cells[j].Text := '';
  end;
  if Assigned(CopyValuesFromNode) then begin
    // Copy values from source row, ensure we have whole cell data
    OldRow := DataGridResult.Rows[CopyValuesFromNode.Index];
    for j:=0 to DataGrid.Header.Columns.Count-1 do begin
      if not (coVisible in DataGrid.Header.Columns[j].Options) then
        continue; // Ignore invisible key column
      if SelectedTableColumns[j].DefaultType = cdtAutoInc then
        continue; // Empty value for auto-increment column
      DataGridResult.Rows[i].Cells[j].NewText := OldRow.Cells[j].Text;
      DataGridResult.Rows[i].Cells[j].NewIsNull := OldRow.Cells[j].IsNull;
      DataGridResult.Rows[i].Cells[j].Modified := (DataGridResult.Rows[i].Cells[j].NewText <> DataGridResult.Rows[i].Cells[j].Text)
        or (DataGridResult.Rows[i].Cells[j].NewIsNull <> DataGridResult.Rows[i].Cells[j].IsNull);
    end;
  end;
  DataGrid.FocusedNode := DataGrid.AddChild(nil);
  DataGrid.ClearSelection;
  DataGrid.Selected[DataGrid.FocusedNode] := True;
  DataGridHasChanges := True;
  ValidateControls(DataGrid);
end;


{**
  DataGrid: compose and fire INSERT query
}
function TMainForm.GridPostInsert(Sender: TBaseVirtualTree): Boolean;
var
  Row: PGridRow;
  sql, Cols, Val, Vals: String;
  i: Integer;
  Node: PVirtualNode;
begin
  Node := Sender.FocusedNode;
  Row := @DataGridResult.Rows[Node.Index];
  Cols := '';
  Vals := '';
  for i := 0 to Length(DataGridResult.Columns) - 1 do begin
    if Row.Cells[i].Modified then begin
      Cols := Cols + mask(DataGridResult.Columns[i].Name) + ', ';
      Val := Row.Cells[i].NewText;
      case DataGridResult.Columns[i].DatatypeCat of
        dtcInteger, dtcReal: Val := UnformatNumber(Val);
        dtcBinary: begin
          if actBlobAsText.Checked then
            Val := esc(Val)
          else begin
            CheckHex(Copy(Val, 3), 'Invalid hexadecimal string given in field "' + DataGridResult.Columns[i].Name + '".');
            if Val = '0x' then
              Val := esc('');
          end;
        end;
        else Val := esc(Val);
      end;
      if Row.Cells[i].NewIsNull then Val := 'NULL';
      Vals := Vals + Val + ', ';
    end;
  end;
  if Length(Cols) = 0 then begin
    // No field was manually modified, cancel the INSERT in that case
    Sender.BeginUpdate;
    Sender.DeleteNode(Node);
    SetLength(DataGridResult.Rows, Length(DataGridResult.Rows) - 1);
    Sender.EndUpdate;
    DataGridHasChanges := False;
    ValidateControls(Sender);
    Result := True; // Important for DataGridFocusChanging to allow moving focus
  end else begin
    // At least one field was modified, assume this INSERT should be posted
    Vals := Copy(Vals, 1, Length(Vals)-2);
    Cols := Copy(Cols, 1, Length(Cols)-2);
    sql := 'INSERT INTO '+mask(DataGridTable)+' ('+Cols+') VALUES ('+Vals+')';
    // Send INSERT query
    try
      Connection.Query(sql);
      if Connection.RowsAffected = 0 then
        Raise Exception.Create('Server failed to insert row.');
      Result := True;
      GridFinalizeEditing(Sender);
      InvalidateVT(DataGrid, VTREE_NOTLOADED_PURGECACHE, False);
    except
      on E:Exception do begin
        MessageDlg(E.Message, mtError, [mbOK], 0);
        Result := False;
      end;
    end;
  end;
end;


{**
  DataGrid: compose and fire DELETE query
}
function TMainForm.GridPostDelete(Sender: TBaseVirtualTree): Boolean;
var
  Node, FocusAfterDelete: PVirtualNode;
  Nodes: TNodeArray;
  sql: String;
  Affected: Int64;
  i, j: Integer;
  msg: String;
begin
  Node := Sender.GetFirstSelected;
  FocusAfterDelete := nil;
  sql := 'DELETE FROM '+mask(SelectedTable.Name)+' WHERE';
  while Assigned(Node) do begin
    sql := sql + ' (' +
      GetWhereClause(@DataGridResult.Rows[Node.Index], @DataGridResult.Columns) +
      ') OR';
    FocusAfterDelete := Node;
    Node := Sender.GetNextSelected(Node);
  end;
  if Assigned(FocusAfterDelete) then
    FocusAfterDelete := Sender.GetNext(FocusAfterDelete);
  sql := Copy(sql, 1, Length(sql)-3);
  sql := sql + ' LIMIT ' + IntToStr(Sender.SelectedCount);

  try
    // Send DELETE query
    Connection.Query(sql);
    Result := True;
  except
    on E:Exception do begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      Result := False;
    end;
  end;

  if Result then begin
    // Remove deleted row nodes out of the grid
    Affected := Connection.RowsAffected;
    if Affected = Sender.SelectedCount then begin
      // Fine. Number of deleted rows equals the selected node count.
      // In this case, just remove the selected nodes, avoid a full reload
      Sender.BeginUpdate;
      Nodes := Sender.GetSortedSelection(True);
      for i:=High(Nodes) downto Low(Nodes) do begin
        for j := Nodes[i].Index to High(DataGridResult.Rows)-1 do begin
          // Move upper rows by one so the selected row gets overwritten
          DataGridResult.Rows[j] := DataGridResult.Rows[j+1];
        end;
      end;
      SetLength(DataGridResult.Rows, Length(DataGridResult.Rows) - Sender.SelectedCount);
      Sender.DeleteSelectedNodes;
      if not Assigned(FocusAfterDelete) then
        FocusAfterDelete := Sender.GetLast;
      if Assigned(FocusAfterDelete) then
        SelectNode(Sender as TVirtualStringTree, FocusAfterDelete);
      Sender.EndUpdate;
    end else begin
      // Should never get called as we block DELETEs on tables without a unique key
      InvalidateVT(DataGrid, VTREE_NOTLOADED_PURGECACHE, False);
      msg := 'Warning: Consistency problem detected.' + CRLF + CRLF
        + 'The last DELETE query affected ' + FormatNumber(Affected) + ' rows, when it should have touched '+FormatNumber(Sender.SelectedCount)+' row(s)!'
        + CRLF + CRLF
        + 'This is most likely caused by not having a primary key in the table''s definition.';
      LogSQL( msg );
      MessageDlg( msg, mtWarning, [mbOK], 0);
    end;
    DisplayRowCountStats;
  end;
end;


{**
  DataGrid: cancel INSERT or UPDATE mode, reset modified node data
}
procedure TMainForm.DataGridCancel(Sender: TObject);
var
  i: Integer;
begin
  case DataGridResult.Rows[DataGrid.FocusedNode.Index].State of
    grsModified: GridFinalizeEditing(DataGrid);
    grsInserted: begin
      i := Length(DataGridResult.Rows);
      DataGrid.DeleteNode(DataGrid.FocusedNode, False);
      SetLength(DataGridResult.Rows, i-1);
      // Focus+select last node if possible
      actDataLastExecute(Sender);
    end;
  end;
  DataGridHasChanges := False;
  ValidateControls(Sender);
end;



procedure TMainForm.AnyGridKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
var
  g: TVirtualStringTree;
begin
  g := TVirtualStringTree(Sender);
  case Key of
    VK_HOME: g.FocusedColumn := 0;
    VK_END: g.FocusedColumn := g.Header.Columns.Count-1;
    VK_RETURN: if Assigned(g.FocusedNode) then g.EditNode(g.FocusedNode, g.FocusedColumn);
    VK_DOWN: if (g = DataGrid) and Assigned(g.FocusedNode) and (g.FocusedNode.Index = g.RootNodeCount-1) then
      actDataInsertExecute(Sender);
    VK_NEXT: if (g = DataGrid) and Assigned(g.FocusedNode) and (g.FocusedNode.Index = g.RootNodeCount-1) then
      actDataShowNext.Execute;
  end;
end;


procedure TMainForm.DataGridEditing(Sender: TBaseVirtualTree; Node:
    PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := DataGridEnsureFullRow(Sender as TVirtualStringTree, Node);
  if Allowed then begin
    // Move Esc shortcut from "Cancel row editing" to "Cancel cell editing"
    actDataCancelChanges.ShortCut := 0;
    actDataPostChanges.ShortCut := 0;
  end;
end;

procedure TMainForm.DataGridEdited(Sender: TBaseVirtualTree; Node:
    PVirtualNode; Column: TColumnIndex);
begin
  // Reassign Esc to "Cancel row editing" action
  if ([tsEditing, tsEditPending] * Sender.TreeStates) = [] then begin
    actDataCancelChanges.ShortCut := TextToShortcut('Esc');
    actDataPostChanges.ShortCut := TextToShortcut('Ctrl+Enter');
  end;
end;

procedure TMainForm.DataGridEditCancelled(Sender: TBaseVirtualTree; Column:
    TColumnIndex);
begin
  // Reassign Esc to "Cancel row editing" action
  actDataCancelChanges.ShortCut := TextToShortcut('Esc');
  actDataPostChanges.ShortCut := TextToShortcut('Ctrl+Enter');
end;

procedure TMainForm.DataGridCreateEditor(Sender: TBaseVirtualTree; Node:
    PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
var
  VT: TVirtualStringTree;
  HexEditor: THexEditorLink;
  DateTimeEditor: TDateTimeEditorLink;
  EnumEditor: TEnumEditorLink;
  SetEditor: TSetEditorLink;
  InplaceEditor: TInplaceEditorLink;
  TypeCat: TDatatypeCategoryIndex;
begin
  VT := Sender as TVirtualStringTree;
  TypeCat := DataGridResult.Columns[Column].DatatypeCat;
  if (TypeCat = dtcText) or ((TypeCat = dtcBinary) and actBlobAsText.Checked) then begin
    InplaceEditor := TInplaceEditorLink.Create(VT);
    InplaceEditor.DataType := DataGridResult.Columns[Column].Datatype;
    InplaceEditor.MaxLength := DataGridResult.Columns[Column].MaxLength;
    InplaceEditor.ButtonVisible := True;
    EditLink := InplaceEditor;
  end else if (TypeCat = dtcBinary) and prefEnableBinaryEditor then begin
    HexEditor := THexEditorLink.Create(VT);
    HexEditor.DataType := DataGridResult.Columns[Column].Datatype;
    HexEditor.MaxLength := DataGridResult.Columns[Column].MaxLength;
    EditLink := HexEditor;
  end else if (TypeCat = dtcTemporal) and prefEnableDatetimeEditor then begin
    DateTimeEditor := TDateTimeEditorLink.Create(VT);
    DateTimeEditor.DataType := DataGridResult.Columns[Column].Datatype;
    EditLink := DateTimeEditor;
  end else if (TypeCat = dtcIntegerNamed) and prefEnableEnumEditor then begin
    EnumEditor := TEnumEditorLink.Create(VT);
    EnumEditor.DataType := DataGridResult.Columns[Column].Datatype;
    EnumEditor.ValueList := DataGridResult.Columns[Column].ValueList;
    EditLink := EnumEditor;
  end else if (TypeCat = dtcSetNamed) and prefEnableSetEditor then begin
    SetEditor := TSetEditorLink.Create(VT);
    SetEditor.DataType := DataGridResult.Columns[Column].Datatype;
    SetEditor.ValueList := DataGridResult.Columns[Column].ValueList;
    EditLink := SetEditor;
  end else begin
    InplaceEditor := TInplaceEditorLink.Create(VT);
    InplaceEditor.DataType := DataGridResult.Columns[Column].Datatype;
    InplaceEditor.ButtonVisible := False;
    EditLink := InplaceEditor;
  end;
end;


procedure TMainForm.menuShowSizeColumnClick(Sender: TObject);
var
  NewVal: Boolean;
begin
  NewVal := not TMenuItem(Sender).Checked;
  TMenuItem(Sender).Checked := newVal;
  if NewVal then
    DBtree.Header.Columns[1].Options := DBtree.Header.Columns[1].Options + [coVisible]
  else
    DBtree.Header.Columns[1].Options := DBtree.Header.Columns[1].Options - [coVisible];
  OpenRegistry;
  MainReg.WriteBool(REGNAME_SIZECOL_TREE, NewVal);
end;


procedure TMainForm.AutoCalcColWidth(Tree: TVirtualStringTree; Column: TColumnIndex);
var
  Node: PVirtualNode;
  i, ColTextWidth, ContentTextWidth: Integer;
  Rect: TRect;
  Col: TVirtualTreeColumn;
begin
  // Find optimal default width for columns. Needs to be done late, after the SQL
  // composing to enable text width calculation based on actual table content
  // Weird: Fixes first time calculation always based on Tahoma/8pt font
  Tree.Canvas.Font := Tree.Font;
  Col := Tree.Header.Columns[Column];
  if not (coVisible in Col.Options) then
    Exit;
  ColTextWidth := Tree.Canvas.TextWidth(Col.Text);
  // Add space for sort glyph
  if Col.ImageIndex > -1 then
    ColTextWidth := ColTextWidth + 20;
  Node := Tree.GetFirstVisible;
  // Go backwards 50 nodes from focused one if tree was scrolled
  i := 0;
  if Assigned(Tree.FocusedNode) then begin
    Node := Tree.FocusedNode;
    while Assigned(Node) do begin
      inc(i);
      if (Node = Tree.GetFirst) or (i > 50) then
        break;
      Node := Tree.GetPreviousVisible(Node);
    end;
  end;
  i := 0;
  while Assigned(Node) do begin
    // Note: this causes the node to load, an exception can propagate
    //       here if the query or connection dies.
    Rect := Tree.GetDisplayRect(Node, Column, True, True);
    ContentTextWidth := Rect.Right - Rect.Left;
    if vsMultiLine in Node.States then
      ContentTextWidth := Max(ContentTextWidth, Tree.Canvas.TextWidth(Tree.Text[Node, Column]));
    ColTextWidth := Max(ColTextWidth, ContentTextWidth);
    inc(i);
    if i > 100 then break;
    // GetDisplayRect may have implicitely taken the node away.
    // Strange that Node keeps being assigned though, probably a timing issue.
    if Tree.RootNodeCount = 0 then break;
    Node := Tree.GetNextVisible(Node);
  end;
  // text margins and minimal extra space
  ColTextWidth := ColTextWidth + Tree.TextMargin*2 + 5;
  ColTextWidth := Min(ColTextWidth, prefMaxColWidth);
  Col.Width := ColTextWidth;
end;


procedure TMainForm.AnyGridBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  gr: TGridResult;
  cl: TColor;
begin
  if Column = -1 then
    Exit;
  gr := GridResult(Sender);
  cl := clNone;
  if (vsSelected in Node.States) and (Node = Sender.FocusedNode) and (Column = Sender.FocusedColumn) then
    cl := clHighlight
  else if vsSelected in Node.States then
    cl := $00DDDDDD
  else if prefEnableNullBG and gr.Rows[Node.Index].Cells[Column].IsNull then
    cl := prefNullBG;
  if cl <> clNone then begin
    TargetCanvas.Brush.Color := cl;
    TargetCanvas.FillRect(CellRect);
  end;
end;


procedure TMainForm.HandleDataGridAttributes(RefreshingData: Boolean);
var
  rx: TRegExpr;
  idx, i: Integer;
  TestList: TStringList;
  Sort, KeyName, FocusedCol, CellFocus, Filter: String;
begin
  OpenRegistry;
  MainReg.OpenKey(GetRegKeyTable, True);
  actDataResetSorting.Enabled := False;
  // Clear filter, column names and sort structure if gr
  if not Assigned(DataGridHiddenColumns) then begin
    DataGridHiddenColumns := TStringList.Create;
    DataGridHiddenColumns.Delimiter := DELIM;
    DataGridHiddenColumns.StrictDelimiter := True;
  end;
  if not Assigned(DataGridFocusedCell) then
    DataGridFocusedCell := TStringList.Create;
  // Remember focused node and column for selected table
  if Assigned(DataGrid.FocusedNode) then begin
    KeyName := Mask(DataGridDB)+'.'+Mask(DataGridTable);
    FocusedCol := '';
    if DataGrid.FocusedColumn <> NoColumn then
      FocusedCol := DataGrid.Header.Columns[DataGrid.FocusedColumn].Text;
    DataGridFocusedCell.Values[KeyName] := IntToStr(DataGrid.FocusedNode.Index) + DELIM + FocusedCol;
  end;
  DataGridFocusedNodeIndex := 0;
  DataGridFocusedColumnName := '';
  KeyName := Mask(SelectedTable.Database)+'.'+Mask(SelectedTable.Name);
  CellFocus := DataGridFocusedCell.Values[KeyName];
  if CellFocus <> '' then begin
    DataGridFocusedNodeIndex := MakeInt(Explode(DELIM, CellFocus)[0]);
    DataGridFocusedColumnName := Explode(DELIM, CellFocus)[1];
  end;
  if not RefreshingData then begin
    DataGridHiddenColumns.Clear;
    SynMemoFilter.Clear;
    SetLength(DataGridSortColumns, 0);
    DataGridWantedRowCount := 0;
    while DataGridFocusedNodeIndex >= DataGridWantedRowCount do
      Inc(DataGridWantedRowCount, prefGridRowcountStep);
  end else begin
    // Save current attributes if grid gets refreshed
    if DataGridHiddenColumns.Count > 0 then
      MainReg.WriteString(REGNAME_HIDDENCOLUMNS, DataGridHiddenColumns.DelimitedText)
    else if MainReg.ValueExists(REGNAME_HIDDENCOLUMNS) then
      MainReg.DeleteValue(REGNAME_HIDDENCOLUMNS);

    if SynMemoFilter.GetTextLen > 0 then
      MainReg.WriteString(REGNAME_FILTER, SynMemoFilter.Text)
    else if MainReg.ValueExists(REGNAME_FILTER) then
      MainReg.DeleteValue(REGNAME_FILTER);

    for i := 0 to High(DataGridSortColumns) do
      Sort := Sort + IntToStr(DataGridSortColumns[i].SortDirection) + '_' + DataGridSortColumns[i].ColumnName + DELIM;
    if Sort <> '' then
      MainReg.WriteString(REGNAME_SORT, Sort)
    else if MainReg.ValueExists(REGNAME_SORT) then
      MainReg.DeleteValue(REGNAME_SORT);
  end;

  // Auto remove registry spam if table folder is empty
  TestList := TStringList.Create;
  MainReg.GetValueNames(TestList);
  if (not MainReg.HasSubKeys) and (TestList.Count = 0) then
    MainReg.DeleteKey(GetRegKeyTable);

  // Do nothing if table was not filtered yet
  if not MainReg.OpenKey(GetRegKeyTable, False) then
    Exit;

  // Columns
  if MainReg.ValueExists(REGNAME_HIDDENCOLUMNS) then
    DataGridHiddenColumns.DelimitedText := MainReg.ReadString(REGNAME_HIDDENCOLUMNS);

  // Set filter, without changing cursor position
  if MainReg.ValueExists(REGNAME_FILTER) then begin
    Filter := MainReg.ReadString(REGNAME_FILTER);
    if SynMemoFilter.Text <> Filter then
      SynMemoFilter.Text := Filter;
    if SynMemoFilter.GetTextLen > 0 then
      ToggleFilterPanel(True);
  end;

  // Sort
  if MainReg.ValueExists(REGNAME_SORT) then begin
    SetLength(DataGridSortColumns, 0);
    rx := TRegExpr.Create;
    rx.Expression := '\b(\d)_(.+)\'+DELIM;
    rx.ModifierG := False;
    if rx.Exec(MainReg.ReadString(REGNAME_SORT)) then while true do begin
      idx := Length(DataGridSortColumns);
      // Check if column exists, could be renamed or deleted
      for i:=0 to SelectedTableColumns.Count-1 do begin
        if SelectedTableColumns[i].Name = rx.Match[2] then begin
          SetLength(DataGridSortColumns, idx+1);
          DataGridSortColumns[idx] := TOrderCol.Create;
          DataGridSortColumns[idx].ColumnName := rx.Match[2];
          DataGridSortColumns[idx].SortDirection := StrToIntDef(rx.Match[1], ORDER_ASC);
          break;
        end;
      end;
      if not rx.ExecNext then
        break;
    end;
    actDataResetSorting.Enabled := Length(DataGridSortColumns) > 0;
  end;
end;


function TMainForm.GetRegKeyTable: String;
begin
  // Return the slightly complex registry path to \Servers\ThisServer\curdb|curtable
  Result := REGPATH + REGKEY_SESSIONS + SessionName + '\' +
    ActiveDatabase + DELIM + SelectedTable.Name;
end;


procedure TMainForm.QueryGridFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
begin
  ValidateControls(Sender);
end;


procedure TMainForm.pnlQueryHelpersCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  // Ensure minimum width for query helpers while resizing
  Resize := NewWidth >= 20;
end;


procedure TMainForm.pnlQueryMemoCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  // Ensure visibility of query memo while resizing
  Resize := NewWidth >= pnlQueryHelpers.Width + spltQueryHelpers.Width + 40;
end;


procedure TMainForm.DataGridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Grid: TVirtualStringTree;
  Hit: THitInfo;
begin
  // Detect mouse hit in grid whitespace and apply changes.
  Grid := Sender as TVirtualStringTree;
  if not Assigned(Grid.FocusedNode) then
    Exit;
  Grid.GetHitTestInfoAt(X, Y, False, Hit);
  if (Hit.HitNode = nil) or (Hit.HitColumn = NoColumn) or (Hit.HitColumn = InvalidColumn) then
    DataGridPostUpdateOrInsert(Grid.FocusedNode);
end;


procedure TMainForm.ListDatabasesBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
  var ContentRect: TRect);
var
  vt: TVirtualStringTree;
  Val, Max: Extended;
  LoopNode: PVirtualNode;
begin
  // Display color bars
  if Column in [1,2,4..9] then begin
    vt := Sender as TVirtualStringTree;
    // Find out maximum value in column
    LoopNode := vt.GetFirst;
    Max := 1;
    while Assigned(LoopNode) do begin
      Val := MakeFloat(vt.Text[LoopNode, Column]);
      if Val > Max then
        Max := Val;
      LoopNode := vt.GetNext(LoopNode);
    end;
    PaintColorBar(MakeFloat(vt.Text[Node, Column]), Max, TargetCanvas, CellRect);
  end;
end;


procedure TMainForm.ListDatabasesBeforePaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
var
  vt: TVirtualStringTree;
  i: Integer;
begin
  // Invalidate list of databases, before (re)painting
  vt := Sender as TVirtualStringTree;
  if vt.Tag = VTREE_LOADED then
    Exit;
  Screen.Cursor := crHourglass;
  FreeAndNil(AllDatabasesDetails);
  vt.Clear;
  try
    if Connection.InformationSchemaObjects.IndexOf('SCHEMATA') > -1 then
      AllDatabasesDetails := Connection.GetResults('SELECT * FROM '+mask(DBNAME_INFORMATION_SCHEMA)+'.'+mask('SCHEMATA'));
  except
    on E:Exception do
      LogSQL(E.Message, lcError);
  end;
  if vt.Tag = VTREE_NOTLOADED_PURGECACHE then begin
    for i:=0 to AllDatabases.Count-1 do begin
      if Connection.DbObjectsCached(AllDatabases[i]) then
        Connection.GetDBObjects(AllDatabases[i], True);
    end;
  end;
  vt.RootNodeCount := AllDatabases.Count;
  tabDatabases.Caption := 'Databases ('+FormatNumber(vt.RootNodeCount)+')';
  vt.Tag := VTREE_LOADED;
  Screen.Cursor := crDefault;
end;


procedure TMainForm.ListDatabasesDblClick(Sender: TObject);
begin
  // Select database on doubleclick
  if Assigned(ListDatabases.FocusedNode) then try
    ActiveDatabase := ListDatabases.Text[ListDatabases.FocusedNode, 0];
  except
    on E:Exception do LogSQL(E.Message, lcError);
  end;
end;


procedure TMainForm.ListDatabasesGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  db: String;
begin
  // Return icon index for databases. Ghosted if db objects not yet in cache.
  if not (Kind in [ikNormal, ikSelected]) then
    Exit;
  if Column <> (Sender as TVirtualStringTree).Header.MainColumn then
    Exit;
  db := ListDatabases.Text[Node, 0];
  if db = ActiveDatabase then
    ImageIndex := ICONINDEX_DB_HIGHLIGHT
  else
    ImageIndex := ICONINDEX_DB;
  Ghosted := not Connection.DbObjectsCached(db);
end;


procedure TMainForm.ListDatabasesGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  // Tell VirtualTree we're using a simple integer as data
  NodeDataSize := SizeOf(Int64);
end;


procedure TMainForm.ListDatabasesInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Idx: PInt;
begin
  // Integers mapped to the node's index so nodes can be sorted without losing their database name
  Idx := Sender.GetNodeData(Node);
  Idx^ := Node.Index;
end;


procedure TMainForm.ListDatabasesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Idx: PInt;
  Objects: TDBObjectList;
  DBname: String;

  function GetItemCount(ItemType: TListNodeType): String;
  var
    c: Integer;
    o: TDBObject;
  begin
    if Objects <> nil then begin
      c := 0;
      for o in Objects do begin
        if (ItemType = lntNone) or (o.NodeType = ItemType) then
          Inc(c);
      end;
      Result := FormatNumber(c);
    end else
      Result := '';
  end;

begin
  // Return text for database columns
  Idx := Sender.GetNodeData(Node);
  DBname := AllDatabases[Idx^];
  if Connection.DbObjectsCached(DBname) then
    Objects := Connection.GetDBObjects(DBname);
  case Column of
    0: CellText := DBname;
    1: if Assigned(Objects) then CellText := FormatByteNumber(Objects.DataSize)
      else CellText := '';
    2: CellText := GetItemCount(lntNone);
    3: if Assigned(Objects) and (Objects.LastUpdate > 0) then CellText := DateTimeToStr(Objects.LastUpdate)
      else CellText := '';
    4: CellText := GetItemCount(lntTable);
    5: CellText := GetItemCount(lntView);
    6: CellText := GetItemCount(lntFunction);
    7: CellText := GetItemCount(lntProcedure);
    8: CellText := GetItemCount(lntTrigger);
    9: CellText := GetItemCount(lntEvent);
    10: begin
      CellText := '';
      if Assigned(AllDatabasesDetails) then begin
        AllDatabasesDetails.First;
        while not AllDatabasesDetails.Eof do begin
          if AllDatabasesDetails.Col('SCHEMA_NAME', True) = DBname then begin
            CellText := AllDatabasesDetails.Col('DEFAULT_COLLATION_NAME', True);
            break;
          end;
          AllDatabasesDetails.Next;
        end;
      end;
    end;
  end;

end;


procedure TMainForm.ListVariablesBeforePaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
var
  i : Integer;
  vt: TVirtualStringTree;
  Results: TMySQLQuery;
  Sel: TStringList;
begin
  // Display server variables
  vt := Sender as TVirtualStringTree;
  if vt.Tag = VTREE_LOADED then
    Exit;
  Sel := GetVTCaptions(vt, True);
  DeInitializeVTNodes(vt);
  Screen.Cursor := crHourglass;
  try
    Results := Connection.GetResults('SHOW VARIABLES');
    SetLength(VTRowDataListVariables, Results.RecordCount);
    for i:=0 to Results.RecordCount-1 do begin
      VTRowDataListVariables[i].ImageIndex := 25;
      VTRowDataListVariables[i].Captions := TStringList.Create;
      VTRowDataListVariables[i].Captions.Add(Results.Col(0));
      VTRowDataListVariables[i].Captions.Add(Results.Col(1));
      Results.Next;
    end;
    FreeAndNil(Results);
    vt.RootNodeCount := Length(VTRowDataListVariables);
    vt.SortTree(vt.Header.SortColumn, vt.Header.SortDirection);
    SetVTSelection(vt, Sel);
    // Apply or reset filter
    editFilterVTChange(Sender);
    // Display number of listed values on tab
    tabVariables.Caption := 'Variables (' + IntToStr(vt.RootNodeCount) + ')';
  finally
    // Important to flag the tree as "loaded", otherwise OnPaint will cause an endless loop
    vt.Tag := VTREE_LOADED;
    Screen.Cursor := crDefault;
  end;
end;


procedure TMainForm.ListStatusBeforePaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
var
  i: Integer;
  valcount: Int64;
  tmpval: Double;
  Results: TMySQLQuery;
  val, avg_perhour, avg_persec: String;
  valIsBytes, valIsNumber: Boolean;
  vt: TVirtualStringTree;
  Sel: TStringList;
begin
  // Display server status key/value pairs
  vt := Sender as TVirtualStringTree;
  if vt.Tag = VTREE_LOADED then
    Exit;
  Sel := GetVTCaptions(vt, True);
  DeInitializeVTNodes(vt);
  Screen.Cursor := crHourglass;
  try
    Results := Connection.GetResults('SHOW /*!50002 GLOBAL */ STATUS');
    SetLength(VTRowDataListStatus, Results.RecordCount);
    for i:=0 to Results.RecordCount-1 do begin
      VTRowDataListStatus[i].ImageIndex := 25;
      VTRowDataListStatus[i].Captions := TStringList.Create;
      VTRowDataListStatus[i].Captions.Add(Results.Col(0));
      val := Results.Col(1);
      avg_perhour := '';
      avg_persec := '';

      // Detect value type
      valIsNumber := IntToStr(MakeInt(val)) = val;
      valIsBytes := valIsNumber and (Copy(Results.Col(0), 1, 6) = 'Bytes_');

      // Calculate average values ...
      if valIsNumber then begin
        valCount := MakeInt(val);
        // ... per hour
        tmpval := valCount / ( Connection.ServerUptime / 60 / 60 );
        if valIsBytes then avg_perhour := FormatByteNumber( Trunc(tmpval) )
        else avg_perhour := FormatNumber( tmpval, 1 );
        // ... per second
        tmpval := valCount / Connection.ServerUptime;
        if valIsBytes then avg_persec := FormatByteNumber( Trunc(tmpval) )
        else avg_persec := FormatNumber( tmpval, 1 );
      end;

      // Format numeric or byte values
      if valIsBytes then
        val := FormatByteNumber(val)
      else if valIsNumber then
        val := FormatNumber(val);

      VTRowDataListStatus[i].Captions.Add( val );
      VTRowDataListStatus[i].Captions.Add(avg_perhour);
      VTRowDataListStatus[i].Captions.Add(avg_persec);
      Results.Next;
    end;
    FreeAndNil(Results);
    // Tell VirtualTree the number of nodes it will display
    vt.RootNodeCount := Length(VTRowDataListStatus);
    vt.SortTree(vt.Header.SortColumn, vt.Header.SortDirection);
    SetVTSelection(vt, Sel);
    // Apply or reset filter
    editFilterVTChange(Sender);
    // Display number of listed values on tab
    tabStatus.Caption := 'Status (' + IntToStr(vt.RootNodeCount) + ')';
  finally
    vt.Tag := VTREE_LOADED;
    Screen.Cursor := crDefault;
  end;
end;


procedure TMainForm.ListProcessesBeforePaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
var
  i, j: Integer;
  Results: TMySQLQuery;
  vt: TVirtualStringTree;
  Sel: TStringList;
  Text: String;
const
  InfoLen = SIZE_KB*50;
begin
  // Display client threads
  vt := Sender as TVirtualStringTree;
  if vt.Tag = VTREE_LOADED then
    Exit;
  vt.OnFocusChanged(vt, vt.FocusedNode, vt.FocusedColumn);
  Sel := GetVTCaptions(vt, True);
  DeInitializeVTNodes(vt);
  Screen.Cursor := crHourglass;
  try
    if Connection.InformationSchemaObjects.IndexOf('PROCESSLIST') > -1 then begin
      // Minimize network traffic on newer servers by fetching only first KB of SQL query in "Info" column
      Results := Connection.GetResults('SELECT '+mask('ID')+', '+mask('USER')+', '+mask('HOST')+', '+mask('DB')+', '
        + mask('COMMAND')+', '+mask('TIME')+', '+mask('STATE')+', LEFT('+mask('INFO')+', '+IntToStr(InfoLen)+') AS '+mask('Info')
        + ' FROM '+mask(DBNAME_INFORMATION_SCHEMA)+'.'+mask('PROCESSLIST'));
    end else begin
      // Older servers fetch the whole query length, but at least we cut them off below, so a high memory usage is just a peak
      Results := Connection.GetResults('SHOW FULL PROCESSLIST');
    end;
    SetLength(VTRowDataListProcesses, Results.RecordCount);
    ProcessListMaxTime := 1;
    for i:=0 to Results.RecordCount-1 do begin
      if AnsiCompareText(Results.Col(4), 'Killed') = 0 then
        VTRowDataListProcesses[i].ImageIndex := 26  // killed
      else begin
        if Results.Col('Info') = '' then
          VTRowDataListProcesses[i].ImageIndex := 55 // idle
        else
          VTRowDataListProcesses[i].ImageIndex := 57 // running query
      end;
      VTRowDataListProcesses[i].Captions := TStringList.Create;
      for j:=0 to Results.ColumnCount-1 do begin
        Text := Results.Col(j);
        if Results.ColumnNames[j] = 'Info' then
          Text := sstr(Text, InfoLen);
        VTRowDataListProcesses[i].Captions.Add(Text);
      end;
      ProcessListMaxTime := Max(ProcessListMaxTime, MakeInt(Results.Col(5)));
      Results.Next;
    end;
    FreeAndNil(Results);
    vt.RootNodeCount := Length(VTRowDataListProcesses);
    vt.SortTree(vt.Header.SortColumn, vt.Header.SortDirection);
    // Reset focused node and column, so OnFocusChange will fire, and update the SQL viewer
    vt.FocusedNode := nil;
    vt.FocusedColumn := NoColumn;
    SetVTSelection(vt, Sel);
    // Apply or reset filter
    editFilterVTChange(Sender);
    // Display number of listed values on tab
    tabProcessList.Caption := 'Process-List (' + IntToStr(vt.RootNodeCount) + ')';
  except
    on E: Exception do begin
      LogSQL('Error loading process list (automatic refresh disabled): ' + e.Message);
      TimerRefresh.Enabled := false;
    end;
  end;
  vt.Tag := VTREE_LOADED;
  Screen.Cursor := crDefault;
end;


procedure TMainForm.ListCommandStatsBeforePaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
  procedure addLVitem( idx: Integer; caption: String; commandCount: Int64; totalCount: Int64 );
  var
    tmpval : Double;
  begin
    VTRowDataListCommandStats[idx].ImageIndex := 25;
    VTRowDataListCommandStats[idx].Captions := TStringList.Create;
    caption := Copy( caption, 5, Length(caption) );
    caption := StringReplace( caption, '_', ' ', [rfReplaceAll] );
    VTRowDataListCommandStats[idx].Captions.Add( caption );
    // Total Frequency
    VTRowDataListCommandStats[idx].Captions.Add( FormatNumber( commandCount ) );
    // Average per hour
    tmpval := commandCount / ( Connection.ServerUptime / 60 / 60 );
    VTRowDataListCommandStats[idx].Captions.Add( FormatNumber( tmpval, 1 ) );
    // Average per second
    tmpval := commandCount / Connection.ServerUptime;
    VTRowDataListCommandStats[idx].Captions.Add( FormatNumber( tmpval, 1 ) );
    // Percentage. Take care of division by zero errors and Int64's
    if commandCount < 1 then
      commandCount := 1;
    if totalCount < 1 then
      totalCount := 1;
    tmpval := 100 / totalCount * commandCount;
    VTRowDataListCommandStats[idx].Captions.Add( FormatNumber( tmpval, 1 ) + ' %' );
  end;

var
  i: Integer;
  questions: Int64;
  Results: TMySQLQuery;
  vt: TVirtualStringTree;
  Sel: TStringList;
begin
  // Display command statistics
  vt := Sender as TVirtualStringTree;
  if vt.Tag = VTREE_LOADED then
    Exit;

  Sel := GetVTCaptions(vt, True);
  DeInitializeVTNodes(vt);
  Screen.Cursor := crHourglass;
  try
    Results := Connection.GetResults('SHOW /*!50002 GLOBAL */ STATUS LIKE ''Com\_%''' );
    questions := 0;
    while not Results.Eof do begin
      Inc(questions, MakeInt(Results.Col(1)));
      Results.Next;
    end;
    SetLength(VTRowDataListCommandStats, Results.RecordCount+1);
    addLVitem(0, '    All commands', questions, questions );
    Results.First;
    for i:=1 to Results.RecordCount do begin
      addLVitem(i, Results.Col(0), MakeInt(Results.Col(1)), questions );
      Results.Next;
    end;
    FreeAndNil(Results);
    // Tell VirtualTree the number of nodes it will display
    vt.RootNodeCount := Length(VTRowDataListCommandStats);
    vt.SortTree(vt.Header.SortColumn, vt.Header.SortDirection);
    SetVTSelection(vt, Sel);
    // Apply or reset filter
    editFilterVTChange(Sender);
    // Display number of listed values on tab
    tabCommandStats.Caption := 'Command-Statistics (' + IntToStr(vt.RootNodeCount) + ')';
  finally
    vt.Tag := VTREE_LOADED;
    Screen.Cursor := crDefault;
  end;
end;


procedure TMainForm.actCopyOrCutExecute(Sender: TObject);
var
  Control: TWinControl;
  Edit: TCustomEdit;
  Combo: TCustomComboBox;
  Grid: TVirtualStringTree;
  SynMemo: TSynMemo;
  Success, DoCut: Boolean;
  SQLStream: TMemoryStream;
begin
  // Copy text from a focused control to clipboard
  Success := False;
  Control := Screen.ActiveControl;
  DoCut := Sender = actCut;
  if Control is TCustomEdit then begin
    Edit := TCustomEdit(Control);
    if Edit.SelLength > 0 then begin
      if DoCut then Edit.CutToClipboard
      else Edit.CopyToClipboard;
      Success := True;
    end;
  end else if Control is TCustomComboBox then begin
    Combo := TCustomComboBox(Control);
    if Combo.SelLength > 0 then begin
      Clipboard.AsText := Combo.SelText;
      if DoCut then Combo.SelText := '';
      Success := True;
    end;
  end else if Control is TVirtualStringTree then begin
    Grid := Control as TVirtualStringTree;
    if Assigned(Grid.FocusedNode) then begin
      DataGridEnsureFullRow(Grid, Grid.FocusedNode);
      Clipboard.AsText := Grid.Text[Grid.FocusedNode, Grid.FocusedColumn];
      if (Grid = ActiveGrid) and DoCut then
        Grid.Text[Grid.FocusedNode, Grid.FocusedColumn] := '';
      Success := True;
    end;
  end else if Control is TSynMemo then begin
    SynMemo := Control as TSynMemo;
    if SynMemo.SelAvail then begin
      // Create both text and HTML clipboard format, so rich text applications can paste highlighted SQL
      SynExporterHTML1.ExportAll(Explode(CRLF, SynMemo.SelText));
      if DoCut then SynMemo.CutToClipboard
      else SynMemo.CopyToClipboard;
      SQLStream := TMemoryStream.Create;
      SynExporterHTML1.SaveToStream(SQLStream);
      StreamToClipboard(nil, SQLStream, False);
      Success := True;
    end;
  end;
  if not Success then
    MessageBeep(MB_ICONASTERISK);
end;


procedure TMainForm.actPasteExecute(Sender: TObject);
var
  Control: TWinControl;
  Edit: TCustomEdit;
  Combo: TComboBox;
  Grid: TVirtualStringTree;
  SynMemo: TSynMemo;
  Success: Boolean;
begin
  // Paste text into the focused control
  Success := False;
  Control := Screen.ActiveControl;
  if not Clipboard.HasFormat(CF_TEXT) then begin
    // Do nothing, we cannot paste a picture or so
  end else if Control is TCustomEdit then begin
    Edit := TCustomEdit(Control);
    if not Edit.ReadOnly then begin
      Edit.PasteFromClipboard;
      Success := True;
    end;
  end else if Control is TComboBox then begin
    Combo := TComboBox(Control);
    if Combo.Style = csDropDown then begin
      Combo.SelText := ClipBoard.AsText;
      Success := True;
    end;
  end else if Control is TVirtualStringTree then begin
    Grid := Control as TVirtualStringTree;
    if Assigned(Grid.FocusedNode) and (Grid = ActiveGrid) then begin
      Grid.Text[Grid.FocusedNode, Grid.FocusedColumn] := ClipBoard.AsText;
      Success := True;
    end;
  end else if Control is TSynMemo then begin
    SynMemo := TSynMemo(Control);
    if not SynMemo.ReadOnly then begin
      SynMemo.PasteFromClipboard;
      Success := True;
    end;
  end;
  if not Success then
    MessageBeep(MB_ICONASTERISK);
end;


procedure TMainForm.actSelectAllExecute(Sender: TObject);
var
  Control: TWinControl;
  Grid: TVirtualStringTree;
  ListBox: TListBox;
  Success: Boolean;
begin
  // Select all items, text or whatever
  Success := False;
  Control := Screen.ActiveControl;
  if Control is TCustomEdit then begin
    TCustomEdit(Control).SelectAll;
    Success := True;
  end else if Control is TVirtualStringTree then begin
    Grid := TVirtualStringTree(Control);
    if toMultiSelect in Grid.TreeOptions.SelectionOptions then begin
      Grid.SelectAll(False);
      Success := True;
    end;
  end else if Control is TSynMemo then begin
    TSynMemo(Control).SelectAll;
    Success := True;
  end else if Control is TListBox then begin
    ListBox := TListBox(Control);
    if ListBox.MultiSelect then begin
      ListBox.SelectAll;
      Success := True;
    end;
  end;
  if not Success then
    MessageBeep(MB_ICONASTERISK);
end;


procedure TMainForm.actSelectInverseExecute(Sender: TObject);
var
  Control: TWinControl;
  Grid: TVirtualStringTree;
  ListBox: TListBox;
  Success: Boolean;
  i: Integer;
begin
  // Invert selection in grids or listboxes
  Success := False;
  Control := Screen.ActiveControl;
  if Control is TVirtualStringTree then begin
    Grid := TVirtualStringTree(Control);
    if toMultiSelect in Grid.TreeOptions.SelectionOptions then begin
      Grid.InvertSelection(False);
      Success := True;
    end;
  end else if Control is TListBox then begin
    ListBox := TListBox(Control);
    if ListBox.MultiSelect then begin
      for i:=0 to ListBox.Count-1 do
        ListBox.Selected[i] := not ListBox.Selected[i];
      Success := True;
    end;
  end;
  if not Success then
    MessageBeep(MB_ICONASTERISK);
end;


procedure TMainForm.EnumerateRecentFilters;
var
  flt: TStringList;
  i: Integer;
  item: TMenuItem;
  rx: TRegExpr;
  capt: String;
begin
  // Reset menu and combobox
  menuRecentFilters.Enabled := False;
  for i := menuRecentFilters.Count - 1 downto 0 do
    menuRecentFilters.Delete(i);
  comboRecentFilters.Items.Clear;
  // Enumerate recent filters from registry
  if MainReg.OpenKey(GetRegKeyTable+'\'+REGNAME_FILTERS, False) then begin
    flt := TStringList.Create;
    rx := TRegExpr.Create;
    rx.Expression := '\s+';
    MainReg.GetValueNames(flt);
    for i := 0 to flt.Count - 1 do begin
      item := TMenuItem.Create(popupFilter);
      capt := MainReg.ReadString(flt[i]);
      capt := rx.Replace(capt, ' ', True);
      item.Hint := capt;
      item.Caption := sstr(capt, 50);
      item.Tag := MakeInt(flt[i]);
      item.OnClick := LoadRecentFilter;
      menuRecentFilters.Add(item);
      comboRecentFilters.Items.Add(sstr(capt, 100));
    end;
    FreeAndNil(rx);
    FreeAndNil(flt);
    menuRecentFilters.Enabled := menuRecentFilters.Count > 0;
  end;
  comboRecentFilters.Visible := comboRecentFilters.Items.Count > 0;
  lblRecentFilters.Visible := comboRecentFilters.Visible;
  SynMemoFilter.Height := pnlFilter.Height - 3;
  SynMemoFilter.Top := comboRecentFilters.Top;
  if comboRecentFilters.Visible then begin
    SynMemoFilter.Height := SynMemoFilter.Height - comboRecentFilters.Height;
    SynMemoFilter.Top := SynMemoFilter.Top + comboRecentFilters.Height;
    comboRecentFilters.ItemIndex := 0;
  end;
end;


procedure TMainForm.LoadRecentFilter(Sender: TObject);
var
  key: Integer;
begin
  // Event handler for both dynamic popup menu items and filter combobox
  if Sender is TMenuItem then
    key := (Sender as TMenuItem).Tag
  else
    key := (Sender as TComboBox).ItemIndex+1;
  if MainReg.OpenKey(GetRegKeyTable+'\'+REGNAME_FILTERS, False) then begin
    SynMemoFilter.UndoList.AddGroupBreak;
    SynMemoFilter.BeginUpdate;
    SynMemoFilter.SelectAll;
    SynMemoFilter.SelText := MainReg.ReadString(IntToStr(key));
    SynMemoFilter.EndUpdate;
  end;
end;


procedure TMainForm.PlaceObjectEditor(Obj: TDBObject);
var
  EditorClass: TDBObjectEditorClass;
begin
  // Place the relevant editor frame onto the editor tab, hide all others
  if Assigned(ActiveObjectEditor) and (Obj.NodeType <> ActiveObjectEditor.DBObject.NodeType) then
    FreeAndNil(ActiveObjectEditor);
  case Obj.NodeType of
    lntTable: EditorClass := TfrmTableEditor;
    lntView: EditorClass := TfrmView;
    lntProcedure, lntFunction: EditorClass := TfrmRoutineEditor;
    lntTrigger: EditorClass := TfrmTriggerEditor;
    lntEvent: EditorClass := TfrmEventEditor;
    else Exit;
  end;
  if not Assigned(ActiveObjectEditor) then begin
    ActiveObjectEditor := EditorClass.Create(tabEditor);
    ActiveObjectEditor.Parent := tabEditor;
  end;
  ActiveObjectEditor.Init(Obj);
end;


procedure TMainForm.UpdateEditorTab;
var
  Cap: String;
begin
  tabEditor.ImageIndex := ActiveObjectEditor.DBObject.ImageIndex;
  Cap := ActiveObjectEditor.DBObject.ObjType+': ';
  if ActiveObjectEditor.DBObject.Name = '' then
    Cap := Cap + '[Untitled]'
  else
    Cap := sstr(Cap + ActiveObjectEditor.DBObject.Name, 30);
  SetTabCaption(tabEditor.PageIndex, Cap);
end;


procedure TMainForm.actEditObjectExecute(Sender: TObject);
var
  Obj: PDBObject;
  db: String;
begin
  debug('actEditObjectExecute()');
  if ListTables.Focused then begin
    // Got here from ListTables.OnDblClick or ListTables's context menu item "Edit"
    Obj := ListTables.GetNodeData(ListTables.FocusedNode);
    if (Obj.Name <> SelectedTable.Name) or (Obj.NodeType <> SelectedTable.NodeType) then
      SelectDBObject(Obj.Name, Obj.NodeType);
  end;

  case DBtree.GetNodeLevel(DBtree.FocusedNode) of
    1: begin
      if CreateDatabaseForm = nil then
        CreateDatabaseForm := TCreateDatabaseForm.Create(Self);
      CreateDatabaseForm.modifyDB := ActiveDatabase;
      if CreateDatabaseForm.ShowModal = mrOk then begin
        db := CreateDatabaseForm.editDBName.Text;
        // Add new DB to database filter if it's not empty
        if comboOnlyDBs.Text <> '' then begin
          comboOnlyDBs.Text := comboOnlyDBs.Text + ';' + db;
          comboOnlyDBs.Items.Insert(0, comboOnlyDBs.Text);
        end;
        FreeAndNil(AllDatabases);
        // reload db nodes and switch to new one
        RefreshTree(False, db);
      end;
    end;

    2: PlaceObjectEditor(SelectedTable);
  end;

end;


procedure TMainForm.ListTablesKeyPress(Sender: TObject; var Key: Char);
begin
  // Open object editor on pressing Enter
  if Ord(Key) = VK_RETURN then
    ListTables.OnDblClick(Sender);
end;


procedure TMainForm.ListTablesDblClick(Sender: TObject);
var
  Obj: PDBObject;
  vt: TVirtualStringTree;
begin
  // DoubleClick: Display editor
  debug('ListTablesDblClick()');
  vt := Sender as TVirtualStringTree;
  if Assigned(vt.FocusedNode) then begin
    Obj := vt.GetNodeData(vt.FocusedNode);
    SelectDBObject(vt.Text[vt.FocusedNode, vt.FocusedColumn], Obj.NodeType);
    PageControlMainChange(Sender);
  end;
end;


procedure TMainForm.actNewQueryTabExecute(Sender: TObject);
var
  i: Integer;
  QueryTab: TQueryTab;
begin
  i := QueryTabs[QueryTabs.Count-1].Number + 1;

  QueryTabs.Add(TQueryTab.Create);
  QueryTab := QueryTabs[QueryTabs.Count-1];
  QueryTab.Number := i;
  QueryTab.GridResult := TGridResult.Create;

  QueryTab.TabSheet := TTabSheet.Create(PageControlMain);
  QueryTab.TabSheet.PageControl := PageControlMain;
  QueryTab.TabSheet.ImageIndex := tabQuery.ImageIndex;

  QueryTab.CloseButton := TSpeedButton.Create(QueryTab.TabSheet);
  QueryTab.CloseButton.Parent := PageControlMain;
  QueryTab.CloseButton.Width := 16;
  QueryTab.CloseButton.Height := 16;
  QueryTab.CloseButton.Flat := True;
  ImageListMain.GetBitmap(134, QueryTab.CloseButton.Glyph);
  QueryTab.CloseButton.OnMouseDown := CloseButtonOnMouseDown;
  QueryTab.CloseButton.OnMouseUp := CloseButtonOnMouseUp;
  SetTabCaption(QueryTab.TabSheet.PageIndex, '');

  // Dumb code which replicates all controls from tabQuery
  QueryTab.pnlMemo := TPanel.Create(QueryTab.TabSheet);
  QueryTab.pnlMemo.Parent := QueryTab.TabSheet;
  QueryTab.pnlMemo.Tag := pnlQueryMemo.Tag;
  QueryTab.pnlMemo.BevelOuter := pnlQueryMemo.BevelOuter;
  QueryTab.pnlMemo.Align := pnlQueryMemo.Align;

  QueryTab.Memo := TSynMemo.Create(QueryTab.pnlMemo);
  QueryTab.Memo.Parent := QueryTab.pnlMemo;
  QueryTab.Memo.Tag := SynMemoQuery.Tag;
  QueryTab.Memo.Align := SynMemoQuery.Align;
  QueryTab.Memo.Options := SynMemoQuery.Options;
  QueryTab.Memo.PopupMenu := SynMemoQuery.PopupMenu;
  QueryTab.Memo.TabWidth := SynMemoQuery.TabWidth;
  QueryTab.Memo.RightEdge := SynMemoQuery.RightEdge;
  QueryTab.Memo.WantTabs := SynMemoQuery.WantTabs;
  QueryTab.Memo.Highlighter := SynMemoQuery.Highlighter;
  QueryTab.Memo.Gutter.Assign(SynMemoQuery.Gutter);
  QueryTab.Memo.Font.Assign(SynMemoQuery.Font);
  QueryTab.Memo.ActiveLineColor := SynMemoQuery.ActiveLineColor;
  QueryTab.Memo.OnDragDrop := SynMemoQuery.OnDragDrop;
  QueryTab.Memo.OnDragOver := SynMemoQuery.OnDragOver;
  QueryTab.Memo.OnDropFiles := SynMemoQuery.OnDropFiles;
  QueryTab.Memo.OnReplaceText := SynMemoQuery.OnReplaceText;
  QueryTab.Memo.OnStatusChange := SynMemoQuery.OnStatusChange;
  QueryTab.Memo.OnPaintTransient := SynMemoQuery.OnPaintTransient;
  SynCompletionProposal.AddEditor(QueryTab.Memo);

  QueryTab.spltHelpers := TSplitter.Create(QueryTab.pnlMemo);
  QueryTab.spltHelpers.Parent := QueryTab.pnlMemo;
  QueryTab.spltHelpers.Tag := spltQueryHelpers.Tag;
  QueryTab.spltHelpers.Align := spltQueryHelpers.Align;
  QueryTab.spltHelpers.Cursor := spltQueryHelpers.Cursor;
  QueryTab.spltHelpers.ResizeStyle := spltQueryHelpers.ResizeStyle;
  QueryTab.spltHelpers.Width := spltQueryHelpers.Width;

  QueryTab.pnlHelpers := TPanel.Create(QueryTab.pnlMemo);
  QueryTab.pnlHelpers.Parent := QueryTab.pnlMemo;
  QueryTab.pnlHelpers.Tag := pnlQueryHelpers.Tag;
  QueryTab.pnlHelpers.BevelOuter := pnlQueryHelpers.BevelOuter;
  QueryTab.pnlHelpers.Align := pnlQueryHelpers.Align;

  QueryTab.lboxHelpers := TListBox.Create(QueryTab.pnlHelpers);
  QueryTab.lboxHelpers.Parent := QueryTab.pnlHelpers;
  QueryTab.lboxHelpers.Tag := lboxQueryHelpers.Tag;
  QueryTab.lboxHelpers.Align := lboxQueryHelpers.Align;
  QueryTab.lboxHelpers.PopupMenu := lboxQueryHelpers.PopupMenu;
  QueryTab.lboxHelpers.MultiSelect := lboxQueryHelpers.MultiSelect;
  QueryTab.lboxHelpers.DragMode := lboxQueryHelpers.DragMode;
  QueryTab.lboxHelpers.Font.Assign(lboxQueryHelpers.Font);
  QueryTab.lboxHelpers.OnClick := lboxQueryHelpers.OnClick;
  QueryTab.lboxHelpers.OnDblClick := lboxQueryHelpers.OnDblClick;

  QueryTab.tabsetHelpers := TTabSet.Create(QueryTab.pnlHelpers);
  QueryTab.tabsetHelpers.Parent := QueryTab.pnlHelpers;
  QueryTab.tabsetHelpers.Tag := tabsetQueryHelpers.Tag;
  QueryTab.tabsetHelpers.Height := tabsetQueryHelpers.Height;
  QueryTab.tabsetHelpers.Align := tabsetQueryHelpers.Align;
  QueryTab.tabsetHelpers.Tabs := tabsetQueryHelpers.Tabs;
  QueryTab.tabsetHelpers.Style := tabsetQueryHelpers.Style;
  QueryTab.tabsetHelpers.Font.Assign(tabsetQueryHelpers.Font);
  QueryTab.tabsetHelpers.OnChange := tabsetQueryHelpers.OnChange;

  QueryTab.spltQuery := TSplitter.Create(QueryTab.TabSheet);
  QueryTab.spltQuery.Parent := QueryTab.TabSheet;
  QueryTab.spltQuery.Tag := spltQuery.Tag;
  QueryTab.spltQuery.Align := spltQuery.Align;
  QueryTab.spltQuery.Height := spltQuery.Height;
  QueryTab.spltQuery.Cursor := spltQuery.Cursor;
  QueryTab.spltQuery.ResizeStyle := spltQuery.ResizeStyle;
  QueryTab.spltQuery.AutoSnap := spltQuery.AutoSnap;

  QueryTab.LabelResultInfo := TLabel.Create(QueryTab.TabSheet);
  QueryTab.LabelResultInfo.Parent := QueryTab.TabSheet;
  QueryTab.LabelResultInfo.Tag := LabelResultInfo.Tag;
  QueryTab.LabelResultInfo.Align := LabelResultInfo.Align;
  QueryTab.LabelResultInfo.Font.Assign(LabelResultInfo.Font);
  QueryTab.LabelResultInfo.Caption := '';

  QueryTab.Grid := TVirtualStringTree.Create(QueryTab.TabSheet);
  QueryTab.Grid.Parent := QueryTab.TabSheet;
  QueryTab.Grid.Tag := QueryGrid.Tag;
  QueryTab.Grid.Align := QueryGrid.Align;
  QueryTab.Grid.TreeOptions := QueryGrid.TreeOptions;
  QueryTab.Grid.PopupMenu := QueryGrid.PopupMenu;
  QueryTab.Grid.LineStyle := QueryGrid.LineStyle;
  QueryTab.Grid.Font.Assign(QueryGrid.Font);
  QueryTab.Grid.Header.ParentFont := QueryGrid.Header.ParentFont;
  QueryTab.Grid.WantTabs := QueryGrid.WantTabs;
  QueryTab.Grid.AutoScrollDelay := QueryGrid.AutoScrollDelay;
  QueryTab.Grid.OnBeforeCellPaint := QueryGrid.OnBeforeCellPaint;
  QueryTab.Grid.OnFocusChanged := QueryGrid.OnFocusChanged;
  QueryTab.Grid.OnGetText := QueryGrid.OnGetText;
  QueryTab.Grid.OnInitNode := QueryGrid.OnInitNode;
  QueryTab.Grid.OnKeyDown := QueryGrid.OnKeyDown;
  QueryTab.Grid.OnPaintText := QueryGrid.OnPaintText;
  FixVT(QueryTab.Grid, prefGridRowsLineCount);
  SetupSynEditors;

  // Set splitter positions
  QueryTab.pnlMemo.Height := pnlQueryMemo.Height;
  QueryTab.pnlMemo.Top := pnlQueryMemo.Top;
  QueryTab.spltQuery.Top := spltQuery.Top;
  QueryTab.pnlHelpers.Width := pnlQueryHelpers.Width;

  // Show new tab
  PageControlMain.ActivePage := QueryTab.TabSheet;
  PageControlMainChange(Sender);
end;


procedure TMainForm.panelTopDblClick(Sender: TObject);
var
  aRect: TRect;
  aPoint: TPoint;
begin
  // Catch doubleclick on PageControlMain's underlying panel, which gets fired
  // when user clicks right besides the visible tabs
  aPoint := PageControlMain.ClientOrigin;
  aRect := Rect(aPoint.X, aPoint.Y, aPoint.X + PageControlMain.Width, aPoint.Y + PageControlMain.Height - tabQuery.Height);
  GetCursorPos(aPoint);
  if PtInRect(aRect, aPoint) then
    actNewQueryTab.Execute;
end;


procedure TMainForm.actCloseQueryTabExecute(Sender: TObject);
begin
  // Close active query tab by main action
  CloseQueryTab(PageControlMain.ActivePageIndex);
end;


procedure TMainForm.menuCloseQueryTab(Sender: TObject);
var
  aPoint: TPoint;
begin
  // Close query tab by menu item
  aPoint := PageControlMain.ScreenToClient(popupMainTabs.PopupPoint);
  CloseQueryTab(GetMainTabAt(aPoint.X, aPoint.Y));
end;


procedure TMainForm.popupMainTabsPopup(Sender: TObject);
var
  aPoint: TPoint;
  PageIndex: Integer;
begin
  // Detect if there is a tab under mouse position
  aPoint := PageControlMain.ScreenToClient(popupMainTabs.PopupPoint);
  PageIndex := GetMainTabAt(aPoint.X, aPoint.Y);
  menuCloseTab.Enabled := IsQueryTab(PageIndex, False);
end;


procedure TMainForm.CloseQueryTab(PageIndex: Integer);
var
  NewPageIndex: Integer;
begin
  if not IsQueryTab(PageIndex, False) then
    Exit;
  // Ask user if query content shall be saved to disk
  if not ConfirmTabClose(PageIndex) then
    Exit;
  // Work around bugs in ComCtrls.TPageControl.RemovePage
  NewPageIndex := PageControlMain.ActivePageIndex;
  if NewPageIndex >= PageIndex then
    Dec(NewPageIndex);
  PageControlMain.Pages[PageIndex].Free;
  QueryTabs.Delete(PageIndex-tabQuery.PageIndex);
  PageControlMain.ActivePageIndex := NewPageIndex;
  FixQueryTabCloseButtons;
  PageControlMain.OnChange(PageControlMain);
end;


procedure TMainForm.CloseButtonOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FLastMouseDownCloseButton := Sender;
end;


procedure TMainForm.CloseButtonOnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  aPoint: TPoint;
begin
  // Click on "Close" button of Query tab
  if Button <> mbLeft then
    Exit;
  // Between MousDown and MouseUp it is possible that the focused tab has switched. As we simulate a mouse-click
  // here, we must check if also the MouseDown event was fired on this particular button. See issue #1469.
  if (Sender <> FLastMouseDownCloseButton) then
    Exit;
  aPoint := PageControlMain.ScreenToClient((Sender as TSpeedButton).ClientToScreen(Point(X,Y)));
  CloseQueryTab(GetMainTabAt(aPoint.X, aPoint.Y));
end;


procedure TMainForm.PageControlMainMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  CurTickcount: Cardinal;
  TabNumber: Integer;
begin
  // Simulate doubleclick on tab to close it
  CurTickcount := GetTickCount;
  TabNumber := GetMainTabAt(X, Y);
  if (TabNumber = FLastTabNumberOnMouseUp)
    and (CurTickcount - FLastMouseUpOnPageControl <= GetDoubleClickTime) then
    CloseQueryTab(TabNumber)
  else begin
    FLastMouseUpOnPageControl := CurTickcount;
    FLastTabNumberOnMouseUp := TabNumber;
  end;
end;


function TMainForm.GetMainTabAt(X, Y: Integer): Integer;
var
  i: Integer;
begin
  // Return page index of main tab by coordinates
  Result := PageControlMain.IndexOfTabAt(X, Y);
  for i:=0 to PageControlMain.PageCount-1 do begin
    if (i<=Result) and (not PageControlMain.Pages[i].TabVisible) then
      Inc(Result);
  end;
end;


procedure TMainForm.FixQueryTabCloseButtons;
var
  i, PageIndex, VisiblePageIndex: Integer;
  Rect: TRect;
  btn: TSpeedButton;
begin
  // Fix positions of "Close" buttons on Query tabs
  // Avoid AV on Startup, when Mainform.OnResize is called once or twice implicitely.
  if not Assigned(btnAddTab) then
    Exit;
  for PageIndex:=tabQuery.PageIndex+1 to PageControlMain.PageCount-1 do begin
    VisiblePageIndex := PageIndex;
    for i:=0 to PageControlMain.PageCount-1 do begin
      if (i<=VisiblePageIndex) and (not PageControlMain.Pages[i].TabVisible) then
        Dec(VisiblePageIndex);
    end;
    Rect := PageControlMain.TabRect(VisiblePageIndex);
    btn := QueryTabs[PageIndex-tabQuery.PageIndex].CloseButton;
    btn.Top := Rect.Top + 2;
    btn.Left := Rect.Right - 19;
  end;
  // Set position of "Add tab" button
  VisiblePageIndex := PageControlMain.PageCount-1;
  for i:=0 to PageControlMain.PageCount-1 do begin
    if not PageControlMain.Pages[i].TabVisible then
      Dec(VisiblePageIndex);
  end;
  Rect := PageControlMain.TabRect(VisiblePageIndex);
  btnAddTab.Top := Rect.Top;
  btnAddTab.Left := Rect.Right + 5;
end;


function TMainForm.ActiveQueryTab: TQueryTab;
var
  idx: Integer;
begin
  idx := PageControlMain.ActivePageIndex-tabQuery.PageIndex;
  if (idx >= 0) and (idx < QueryTabs.Count) then
    Result := QueryTabs[idx]
  else
    Result := nil;
end;


function TMainForm.ActiveQueryMemo: TSynMemo;
begin
  // Return current query memo
  Result := ActiveQueryTab.Memo;
end;


function TMainForm.ActiveQueryHelpers: TListBox;
begin
  // Return current query helpers listbox
  Result := ActiveQueryTab.lboxHelpers;
end;


function TMainForm.ActiveQueryTabset: TTabset;
begin
  // Return current query helpers tabset
  Result := ActiveQueryTab.tabsetHelpers
end;


function TMainForm.ActiveGrid: TVirtualStringTree;
begin
  Result := nil;
  if PageControlMain.ActivePage = tabData then Result := DataGrid
  else if ActiveQueryTab <> nil then
    Result := ActiveQueryTab.Grid;
end;


function TMainForm.GridResult(Grid: TBaseVirtualTree): TGridResult;
begin
  // All grids (data- and query-grids) are placed directly on a TTabSheet
  Result := GridResult((Grid.Parent as TTabSheet).PageIndex)
end;


function TMainForm.GridResult(PageIndex: Integer): TGridResult;
begin
  // Return the grid result for "Data" or one of the "Query" tabs.
  // Results are enumerated like the tabs on which they get displayed, starting at tabData
  Dec(PageIndex, tabQuery.PageIndex);
  if PageIndex < 0 then
    Result := DataGridResult
  else if PageIndex < QueryTabs.Count then
    Result := QueryTabs[PageIndex].GridResult
  else
    Result := nil;
end;


function TMainForm.QueryTabActive: Boolean;
begin
  // Find out if the active main tab is a query tab
  Result := IsQueryTab(PageControlMain.ActivePageIndex, True);
end;

function TMainForm.IsQueryTab(PageIndex: Integer; IncludeFixed: Boolean): Boolean;
var
  Min: Integer;
begin
  // Find out if the given main tab is a query tab
  Min := tabQuery.PageIndex+1;
  if IncludeFixed then Dec(Min);
  Result := PageIndex >= Min;
end;

procedure TMainForm.SetWindowCaption;
var
  Cap: String;
begin
  // Set window caption and taskbar text
  Cap := SessionName;
  if ActiveDatabase <> '' then
    Cap := Cap + ' /' + ActiveDatabase;
  if SelectedTable.Name <> '' then
    Cap := Cap + '/' + SelectedTable.Name;
  Cap := Cap + ' - ' + APPNAME;
  if PortableMode then
    Cap := Cap + ' Portable';
  Cap := Cap + ' ' + AppVersion;
  Caption := Cap;
  Application.Title := Cap;
end;


procedure TMainForm.OnMessageHandler(var Msg: TMsg; var Handled: Boolean);
begin
  // Clicks on system window menu get handled here
  if Msg.message = WM_SYSCOMMAND then begin
    Handled := True;
    case Msg.wParam of
      MSG_UPDATECHECK: Mainform.actUpdateCheck.Execute;
      MSG_ABOUT: Mainform.actAboutBox.Execute;
      else Handled := False;
    end;
  end;
end;


procedure TMainForm.SetTabCaption(PageIndex: Integer; Text: String);
begin
  if PageIndex >= PageControlMain.PageCount then begin
    // The current tab can be closed already if we're here after CloseQueryTab()
    Exit;
  end;
  // Special case if passed text is empty: Reset query tab caption to "Query #123"
  if (PageIndex = tabQuery.PageIndex) and (Text = '') then
    Text := 'Query';
  if IsQueryTab(PageIndex, False) then begin
    if Text = '' then
      Text := 'Query #'+IntToStr(PageIndex-tabQuery.PageIndex);
    // Leave space for close button on closable query tabs
    Text := Text + '      ';
  end;
  TTabSheet(PageControlMain.Pages[PageIndex]).Caption := Text;
  FixQueryTabCloseButtons;
end;


function TMainForm.ConfirmTabClose(PageIndex: Integer): Boolean;
var
  msg: String;
  Tab: TQueryTab;
begin
  Tab := QueryTabs[PageIndex-tabQuery.PageIndex];
  if not Tab.Memo.Modified then
    Result := True
  else begin
    // Unhide tabsheet so the user sees the memo content
    Tab.TabSheet.PageControl.ActivePage := Tab.TabSheet;
    if Tab.MemoFilename <> '' then
      msg := 'Save changes to file '+CRLF+CRLF+Tab.MemoFilename+' ?'
    else
      msg := 'Save content of tab "'+Trim(Tab.TabSheet.Caption)+'" ?';
    case MessageDlg(msg, mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrNo: Result := True;
      mrYes: begin
        if Tab.MemoFilename <> '' then
          SaveQueryMemo(Tab, Tab.MemoFilename, False)
        else if SaveDialogSQLFile.Execute then
          SaveQueryMemo(Tab, SaveDialogSQLFile.FileName, False);
        // The save dialog can be cancelled.
        Result := not Tab.Memo.Modified;
      end;
      else Result := False;
    end;
  end;
end;


procedure TMainForm.comboOnlyDBsChange(Sender: TObject);
begin
  // Immediately apply database filter
  RefreshTree(False);
end;


procedure TMainForm.comboOnlyDBsExit(Sender: TObject);
var
  i, idx: Integer;
  FilterText: String;
begin
  // Add (move) custom filter text to (in) drop down history, if not empty
  FilterText := comboOnlyDBs.Text;
  idx := -1;
  for i:=0 to comboOnlyDBs.Items.Count-1 do begin
    if comboOnlyDBs.Items[i] = FilterText then begin
      idx := i;
      break;
    end;
  end;
  if idx > -1 then
    comboOnlyDBs.Items.Move(idx, 0)
  else
    comboOnlyDBs.Items.Insert(0, FilterText);
  comboOnlyDBs.Text := FilterText;
end;


procedure TMainForm.comboOnlyDBsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  // DBtree dragging node over DB filter dropdown
  Accept := (Source = DBtree) and (DBtree.GetNodeLevel(DBtree.FocusedNode) = 1);
end;


procedure TMainForm.comboOnlyDBsDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  dbs: TStringList;
  newdb: String;
begin
  // DBtree node dropped on DB filter dropdown
  dbs := Explode(';', comboOnlyDBs.Text);
  newdb := DBtree.Text[DBtree.FocusedNode, DBtree.FocusedColumn];
  if dbs.IndexOf(newdb) = -1 then begin
    if (comboOnlyDBs.Text <> '') and (comboOnlyDBs.Text[Length(comboOnlyDBs.Text)-1] <> ';') then
      comboOnlyDBs.Text := comboOnlyDBs.Text + ';';
    comboOnlyDBs.Text := comboOnlyDBs.Text + newdb;
    comboOnlyDBs.Items.Insert(0, comboOnlyDBs.Text);
    comboOnlyDBs.OnChange(Sender);
  end;
end;


procedure TMainForm.comboOnlyDBsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: Integer;
begin
  // Pressing Delete key while filters are dropped down, deletes the filter from the list
  i := comboOnlyDBs.ItemIndex;
  if comboOnlyDBs.DroppedDown and (Key=VK_DELETE) and (i > -1) then begin
    Key := 0;
    comboOnlyDBs.Items.Delete(i);
    if comboOnlyDBs.Items.Count > i then
      comboOnlyDBs.ItemIndex := i
    else
      comboOnlyDBs.ItemIndex := i-1;
    comboOnlyDBs.OnChange(Sender);
  end;
end;


procedure TMainForm.actFilterPanelExecute(Sender: TObject);
var
  MakeVisible: Boolean;
begin
  // (De-)activate or focus filter panel
  MakeVisible := Sender <> btnCloseFilterPanel;
  pnlFilterVT.Visible := MakeVisible;
  pnlFilterVT.Tag := Integer(MakeVisible);
  // On startup, we cannot SetFocus, throws exceptons. Call with nil in that special case - see FormCreate
  if Assigned(Sender) and MakeVisible and editFilterVT.CanFocus then
    editFilterVT.SetFocus;
end;


procedure TMainForm.UpdateFilterPanel(Sender: TObject);
var
  tab: TTabSheet;
  f: String;
  FilterPanelVisible: Boolean;
begin
  // Called when active tab changes
  pnlFilterVT.Enabled := PageControlMain.ActivePage <> tabEditor;
  lblFilterVT.Enabled := pnlFilterVT.Enabled;
  editFilterVT.Enabled := pnlFilterVT.Enabled;
  lblFilterVTInfo.Enabled := pnlFilterVT.Enabled;
  if pnlFilterVT.Enabled then
    editFilterVT.Color := clWindow
  else
    editFilterVT.Color := clBtnFace;

  tab := PageControlMain.ActivePage;
  if tab = tabHost then
    tab := PageControlHost.ActivePage;
  FilterPanelVisible := pnlFilterVT.Tag = Integer(True);
  if not FilterPanelVisible then begin
    if editFilterVT.Text <> '' then
      editFilterVT.Text := ''
    else
      editFilterVTChange(Sender);
  end else begin
    if tab = tabVariables then f := FilterTextVariables
    else if tab = tabStatus then f := FilterTextStatus
    else if tab = tabProcesslist then f := FilterTextProcessList
    else if tab = tabCommandStats then f := FilterTextCommandStats
    else if tab = tabDatabase then f := FilterTextDatabase
    else if tab = tabData then f := FilterTextData
    else if QueryTabActive and (tab = ActiveQueryTab.TabSheet) then f := ActiveQueryTab.FilterText;
    if editFilterVT.Text <> f then
      editFilterVT.Text := f
  end;

end;


procedure TMainform.SetupSynEditors;
var
  i, j: Integer;
  Editors: TObjectList;
  BaseEditor, Editor: TSynMemo;
  FontName: String;
  FontSize, TabWidth: Integer;
  KeyStroke: TSynEditKeyStroke;
  ActiveLineColor: TColor;
  Attri: TSynHighlighterAttributes;
  Shortcut1, Shortcut2: TShortcut;

  procedure FindEditors(Comp: TComponent);
  var i: Integer;
  begin
    for i:=0 to Comp.ComponentCount-1 do begin
      if Comp.Components[i] is TSynMemo then
        Editors.Add(Comp.Components[i]);
      FindEditors(Comp.Components[i]);
    end;
  end;

begin
  // Restore font, highlighter and shortcuts for each instantiated TSynMemo
  Editors := TObjectList.Create;
  BaseEditor := SynMemoQuery;
  for i:=0 to QueryTabs.Count-1 do
    Editors.Add(QueryTabs[i].Memo);
  Editors.Add(SynMemoFilter);
  Editors.Add(SynMemoProcessView);
  Editors.Add(SynMemoSQLLog);
  if Assigned(ActiveObjectEditor) then
    FindEditors(ActiveObjectEditor);
  if Assigned(CreateDatabaseForm) then
    Editors.Add(CreateDatabaseForm.SynMemoPreview);
  if Assigned(OptionsForm) then
    Editors.Add(OptionsForm.SynMemoSQLSample);
  if Assigned(SQLHelpForm) then begin
    Editors.Add(SQLHelpForm.memoDescription);
    Editors.Add(SQLHelpForm.MemoExample);
  end;

  FontName := GetRegValue(REGNAME_FONTNAME, DEFAULT_FONTNAME);
  FontSize := GetRegValue(REGNAME_FONTSIZE, DEFAULT_FONTSIZE);
  TabWidth := GetRegValue(REGNAME_TABWIDTH, DEFAULT_TABWIDTH);
  ActiveLineColor := StringToColor(GetRegValue(REGNAME_SQLCOLACTIVELINE, ColorToString(DEFAULT_SQLCOLACTIVELINE)));
  for i:=0 to Editors.Count-1 do begin
    Editor := Editors[i] as TSynMemo;
    Editor.Font.Name := FontName;
    Editor.Font.Size := FontSize;
    Editor.Gutter.Font.Name := FontName;
    Editor.Gutter.Font.Size := FontSize;
    Editor.Gutter.AutoSize := BaseEditor.Gutter.AutoSize;
    Editor.Gutter.DigitCount := BaseEditor.Gutter.DigitCount;
    Editor.Gutter.LeftOffset := BaseEditor.Gutter.LeftOffset;
    Editor.Gutter.RightOffset := BaseEditor.Gutter.RightOffset;
    Editor.Gutter.ShowLineNumbers := BaseEditor.Gutter.ShowLineNumbers;
    Editor.ActiveLineColor := ActiveLineColor;
    Editor.Options := BaseEditor.Options;
    Editor.TabWidth := TabWidth;
    Editor.MaxScrollWidth := BaseEditor.MaxScrollWidth;
    Editor.WantTabs := BaseEditor.WantTabs;
    Editor.OnPaintTransient := BaseEditor.OnPaintTransient;
    // Shortcuts
    if Editor = BaseEditor then for j:=0 to Editor.Keystrokes.Count-1 do begin
      KeyStroke := Editor.Keystrokes[j];
      Shortcut1 := GetRegValue(REGPREFIX_SHORTCUT1+EditorCommandToCodeString(Keystroke.Command), KeyStroke.ShortCut);
      Shortcut2 := GetRegValue(REGPREFIX_SHORTCUT2+EditorCommandToCodeString(Keystroke.Command), KeyStroke.ShortCut2);
      try
        Keystroke.ShortCut := Shortcut1;
        Keystroke.ShortCut2 := Shortcut2;
      except
        on E:ESynKeyError do begin
          LogSQL('Could not apply SynEdit keystroke shortcut "'+ShortCutToText(Shortcut1)+'"' +
            ' (or secondary: "'+ShortCutToText(Shortcut2)+'") to '+EditorCommandToCodeString(Keystroke.Command)+'. '+
            E.Message + '. Please go to Tools > Preferences > Shortcuts to change this settings.', lcError);
        end;
      end;
    end else
      Editor.Keystrokes := BaseEditor.KeyStrokes;
  end;
  // Highlighting
  for i:=0 to SynSQLSyn1.AttrCount - 1 do begin
    Attri := SynSQLSyn1.Attribute[i];
    Attri.Foreground := GetRegValue(REGPREFIX_SQLATTRI+Attri.FriendlyName+REGPOSTFIX_SQL_FG, Attri.Foreground);
    Attri.Background := GetRegValue(REGPREFIX_SQLATTRI+Attri.FriendlyName+REGPOSTFIX_SQL_BG, Attri.Background);
    Attri.IntegerStyle := GetRegValue(REGPREFIX_SQLATTRI+Attri.FriendlyName+REGPOSTFIX_SQL_STYLE, Attri.IntegerStyle);
    if Assigned(OptionsForm) then
      OptionsForm.SynSQLSynSQLSample.Attribute[i].AssignColorAndStyle(Attri);
  end;
end;


procedure TMainForm.actReformatSQLExecute(Sender: TObject);
var
  Control: TWinControl;
  m: TCustomSynEdit;
  CursorPosStart, CursorPosEnd: Integer;
  NewSQL: String;
begin
  // Reformat SQL query
  m := nil;
  Control := Screen.ActiveControl;
  if Control is TCustomSynEdit then begin
    m := Control as TCustomSynEdit;
    // We have a few readonly-SynMemos which we'll ignore here
    if m.ReadOnly then
      m := nil;
  end;
  if (not Assigned(m)) and QueryTabActive then
    m := ActiveQueryMemo;
  if not Assigned(m) then begin
    MessageDlg('Please select a non-readonly SQL editor first.', mtError, [mbOK], 0);
    Exit;
  end;
  CursorPosStart := m.SelStart;
  CursorPosEnd := m.SelEnd;
  if not m.SelAvail then
    m.SelectAll;
  NewSQL := m.SelText;
  if Length(NewSQL) = 0 then
    MessageDlg('Cannot reformat anything - your editor is empty.', mtError, [mbOK], 0)
  else begin
    Screen.Cursor := crHourglass;
    m.UndoList.AddGroupBreak;
    NewSQL := ReformatSQL(NewSQL);
    m.SelText := NewSQL;
    m.SelStart := CursorPosStart;
    if CursorPosEnd > CursorPosStart then
      m.SelEnd := CursorPosStart + Length(NewSQL);
    m.UndoList.AddGroupBreak;
    Screen.Cursor := crDefault;
  end;
end;


procedure TMainForm.PageControlMainContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  ClickPoint: TPoint;
  TabsHeight: Integer;
begin
  // Activate tab popup menu only when clicked on tabs area.
  TabsHeight := (btnAddTab.Height+2) * PageControlMain.RowCount;
  if MousePos.Y <= TabsHeight then begin
    ClickPoint := PageControlMain.ClientToScreen(MousePos);
    popupMainTabs.Popup(ClickPoint.X, ClickPoint.Y);
    Handled := True;
  end else
    Handled := False;
end;


procedure TMainForm.menuQueryHelpersGenerateStatementClick(Sender: TObject);
var
  MenuItem: TMenuItem;
  sql, Val, WhereClause: String;
  i, idx: Integer;
  ColumnNames, DefaultValues, KeyColumns: TStringList;
  Column: TTableColumn;
begin
  // Generate INSERT, UPDATE or DELETE query using selected columns
  MenuItem := (Sender as TMenuItem);
  ColumnNames := TStringList.Create;
  DefaultValues := TStringList.Create;
  for i:=0 to ActiveQueryHelpers.Items.Count-1 do begin
    if ActiveQueryHelpers.Selected[i] then begin
      ColumnNames.Add(mask(ActiveQueryHelpers.Items[i]));
      Column := SelectedTableColumns[i];
      case Column.DataType.Category of
        dtcInteger, dtcReal: Val := '0';
        dtcText, dtcIntegerNamed, dtcSetNamed: begin
          Val := esc(Column.DefaultText);
          if Column.DefaultType in [cdtNull, cdtNullUpdateTS] then
            Val := esc('')
          else
            Val := esc(Column.DefaultText);
        end;
        dtcTemporal: Val := 'NOW()';
        else Val := 'NULL';
      end;
      if Column.DefaultType = cdtAutoInc then
        Val := 'NULL';
      DefaultValues.Add(Val);
    end;
  end;
  KeyColumns := GetKeyColumns;
  if KeyColumns.Count > 0 then begin
    WhereClause := '';
    for i:=0 to KeyColumns.Count-1 do begin
      idx := ColumnNames.IndexOf(mask(KeyColumns[i]));
      if idx > -1 then
        WhereClause := WhereClause + mask(KeyColumns[i])+'='+DefaultValues[idx] + ' AND ';
    end;
    Delete(WhereClause, Length(sql)-3, 4);
  end else
    WhereClause := '??? # No primary or unique key available!';

  if MenuItem = menuQueryHelpersGenerateInsert then begin
    sql := 'INSERT INTO '+mask(SelectedTable.Name)+CRLF+
      #9'('+ImplodeStr(', ', ColumnNames)+')'+CRLF+
      #9'VALUES ('+ImplodeStr(', ', DefaultValues)+')';

  end else if MenuItem = menuQueryHelpersGenerateUpdate then begin
    sql := 'UPDATE '+mask(SelectedTable.Name)+CRLF+#9'SET'+CRLF;
    if ColumnNames.Count > 0 then begin
      for i:=0 to ColumnNames.Count-1 do begin
        sql := sql + #9#9 + ColumnNames[i] + '=' + DefaultValues[i] + ',' + CRLF;
      end;
      Delete(sql, Length(sql)-2, 1);
    end else
      sql := sql + #9#9'??? # No column names selected!'+CRLF;
    sql := sql + #9'WHERE ' + WhereClause;

  end else if MenuItem = menuQueryHelpersGenerateDelete then begin
    sql := 'DELETE FROM '+mask(SelectedTable.Name)+' WHERE ' + WhereClause;

  end;
  ActiveQueryMemo.UndoList.AddGroupBreak;
  ActiveQueryMemo.SelText := sql;
end;


procedure TMainForm.DBtreeChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  VT: TVirtualStringTree;
begin
  // Resize "Size" column in dbtree to hold widest possible byte numbers without cutting text
  VT := Sender as TVirtualStringTree;
  if coVisible in VT.Header.Columns[1].Options then
    VT.Header.Columns[1].Width := TextWidth(VT.Canvas, FormatByteNumber(SIZE_MB-1))+VT.TextMargin*2;
end;


procedure TMainForm.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
var
  Control: TWinControl;
  VT: TBaseVirtualTree;
begin
  // Wheel scrolling only works in component which has focus. Help out by doing that by hand at least for any VirtualTree.
  // See http://www.delphipraxis.net/viewtopic.php?p=1113607
  // TODO: Does not work when a SynMemo has focus, probably related to the broken solution of this issue:
  // http://sourceforge.net/tracker/index.php?func=detail&aid=1574059&group_id=3221&atid=103221
  Control := FindVCLWindow(MousePos);
  if (Control is TBaseVirtualTree) and (not Control.Focused) and PtInRect(Control.ClientRect, Control.ScreenToClient(MousePos)) then begin
    VT := Control as TBaseVirtualTree;
    VT.OffsetY := VT.OffsetY + (WheelDelta div 2); // Don't know why, but WheelDelta is twice as big as it normally appears
    VT.UpdateScrollBars(True);
    Handled := True;
  end else
    Handled := False;
end;


procedure TMainForm.actDataResetSortingExecute(Sender: TObject);
begin
  SetLength(DataGridSortColumns, 0);
  InvalidateVT(DataGrid, VTREE_NOTLOADED_PURGECACHE, False);
end;


procedure TMainForm.WMCopyData(var Msg: TWMCopyData);
var
  i: Integer;
begin
  // Probably a second instance is posting its command line parameters here
  if (Msg.CopyDataStruct.dwData = SecondInstMsgId) and (SecondInstMsgId <> 0) then begin
    ParseCommandLineParameters(ParamBlobToStr(Msg.CopyDataStruct.lpData));
    for i:=0 to FCmdlineFilenames.Count-1 do begin
      actNewQueryTabExecute(self);
      if not QueryLoad(FCmdlineFilenames[i]) then
        actCloseQueryTabExecute(Self);
    end;
    if Assigned(FCmdlineConnectionParams) then
      if InitConnection(FCmdlineConnectionParams, FCmdlineSessionName) then
        DoAfterConnect;
  end else
    // Not the right message id
    inherited;
end;


procedure TMainForm.DefaultHandler(var Message);
begin
  if TMessage(Message).Msg = SecondInstMsgId then begin
    // A second instance asked for our handle. Post that into its message queue.
    PostThreadMessage(TMessage(Message).WParam, SecondInstMsgId, Handle, 0);
  end else
    // Otherwise do what would happen without this overridden procedure
    inherited;
end;


procedure TMainForm.actBlobAsTextExecute(Sender: TObject);
begin
  // Activate displaying BLOBs as text data, ignoring possible weird effects in grid updates/inserts
  InvalidateVT(DataGrid, VTREE_NOTLOADED_PURGECACHE, False);
end;


function TMainForm.GetBlobContent(Results: TMySQLQuery; Column: Integer): String;
begin
  if actBlobAsText.Checked then
    Result := Results.Col(Column)
  else
    Result := '0x' + Results.BinColAsHex(Column);
end;


procedure TMainForm.vstScroll(Sender: TBaseVirtualTree; DeltaX, DeltaY: Integer);
begin
  // A tree gets scrolled only when the mouse is over it - see FormMouseWheel
  // Our home brewn cell editors do not reposition when the underlying tree scrolls.
  // To avoid confusion, terminate editors then.
  if Sender.IsEditing then
    Sender.EndEditNode;
end;


procedure TMainForm.lblExplainProcessClick(Sender: TObject);
var
  Tab: TQueryTab;
begin
  // Click on "Explain" link label, in process viewer
  actNewQueryTabExecute(Sender);
  Tab := QueryTabs[QueryTabs.Count-1];
  Tab.Memo.Text := 'USE '+mask(listProcesses.Text[listProcesses.FocusedNode, 3])+';'+CRLF+
    'EXPLAIN'+CRLF+SynMemoProcessView.Text;
  Tab.TabSheet.Show;
  actExecuteQueryExecute(Sender);
end;


procedure TMainForm.UpdateLineCharPanel;
var
  x, y: Int64;
  Grid: TVirtualStringTree;
begin
  // Fill panel with "Line:Char"
  x := -1;
  y := -1;
  Grid := ActiveGrid;
  if Assigned(Grid) and Grid.Focused then begin
    if Assigned(Grid.FocusedNode) then
      y := Grid.FocusedNode.Index+1;
    x := Grid.FocusedColumn+1;
  end else if QueryTabActive and ActiveQueryMemo.Focused then begin
    x := ActiveQueryMemo.CaretX;
    y := ActiveQueryMemo.CaretY;
  end;
  if (x > -1) and (y > -1) then
    ShowStatusMsg(FormatNumber(y)+' : '+FormatNumber(x), 1)
  else
    ShowStatusMsg('', 1);
end;

end.

