//20101210 modi by 600826
//20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//20121210 modi by 603744 for Z30-12120300002
//20121225 modi by 603744 for Z30-12121700001
//20130416 modi by 03433 for B11-130416001 错误信息：EDatabaseError；Field GGB006 not found.
//20130719 MODI BY 601394 FOR B11-130718001 订单合并跑物料需求查看单据不全
//20140212 MODI BY 03277 FOR B11-140212001 RIB036为空时 查询数据不正确
//20140410 MODI BY 03277 FOR B11-140409002 RIB关联RJA 用RIB036 RIB037
//20140507 MODI BY 29238 FOR b11-140507001 需求量为0时，RIB036和RIB037字段为空，关联查询数据出现多笔
//20141027 modi by 03433 for Z30-14101400001 增加订单树状信息查询按钮
//20151130 MODI BY 03277 FOR B11-151130003 生产计划取订单，生产计划跑物料需求，工单和采购单不显示
//20161012 modi by 01296  for b10-161011001 工单/委外单关联生产计划增加需求计划来源=''条件
//20210112 modi by 11245 for P00-21010004 物料需求生单展开需要展开完整的生产路线
//20210415 modi by 11245 for N01-21041400001 后续单据加上超链接
//20210514 modi by 11245 for N01-21051400001 超链接那边后面几个单据的变量名给错了
//20220523 modi by 11245 for X-1001321 优化
//20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
// 20221008 Modi by liucb(01684) for x-1000722 增加超领单
//20221019 modi by 01514 for X-1000132 增加模糊查询
//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
// 20221209 Modi by liucb(01684) for b-1001298 物料需求关联采购底稿条件修改
//20230328 modi by 11245 for B-1001603 收款核销单日期字段用错，应该是GHA004而不是GHC004
// 20240327 Modi by liucb(01684) for b-1002683 增加退料单
//20240820 modi by yangxun for B-1003014 增加委外退货单
//20250922 Modi by liucb(01684) for x-1003613 增加工艺名称
//20251107 Modi by liucb(01684) for x-1003656 增加工艺排序
unit COPDR28f;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Radical, ADODB, DB, StdCtrls, ComCtrls, Buttons, ExtCtrls,
  urEdit, urPage, Mask, DBClient, urChkBox, Grids, Wwdbigrd, Wwdbgrid,
  urDBGrid, urClientDataSet, Provider, cxControls, cxContainer, cxTreeView,
  urADODataSet, DCComboBox, cxEdit, cxProgressBar, jpeg, cxImage, SelectPnl;

type
  TfrmCOPDR28 = class(TfrmRadical)
    btnOK: TBitBtn;
    btnExit: TBitBtn;
    pcStep: TurPageControl;
    tsStep1: TTabSheet;
    tsStep2: TTabSheet;
    edDate02: TurDateEdit;
    edDate01: TurDateEdit;
    edDateJiao01: TurDateEdit;
    edDateJiao02: TurDateEdit;
    edCustNo02: TurEdit;
    grp2: TGroupBox;
    grp4: TGroupBox;
    grp5: TGroupBox;
    edCustNo01: TurEdit;
    cdsmain: TClientDataSet;
    dsMain: TDataSource;
    cdsmainIBB001: TStringField;
    cdsmainIBB002: TStringField;
    cdsmainIBB003: TStringField;
    cdsmainIBB004: TStringField;
    cdsmainIBB005: TStringField;
    cdsmainIBB006: TFloatField;
    cdsmainIBB034: TStringField;
    cdsmainIBB031: TFloatField;
    cdsmainIBB009: TFloatField;
    cdsmainIBB010: TFloatField;
    cdsmainIBB032: TFloatField;
    cdsmainIBB014: TFloatField;
    pnl1: TPanel;
    pnl2: TPanel;
    spl1: TSplitter;
    dbgridmain: TurDBGrid;
    tvMain: TcxTreeView;
    urdtst1: TurADODataSet;
    cdsmainDEA057: TStringField;
    grp6: TGroupBox;
    cboConfirm: TDcComboBox;
    cdsmainIBA021: TStringField;
    prgBar: TcxProgressBar;
    pnlTreeQuery: TPanel;
    edtQuery: TEdit;
    imgSearch: TcxImage;
    spTicket: TSelectPanel;
    spCustom: TSelectPanel;
    procedure btnExitClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cdsmainNewRecord(DataSet: TDataSet);
    procedure cdsmainBeforeDelete(DataSet: TDataSet);
    procedure dbgridmainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsmainAfterScroll(DataSet: TDataSet);
    procedure tvMainDblClick(Sender: TObject);
    function GetTableViewSQL(xTableView: string): string; //2011/1/10 for zy
    procedure cdsMainIBB023GetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure pcStepChange(Sender: TObject);
    procedure tvMainCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure edtQueryChange(Sender: TObject);
    procedure edtQueryKeyPress(Sender: TObject; var Key: Char);
    procedure edtQueryEnter(Sender: TObject);
    procedure edtQueryExit(Sender: TObject);
    procedure FormShow(Sender: TObject); //20121225 modi by 603744 for Z30-12121700001
  private
    FTicketNo: string; //20141027 modi by 03433 for Z30-14101400001 增加订单树状信息查询按钮
  protected
    function GetDataModule: TDataModule; override;
    function BeforeStart: Boolean; override;
  public
    { Public declarations }
    FCost: Boolean; //20110111 add by 600826 金额权限
    mFmtStr10, mFmtStr11, mFmtStr12: string;
    procedure OpenWork(xName, xKeyfield, xkeyValue: string);
  protected
    procedure OpenF2Window(var Key: Word; ActiveCtrl: TWinControl); override;
    procedure SetGridColor(Target: TurDBGrid);
    procedure GetFirst(xIBB001, xIBB002: string);
    procedure GetFromFirst(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string);
    procedure GetXiaoHuoDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //销货单
    procedure GetXiaoTuiDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //销退单
    procedure GetXiaoShouFaPiao(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string; xTpye: string = '1'); //销售发票
    procedure GetHongZiXiaoShouFaPiao(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao, xType: string); //红字销售发票
    procedure GetShouKuanDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //收款单
    procedure GetShouKuanHeXiaoDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao, xtype: string); //收款核销单
    procedure GetKeHuDaoKuanHeXiaoDanShouKuan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //客户到款核销-收款
    procedure GetKeHuDaoKuanHeXiaoDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //客户到款核销-销售
    procedure GetWeiTuoJieSuanDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //委托结算
    procedure GetHongZiWeiTuoJieSuanDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //红字委托结算
    procedure GetCaiGouDiGao(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //采购底稿
    procedure GetCaiGouDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //采购单
    procedure GetShengChanJiHua(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //生产计划
    procedure GetGongDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string; xTpye: string = '1'); //工单
    procedure GetWeiWaiDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string; xTpye: string = '1'); //委外单
    procedure GetWuLiaoXuQiu(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //物料需求
    procedure GetGongDanGongYi(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //工单工艺//20121210 modi by 603744 for Z30-12120300002
    //20130719 ADD BY 601394 FOR B11-130718001 订单合并跑物料需求查看单据不全           ==BEGIN==
    procedure GetGongDan2(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao, xDDLaiYuan, xDDDanHao, xDDXuHao: string); //工单
    procedure GetWeiWaiDan2(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao, xDDLaiYuan, xDDDanHao, xDDXuHao: string); //委外单
    procedure GetCaiGouDiGao2(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao, xDDLaiYuan, xDDDanHao, xDDXuHao: string); //采购底稿
    //20130719 ADD BY 601394 FOR B11-130718001 订单合并跑物料需求查看单据不全           ==END==
    //20210112 modi by 11245 for P00-21010004 物料需求生单展开需要展开完整的生产路线 ==begin==
    procedure GetLingLiaoDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //领料单
    procedure GetShengChanRuKuDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string; xtype: Integer); //生产入库单
    procedure GetShengChanRuKuJianYanDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //生产入库检验单
    procedure GetChongGongDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //重工单
    procedure GetChaoHaoLingLiaoDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //超耗领料单
    procedure GetWeiWaiSongLiaoDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //委外送料单
    procedure GetWeiWaiShouLiaoDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //委外收料单
    procedure GetWeiWaiJianYanDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //委外检验单
    procedure GetWeiWaiJinHuoDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //委外进货单
    procedure GetWeiWaiChaoHaoSongLiaoDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //委外超耗送料单
    procedure GetFuChanPinRuKu(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao, xDDLaiYuan, xDDDanHao, xDDXuHao: string);
    procedure GetChaoLingDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //超领单 // 20221008 Add by liucb(01684) for  x-1000722 增加超领单
    procedure GetWeiWaiChaoSongDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //委外超送单 // 20221008 Add by liucb(01684) for  x-1000722 增加超领单
    procedure GetWeiWaiTuiHuoDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string);//委外退货单 //20240820 modi by yangxun for B-1003014 增加委外退货单
    //20210112 modi by 11245 for P00-21010004 物料需求生单展开需要展开完整的生产路线 ==end==
    procedure GetTuiLiao(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //退料单
    procedure GetWeiWaiTuiLiaoDan(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao: string); //委外退料单
  end;

var
  frmCOPDR28: TfrmCOPDR28;

implementation

uses COPDR28d, LibTPA, LibDataModule, LibDefine, LibColor;

{$R *.dfm}

{ TfrmINVKB03 }


function TfrmCOPDR28.BeforeStart: Boolean;
begin
  Result := inherited BeforeStart;
  if not Result then exit;
  dsMain.DataSet := cdsmain;
  pcStep.ActivePageIndex := 0;
  Self.SetGridColor(dbgridmain);
  pnl2.Color := StringToColor(FormColor);
  tsStep2.TabVisible := False;
  mFmtStr10 := GetNumberFormat('', StrtoIntDef(Decoder.GetInfo(nnCommon, 'CAA010'), 0), True);
  mFmtStr11 := GetNumberFormat('', StrtoIntDef(Decoder.GetInfo(nnCommon, 'CAA011'), 0), True);
  mFmtStr12 := GetNumberFormat('', StrtoIntDef(Decoder.GetInfo(nnCommon, 'CAA012'), 0), True);

  //20141027 modi by 03433 for Z30-14101400001 增加订单树状信息查询按钮 begin======================
  FTicketNo := Decoder.GetReceiveValue('_KeyValue1');
  if FTicketNo <> '' then
  begin
    spTicket.edBegin.Text := FTicketNo;
    spTicket.edFinal.Text := FTicketNo;
    cboConfirm.ItemIndex := 2;
    btnOK.Click;
  end;
  //20141027 modi by 03433 for Z30-14101400001 增加订单树状信息查询按钮 end=======================
end;

function TfrmCOPDR28.GetDataModule: TDataModule;
begin
  Result := COPDR28d.TdmCOPDR28.Create(Self);
end;

procedure TfrmCOPDR28.btnExitClick(Sender: TObject);
begin
  inherited;
  Self.Close
end;


procedure TfrmCOPDR28.OpenF2Window(var Key: Word; ActiveCtrl: TWinControl);
begin
  inherited;
  //订单单号
//  if (ActiveCtrl = spTicket.edBegin) or (ActiveCtrl = edTicket02) then
//    PutDatas(OpenF2Form('DCSIBA', '203', [], ['IBA001']), ActiveCtrl)
//  else
  //订单日期
//    if (ActiveCtrl = edDate01) or (ActiveCtrl = edDate02) then
//      PutDatas(OpenPartner('UWCALENDAR', [TurDateEdit(ActiveCtrl).Text]), ActiveCtrl)
//    else
  //客户编号
//      if (ActiveCtrl = spCustom.edBegin) or (ActiveCtrl = spCustom.edFinal) then
//        PutDatas(OpenF2Form('TPADFA', '201', ['F'], ['DFA001']), ActiveCtrl)
//      else
  //交货日期
//        if (ActiveCtrl = edDateJiao01) or (ActiveCtrl = edDateJiao02) then
//          PutDatas(OpenPartner('UWCALENDAR', [TurDateEdit(ActiveCtrl).Text]), ActiveCtrl)
//        else ;

  if (ActiveCtrl is TurDateEdit) then  //日期 
    PutDatas( OpenPartner( 'UWCALENDAR', [TurDateEdit(ActiveCtrl).Text] ), ActiveCtrl ) 

  else if (ActiveCtrl=spTicket.edBegin) or (ActiveCtrl=spTicket.edFinal) then  //单号
    PutDatas(OpenF2Form('DCSIBA', '203', [], ['IBA001']), ActiveCtrl)
  else if ActiveCtrl = spTicket.ListBox then
    spTicket.PutDatas(OpenF2Form('DCSIBA', '203', [], ['IBA001'],True))

  else if (ActiveCtrl=spCustom.edBegin) or (ActiveCtrl=spCustom.edFinal) then  //客户
    PutDatas(OpenF2Form('TPADFA', '201', ['F'], ['DFA001']), ActiveCtrl)
  else if ActiveCtrl = spCustom.ListBox then
    spCustom.PutDatas(OpenF2Form('TPADFA', '201', ['F'], ['DFA001','DFA002'],True))
end;

procedure TfrmCOPDR28.btnOKClick(Sender: TObject);
var
  FSQLWhere, mSQL: string;
  mTableView: string; //2011/1/10  for zy
begin
  inherited;
  //20220523 modi by 11245 for X-1001321 优化 ==begin==
  prgBar.Visible := True;
  prgBar.Properties.Min := 0;
  prgBar.Properties.Max := 100;
  prgBar.Position := 0;
  //20220523 modi by 11245 for X-1001321 优化 ==end==
  FCost := poCost in AppPower;
  FSQLWhere := ' where 1=1 ';
  FSQLWhere := libtpa.GenStartEndSQL(FSQLWhere, 'IBA001', spTicket.edBegin.Text, spTicket.edFinal.Text); //起讫[订单单号]
  FSQLWhere := libtpa.GenStartEndSQL(FSQLWhere, 'IBA003', edDate01.Text, edDate02.Text); //起讫[订单日期]
  FSQLWhere := libtpa.GenStartEndSQL(FSQLWhere, 'IBA004', spCustom.edBegin.Text, spCustom.edFinal.Text); //起讫[客户名称]
  FSQLWhere := libtpa.GenStartEndSQL(FSQLWhere, 'IBA021', edCustNo01.Text, edCustNo02.Text); //起讫[客户单号]
  FSQLWhere := libtpa.GenStartEndSQL(FSQLWhere, 'IBB013', edDateJiao01.Text, edDateJiao02.Text); //起讫[客户名称]
  //20121225 modi by 603744 for Z30-12121700001 BEGIN========
  if cboConfirm.ItemIndex = 0 then
  begin
    FSQLWhere := FSQLWhere + ' AND IBA022 =''T'' ';
  end
  else if cboConfirm.ItemIndex = 1 then
  begin
    FSQLWhere := FSQLWhere + ' AND IBA022 =''F'' ';
  end;
  //20121225 modi by 603744 for Z30-12121700001 END===========
//2011/1/10  for zy _begin
  mTableView := GetTableViewSQL('TPADFA');
  if mTableView <> '' then
    FSQLWhere := FSQLWhere + ' AND IBA004 in ' + mTableView;
//2011/1/10  for zy _end
  mSQL := 'select DCSIBA.*,DCSIBB.*,DEA057 from DCSIBA left join DCSIBB on IBA001=IBB001 left join TPADEA on DEA001=IBB003  ';
  mSQL := mSQL + FSQLWhere;
  cdsmainIBB034.Visible := True;
  cdsmainIBB031.Visible := True;
  cdsmainIBB009.Visible := True;
  cdsmainIBB010.Visible := True;
  cdsmainIBB032.Visible := True;
  with TDataSetProvider.Create(nil) do
  begin
    try
      DataSet := TdmCOPDR28(FDM).OpenQueryDataSet(mSQL);
      cdsmain.Data := Data;
    finally
      Free;
    end;
  end;
  cdsmain.FieldByName('IBB023').OnGetText := cdsMainIBB023GetText; //20121225 modi by 603744 for Z30-12121700001
  TNumericField(cdsmain.FieldByName('IBB006')).DisplayFormat := GetNumberFormat('', StrToIntDef(Decoder.GetInfo(nnCommon, 'CAA010'), 0), True);
  TNumericField(cdsmain.FieldByName('IBB014')).DisplayFormat := GetNumberFormat('', StrToIntDef(Decoder.GetInfo(nnCommon, 'CAA010'), 0), True);
  TNumericField(cdsmain.FieldByName('IBB031')).DisplayFormat := GetNumberFormat('', StrToIntDef(Decoder.GetInfo(nnCommon, 'CAA011'), 0), True);
  TNumericField(cdsmain.FieldByName('IBB009')).DisplayFormat := GetNumberFormat('', StrToIntDef(Decoder.GetInfo(nnCommon, 'CAA011'), 0), True);
  TNumericField(cdsmain.FieldByName('IBB010')).DisplayFormat := GetNumberFormat('', StrToIntDef(Decoder.GetInfo(nnCommon, 'CAA012'), 0), True);
  TNumericField(cdsmain.FieldByName('IBB032')).DisplayFormat := GetNumberFormat('', StrToIntDef(Decoder.GetInfo(nnCommon, 'CAA012'), 0), True);
  if not FCost then //若无成本权限
  begin

    cdsmainIBB034.Visible := False;
    cdsmainIBB031.Visible := False;
    cdsmainIBB009.Visible := False;
    cdsmainIBB010.Visible := False;
    cdsmainIBB032.Visible := False;
  end;
  if tsStep2.TabVisible = False then
    tsStep2.TabVisible := True;
  pcStep.ActivePageIndex := 1;
  if cdsMain.IsEmpty then
    tvMain.Items.Clear;
end;

procedure TfrmCOPDR28.SetGridColor(Target: TurDBGrid);
begin
  with Target do
  begin
    //11.Grid奇数信息列底色
    PaintOptions.AlternatingRowColor := StringToColor(LibColor.GridOddRowColor);
    //12.Grid偶数信息列底色
    Color := StringToColor(LibColor.GridEvenRowColor);
    //13.Grid Active Row Color
    PaintOptions.ActiveRecordColor := StringToColor(LibColor.GridActiveRowColor);
    //14.Grid抬头底色
    Colors.Title := StringToColor(LibColor.GridTitleColor);
    //15.Grid索引字段底色
    Colors.IndexField := StringToColor(LibColor.GridIndexFieldColor);
    //16.Grid固定字段底色
    Colors.FixField := StringToColor(LibColor.GridFixFieldColor);
    //17.Grid字型颜色
    Font.Color := StringToColor(LibColor.GridFontColor);
    //18.Gtid箭头颜色
    IndicatorIconColor := StringToColor(LibColor.GridIndicatorIconColor);
    //19.Grid信息区线条颜色
    LineColors.DataColor := StringToColor(LibColor.GridDataLineColor);
    //20.Grid抬头区线条颜色
    LineColors.FixedColor := StringToColor(LibColor.GridTitleLineColor);
    //20.Grid抬头区线条颜色
    LineColors.HighLightColor := StringToColor(LibColor.GridTitleLineColor);
    //21.Grid抬头字型颜色
    TitleFont.Color := StringToColor(LibColor.GridTitleFontColor);
    //22.Grid左，下边界颜色
    TitleColor := StringToColor(LibColor.GridTitleLBColor);
    //23.只读字段颜色
    Colors.ReadOnlyField := StringToColor(LibColor.GridReadOnlyFieldColor);
  end;
end;

procedure TfrmCOPDR28.cdsmainNewRecord(DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

procedure TfrmCOPDR28.cdsmainBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

procedure TfrmCOPDR28.dbgridmainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if not (Key in [VK_PRIOR, VK_NEXT, VK_END, VK_HOME, VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN]) then
    Abort;
end;

procedure TfrmCOPDR28.cdsmainAfterScroll(DataSet: TDataSet);
var
  i: Integer;
begin
  inherited;
  GetFirst(cdsmain.FieldByName('IBB001').AsString, cdsmain.FieldByName('IBB002').AsString);
  for i := 0 to tvmain.Items.Count - 1 do
  begin
    tvmain.Items[i].Expanded := true;
  end;
end;

procedure TfrmCOPDR28.GetFirst(xIBB001, xIBB002: string);
var
  root_node: TTreeNode;
begin
  tvMain.Items.Clear;
  root_node := tvMain.Items.AddFirst(nil, '客户订单   [' + xIBB001 + ']-' + xIBB002);
  GetFromFirst(root_node, '32', xIBB001, xIBB002);
end;

procedure TfrmCOPDR28.GetFromFirst(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXuHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//销货单
  GetXiaoHuoDan(xnode, xLaiYuan, xDanHao, xXuHao);
//预开发票
  GetXiaoShouFaPiao(xnode, xLaiYuan, xDanHao, '', '2');
//客户到款核销单
  GetKeHuDaoKuanHeXiaoDan(xnode, xLaiYuan, xDanHao, xXuHao);
//采购底稿
  GetCaiGouDiGao(xnode, xLaiYuan, xDanHao, xXuHao);
//生产计划
  GetShengChanJiHua(xnode, xLaiYuan, xDanHao, xXuHao);
 //物料需求
  GetWuLiaoXuQiu(xnode, xLaiYuan, xDanHao, xXuHao);
//工单
  GetGongDan(xnode, xLaiYuan, xDanHao, xXuHao);
//委外单
  GetWeiWaiDan(xnode, xLaiYuan, xDanHao, xXuHao);
end;

procedure TfrmCOPDR28.GetXiaoHuoDan(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from JSKKEA left join JSKKEB on KEA001=KEB001 where KEB015=' + //20220523 mark by 11245 for X-1001321 优化
  mSQL := 'select KEB040,KEB001,KEB002,KEA003,KEB003,KEB004,KEA040,KEB007,KEB014,KEB018,KEB038 from JSKKEA left join JSKKEB on KEA001=KEB001 where KEB015=' + //20220523 modi by 11245 for X-1001321 优化
    quotedstr(xLaiYuan) + ' and KEB016=' + quotedstr(xDanHao);
  if xXuHao <> '' then
    mSQL := mSQL + ' and KEB017=' + quotedstr(xXuHao);
  mSQL := mSQL + ' order by KEA003,KEA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '销货单')
       //20220523 modi by 11245 for X-1001321 优化 ==begin==
    else
      prgBar.Position := 1 / 8 * 100;
    //20220523 modi by 11245 for X-1001321 优化 ==end==
    First;
    while not Eof do
    begin
//20121225 mark by 603744 for Z30-12121700001 begin========================
//      cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KEB001').AsString + ']' + '-' + fieldbyname('KEB002').AsString + ' ' +
//        //TransDateOut(fieldbyname('KEA003').AsString, False) + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KEB007').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        TransDateOut(fieldbyname('KEA003').AsString, False) + ' 品号：' + FieldByName('KEB003').AsString + ' 品名：' + FieldByName('KEB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KEB007').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        ' 销退数量:' + FormatFloat(mFmtStr10, FieldByName('KEB014').AsFloat) + ' 已开票数量:' + FormatFloat(mFmtStr10, FieldByName('KEB018').AsFloat) +
//        ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KEB038').AsFloat));
//20121225 mark by 603744 for Z30-12121700001 end=========================
      //20121225 modi by 603744 for Z30-12121700001 begin===================
      if FieldByName('KEA040').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KEB001').AsString + ']' + '-' + fieldbyname('KEB002').AsString + ' ' +
        //TransDateOut(fieldbyname('KEA003').AsString, False) + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KEB007').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('KEA003').AsString, False) + ' 品号：' + FieldByName('KEB003').AsString + ' 品名：' + FieldByName('KEB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KEB007').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
          TransDateOut(fieldbyname('KEA003').AsString, False) + ' 品号：' + FieldByName('KEB003').AsString + ' 品名：' + FieldByName('KEB004').AsString + ' 规格：' + FieldByName('KEB040').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KEB007').AsFloat) + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 销退数量:' + FormatFloat(mFmtStr10, FieldByName('KEB014').AsFloat) + ' 已开票数量:' + FormatFloat(mFmtStr10, FieldByName('KEB018').AsFloat) +
          ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KEB038').AsFloat)
          + ' 已审核')
      else if FieldByName('KEA040').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KEB001').AsString + ']' + '-' + fieldbyname('KEB002').AsString + ' ' +
        //TransDateOut(fieldbyname('KEA003').AsString, False) + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KEB007').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('KEA003').AsString, False) + ' 品号：' + FieldByName('KEB003').AsString + ' 品名：' + FieldByName('KEB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KEB007').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
          TransDateOut(fieldbyname('KEA003').AsString, False) + ' 品号：' + FieldByName('KEB003').AsString + ' 品名：' + FieldByName('KEB004').AsString + ' 规格：' + FieldByName('KEB040').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KEB007').AsFloat) + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 销退数量:' + FormatFloat(mFmtStr10, FieldByName('KEB014').AsFloat) + ' 已开票数量:' + FormatFloat(mFmtStr10, FieldByName('KEB018').AsFloat) +
          ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KEB038').AsFloat)
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 end=====================
      GetXiaoTuiDan(cur_node, '33', fieldbyname('KEB001').AsString, fieldbyname('KEB002').AsString);
      GetXiaoShouFaPiao(cur_node, '33', fieldbyname('KEB001').AsString, fieldbyname('KEB002').AsString);
      GetKeHuDaoKuanHeXiaoDan(cur_node, '33', fieldbyname('KEB001').AsString, '');
      GetWeiTuoJieSuanDan(cur_node, '33', fieldbyname('KEB001').AsString, fieldbyname('KEB002').AsString);
      GetHongZiWeiTuoJieSuanDan(cur_node, '33', fieldbyname('KEB001').AsString, fieldbyname('KEB002').AsString);
       //20220523 modi by 11245 for X-1001321 优化 ==begin==
      if xLaiYuan = '32' then
        prgBar.Position := prgBar.Position + (1 / (RecordCount * 8) * 100);
      //20220523 modi by 11245 for X-1001321 优化 ==end==
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.GetXiaoTuiDan(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from JSKKFA left join JSKKFB on KFA001=KFB001 where KFB014=' +//20220523 mark by 11245 for X-1001321 优化
  mSQL := 'select KFA042,KFB001,KFB002,KFB003,KFB004,KFA003,KFB042,KFB007,KFB020,KFB040 from JSKKFA left join JSKKFB on KFA001=KFB001 where KFB014=' + //20220523 modi by 11245 for X-1001321 优化
    quotedstr(xLaiYuan) + ' and KFB015=' + quotedstr(xDanHao);
  if xXuHao <> '' then
    mSQL := mSQL + ' and KFB016=' + quotedstr(xXuHao);
  mSQL := mSQL + ' order by KFA003,KFA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '销退单');
    First;
    while not Eof do
    begin
//20121225 mark by 603744 for Z30-12121700001 begin======================
//      cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFB001').AsString + ']' + '-' + fieldbyname('KFB002').AsString + ' ' +
//        //TransDateOut(fieldbyname('KFA003').AsString, False) + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KFB007').AsFloat) +  //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        TransDateOut(fieldbyname('KFA003').AsString, False) + ' 品号：' + FieldByName('KFB003').AsString + ' 品名：' + FieldByName('KFB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KFB007').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KFB040').AsFloat) + ' 已开票数量:' + FormatFloat(mFmtStr10, FieldByName('KFB020').AsFloat));
//20121225 mark by 603744 for Z30-12121700001 end=======================
      //20121225 modi by 603744 for Z30-12121700001 begin=====================
      if FieldByName('KFA042').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFB001').AsString + ']' + '-' + fieldbyname('KFB002').AsString + ' ' +
        //TransDateOut(fieldbyname('KFA003').AsString, False) + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KFB007').AsFloat) +  //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('KFA003').AsString, False) + ' 品号：' + FieldByName('KFB003').AsString + ' 品名：' + FieldByName('KFB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KFB007').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
          TransDateOut(fieldbyname('KFA003').AsString, False) + ' 品号：' + FieldByName('KFB003').AsString + ' 品名：' + FieldByName('KFB004').AsString + ' 规格：' + FieldByName('KFB042').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KFB007').AsFloat) + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KFB040').AsFloat) + ' 已开票数量:' + FormatFloat(mFmtStr10, FieldByName('KFB020').AsFloat)
          + ' 已审核')
      else if FieldByName('KFA042').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFB001').AsString + ']' + '-' + fieldbyname('KFB002').AsString + ' ' +
        //TransDateOut(fieldbyname('KFA003').AsString, False) + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KFB007').AsFloat) +  //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('KFA003').AsString, False) + ' 品号：' + FieldByName('KFB003').AsString + ' 品名：' + FieldByName('KFB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KFB007').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
          TransDateOut(fieldbyname('KFA003').AsString, False) + ' 品号：' + FieldByName('KFB003').AsString + ' 品名：' + FieldByName('KFB004').AsString + ' 规格：' + FieldByName('KFB042').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('KFB007').AsFloat) + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KFB040').AsFloat) + ' 已开票数量:' + FormatFloat(mFmtStr10, FieldByName('KFB020').AsFloat)
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 end======================
      GetXiaoShouFaPiao(cur_node, '34', fieldbyname('KFB001').AsString, fieldbyname('KFB002').AsString);
      GetHongZiXiaoShouFaPiao(cur_node, '34', fieldbyname('KFB001').AsString, fieldbyname('KFB002').AsString, '1');
      GetKeHuDaoKuanHeXiaoDan(cur_node, '34', fieldbyname('KFB001').AsString, '');
      Next;
    end;
  finally
    Free;
  end;

end;

procedure TfrmCOPDR28.GetXiaoShouFaPiao(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string; xTpye: string = '1');
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
  if xTpye = '3' then
  begin
//    mSQL := 'select * from YSFGGA left join YSFGGC on GGA001=GGC001  where GGA002=''T'' and  GGC003=' + //20220523 modi by 11245 for X-1001321 优化
    mSQL := 'select GGA035,GGA032,GGC001,GGC002,GGA005,GGC006,GGC007,GGC024,GGC013 ' +
      ' ,GGA018 ' + //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
      ' from YSFGGA left join YSFGGC on GGA001=GGC001  where GGA002=''T'' and  GGC003=' + //20220523 modi by 11245 for X-1001321 优化
      quotedstr(xLaiYuan) + ' and GGC004=' + quotedstr(xDanHao);
    if xXUHao <> '' then
      mSQL := mSQL + ' and GGC005=' + quotedstr(xXUHao);
  end
  else
  begin
//    mSQL := 'select * from YSFGGA left join YSFGGB on GGA001=GGB001  where GGA002=''T'' and  GGB003=' + //20220523 modi by 11245 for X-1001321 优化
    mSQL := 'select GGA035,GGA032,GGA005,GGB001,GGB002,GGB010,GGB024 ' +
      ' ,GGA018 ' + //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
      ' from YSFGGA left join YSFGGB on GGA001=GGB001  where GGA002=''T'' and  GGB003=' + //20220523 modi by 11245 for X-1001321 优化
      quotedstr(xLaiYuan) + ' and GGB004=' + quotedstr(xDanHao);
    if xXUHao <> '' then
      mSQL := mSQL + ' and GGB005=' + quotedstr(xXUHao);
  end;
  mSQL := mSQL + ' order by GGA005,GGA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      if xTpye = '2' then
        root_node := tvMain.Items.AddChild(xnode, '预开发票')
      else
        root_node := tvMain.Items.AddChild(xnode, '销售发票')
     //20220523 modi by 11245 for X-1001321 优化 ==begin==
    else
      if xTpye = '2' then
        prgBar.Position := 2 / 8 * 100;
    //20220523 modi by 11245 for X-1001321 优化 ==end==
    First;
    while not Eof do
    begin
      if not FCost then
      begin
        if xTpye = '3' then
        //20121225 modi by 603744 for Z30-12121700001 begin====================
        begin
          if FieldByName('GGA032').AsString = 'T' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGC001').AsString + ']' + '-' + fieldbyname('GGC002').AsString + ' ' +
            //TransDateOut(fieldbyname('GGA005').AsString, False))
              //TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString  //20130416 mark by 03433 for B11-130416001 错误信息：EDatabaseError；Field GGB006 not found.
              TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGC006').AsString + ' 品名：' + FieldByName('GGC007').AsString //20130416 modi by 03433 for B11-130416001 错误信息：EDatabaseError；Field GGB006 not found.
              + ' 规格：' + FieldByName('GGC024').AsString //20190605 modi by 11245 for B11-190605004 增加规格显示
//              + ' 已审核')//20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
              + IIf(FieldByName('GGA018').AsString = '2', ' 作废', ' 已审核')) //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
          else if FieldByName('GGA032').AsString = 'F' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGC001').AsString + ']' + '-' + fieldbyname('GGC002').AsString + ' ' +
            //TransDateOut(fieldbyname('GGA005').AsString, False))
              //TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString //20130416 mark by 03433 for B11-130416001 错误信息：EDatabaseError；Field GGB006 not found.
              TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGC006').AsString + ' 品名：' + FieldByName('GGC007').AsString //20130416 modi by 03433 for B11-130416001 错误信息：EDatabaseError；Field GGB006 not found.
              + ' 规格：' + FieldByName('GGC024').AsString //20190605 modi by 11245 for B11-190605004 增加规格显示
//              + ' 未审核'); //20220915 mark by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
              + IIf(FieldByName('GGA018').AsString = '2', ' 作废', ' 未审核')); //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
        end
        //20121225 modi by 603744 for Z30-12121700001 end====================
//20121225 mark by 603744 for Z30-12121700001 begin======================
//          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGC001').AsString + ']' + '-' + fieldbyname('GGC002').AsString + ' ' +
//            //TransDateOut(fieldbyname('GGA005').AsString, False))
//            TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString)
//20121225 mark by 603744 for Z30-12121700001 end=====================
        else
        //20121225 modi by 603744 for Z30-12121700001 begin====================
        begin
          if FieldByName('GGA032').AsString = 'T' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGB001').AsString + ']' + '-' + fieldbyname('GGB002').AsString + ' ' +
              TransDateOut(fieldbyname('GGA005').AsString, False) + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat)
//              + ' 已审核')//20220915 mark by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
              + IIf(FieldByName('GGA018').AsString = '2', ' 作废', ' 已审核')) //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
          else if FieldByName('GGA032').AsString = 'F' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGB001').AsString + ']' + '-' + fieldbyname('GGB002').AsString + ' ' +
              TransDateOut(fieldbyname('GGA005').AsString, False) + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat)
//              + ' 未审核');//20220915 mark by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
              + IIf(FieldByName('GGA018').AsString = '2', ' 作废', ' 未审核')); //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
        end;
        //20121225 modi by 603744 for Z30-12121700001 end========================
//20121225 mark by 603744 for Z30-12121700001 begin======================
//          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGB001').AsString + ']' + '-' + fieldbyname('GGB002').AsString + ' ' +
//            TransDateOut(fieldbyname('GGA005').AsString, False) + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
            //TransDateOut(fieldbyname('GGA005').AsString, False) +' 品号：'+ FieldByName('GGB006').AsString+' 品名：'+FieldByName('GGB007').AsString+ ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//20121225 mark by 603744 for Z30-12121700001 end=========================
      end
      else
      begin
        if xTpye = '3' then
        //20121225 modi by 603744 for Z30-12121700001 begin========================
        begin
          if FieldByName('GGA032').AsString = 'T' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGC001').AsString + ']' + '-' + fieldbyname('GGC002').AsString + ' ' +
            //TransDateOut(fieldbyname('GGA005').AsString, False) + ' 本次冲销金额:' + FormatFloat(mFmtStr12, FieldByName('GGC013').AsFloat)) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
              //TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString + ' 本次冲销金额:' + FormatFloat(mFmtStr12, FieldByName('GGC013').AsFloat) //20130416 mark by 03433 for B11-130416001 错误信息：EDatabaseError；Field GGB006 not found.
              TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGC006').AsString + ' 品名：' + FieldByName('GGC007').AsString + ' 本次冲销金额:' + FormatFloat(mFmtStr12, FieldByName('GGC013').AsFloat) //20130416 modi by 03433 for B11-130416001 错误信息：EDatabaseError；Field GGB006 not found.
              + ' 规格：' + FieldByName('GGC024').AsString //20190605 modi by 11245 for B11-190605004 增加规格显示
//              + ' 已审核') //20220915 mark by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
              + IIf(FieldByName('GGA018').AsString = '2', ' 作废', ' 已审核')) //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
          else if FieldByName('GGA032').AsString = 'F' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGC001').AsString + ']' + '-' + fieldbyname('GGC002').AsString + ' ' +
            //TransDateOut(fieldbyname('GGA005').AsString, False) + ' 本次冲销金额:' + FormatFloat(mFmtStr12, FieldByName('GGC013').AsFloat)) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
              //TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString + ' 本次冲销金额:' + FormatFloat(mFmtStr12, FieldByName('GGC013').AsFloat)//20130416 mark by 03433 for B11-130416001 错误信息：EDatabaseError；Field GGB006 not found.
              TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGC006').AsString + ' 品名：' + FieldByName('GGC007').AsString + ' 本次冲销金额:' + FormatFloat(mFmtStr12, FieldByName('GGC013').AsFloat) //20130416 modi by 03433 for B11-130416001 错误信息：EDatabaseError；Field GGB006 not found.
              + ' 规格：' + FieldByName('GGC024').AsString //20190605 modi by 11245 for B11-190605004 增加规格显示
//              + ' 未审核');//20220915 mark by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
              + IIf(FieldByName('GGA018').AsString = '2', ' 作废', ' 未审核')); //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
        end
        //20121225 modi by 603744 for Z30-12121700001 end==========================
//20121225 mark by 603744 for Z30-12121700001 begin===========================
//          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGC001').AsString + ']' + '-' + fieldbyname('GGC002').AsString + ' ' +
//            //TransDateOut(fieldbyname('GGA005').AsString, False) + ' 本次冲销金额:' + FormatFloat(mFmtStr12, FieldByName('GGC013').AsFloat)) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//            TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString + ' 本次冲销金额:' + FormatFloat(mFmtStr12, FieldByName('GGC013').AsFloat)) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//20121225 mark by 603744 for Z30-12121700001 end===========================
        else
        //20121225 modi by 603744 for Z30-12121700001 begin========================
        begin
          if FieldByName('GGA032').AsString = 'T' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGB001').AsString + ']' + '-' + fieldbyname('GGB002').AsString + ' ' +
              TransDateOut(fieldbyname('GGA005').AsString, False) + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
            //TransDateOut(fieldbyname('GGA005').AsString, False) +' 品号：'+ FieldByName('GGB006').AsString+' 品名：'+FieldByName('GGB007').AsString+ ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat)  //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
              + ' 价税合计:' + FormatFloat(mFmtStr12, FieldByName('GGB024').AsFloat)
//              + ' 已审核')//20220915 mark by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
              + IIf(FieldByName('GGA018').AsString = '2', ' 作废', ' 已审核')) //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
          else if FieldByName('GGA032').AsString = 'F' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGB001').AsString + ']' + '-' + fieldbyname('GGB002').AsString + ' ' +
              TransDateOut(fieldbyname('GGA005').AsString, False) + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
            //TransDateOut(fieldbyname('GGA005').AsString, False) +' 品号：'+ FieldByName('GGB006').AsString+' 品名：'+FieldByName('GGB007').AsString+ ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat)  //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
              + ' 价税合计:' + FormatFloat(mFmtStr12, FieldByName('GGB024').AsFloat)
//              + ' 未审核'); //20220915 mark by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
              + IIf(FieldByName('GGA018').AsString = '2', ' 作废', ' 未审核')); //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
        end;
        //20121225 modi by 603744 for Z30-12121700001 end=========================
//20121225 mark by 603744 for Z30-12121700001 begin=====================
//          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGB001').AsString + ']' + '-' + fieldbyname('GGB002').AsString + ' ' +
//            TransDateOut(fieldbyname('GGA005').AsString, False) + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//            //TransDateOut(fieldbyname('GGA005').AsString, False) +' 品号：'+ FieldByName('GGB006').AsString+' 品名：'+FieldByName('GGB007').AsString+ ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat)  //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//            + ' 价税合计:' + FormatFloat(mFmtStr12, FieldByName('GGB024').AsFloat));
//20121225 mark by 603744 for Z30-12121700001 end=======================
      end;
      if xTpye = '2' then
      begin
        GetXiaoShouFaPiao(cur_node, '35', fieldbyname('GGB001').AsString, fieldbyname('GGB002').AsString, '3');
        GetShouKuanHeXiaoDan(cur_node, '35', fieldbyname('GGB001').AsString, fieldbyname('GGB002').AsString, '1');
        GetShouKuanDan(cur_node, '35', fieldbyname('GGB001').AsString, fieldbyname('GGB002').AsString);
        prgBar.Position := prgBar.Position + (1 / (RecordCount * 8) * 100); //20220523 modi by 11245 for X-1001321 优化
      end
      else if xTpye = '3' then
      begin
        GetHongZiXiaoShouFaPiao(cur_node, '59', fieldbyname('GGA035').AsString, fieldbyname('GGC002').AsString, '2');
        GetShouKuanDan(cur_node, '59', fieldbyname('GGC001').AsString, fieldbyname('GGC002').AsString);
        GetShouKuanHeXiaoDan(cur_node, '59', fieldbyname('GGC001').AsString, fieldbyname('GGC002').AsString, '1');
      end
      else
      begin
        GetHongZiXiaoShouFaPiao(cur_node, '59', fieldbyname('GGA035').AsString, fieldbyname('GGB002').AsString, '2');
        GetShouKuanDan(cur_node, '59', fieldbyname('GGB001').AsString, fieldbyname('GGB002').AsString);
        GetShouKuanHeXiaoDan(cur_node, '59', fieldbyname('GGB001').AsString, fieldbyname('GGB002').AsString, '1');
      end;
      Next;
    end;
  finally
    Free;
  end;

end;

procedure TfrmCOPDR28.GetHongZiXiaoShouFaPiao(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao, xType: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
  if xType = '1' then
  begin
//    mSQL := 'select * from YSFGGA left join YSFGGB on GGA001=GGB001  where  GGA035='''' and  GGA002=''F'' and  GGB003=' +//20220523 modi by 11245 for X-1001321 优化
    mSQL := 'select GGA032,GGB001,GGB002,GGA005,GGB006,GGB007,GGB031,GGB010,GGB024 ' +
      ' ,GGA018 ' + //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
      ' from YSFGGA left join YSFGGB on GGA001=GGB001  where  GGA035='''' and  GGA002=''F'' and  GGB003=' + //20220523 modi by 11245 for X-1001321 优化
      quotedstr(xLaiYuan) + ' and GGB004=' + quotedstr(xDanHao);
    if xXUHao <> '' then
      mSQL := mSQL + ' and GGB005=' + quotedstr(xXUHao);
  end
  else if xType = '2' then
//    mSQL := 'select * from YSFGGA left join YSFGGB on GGA001=GGB001  where GGA002=''F'' and  GGB001=' + //20220523 modi by 11245 for X-1001321 优化
    mSQL := 'select GGA032,GGB001,GGB002,GGA005,GGB006,GGB007,GGB031,GGB010,GGB024 ' +
      ' ,GGA018 ' + //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
      ' from YSFGGA left join YSFGGB on GGA001=GGB001  where GGA002=''F'' and  GGB001=' + //20220523 modi by 11245 for X-1001321 优化
      quotedstr(xDanHao) + ' and GGB002=' + quotedstr(xXUHao);
  mSQL := mSQL + ' order by GGA005,GGA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '红字销售发票');
    First;
    while not Eof do
    begin
      if not FCost then
      begin
        //20121225 modi by 603744 for Z30-12121700001 begin===========================================================
        if FieldByName('GGA032').AsString = 'T' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGB001').AsString + ']' + '-' + fieldbyname('GGB002').AsString + ' ' +
          //TransDateOut(fieldbyname('GGA005').AsString, False) + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat))//20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//            TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat)//20190605 mark by 11245 for B11-190605004 增加规格显示
            TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString + ' 规格：' + FieldByName('GGB031').AsString + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat) //20190605 modi by 11245 for B11-190605004 增加规格显示
//            + ' 已审核')//20220915 mark by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
            + IIf(FieldByName('GGA018').AsString = '2', ' 作废', ' 已审核')) //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
        else if FieldByName('GGA032').AsString = 'F' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGB001').AsString + ']' + '-' + fieldbyname('GGB002').AsString + ' ' +
          //TransDateOut(fieldbyname('GGA005').AsString, False) + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat))//20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//            TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat)//20190605 mark by 11245 for B11-190605004 增加规格显示
            TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString + ' 规格：' + FieldByName('GGB031').AsString + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat) //20190605 modi by 11245 for B11-190605004 增加规格显示
//            + ' 未审核'); //20220915 mark by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
            + IIf(FieldByName('GGA018').AsString = '2', ' 作废', ' 未审核')); //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
        //20121225 modi by 603744 for Z30-12121700001 end===========================================================
//20121225 mark by 603744 for Z30-12121700001 begin=========================================================
//        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGB001').AsString + ']' + '-' + fieldbyname('GGB002').AsString + ' ' +
//          //TransDateOut(fieldbyname('GGA005').AsString, False) + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat))//20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat)) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//20121225 mark by 603744 for Z30-12121700001 end===========================================================
      end
      else
      begin
        //20121225 modi by 603744 for Z30-12121700001 begin===========================================================
        if FieldByName('GGA032').AsString = 'T' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGB001').AsString + ']' + '-' + fieldbyname('GGB002').AsString + ' ' +
          //TransDateOut(fieldbyname('GGA005').AsString, False) + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//            TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
            TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString + ' 规格：' + FieldByName('GGB031').AsString + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat) //20190605 modi by 11245 for B11-190605004 增加规格显示
            + ' 价税合计:' + FormatFloat(mFmtStr12, FieldByName('GGB024').AsFloat)
//            + ' 已审核') //20220915 mark by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
            + IIf(FieldByName('GGA018').AsString = '2', ' 作废', ' 已审核')) //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
        else if FieldByName('GGA032').AsString = 'F' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGB001').AsString + ']' + '-' + fieldbyname('GGB002').AsString + ' ' +
          //TransDateOut(fieldbyname('GGA005').AsString, False) + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//            TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
            TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString + ' 规格：' + FieldByName('GGB031').AsString + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat) //20190605 modi by 11245 for B11-190605004 增加规格显示
            + ' 价税合计:' + FormatFloat(mFmtStr12, FieldByName('GGB024').AsFloat)
//            + ' 未审核'); //20220915 mark by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
            + IIf(FieldByName('GGA018').AsString = '2', ' 作废', ' 已审核')) //20220915 modi by 11245 for x-1001126 作废则不显示已审核未审核，只显示作废
        //20121225 modi by 603744 for Z30-12121700001 end=================================================================
//20121225 mark by 603744 for Z30-12121700001 begin=======================================================================
//        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GGB001').AsString + ']' + '-' + fieldbyname('GGB002').AsString + ' ' +
//          //TransDateOut(fieldbyname('GGA005').AsString, False) + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('GGA005').AsString, False) + ' 品号：' + FieldByName('GGB006').AsString + ' 品名：' + FieldByName('GGB007').AsString + ' 发票数量:' + FormatFloat(mFmtStr10, FieldByName('GGB010').AsFloat) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          + ' 价税合计:' + FormatFloat(mFmtStr12, FieldByName('GGB024').AsFloat));
//20121225 mark by 603744 for Z30-12121700001 end============================================================================
      end;
      GetShouKuanDan(cur_node, '60', fieldbyname('GGB001').AsString, fieldbyname('GGB002').AsString);
      GetShouKuanHeXiaoDan(cur_node, '60', fieldbyname('GGB001').AsString, fieldbyname('GGB002').AsString, '1');
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.GetShouKuanDan(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL, mSQL1: string;
begin
//  mSQL := 'select * from YSFGDA left join YSFGDC on GDA001=GDC001  where GDA040=''T'' and  GDC004=' +//20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select GDC019,GDC001,GDC002,GDA003,GDC008'+
          ',GDA005,GDA001 '+ //20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
          ' from YSFGDA left join YSFGDC on GDA001=GDC001  where GDA040=''T'' and  GDC004=' + //20220523 modi by 11245 for X-1001321 优化
    quotedstr(xLaiYuan) + ' and GDC005=' + quotedstr(xDanHao) + ' and GDC046=' + quotedstr(xXUHao);
//  mSQL1 := 'select * from YSFGDA left join YSFGDC on GDA001=GDC001  where GDA040<>''T'' and  GDC004=' +//20220523 modi by 11245 for X-1001321 优化
  mSQL1 := 'select GDC019,GDC001,GDC002,GDA003,GDC008'+
           ',GDA005,GDA001 '+ //20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号 
           ' from YSFGDA left join YSFGDC on GDA001=GDC001  where GDA040<>''T'' and  GDC004=' + //20220523 modi by 11245 for X-1001321 优化
    quotedstr(xLaiYuan) + ' and GDC005=' + quotedstr(xDanHao);
  mSQL := mSQL + ' union All ' + mSQL1;
  mSQL1 := 'select * from ('+mSQL + ') A order by GDA005,GDA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '收款单');
    First;
    while not Eof do
    begin
      if not FCost then
      begin
        //20121225 modi by 603744 for Z30-12121700001 begin=================
        if FieldByName('GDC019').AsString = 'T' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GDC001').AsString + ']' + '-' + fieldbyname('GDC002').AsString + ' ' +
            TransDateOut(fieldbyname('GDA003').AsString, False)
            + ' 已审核')
        else if FieldByName('GDC019').AsString = 'F' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GDC001').AsString + ']' + '-' + fieldbyname('GDC002').AsString + ' ' +
            TransDateOut(fieldbyname('GDA003').AsString, False)
            + ' 未审核');
        //20121225 modi by 603744 for Z30-12121700001 end==================
//20121225 mark by 603744 for Z30-12121700001 begin===============
//        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GDC001').AsString + ']' + '-' + fieldbyname('GDC002').AsString + ' ' +
//          TransDateOut(fieldbyname('GDA003').AsString, False));
//20121225 mark by 603744 for Z30-12121700001 end================
      end
      else
      begin
        //20121225 modi by 603744 for Z30-12121700001 begin=================
        if FieldByName('GDC019').AsString = 'T' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GDC001').AsString + ']' + '-' + fieldbyname('GDC002').AsString + ' ' +
            TransDateOut(fieldbyname('GDA003').AsString, False) + ' 收款金额:' + FormatFloat(mFmtStr12, FieldByName('GDC008').AsFloat)
            + ' 已审核')
        else if FieldByName('GDC019').AsString = 'F' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GDC001').AsString + ']' + '-' + fieldbyname('GDC002').AsString + ' ' +
            TransDateOut(fieldbyname('GDA003').AsString, False) + ' 收款金额:' + FormatFloat(mFmtStr12, FieldByName('GDC008').AsFloat)
            + ' 未审核');
        //20121225 modi by 603744 for Z30-12121700001 end=================
//20121225 mark by 603744 for Z30-12121700001 begin=========================
//        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GDC001').AsString + ']' + '-' + fieldbyname('GDC002').AsString + ' ' +
//          TransDateOut(fieldbyname('GDA003').AsString, False) + ' 收款金额:' + FormatFloat(mFmtStr12, FieldByName('GDC008').AsFloat));
//20121225 mark by 603744 for Z30-12121700001 end========================
      end;
      GetKeHuDaoKuanHeXiaoDanShouKuan(cur_node, '54', fieldbyname('GDC001').AsString, fieldbyname('GDC002').AsString);
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.GetShouKuanHeXiaoDan(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao, xtype: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
  if xtype = '1' then
  begin
//    mSQL := 'select * from YSFGHA left join YSFGHC on GHA001=GHC001  where GHC003=' +//20220523 modi by 11245 for X-1001321 优化
    mSQL := 'select GHC033,GHC001,GHC002,GHC014,GHA004 from YSFGHA left join YSFGHC on GHA001=GHC001  where GHC003=' + //20220523 modi by 11245 for X-1001321 优化
      quotedstr(xLaiYuan) + ' and GHC004=' + quotedstr(xDanHao);
    mSQL := mSQL + ' order by GHA004,GHA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
    with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
    try
      if not IsEmpty then
        root_node := tvMain.Items.AddChild(xnode, '收款核销单');
      First;
      while not Eof do
      begin
        if not FCost then
        begin
          //20121225 modi by 603744 for Z30-12121700001 begin=============
          if FieldByName('GHC033').AsString = 'T' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GHC001').AsString + ']' + '-' + fieldbyname('GHC002').AsString + ' ' +
//              TransDateOut(fieldbyname('GHC004').AsString, False) //20230328 mark by 11245 for B-1001603 收款核销单日期字段用错，应该是GHC006而不是GHC004
              TransDateOut(fieldbyname('GHA004').AsString, False)//20230328 modi by 11245 for B-1001603 收款核销单日期字段用错，应该是GHC006而不是GHC004
              + ' 已审核')
          else if FieldByName('GHC033').AsString = 'F' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GHC001').AsString + ']' + '-' + fieldbyname('GHC002').AsString + ' ' +
//              TransDateOut(fieldbyname('GHC004').AsString, False) //20230328 mark by 11245 for B-1001603 收款核销单日期字段用错，应该是GHC006而不是GHC004
              TransDateOut(fieldbyname('GHA004').AsString, False) //20230328 modi by 11245 for B-1001603 收款核销单日期字段用错，应该是GHC006而不是GHC004
              + ' 未审核');
          //20121225 modi by 603744 for Z30-12121700001 end================
//20121225 mark by 603744 for Z30-12121700001 begin====================
//          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GHC001').AsString + ']' + '-' + fieldbyname('GHC002').AsString + ' ' +
//            TransDateOut(fieldbyname('GHC004').AsString, False));
//20121225 mark by 603744 for Z30-12121700001 end=======================
        end
        else
        begin
          //20121225 modi by 603744 for Z30-12121700001 begin=================
          if FieldByName('GHC033').AsString = 'T' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GHC001').AsString + ']' + '-' + fieldbyname('GHC002').AsString + ' ' +
//              TransDateOut(fieldbyname('GHC004').AsString, False) + ' 实收金额:' + FormatFloat(mFmtStr12, FieldByName('GHC014').AsFloat) //20230328 mark by 11245 for B-1001603 收款核销单日期字段用错，应该是GHC006而不是GHC004
              TransDateOut(fieldbyname('GHA004').AsString, False) + ' 实收金额:' + FormatFloat(mFmtStr12, FieldByName('GHC014').AsFloat) //20230328 modi by 11245 for B-1001603 收款核销单日期字段用错，应该是GHC006而不是GHC004
              + ' 已审核')
          else if FieldByName('GHC033').AsString = 'F' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GHC001').AsString + ']' + '-' + fieldbyname('GHC002').AsString + ' ' +
//              TransDateOut(fieldbyname('GHC004').AsString, False) + ' 实收金额:' + FormatFloat(mFmtStr12, FieldByName('GHC014').AsFloat) //20230328 mark by 11245 for B-1001603 收款核销单日期字段用错，应该是GHC006而不是GHC004
              TransDateOut(fieldbyname('GHA004').AsString, False) + ' 实收金额:' + FormatFloat(mFmtStr12, FieldByName('GHC014').AsFloat)//20230328 modi by 11245 for B-1001603 收款核销单日期字段用错，应该是GHC006而不是GHC004
              + ' 未审核');
          //20121225 modi by 603744 for Z30-12121700001 end======================
//20121225 mark by 603744 for Z30-12121700001 begin==================
//          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('GHC001').AsString + ']' + '-' + fieldbyname('GHC002').AsString + ' ' +
//            TransDateOut(fieldbyname('GHC004').AsString, False) + ' 实收金额:' + FormatFloat(mFmtStr12, FieldByName('GHC014').AsFloat));
//20121225 mark by 603744 for Z30-12121700001 end===================
        end;
        Next;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TfrmCOPDR28.GetKeHuDaoKuanHeXiaoDanShouKuan(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from JSKKFC left join JSKKFD on KFC001=KFD001  where KFD003=' + //20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select KFD018,KFD001,KFD002,KFC002,KFD013 from JSKKFC left join JSKKFD on KFC001=KFD001  where KFD003=' + //20220523 modi by 11245 for X-1001321 优化
    quotedstr(xLaiYuan) + ' and KFD004=' + quotedstr(xDanHao);
  mSQL := mSQL + ' order by KFC002,KFC001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '客户到款核销单');
    First;
    while not Eof do
    begin
      if not FCost then
      begin
        //20121225 modi by 603744 for Z30-12121700001 begin=====================
        if FieldByName('KFD018').AsString = 'T' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFD001').AsString + ']' + '-' + fieldbyname('KFD002').AsString + ' ' +
            TransDateOut(fieldbyname('KFC002').AsString, False)
            + ' 已审核')
        else if FieldByName('KFD018').AsString = 'F' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFD001').AsString + ']' + '-' + fieldbyname('KFD002').AsString + ' ' +
            TransDateOut(fieldbyname('KFC002').AsString, False)
            + ' 未审核');
        //20121225 modi by 603744 for Z30-12121700001 end========================
//20121225 mark by 603744 for Z30-12121700001 begin=====================
//        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFD001').AsString + ']' + '-' + fieldbyname('KFD002').AsString + ' ' +
//          TransDateOut(fieldbyname('KFC002').AsString, False));
//20121225 mark by 603744 for Z30-12121700001 end=====================
      end
      else
      begin
        //20121225 modi by 603744 for Z30-12121700001 begin=========================
        if FieldByName('KFD018').AsString = 'T' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFD001').AsString + ']' + '-' + fieldbyname('KFD002').AsString + ' ' +
            TransDateOut(fieldbyname('KFC002').AsString, False) + ' 单据金额:' + FormatFloat(mFmtStr12, FieldByName('KFD013').AsFloat)
            + ' 已审核')
        else if FieldByName('KFD018').AsString = 'F' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFD001').AsString + ']' + '-' + fieldbyname('KFD002').AsString + ' ' +
            TransDateOut(fieldbyname('KFC002').AsString, False) + ' 单据金额:' + FormatFloat(mFmtStr12, FieldByName('KFD013').AsFloat)
            + ' 未审核');
        //20121225 modi by 603744 for Z30-12121700001 end===========================
//20121225 mark by 603744 for Z30-12121700001 begin===============
//        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFD001').AsString + ']' + '-' + fieldbyname('KFD002').AsString + ' ' +
//          TransDateOut(fieldbyname('KFC002').AsString, False) + ' 单据金额:' + FormatFloat(mFmtStr12, FieldByName('KFD013').AsFloat));
//20121225 mark by 603744 for Z30-12121700001 end=================
      end;
      Next;
    end;
  finally
    Free;
  end;

end;

procedure TfrmCOPDR28.GetKeHuDaoKuanHeXiaoDan(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from JSKKFC left join JSKKFE on KFC001=KFE001  where KFE003=' +//20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select KFE016,KFE001,KFE002,KFC002,KFE014 from JSKKFC left join JSKKFE on KFC001=KFE001  where KFE003=' + //20220523 modi by 11245 for X-1001321 优化
    quotedstr(xLaiYuan) + ' and KFE004=' + quotedstr(xDanHao);
  mSQL := mSQL + ' order by KFC002,KFC001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号  
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '客户到款核销单')
     //20220523 modi by 11245 for X-1001321 优化 ==begin==
    else
      if xLaiYuan = '32' then
        prgBar.Position := 3 / 8 * 100;
    //20220523 modi by 11245 for X-1001321 优化 ==end==
    First;
    while not Eof do
    begin
      if not FCost then
      begin
        //20121225 modi by 603744 for Z30-12121700001 begin==================================================================
        if FieldByName('KFE016').AsString = 'T' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFE001').AsString + ']' + '-' + fieldbyname('KFE002').AsString + ' ' +
            TransDateOut(fieldbyname('KFC002').AsString, False)
            + ' 已审核')
        else if FieldByName('KFE016').AsString = 'F' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFE001').AsString + ']' + '-' + fieldbyname('KFE002').AsString + ' ' +
            TransDateOut(fieldbyname('KFC002').AsString, False)
            + ' 未审核');
        //20121225 modi by 603744 for Z30-12121700001 end====================================================================
//20121225 mark by 603744 for Z30-12121700001 begin============================
//        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFE001').AsString + ']' + '-' + fieldbyname('KFE002').AsString + ' ' +
//          TransDateOut(fieldbyname('KFC002').AsString, False));
//20121225 mark by 603744 for Z30-12121700001 end=============================
      end
      else
      begin
        //20121225 modi by 603744 for Z30-12121700001 begin==============
        if FieldByName('KFE016').AsString = 'T' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFE001').AsString + ']' + '-' + fieldbyname('KFE002').AsString + ' ' +
            TransDateOut(fieldbyname('KFC002').AsString, False) + ' 冲账金额:' + FormatFloat(mFmtStr12, FieldByName('KFE014').AsFloat)
            + ' 已审核')
        else if FieldByName('KFE016').AsString = 'F' then
          cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFE001').AsString + ']' + '-' + fieldbyname('KFE002').AsString + ' ' +
            TransDateOut(fieldbyname('KFC002').AsString, False) + ' 冲账金额:' + FormatFloat(mFmtStr12, FieldByName('KFE014').AsFloat)
            + ' 未审核');
        //20121225 modi by 603744 for Z30-12121700001 end===============
//20121225 mark by 603744 for Z30-12121700001 begin=========================
//        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KFE001').AsString + ']' + '-' + fieldbyname('KFE002').AsString + ' ' +
//          TransDateOut(fieldbyname('KFC002').AsString, False) + ' 冲账金额:' + FormatFloat(mFmtStr12, FieldByName('KFE014').AsFloat));
//20121225 mark by 603744 for Z30-12121700001 end===========================
      end;
      //20220523 modi by 11245 for X-1001321 优化 ==begin==
      if xLaiYuan = '32' then
        prgBar.Position := prgBar.Position + (1 / (RecordCount * 8) * 100);
      //20220523 modi by 11245 for X-1001321 优化 ==end==
      Next;
    end;
  finally
    Free;
  end;

end;

procedure TfrmCOPDR28.GetHongZiWeiTuoJieSuanDan(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from JSKKJA left join JSKKJB on KJA001=KJB001  where KJB003=' + //20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select KJA016,KJB001,KJB002,KJA003,KJB006,KJB007,KJB035,KJB011,KJB036 from JSKKJA left join JSKKJB on KJA001=KJB001  where KJB003=' + //20220523 modi by 11245 for X-1001321 优化
    quotedstr(xLaiYuan) + ' and KJB004=' + quotedstr(xDanHao);
  if xXUHao <> '' then
    mSQL := mSQL + ' and KJB005=' + quotedstr(xXUHao);
    mSQL := mSQL + ' order by KJA003,KJA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '红字委托结算');
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin==================================================
      if FieldByName('KJA016').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KJB001').AsString + ']' + '-' + fieldbyname('KJB002').AsString + ' ' +
        //TransDateOut(fieldbyname('KJA003').AsString, False) + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KJB011').AsFloat) +//20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('KJA003').AsString, False) + ' 品号：' + FieldByName('KJB006').AsString + ' 品名：' + FieldByName('KJB007').AsString + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KJB011').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
          TransDateOut(fieldbyname('KJA003').AsString, False) + ' 品号：' + FieldByName('KJB006').AsString + ' 品名：' + FieldByName('KJB007').AsString + ' 规格：' + FieldByName('KJB035').AsString + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KJB011').AsFloat) + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 已开票数量:' + FormatFloat(mFmtStr10, FieldByName('KJB036').AsFloat)
          + ' 已审核')
      else if FieldByName('KJA016').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KJB001').AsString + ']' + '-' + fieldbyname('KJB002').AsString + ' ' +
        //TransDateOut(fieldbyname('KJA003').AsString, False) + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KJB011').AsFloat) +//20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('KJA003').AsString, False) + ' 品号：' + FieldByName('KJB006').AsString + ' 品名：' + FieldByName('KJB007').AsString + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KJB011').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
          TransDateOut(fieldbyname('KJA003').AsString, False) + ' 品号：' + FieldByName('KJB006').AsString + ' 品名：' + FieldByName('KJB007').AsString + ' 规格：' + FieldByName('KJB035').AsString + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KJB011').AsFloat) + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 已开票数量:' + FormatFloat(mFmtStr10, FieldByName('KJB036').AsFloat)
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 end======================================================
//20121225 mark by 603744 for Z30-12121700001 begin========================================================
//      cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KJB001').AsString + ']' + '-' + fieldbyname('KJB002').AsString + ' ' +
//        //TransDateOut(fieldbyname('KJA003').AsString, False) + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KJB011').AsFloat) +//20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        TransDateOut(fieldbyname('KJA003').AsString, False) + ' 品号：' + FieldByName('KJB006').AsString + ' 品名：' + FieldByName('KJB007').AsString + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KJB011').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        ' 已开票数量:' + FormatFloat(mFmtStr10, FieldByName('KJB036').AsFloat));
//20121225 mark by 603744 for Z30-12121700001 end==========================================================
      GetXiaoShouFaPiao(cur_node, '38', fieldbyname('KJB001').AsString, fieldbyname('KJB002').AsString);
      GetHongZiXiaoShouFaPiao(cur_node, '38', fieldbyname('KJB001').AsString, fieldbyname('KJB002').AsString, '1');
      GetKeHuDaoKuanHeXiaoDan(cur_node, '38', fieldbyname('KJB001').AsString, '');
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.GetWeiTuoJieSuanDan(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from JSKKIA left join JSKKIB on KIA001=KIB001  where KIB003=' +//20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select KIA016,KIB001,KIB002,KIA003,KIB006,KIB007,KIB035,KIB011,KIB036 from JSKKIA left join JSKKIB on KIA001=KIB001  where KIB003=' + //20220523 modi by 11245 for X-1001321 优化
    quotedstr(xLaiYuan) + ' and KIB004=' + quotedstr(xDanHao);
  if xXUHao <> '' then
    mSQL := mSQL + ' and KIB005=' + quotedstr(xXUHao);
  mSQL := mSQL + ' order by KIA003,KIA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号  
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '委托结算');
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin==============
      if FieldByName('KIA016').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KIB001').AsString + ']' + '-' + fieldbyname('KIB002').AsString + ' ' +
        //TransDateOut(fieldbyname('KIA003').AsString, False) + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KIB011').AsFloat) +//20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('KIA003').AsString, False) + ' 品号：' + FieldByName('KIB006').AsString + ' 品名：' + FieldByName('KIB007').AsString + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KIB011').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示 //20190605 mark by 11245 for B11-190605004 增加规格显示
          TransDateOut(fieldbyname('KIA003').AsString, False) + ' 品号：' + FieldByName('KIB006').AsString + ' 品名：' + FieldByName('KIB007').AsString + ' 规格：' + FieldByName('KIB035').AsString + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KIB011').AsFloat) + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 已开票数量:' + FormatFloat(mFmtStr10, FieldByName('KIB036').AsFloat)
          + ' 已审核')
      else if FieldByName('KIA016').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KIB001').AsString + ']' + '-' + fieldbyname('KIB002').AsString + ' ' +
        //TransDateOut(fieldbyname('KIA003').AsString, False) + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KIB011').AsFloat) +//20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('KIA003').AsString, False) + ' 品号：' + FieldByName('KIB006').AsString + ' 品名：' + FieldByName('KIB007').AsString + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KIB011').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示 //20190605 mark by 11245 for B11-190605004 增加规格显示
          TransDateOut(fieldbyname('KIA003').AsString, False) + ' 品号：' + FieldByName('KIB006').AsString + ' 品名：' + FieldByName('KIB007').AsString + ' 规格：' + FieldByName('KIB035').AsString + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KIB011').AsFloat) + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 已开票数量:' + FormatFloat(mFmtStr10, FieldByName('KIB036').AsFloat)
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 end=====================
//20121225 mark by 603744 for Z30-12121700001 begin================
//      cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('KIB001').AsString + ']' + '-' + fieldbyname('KIB002').AsString + ' ' +
//        //TransDateOut(fieldbyname('KIA003').AsString, False) + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KIB011').AsFloat) +//20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        TransDateOut(fieldbyname('KIA003').AsString, False) + ' 品号：' + FieldByName('KIB006').AsString + ' 品名：' + FieldByName('KIB007').AsString + ' 结算数量:' + FormatFloat(mFmtStr10, FieldByName('KIB011').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        ' 已开票数量:' + FormatFloat(mFmtStr10, FieldByName('KIB036').AsFloat));
//20121225 mark by 603744 for Z30-12121700001 end====================
      GetXiaoShouFaPiao(cur_node, '36', fieldbyname('KIB001').AsString, fieldbyname('KIB002').AsString);
      GetKeHuDaoKuanHeXiaoDan(cur_node, '36', fieldbyname('KIB001').AsString, '');
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.GetCaiGouDiGao(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from DCSHCA left join DCSHCB on HCA001=HCB001  where HCB016=' +//20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select HCB020,HCB001,HCB002,HCA003,HCB003,HCB004,HCB040,HCB006,HCB041 from DCSHCA left join DCSHCB on HCA001=HCB001  where HCB016=' + //20220523 modi by 11245 for X-1001321 优化
    quotedstr(xLaiYuan) + ' and HCB017=' + quotedstr(xDanHao);
  if xXUHao <> '' then
    mSQL := mSQL + ' and HCB018=' + quotedstr(xXUHao);
  mSQL := mSQL + ' order by HCA003,HCA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '采购底稿')
     //20220523 modi by 11245 for X-1001321 优化 ==begin==
    else
      if xLaiYuan = '32' then
        prgBar.Position := 4 / 8 * 100;
    //20220523 modi by 11245 for X-1001321 优化 ==end==
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin======================================
      if FieldByName('HCB020').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('HCB001').AsString + ']' + '-' + fieldbyname('HCB002').AsString + ' ' +
        //TransDateOut(fieldbyname('HCA003').AsString, False) + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HCB006').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('HCA003').AsString, False) + ' 品号：' + FieldByName('HCB003').AsString + ' 品名：' + FieldByName('HCB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HCB006').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
          TransDateOut(fieldbyname('HCA003').AsString, False) + ' 品号：' + FieldByName('HCB003').AsString + ' 品名：' + FieldByName('HCB004').AsString + ' 规格：' + FieldByName('HCB040').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HCB006').AsFloat) + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 已采量:' + FormatFloat(mFmtStr10, FieldByName('HCB041').AsFloat)
          + ' 已审核')
      else if FieldByName('HCB020').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('HCB001').AsString + ']' + '-' + fieldbyname('HCB002').AsString + ' ' +
        //TransDateOut(fieldbyname('HCA003').AsString, False) + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HCB006').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('HCA003').AsString, False) + ' 品号：' + FieldByName('HCB003').AsString + ' 品名：' + FieldByName('HCB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HCB006').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
          TransDateOut(fieldbyname('HCA003').AsString, False) + ' 品号：' + FieldByName('HCB003').AsString + ' 品名：' + FieldByName('HCB004').AsString + ' 规格：' + FieldByName('HCB040').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HCB006').AsFloat) + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 已采量:' + FormatFloat(mFmtStr10, FieldByName('HCB041').AsFloat)
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 end==================================
//20121225 mark by 603744 for Z30-12121700001 begin==============================================
//      cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('HCB001').AsString + ']' + '-' + fieldbyname('HCB002').AsString + ' ' +
//        //TransDateOut(fieldbyname('HCA003').AsString, False) + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HCB006').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        TransDateOut(fieldbyname('HCA003').AsString, False) + ' 品号：' + FieldByName('HCB003').AsString + ' 品名：' + FieldByName('HCB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HCB006').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        ' 已采量:' + FormatFloat(mFmtStr10, FieldByName('HCB041').AsFloat));
//20121225 mark by 603744 for Z30-12121700001 end================================================
      GetCaiGouDan(cur_node, '13', fieldbyname('HCB001').AsString, fieldbyname('HCB002').AsString);
      //20220523 modi by 11245 for X-1001321 优化 ==begin==
      if xLaiYuan = '32' then
        prgBar.Position := prgBar.Position + (1 / (RecordCount * 8) * 100);
      //20220523 modi by 11245 for X-1001321 优化 ==end==
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.GetCaiGouDan(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from DCSHDA left join DCSHDB on HDA001=HDB001  where  HDB016=' + quotedstr(xDanHao);//20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select HDB017,HDB019,HDB001,HDB003,HDB004,HDB002,HDB040,HDB006,HDA003,HDB018 from DCSHDA left join DCSHDB on HDA001=HDB001  where  HDB016=' + quotedstr(xDanHao); //20220523 modi by 11245 for X-1001321 优化
  if xXUHao <> '' then
    mSQL := mSQL + ' and HDB017=' + quotedstr(xXUHao);
  mSQL := mSQL + ' order by HDA003,HDA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '采购单');
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin==============================
      if FieldByName('HDB019').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('HDB001').AsString + ']' + '-' + fieldbyname('HDB002').AsString + ' ' +
        //TransDateOut(fieldbyname('HDA003').AsString, False) + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HDB006').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('HDA003').AsString, False) + ' 品号：' + FieldByName('HDB003').AsString + ' 品名：' + FieldByName('HDB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HDB006').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
          TransDateOut(fieldbyname('HDA003').AsString, False) + ' 品号：' + FieldByName('HDB003').AsString + ' 品名：' + FieldByName('HDB004').AsString + ' 规格：' + FieldByName('HDB040').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HDB006').AsFloat) + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 已交量:' + FormatFloat(mFmtStr10, FieldByName('HDB018').AsFloat)
          + ' 已审核')
      else if FieldByName('HDB019').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('HDB001').AsString + ']' + '-' + fieldbyname('HDB002').AsString + ' ' +
        //TransDateOut(fieldbyname('HDA003').AsString, False) + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HDB006').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('HDA003').AsString, False) + ' 品号：' + FieldByName('HDB003').AsString + ' 品名：' + FieldByName('HDB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HDB006').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
          TransDateOut(fieldbyname('HDA003').AsString, False) + ' 品号：' + FieldByName('HDB003').AsString + ' 品名：' + FieldByName('HDB004').AsString + ' 规格：' + FieldByName('HDB040').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HDB006').AsFloat) + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 已交量:' + FormatFloat(mFmtStr10, FieldByName('HDB018').AsFloat)
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 end================================
//20121225 mark by 603744 for Z30-12121700001 begin============================================
//      cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('HDB001').AsString + ']' + '-' + fieldbyname('HDB002').AsString + ' ' +
//        //TransDateOut(fieldbyname('HDA003').AsString, False) + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HDB006').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        TransDateOut(fieldbyname('HDA003').AsString, False) + ' 品号：' + FieldByName('HDB003').AsString + ' 品名：' + FieldByName('HDB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HDB006').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        ' 已交量:' + FormatFloat(mFmtStr10, FieldByName('HDB018').AsFloat));
//20121225 mark by 603744 for Z30-12121700001 end=============================================
      Next;
    end;
  finally
    Free;
  end;

end;

procedure TfrmCOPDR28.GetShengChanJiHua(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from SGMSAA left join SGMSAB on SAA001=SAB001  where  SAB020=' + quotedstr(xLaiYuan) +//20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select SAB019,SAB001,SAB002,SAB003,SAB004,SAB005,SAB007 from SGMSAA left join SGMSAB on SAA001=SAB001  where  SAB020=' + quotedstr(xLaiYuan) + //20220523 modi by 11245 for X-1001321 优化
    ' and SAB021=' + quotedstr(xDanHao);
  if xXUHao <> '' then
    mSQL := mSQL + ' and SAB022=' + quotedstr(xXUHao);
  mSQL := mSQL + ' order by SAA003,SAA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '生产计划')
       //20220523 modi by 11245 for X-1001321 优化 ==begin==
    else
      if xLaiYuan = '32' then
        prgBar.Position := 5 / 8 * 100;
    //20220523 modi by 11245 for X-1001321 优化 ==end==
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin==========================
      if FieldByName('SAB019').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('SAB001').AsString + ']' + '-' + fieldbyname('SAB002').AsString +
        //' 计划数量:' + FormatFloat(mFmtStr10, FieldByName('SAB007').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          ' 品号：' + FieldByName('SAB003').AsString + ' 品名：' + FieldByName('SAB004').AsString + ' 计划数量:' + FormatFloat(mFmtStr10, FieldByName('SAB007').AsFloat)//20190605 mark by 11245 for B11-190605004 增加规格显示
          ' 品号：' + FieldByName('SAB003').AsString + ' 品名：' + FieldByName('SAB004').AsString + ' 规格：' + FieldByName('SAB005').AsString + ' 计划数量:' + FormatFloat(mFmtStr10, FieldByName('SAB007').AsFloat) //20190605 modi by 11245 for B11-190605004 增加规格显示
          + ' 已审核')
      else if FieldByName('SAB019').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('SAB001').AsString + ']' + '-' + fieldbyname('SAB002').AsString +
        //' 计划数量:' + FormatFloat(mFmtStr10, FieldByName('SAB007').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          ' 品号：' + FieldByName('SAB003').AsString + ' 品名：' + FieldByName('SAB004').AsString + ' 计划数量:' + FormatFloat(mFmtStr10, FieldByName('SAB007').AsFloat)//20190605 mark by 11245 for B11-190605004 增加规格显示
          ' 品号：' + FieldByName('SAB003').AsString + ' 品名：' + FieldByName('SAB004').AsString + ' 规格：' + FieldByName('SAB005').AsString + ' 计划数量:' + FormatFloat(mFmtStr10, FieldByName('SAB007').AsFloat) //20190605 modi by 11245 for B11-190605004 增加规格显示
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 end==============================
//20121225 mark by 603744 for Z30-12121700001 begin==========================
//      cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('SAB001').AsString + ']' + '-' + fieldbyname('SAB002').AsString +
//        //' 计划数量:' + FormatFloat(mFmtStr10, FieldByName('SAB007').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        ' 品号：' + FieldByName('SAB003').AsString + ' 品名：' + FieldByName('SAB004').AsString + ' 计划数量:' + FormatFloat(mFmtStr10, FieldByName('SAB007').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//20121225 mark by 603744 for Z30-12121700001 end===========================
      GetGongDan(cur_node, '96', fieldbyname('SAB001').AsString, fieldbyname('SAB002').AsString, '3');
      GetWeiWaiDan(cur_node, '96', fieldbyname('SAB001').AsString, fieldbyname('SAB002').AsString, '3');
      GetWuLiaoXuQiu(cur_node, '96', fieldbyname('SAB001').AsString, fieldbyname('SAB002').AsString);
       //20220523 modi by 11245 for X-1001321 优化 ==begin==
      if xLaiYuan = '32' then
        prgBar.Position := prgBar.Position + (1 / (RecordCount * 8) * 100);
      //20220523 modi by 11245 for X-1001321 优化 ==end==
      Next;
    end;
  finally
    Free;
  end;

end;

procedure TfrmCOPDR28.GetGongDan(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXUHao: string; xTpye: string = '1');
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
  if xTpye = '1' then
  begin
    //mSQL := 'select * from SGMRAA  where  RAA025='''' and  RAA010=' + quotedstr(xLaiYuan) +
//    mSQL := 'select * from SGMRAA left join TPADEA on RAA015=DEA001  where  RAA025='''' and  RAA010=' + quotedstr(xLaiYuan) + //20121210 modi by 603744 for Z30-12120300002 //20220523 modi by 11245 for X-1001321 优化
    mSQL := 'select RAA024,RAA001,RAA015,DEA002,RAA040,RAA018,RAA019 from SGMRAA left join TPADEA on RAA015=DEA001  where  RAA025='''' and  RAA010=' + quotedstr(xLaiYuan) + //20220523 modi by 11245 for X-1001321 优化
      ' and RAA011=' + quotedstr(xDanHao) + ' and RAA012=' + quotedstr(xXUHao);
  end
  else if xTpye = '2' then
  begin
    //mSQL := 'select * from SGMRAA  where  RAA025=' + quotedstr(xLaiYuan) +
//    mSQL := 'select * from SGMRAA left join TPADEA on RAA015=DEA001  where  RAA025=' + quotedstr(xLaiYuan) + //20121210 modi by 603744 for Z30-12120300002 //20220523 modi by 11245 for X-1001321 优化
    mSQL := 'select RAA024,RAA001,RAA015,DEA002,RAA040,RAA018,RAA019 from SGMRAA left join TPADEA on RAA015=DEA001  where  RAA025=' + quotedstr(xLaiYuan) + //20220523 modi by 11245 for X-1001321 优化
      ' and RAA026=' + quotedstr(xDanHao) + ' and RAA027=' + quotedstr(xXUHao);
  end
  else if xTpye = '3' then
  begin
    //mSQL := 'select * from SGMRAA  where  RAA010=' + quotedstr(xLaiYuan) +
//    mSQL := 'select * from SGMRAA left join TPADEA on RAA015=DEA001  where  RAA025='''' and RAA010=' + quotedstr(xLaiYuan) + //20121210 modi by 603744 for Z30-12120300002    //20161012 modi by 01296 for b10-161011001 //20220523 modi by 11245 for X-1001321 优化
    mSQL := 'select RAA024,RAA001,RAA015,DEA002,RAA040,RAA018,RAA019 from SGMRAA left join TPADEA on RAA015=DEA001  where  RAA025='''' and RAA010=' + quotedstr(xLaiYuan) + //20220523 modi by 11245 for X-1001321 优化
      ' and RAA011=' + quotedstr(xDanHao) + ' and RAA012=' + quotedstr(xXUHao);
  end;
  mSQL := mSQL + ' order by RAA003,RAA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '工单')
      //20220523 modi by 11245 for X-1001321 优化 ==begin==
    else
      if xLaiYuan = '32' then
        prgBar.Position := 7 / 8 * 100;
    //20220523 modi by 11245 for X-1001321 优化 ==end==
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin=============================================
      if FieldByName('RAA024').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RAA001').AsString + ']' +
          ' 品号：' + fieldbyname('RAA015').AsString + ' 品名：' + fieldbyname('DEA002').AsString + //20121210 modi by 603744 for Z30-12120300002
          ' 规格：' + fieldbyname('RAA040').AsString + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 工单数量:' + FormatFloat(mFmtStr10, FieldByName('RAA018').AsFloat) +
          ' 已生产数量:' + FormatFloat(mFmtStr10, FieldByName('RAA019').AsFloat)
          + ' 已审核')
      else if FieldByName('RAA024').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RAA001').AsString + ']' +
          ' 品号：' + fieldbyname('RAA015').AsString + ' 品名：' + fieldbyname('DEA002').AsString + //20121210 modi by 603744 for Z30-12120300002
          ' 规格：' + fieldbyname('RAA040').AsString + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 工单数量:' + FormatFloat(mFmtStr10, FieldByName('RAA018').AsFloat) +
          ' 已生产数量:' + FormatFloat(mFmtStr10, FieldByName('RAA019').AsFloat)
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 begin=================================================
//20121225 mark by 603744 for Z30-12121700001 begin=================================================
//      cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RAA001').AsString + ']' +
//        ' 品号：' + fieldbyname('RAA015').AsString + ' 品名：' + fieldbyname('DEA002').AsString + //20121210 modi by 603744 for Z30-12120300002
//        ' 工单数量:' + FormatFloat(mFmtStr10, FieldByName('RAA018').AsFloat) +
//        ' 已生产数量:' + FormatFloat(mFmtStr10, FieldByName('RAA019').AsFloat));
//20121225 mark by 603744 for Z30-12121700001 end=================================================
      GetGongDanGongYi(cur_node, '81', fieldbyname('RAA001').AsString, '');
       //20210112 modi by 11245 for P00-21010004 物料需求生单展开需要展开完整的生产路线 ==begin==
      GetLingLiaoDan(cur_node, '81', fieldbyname('RAA001').AsString, '');
      GetChaoHaoLingLiaoDan(cur_node, '81', fieldbyname('RAA001').AsString, '');
      GetChaoLingDan(cur_node, '81', fieldbyname('RAA001').AsString, ''); // 20221008 Add by liucb(01684) for x-1000722 增加超领单
      GetTuiLiao(cur_node, '81', fieldbyname('RAA001').AsString, ''); // 20240327 Add by liucb(01684) for b-1002683 增加退料单
      GetShengChanRuKuDan(cur_node, '81', fieldbyname('RAA001').AsString, '', 1);
      GetShengChanRuKuJianYanDan(cur_node, '81', fieldbyname('RAA001').AsString, '');
      GetChongGongDan(cur_node, '81', fieldbyname('RAA001').AsString, '');
      //20210112 modi by 11245 for P00-21010004 物料需求生单展开需要展开完整的生产路线 ==end==
       //20220523 modi by 11245 for X-1001321 优化 ==begin==
      if xLaiYuan = '32' then
        prgBar.Position := prgBar.Position + (1 / (RecordCount * 8) * 100);
      //20220523 modi by 11245 for X-1001321 优化 ==end==
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.GetWeiWaiDan(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXUHao: string; xTpye: string = '1');
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
  if xTpye = '1' then
  begin
    //mSQL := 'select * from SGMREA  where  REA048='''' and REA010=' + quotedstr(xLaiYuan) +
//    mSQL := 'select * from SGMREA left join TPADEA on REA015=DEA001  where  REA048='''' and REA010=' + quotedstr(xLaiYuan) + //20121210 modi by 603744 for Z30-12120300002 //20220523 modi by 11245 for X-1001321 优化
    mSQL := 'select REA047,REA001,REA015,DEA002,REA068,REA018,REA019 from SGMREA left join TPADEA on REA015=DEA001  where  REA048='''' and REA010=' + quotedstr(xLaiYuan) + //20220523 modi by 11245 for X-1001321 优化
      ' and REA011=' + quotedstr(xDanHao) + ' and REA012=' + quotedstr(xXUHao);
  end
  else if xTpye = '2' then
  begin
    //mSQL := 'select * from SGMREA  where  REA048=' + quotedstr(xLaiYuan) +
//    mSQL := 'select * from SGMREA left join TPADEA on REA015=DEA001  where  REA048=' + quotedstr(xLaiYuan) + //20121210 modi by 603744 for Z30-12120300002 //20220523 modi by 11245 for X-1001321 优化
    mSQL := 'select REA047,REA001,REA015,DEA002,REA068,REA018,REA019  from SGMREA left join TPADEA on REA015=DEA001  where  REA048=' + quotedstr(xLaiYuan) + //20220523 modi by 11245 for X-1001321 优化
      ' and REA049=' + quotedstr(xDanHao) + ' and REA050=' + quotedstr(xXUHao);
  end
  else if xTpye = '3' then
  begin
    //mSQL := 'select * from SGMREA  where  REA010=' + quotedstr(xLaiYuan) +
//    mSQL := 'select * from SGMREA left join TPADEA on REA015=DEA001  where  REA048='''' and REA010=' + quotedstr(xLaiYuan) + //20121210 modi by 603744 for Z30-12120300002  //20161012 modi by 01296  for b10-161011001 //20220523 modi by 11245 for X-1001321 优化
    mSQL := 'select REA047,REA001,REA015,DEA002,REA068,REA018,REA019 from SGMREA left join TPADEA on REA015=DEA001  where  REA048='''' and REA010=' + quotedstr(xLaiYuan) + //20220523 modi by 11245 for X-1001321 优化
      ' and REA011=' + quotedstr(xDanHao) + ' and REA012=' + quotedstr(xXUHao);
  end;
  mSQL := mSQL + ' order by REA003,REA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '委外单')
      //20220523 modi by 11245 for X-1001321 优化 ==begin==
    else
      if xLaiYuan = '32' then
        prgBar.Position := 8 / 8 * 100;
    //20220523 modi by 11245 for X-1001321 优化 ==end==
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin==============
      if FieldByName('REA047').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('REA001').AsString + ']' +
          ' 品号：' + fieldbyname('REA015').AsString + ' 品名：' + fieldbyname('DEA002').AsString + //20121210 modi by 603744 for Z30-12120300002
          ' 规格：' + fieldbyname('REA068').AsString + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 委外数量:' + FormatFloat(mFmtStr10, FieldByName('REA018').AsFloat) +
          ' 已完工量:' + FormatFloat(mFmtStr10, FieldByName('REA019').AsFloat)
          + ' 已审核')
      else if FieldByName('REA047').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('REA001').AsString + ']' +
          ' 品号：' + fieldbyname('REA015').AsString + ' 品名：' + fieldbyname('DEA002').AsString + //20121210 modi by 603744 for Z30-12120300002
          ' 规格：' + fieldbyname('REA068').AsString + //20190605 modi by 11245 for B11-190605004 增加规格显示
          ' 委外数量:' + FormatFloat(mFmtStr10, FieldByName('REA018').AsFloat) +
          ' 已完工量:' + FormatFloat(mFmtStr10, FieldByName('REA019').AsFloat)
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 end===============
//20121225 mark by 603744 for Z30-12121700001 begin===============
//      cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('REA001').AsString + ']' +
//        ' 品号：' + fieldbyname('REA015').AsString + ' 品名：' + fieldbyname('DEA002').AsString + //20121210 modi by 603744 for Z30-12120300002
//        ' 委外数量:' + FormatFloat(mFmtStr10, FieldByName('REA018').AsFloat) +
//        ' 已完工量:' + FormatFloat(mFmtStr10, FieldByName('REA019').AsFloat));
//20121225 mark by 603744 for Z30-12121700001 end==================
  //20210112 modi by 11245 for P00-21010004 物料需求生单展开需要展开完整的生产路线 ==BEGIN==
      GetWeiWaiSongLiaoDan(cur_node, '86', FieldByName('REA001').AsString, '');
      GetWeiWaiChaoHaoSongLiaoDan(cur_node, '86', FieldByName('REA001').AsString, '');
      GetWeiWaiChaoSongDan(cur_node, '86', FieldByName('REA001').AsString, ''); // 20221008 Add by liucb(01684) for x-1000722 增加超领单
      GetWeiWaiTuiLiaoDan(cur_node, '86', FieldByName('REA001').AsString, ''); // 20240327 Add by liucb(01684) for b-1002683 增加退料单
      GetWeiWaiShouLiaoDan(cur_node, '86', FieldByName('REA001').AsString, '');
      GetWeiWaiJinHuoDan(cur_node, '86', FieldByName('REA001').AsString, '');
      GetWeiWaiTuiHuoDan(cur_node, '86', FieldByName('REA001').AsString, ''); //20240820 modi by yangxun for B-1003014 增加委外退货单
      //20210112 modi by 11245 for P00-21010004 物料需求生单展开需要展开完整的生产路线 ==END==
       //20220523 modi by 11245 for X-1001321 优化 ==begin==
      if xLaiYuan = '32' then
        prgBar.Position := prgBar.Position + (1 / (RecordCount * 8) * 100);
      //20220523 modi by 11245 for X-1001321 优化 ==end==
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.GetWuLiaoXuQiu(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from SGMRIA  left join SGMRIB on RIA001=RIB001 where  RIB003=' + quotedstr(xLaiYuan) + //20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select RIB001,RIB002,RIA003,RIB006,RIB007,RIB040,RIB009,RIB036,RIB037 from SGMRIA  left join SGMRIB on RIA001=RIB001 where  RIB003=' + quotedstr(xLaiYuan) + //20220523 modi by 11245 for X-1001321 优化
    ' and RIB004=' + quotedstr(xDanHao);
  if xXUHao <> '' then
    mSQL := mSQL + ' and RIB005=' + quotedstr(xXUHao);
  mSQL := mSQL + ' order by RIA003,RIA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '物料需求')
      //20220523 modi by 11245 for X-1001321 优化 ==begin==
    else
      if xLaiYuan = '32' then
        prgBar.Position := 6 / 8 * 100;
    //20220523 modi by 11245 for X-1001321 优化 ==end==
    First;
    while not Eof do
    begin
      cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RIB001').AsString + ']' + '-' + fieldbyname('RIB002').AsString + ' ' +
        //TransDateOut(fieldbyname('RIA003').AsString, False) + ' 需求量:' + FormatFloat(mFmtStr10, FieldByName('RIB009').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        TransDateOut(fieldbyname('RIA003').AsString, False) + ' 品号：' + FieldByName('RIB006').AsString + ' 品名：' + FieldByName('RIB007').AsString + ' 需求量:' + FormatFloat(mFmtStr10, FieldByName('RIB009').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
        TransDateOut(fieldbyname('RIA003').AsString, False) + ' 品号：' + FieldByName('RIB006').AsString + ' 品名：' + FieldByName('RIB007').AsString + ' 规格：' + FieldByName('RIB040').AsString + ' 需求量:' + FormatFloat(mFmtStr10, FieldByName('RIB009').AsFloat)); //20190605 modi by 11245 for B11-190605004 增加规格显示
      //20130719 MODI BY 601394 FOR B11-130718001 订单合并跑物料需求查看单据不全                ==BEGIN==
//      GetGongDan(cur_node, '91', fieldbyname('RIB001').AsString, fieldbyname('RIB002').AsString, '2');
//      GetWeiWaiDan(cur_node, '91', fieldbyname('RIB001').AsString, fieldbyname('RIB002').AsString, '2');
//      GetCaiGouDiGao(cur_node, '91', fieldbyname('RIB001').AsString, fieldbyname('RIB002').AsString);
      //20130719 MODI BY 601394 FOR B11-130718001 订单合并跑物料需求查看单据不全                ==END==
      //20130719 ADD BY 601394 FOR B11-130718001 订单合并跑物料需求查看单据不全         ==BEGIN==
      if (fieldbyname('RIB036').AsString <> '') and (fieldbyname('RIB037').AsString <> '') then // 20221209 Add by liucb(01684) for b-1001298 排除异常数据
      begin
        GetGongDan2(cur_node, '91', fieldbyname('RIB036').AsString, fieldbyname('RIB037').AsString, xLaiYuan, xDanHao, xXUHao);
        GetWeiWaiDan2(cur_node, '91', fieldbyname('RIB036').AsString, fieldbyname('RIB037').AsString, xLaiYuan, xDanHao, xXUHao);
        GetCaiGouDiGao2(cur_node, '91', fieldbyname('RIB036').AsString, fieldbyname('RIB037').AsString, xLaiYuan, xDanHao, xXUHao);
      end;        
      //20130719 ADD BY 601394 FOR B11-130718001 订单合并跑物料需求查看单据不全         ==END==
       //20220523 modi by 11245 for X-1001321 优化 ==begin==
      if xLaiYuan = '32' then
        prgBar.Position := prgBar.Position + (1 / (RecordCount * 8) * 100);
      //20220523 modi by 11245 for X-1001321 优化 ==end==
      Next;
    end;
  finally
    Free;
  end;

end;

procedure TfrmCOPDR28.OpenWork(xName, xKeyfield, xkeyValue: string);
var
  mKeyName, mKeyValue: array of string;
  mValue: string;
  mOK: Boolean;
  i: Integer;
begin

  Decoder.SetReceiveValue('_Parent', Decoder.GetInfo(nnApp, 'Name'), True);
  Decoder.SetReceiveValue('_ParentLimit', Decoder.GetInfo(nnApp, 'AppPower'));
  Decoder.SetReceiveValue('_KeyCount', IntToStr(GetTokenCount(xKeyfield, ';')));

  mOK := True;
  SetLength(mKeyName, GetTokenCount(xKeyfield, ';'));
  for i := 1 to GetTokenCount(xKeyfield, ';') do
  begin
    mValue := GetToken(xKeyfield, ';', i);
    if mValue <> '' then
      Decoder.SetReceiveValue('_KeyName' + IntToStr(i), mValue)
    else
      mOK := False;
  end;

  SetLength(mKeyValue, GetTokenCount(xkeyValue, ';'));
  for i := 1 to GetTokenCount(xkeyValue, ';') do
  begin
    mValue := GetToken(xkeyValue, ';', i);
    if mValue <> '' then
      Decoder.SetReceiveValue('_KeyValue' + IntToStr(i), mValue)
    else
      mOK := False;
  end;

  if mOK then
    Decoder.OpenSubForm(xName, 2);

end;

procedure TfrmCOPDR28.tvMainDblClick(Sender: TObject);
var
  Node: TTreeNode;
  mDanJuLeiXing, mName, mKey, mDanHao: string;
begin
  inherited;
  Node := tvMain.Selected;
  if Node.Parent <> nil then
  begin
    mDanJuLeiXing := Node.Parent.Text;
    mDanHao := Copy(Node.Text, Pos('[', Node.Text) + 1, Pos(']', Node.Text) - Pos('[', Node.Text) - 1);
  end
  else
  begin
    mDanJuLeiXing := '订单';
    mDanHao := cdsMain.Fieldbyname('IBB001').AsString;
  end;
  if mDanJuLeiXing = '订单' then
  begin
    mName := 'COPDC02';
    mKey := 'IBA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '销货单' then
  begin
    mName := 'COPSC03';
    mKey := 'KEA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '销退单' then
  begin
    mName := 'COPSC04';
    mKey := 'KFA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '销售发票' then
  begin
    mName := 'YSFSC05';
    mKey := 'GGA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '红字销售发票' then
  begin
    mName := 'YSFSC07';
    mKey := 'GGA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '收款单' then
  begin
    mName := 'YSFSC03';
    mKey := 'GDA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '收款核销单' then
  begin
    mName := 'YSFSC08';
    mKey := 'GHA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '客户到款核销单' then
  begin
    mName := 'COPSC05';
    mKey := 'KFC001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '委托结算' then
  begin
    mName := 'COPSC07';
    mKey := 'KIA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '红字委托结算' then
  begin
    mName := 'COPSC10';
    mKey := 'KJA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '预开发票' then
  begin
    mName := 'YSFSC06';
    mKey := 'GGA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '采购底稿' then
  begin
    mName := 'PURCC03';
    mKey := 'HCA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '采购单' then
  begin
    mName := 'PURCC04';
    mKey := 'HDA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '生产计划' then
  begin
    mName := 'SGMZC11';
    mKey := 'SAA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '工单' then
  begin
    mName := 'SGMZC01';
    mKey := 'RAA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '委外单' then
  begin
    mName := 'SGMZC02';
    mKey := 'REA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '物料需求' then
  begin
    mName := 'SXMZQ01';
    mKey := 'RIA001';
    mDanHao := mDanHao;
  end
  else if mDanJuLeiXing = '工单工艺' then
  begin
    mName := 'GYSYC02';
    mKey := 'RAA001';
    mDanHao := mDanHao;
  end
  else
  //20210415 modi by 11245 for N01-21041400001 后续单据加上超链接 ==begin==
    if mDanJuLeiXing = '领料单' then
    begin
      mName := 'SGMZC03';
      mKey := 'RBA001;RBA002';
      mDanHao := '82;' + mDanHao;
    end
    else
      if mDanJuLeiXing = '生产入库单' then
      begin
        mName := 'SGMZC07';
        mKey := 'RCA001;RCA002';
        mDanHao := '84;' + mDanHao;
      end
      else
        if mDanJuLeiXing = '生产入库检验单' then
        begin
          mName := 'QMSCC03';
          mKey := 'MAA001';
          mDanHao := mDanHao;
        end
        else
          if mDanJuLeiXing = '重工单' then
          begin
            mName := 'SGMZC12';
            mKey := 'RKA001';
            mDanHao := mDanHao;
          end
          else
            if mDanJuLeiXing = '超耗领料单' then
            begin
              mName := 'SGMZC19';
              mKey := 'RBA001;RBA002';
              mDanHao := '8A;' + mDanHao;
            end
            else if mDanJuLeiXing = '超领单' then // 20221008 Add by liucb(01684) for x-1000722 增加超领单
            begin
              mName := 'SGMZC21';
              mKey := 'RBA001;RBA002';
              mDanHao := '8C;' + mDanHao;
            end
            else if mDanJuLeiXing = '退料单' then // 20240327 Add by liucb(01684) for b-1002683 增加退料单
            begin
              mName := 'SGMZC05';
              mKey := 'RBA001;RBA002';
              mDanHao := '83;' + mDanHao;
            end
            else
            if mDanJuLeiXing = '委外退料单' then // 20240327 Add by liucb(01684) for b-1002683 增加退料单
            begin
              mName := 'SGMZC06';
              mKey := 'RFA001;RFA002';
              mDanHao := '88;' + mDanHao;
            end
            else
              if mDanJuLeiXing = '委外送料单' then
              begin
                mName := 'SGMZC04';
                mKey := 'RFA001;RFA002';
                mDanHao := '87;' + mDanHao;
              end
              else
                if mDanJuLeiXing = '委外收料单' then
                begin
                  mName := 'QMSCC04';
                  mKey := 'MBA001';
                  mDanHao := mDanHao;
                end
                else
                  if mDanJuLeiXing = '委外检验单' then
                  begin
                    mName := 'QMSCC05';
                    mKey := 'MCA001';
                    mDanHao := mDanHao;
                  end
                  else
                    if mDanJuLeiXing = '委外进货单' then
                    begin
//                      Name := 'SGMZC08';//20210514 mark by 11245 for N01-21051400001 超链接那边后面几个单据的变量名给错了
                      mName := 'SGMZC08'; //20210514 modi by 11245 for N01-21051400001 超链接那边后面几个单据的变量名给错了
                      mKey := 'RGA001;RGA002';
                      mDanHao := '89;' + mDanHao;
                    end
                    else
                      if mDanJuLeiXing = '委外超耗送料单' then
                      begin
//                        Name := 'SGMZC20';//20210514 mark by 11245 for N01-21051400001 超链接那边后面几个单据的变量名给错了
                        mName := 'SGMZC20'; //20210514 modi by 11245 for N01-21051400001 超链接那边后面几个单据的变量名给错了
                        mKey := 'RFA001;RFA002';
                        mDanHao := '8B;' + mDanHao;
                      end
                      else
                        if mDanJuLeiXing = '委外超送单' then // 20221008 Add by liucb(01684) for x-1000722 增加超领单
                        begin
                          mName := 'SGMZC22';
                          mKey := 'RFA001;RFA002';
                          mDanHao := '8D;' + mDanHao;
                        end
                        else
                          if mDanJuLeiXing = '副产品入库单' then
                          begin
//                          Name := 'SGMZC14';//20210514 mark by 11245 for N01-21051400001 超链接那边后面几个单据的变量名给错了
                            mName := 'SGMZC14'; //20210514 modi by 11245 for N01-21051400001 超链接那边后面几个单据的变量名给错了
                            mKey := 'RLA001';
                            mDanHao := mDanHao;
                          end
                          else
  //20210415 modi by 11245 for N01-21041400001 后续单据加上超链接 ==end==
                            //20240820 modi by yangxun for B-1003014 增加委外退货单 ==begin==
                              if mDanJuLeiXing = '委外退货单' then
                              begin
                                mName := 'SGMZC09'; //20210514 modi by 11245 for N01-21051400001 超链接那边后面几个单据的变量名给错了
                                mKey := 'RGA001;RGA002';
                                mDanHao := '90;' + mDanHao;
                              end
                              else
                          //20240820 modi by yangxun for B-1003014 增加委外退货单 ==end==
                              Exit;

  OpenWork(mName, mKey, mDanHao);
end;

function TfrmCOPDR28.GetTableViewSQL(xTableView: string): string;
var
  i: integer;
  mViewName: string;
begin
//xTableView：表示要筛选的基础数据类型，TPADFA－客户，TPADHA－潜在客户，TPADDA－仓库，TPADGA－供应商
  result := '';
  for i := 0 to 3 do
  begin
    mViewName := Self.Decoder.GetInfo(nnUser, 'UserView' + inttostr(i));
    if (xTableView = 'TPADFA') and (UpperCase(copy(mViewName, 1, 6)) = 'TPADFA') then
    begin
      result := '(Select DFA001 from ' + mViewName + ' )';
      Break;
    end;

    if (xTableView = 'TPADHA') and (UpperCase(copy(mViewName, 1, 6)) = 'TPADHA') then
    begin
      result := '(Select DHA001 from ' + mViewName + ' )';
      Break;
    end;

    if (xTableView = 'TPADDA') and (UpperCase(copy(mViewName, 1, 6)) = 'TPADDA') then
    begin
      result := '(Select DDA001 from ' + mViewName + ' )';
      Break;
    end;

    if (xTableView = 'TPADGA') and (UpperCase(copy(mViewName, 1, 6)) = 'TPADGA') then
    begin
      result := '(Select DGA001 from ' + mViewName + ' )';
      Break;
    end;
  end;
end;
//20121210 modi by 603744 for Z30-12120300002 begin===============================

procedure TfrmCOPDR28.GetGongDanGongYi(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from SGMRAC left join SGMRAA on RAC001=RAA001 left join TPADEA on RAA015=DEA001 where RAC028=''81'' and RAC001=' + quotedstr(xDanHao);//20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select RAC001,RAA015,DEA002,DEA057,RAC029,RAC003,QBA002,RAC008,RAC009,RAC010,RAC011,RAC026 ' +  //20250922 Modi by liucb(01684) for x-1003613 增加工艺名称
    ' from SGMRAC left join SGMRAA on RAC001=RAA001 left join TPADEA on RAA015=DEA001 ' +
    ' left join SGMQBA on QBA001=RAC003 ' + //20250922 Add by liucb(01684) for x-1003613 增加工艺名称
    ' where RAC028=''81'' and RAC001=' + quotedstr(xDanHao); //20220523 modi by 11245 for X-1001321 优化
  mSQL := mSQL + ' order by RAA003,RAA001,RAC029 ';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号  //20251107 Modi by liucb(01684) for x-1003656 ADD RAC029 工序排序
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '工单工艺');
    First;
    while not Eof do
    begin
      cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RAC001').AsString + ']' + ' ' +
        '品号：' + fieldbyname('RAA015').AsString + ' 品名：' + fieldbyname('DEA002').AsString +
        '规格：' + fieldbyname('DEA057').AsString + //20190605 modi by 11245 for B11-190605004 增加规格显示
        //' 工序：' + fieldbyname('RAC002').AsString +  //20250922 Mark by liucb(01684) for x-1003613 增加工艺名称
        ' 工序：' + fieldbyname('RAC029').AsString + //20250922 Modi by liucb(01684) for x-1003613 增加工艺名称
        ' 工艺：' + fieldbyname('RAC003').AsString + '(' + fieldbyname('QBA002').AsString + ')' +  //20250922 Modi by liucb(01684) for x-1003613 增加工艺名称
        ' 移入数量：' + fieldbyname('RAC008').AsString + ' 移出数量：' + fieldbyname('RAC009').AsString +
        ' 调整数量：' + fieldbyname('RAC010').AsString + ' 报工数量：' + fieldbyname('RAC011').AsString + ' 报废数量：' + fieldbyname('RAC026').AsString);
      Next;
    end;
  finally
    Free;
  end;
end;
//20121210 modi by 603744 for Z30-12120300002 end=========================
//20121225 modi by 603744 for Z30-12121700001 BEGIN============================

procedure TfrmCOPDR28.cdsMainIBB023GetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  inherited;
  if Sender.AsString = 'T' then
    Text := '已审核'
  else if Sender.AsString = 'F' then
    Text := '未审核';
end;
//20121225 modi by 603744 for Z30-12121700001 END============================

//20130719 ADD BY 601394 FOR B11-130718001 订单合并跑物料需求查看单据不全              ==BEGIN==

procedure TfrmCOPDR28.GetGongDan2(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao, xDDLaiYuan, xDDDanHao, xDDXuHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL, mSQL1: string;
begin
  //20140212 ADD BY 03277 FOR B11-140212001  ==BEGIN==
 // mSQL1 := ' SELECT RJA001,RJA002 FROM SGMRJA LEFT JOIN SGMRIB ON RIB001=RJA001 AND RIB002=RJA002 WHERE RIB003=''32'' AND RIB004= ' + QuotedStr(xDDDanHao) + ' AND RIB005= ' + QuotedStr(xDDXuHao);
 //20151130 MODI BY 03277 FOR B11-151130003 生产计划取订单，生产计划跑物料需求，工单和采购单不显示 ==begin==
 // mSQL1 := ' SELECT RJA001,RJA002 FROM SGMRJA LEFT JOIN SGMRIB ON RIB036=RJA001 AND RIB037=RJA002 WHERE RIB003=''32'' AND RIB004= ' + QuotedStr(xDDDanHao) + ' AND RIB005= ' + QuotedStr(xDDXuHao);//20140410 MODI BY 03277 FOR B11-140409002
  if xDDLaiYuan = '96' then
    mSQL1 := '  SELECT  RJA001,RJA002 FROM SGMRJA LEFT JOIN SGMRIB ON RIB036=RJA001 AND RIB037=RJA002 LEFT JOIN SGMSAB ON SAB001=RIB004 AND SAB002=RIB005 WHERE RIB003=''96'' AND SAB020=''32'' AND SAB001=' + QuotedStr(xDDDanHao) + ' AND SAB002=' + QuotedStr(xDDXuHao)
  else
    mSQL1 := ' SELECT RJA001,RJA002 FROM SGMRJA LEFT JOIN SGMRIB ON RIB036=RJA001 AND RIB037=RJA002 WHERE RIB003=''32'' AND RIB004= ' + QuotedStr(xDDDanHao) + ' AND RIB005= ' + QuotedStr(xDDXuHao);
  //20151130 MODI BY 03277 FOR B11-151130003 生产计划取订单，生产计划跑物料需求，工单和采购单不显示 ==END==
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL1) do
  try
    if not IsEmpty then
    begin
     //20140212 ADD BY 03277 FOR B11-140212001 ==END==
//      mSQL := ' SELECT * FROM SGMRAA ' +  //20220523 modi by 11245 for X-1001321 优化
      mSQL := ' SELECT RAA024,RAA001,RAA015,DEA002,DEA057,RAA018,RAA019 FROM SGMRAA ' + //20220523 modi by 11245 for X-1001321 优化
        ' LEFT JOIN TPADEA ON RAA015=DEA001 ' +
        //' LEFT JOIN SGMRJA ON RJA001=RAA026 AND RJA002=RAA027 ' +  //20140507 MODI BY 29238 FOR b11-140507001
      ' LEFT JOIN SGMRJA ON RJA001=RAA026 AND RJA002=RAA027 AND RJA003=''M'' ' + //20140507 MODI BY 29238 FOR b11-140507001
        ' LEFT JOIN SGMRIB ON RJA054=RIB036 and RJA055=RIB037 ' +
        ' WHERE RAA025=' + QuotedStr(xLaiYuan) + ' AND RJA054=' + QuotedStr(xDanHao) + ' AND RJA055=' + QuotedStr(xXUHao) +
        ' AND RIB003=' + QuotedStr(xDDLaiYuan) + ' AND RIB004=' + QuotedStr(xDDDanHao);
      mSQL := mSQL + IIf(CompareStr(xDDXuHao, '') = 0, '', ' AND RIB005=' + QuotedStr(xDDXuHao));
      mSQL := mSQL + ' order by RAA003,RAA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
      with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
      try
        if not IsEmpty then
          root_node := tvMain.Items.AddChild(xnode, '工单');
        First;
        while not Eof do
        begin
          if FieldByName('RAA024').AsString = 'T' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RAA001').AsString + ']' +
              ' 品号：' + fieldbyname('RAA015').AsString + ' 品名：' + fieldbyname('DEA002').AsString +
              ' 规格：' + fieldbyname('DEA057').AsString + //20190605 modi by 11245 for B11-190605004 增加规格显示
              ' 工单数量:' + FormatFloat(mFmtStr10, FieldByName('RAA018').AsFloat) +
              ' 已生产数量:' + FormatFloat(mFmtStr10, FieldByName('RAA019').AsFloat) + ' 已审核')
          else if FieldByName('RAA024').AsString = 'F' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RAA001').AsString + ']' +
              ' 品号：' + fieldbyname('RAA015').AsString + ' 品名：' + fieldbyname('DEA002').AsString +
              ' 规格：' + fieldbyname('DEA057').AsString + //20190605 modi by 11245 for B11-190605004 增加规格显示
              ' 工单数量:' + FormatFloat(mFmtStr10, FieldByName('RAA018').AsFloat) +
              ' 已生产数量:' + FormatFloat(mFmtStr10, FieldByName('RAA019').AsFloat) + ' 未审核');
          GetGongDanGongYi(cur_node, '81', fieldbyname('RAA001').AsString, '');
          //20210112 modi by 11245 for P00-21010004 物料需求生单展开需要展开完整的生产路线 ==begin==
          GetLingLiaoDan(cur_node, '81', fieldbyname('RAA001').AsString, '');
          GetChaoHaoLingLiaoDan(cur_node, '81', fieldbyname('RAA001').AsString, '');
          GetChaoLingDan(cur_node, '81', fieldbyname('RAA001').AsString, ''); // 20221008 Add by liucb(01684) for x-1000722 增加超领单
          GetTuiLiao(cur_node, '81', fieldbyname('RAA001').AsString, ''); // 20240327 Add by liucb(01684) for b-1002683 增加退料单
          GetShengChanRuKuDan(cur_node, '81', fieldbyname('RAA001').AsString, '', 1);
          GetShengChanRuKuJianYanDan(cur_node, '81', fieldbyname('RAA001').AsString, '');
          GetChongGongDan(cur_node, '81', fieldbyname('RAA001').AsString, '');
          //20210112 modi by 11245 for P00-21010004 物料需求生单展开需要展开完整的生产路线 ==end==
          Next;
        end;
      finally
        Free;
      end;
      //20140212 ADD BY 03277 FOR B11-140212001  ==BEGIN==
    end;
  finally
    Free;
  end;
    //20140212 ADD BY 03277 FOR B11-140212001  ==END==
end;

procedure TfrmCOPDR28.GetWeiWaiDan2(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao, xDDLaiYuan, xDDDanHao, xDDXuHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL, mSQL1: string;
begin
 //20140212 ADD BY 03277 FOR B11-140212001  ==BEGIN==
  //mSQL1 := ' SELECT RJA001,RJA002 FROM SGMRJA LEFT JOIN SGMRIB ON RIB001=RJA001 AND RIB002=RJA002 WHERE RIB003=''32'' AND RIB004= ' + QuotedStr(xDDDanHao) + ' AND RIB005= ' + QuotedStr(xDDXuHao);
 //20151130 MODI BY 03277 FOR B11-151130003 生产计划取订单，生产计划跑物料需求，工单和采购单不显示 ==begin==
 // mSQL1 := ' SELECT RJA001,RJA002 FROM SGMRJA LEFT JOIN SGMRIB ON RIB036=RJA001 AND RIB037=RJA002 WHERE RIB003=''32'' AND RIB004= ' + QuotedStr(xDDDanHao) + ' AND RIB005= ' + QuotedStr(xDDXuHao);//20140410 MODI BY 03277 FOR B11-140409002
  if xDDLaiYuan = '96' then
    mSQL1 := '  SELECT  RJA001,RJA002 FROM SGMRJA LEFT JOIN SGMRIB ON RIB036=RJA001 AND RIB037=RJA002 LEFT JOIN SGMSAB ON SAB001=RIB004 AND SAB002=RIB005 WHERE RIB003=''96'' AND SAB020=''32'' AND SAB001=' + QuotedStr(xDDDanHao) + ' AND SAB002=' + QuotedStr(xDDXuHao)
  else
    mSQL1 := ' SELECT RJA001,RJA002 FROM SGMRJA LEFT JOIN SGMRIB ON RIB036=RJA001 AND RIB037=RJA002 WHERE RIB003=''32'' AND RIB004= ' + QuotedStr(xDDDanHao) + ' AND RIB005= ' + QuotedStr(xDDXuHao);
  //20151130 MODI BY 03277 FOR B11-151130003 生产计划取订单，生产计划跑物料需求，工单和采购单不显示 ==END==
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL1) do
  try
    if not IsEmpty then
    begin
     //20140212 ADD BY 03277 FOR B11-140212001 ==END==
//      mSQL := ' SELECT * FROM SGMREA ' + //20220523 modi by 11245 for X-1001321 优化
      mSQL := ' SELECT REA047,REA001,REA015,DEA002,DEA057,REA018,REA019 FROM SGMREA ' + //20220523 modi by 11245 for X-1001321 优化
        ' LEFT JOIN TPADEA ON REA015=DEA001 ' +
        //' LEFT JOIN SGMRJA ON RJA001=REA049 AND RJA002=REA050 ' + //20140507 MODI BY 29238 FOR b11-140507001
      ' LEFT JOIN SGMRJA ON RJA001=REA049 AND RJA002=REA050 AND RJA003=''M'' ' + //20140507 MODI BY 29238 FOR b11-140507001
        ' LEFT JOIN SGMRIB ON RJA054=RIB036 and RJA055=RIB037 ' +
        ' WHERE REA048=' + QuotedStr(xLaiYuan) + ' AND RJA054=' + QuotedStr(xDanHao) + ' AND RJA055=' + QuotedStr(xXUHao) +
        ' AND RIB003=' + QuotedStr(xDDLaiYuan) + ' AND RIB004=' + QuotedStr(xDDDanHao);
      mSQL := mSQL + IIf(CompareStr(xDDXuHao, '') = 0, '', ' AND RIB005=' + QuotedStr(xDDXuHao));
      mSQL := mSQL + ' order by REA003,REA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
      with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
      try
        if not IsEmpty then
          root_node := tvMain.Items.AddChild(xnode, '委外单');
        First;
        while not Eof do
        begin
          if FieldByName('REA047').AsString = 'T' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('REA001').AsString + ']' +
              ' 品号：' + fieldbyname('REA015').AsString + ' 品名：' + fieldbyname('DEA002').AsString +
              ' 规格：' + fieldbyname('DEA057').AsString + //20190605 modi by 11245 for B11-190605004 增加规格显示
              ' 委外数量:' + FormatFloat(mFmtStr10, FieldByName('REA018').AsFloat) +
              ' 已完工量:' + FormatFloat(mFmtStr10, FieldByName('REA019').AsFloat) + ' 已审核')
          else if FieldByName('REA047').AsString = 'F' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('REA001').AsString + ']' +
              ' 品号：' + fieldbyname('REA015').AsString + ' 品名：' + fieldbyname('DEA002').AsString +
              ' 规格：' + fieldbyname('DEA057').AsString + //20190605 modi by 11245 for B11-190605004 增加规格显示
              ' 委外数量:' + FormatFloat(mFmtStr10, FieldByName('REA018').AsFloat) +
              ' 已完工量:' + FormatFloat(mFmtStr10, FieldByName('REA019').AsFloat) + ' 未审核');

           //20210112 modi by 11245 for P00-21010004 物料需求生单展开需要展开完整的生产路线 ==BEGIN==
          GetWeiWaiSongLiaoDan(cur_node, '86', FieldByName('REA001').AsString, '');
          GetWeiWaiChaoHaoSongLiaoDan(cur_node, '86', FieldByName('REA001').AsString, '');
          GetWeiWaiChaoSongDan(cur_node, '86', FieldByName('REA001').AsString, ''); // 20221008 Add by liucb(01684) for x-1000722 增加超领单
          GetWeiWaiTuiLiaoDan(cur_node, '86', FieldByName('REA001').AsString, ''); // 20240327 Add by liucb(01684) for b-1002683 增加退料单
          GetWeiWaiShouLiaoDan(cur_node, '86', FieldByName('REA001').AsString, '');
          GetWeiWaiJinHuoDan(cur_node, '86', FieldByName('REA001').AsString, '');
          GetWeiWaiTuiHuoDan(cur_node, '86', FieldByName('REA001').AsString, '');//20240820 modi by yangxun for B-1003014 增加委外退货单
          //20210112 modi by 11245 for P00-21010004 物料需求生单展开需要展开完整的生产路线 ==END==
          Next;
        end;
      finally
        Free;
      end;
  //20140212 ADD BY 03277 FOR B11-140212001  ==BEGIN==
    end;
  finally
    Free;
  end;
    //20140212 ADD BY 03277 FOR B11-140212001  ==END==
end;

procedure TfrmCOPDR28.GetCaiGouDiGao2(xnode: TTreeNode; xLaiYuan, xDanHao, xXUHao, xDDLaiYuan, xDDDanHao, xDDXuHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL, mSQL1: string;
begin
 //20140212 ADD BY 03277 FOR B11-140212001  ==BEGIN==
 // mSQL1 := ' SELECT RJA001,RJA002 FROM SGMRJA LEFT JOIN SGMRIB ON RIB001=RJA001 AND RIB002=RJA002 WHERE RIB003=''32'' AND RIB004= ' + QuotedStr(xDDDanHao) + ' AND RIB005= ' + QuotedStr(xDDXuHao);
 //20151130 MODI BY 03277 FOR B11-151130003 生产计划取订单，生产计划跑物料需求，工单和采购单不显示 ==begin==
 // mSQL1 := ' SELECT RJA001,RJA002 FROM SGMRJA LEFT JOIN SGMRIB ON RIB036=RJA001 AND RIB037=RJA002 WHERE RIB003=''32'' AND RIB004= ' + QuotedStr(xDDDanHao) + ' AND RIB005= ' + QuotedStr(xDDXuHao);//20140410 MODI BY 03277 FOR B11-140409002
  if xDDLaiYuan = '96' then
    mSQL1 := '  SELECT  RJA001,RJA002 FROM SGMRJA LEFT JOIN SGMRIB ON RIB036=RJA001 AND RIB037=RJA002 LEFT JOIN SGMSAB ON SAB001=RIB004 AND SAB002=RIB005 WHERE RIB003=''96'' AND SAB020=''32'' AND SAB001=' + QuotedStr(xDDDanHao) + ' AND SAB002=' + QuotedStr(xDDXuHao)
  else
    mSQL1 := ' SELECT RJA001,RJA002 FROM SGMRJA LEFT JOIN SGMRIB ON RIB036=RJA001 AND RIB037=RJA002 WHERE RIB003=''32'' AND RIB004= ' + QuotedStr(xDDDanHao) + ' AND RIB005= ' + QuotedStr(xDDXuHao);
  //20151130 MODI BY 03277 FOR B11-151130003 生产计划取订单，生产计划跑物料需求，工单和采购单不显示 ==END==
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL1) do
  try
    if not IsEmpty then
    begin
     //20140212 ADD BY 03277 FOR B11-140212001 ==END==
//      mSQL := ' SELECT * FROM DCSHCA ' +  //20220523 modi by 11245 for X-1001321 优化
      mSQL := ' SELECT HCB020,HCB001,HCB002,HCA003,HCB003,HCB004,HCB006,HCB041,HCB040 FROM DCSHCA ' + //20220523 modi by 11245 for X-1001321 优化
        ' LEFT JOIN DCSHCB ON HCA001=HCB001 ' +
        ' LEFT JOIN SGMRJA ON RJA001=HCB017 AND RJA002=HCB018 ' +
        ' LEFT JOIN SGMRIB ON RJA054=RIB036 and RJA055=RIB037 ' +
        ' WHERE HCB016=' + QuotedStr(xLaiYuan) + ' AND RJA054=' + QuotedStr(xDanHao) + ' AND RJA055=' + QuotedStr(xXUHao) +
        ' AND RIB003=' + QuotedStr(xDDLaiYuan) + ' AND RIB004=' + QuotedStr(xDDDanHao);
      mSQL := mSQL + IIf(CompareStr(xDDXuHao, '') = 0, '', ' AND RIB005=' + QuotedStr(xDDXuHao));
//      mSQL := 'select * from DCSHCA left join DCSHCB on HCA001=HCB001  where HCB016=' + //20220523 modi by 11245 for X-1001321 优化
      {mSQL := 'select HCB020,HCB001,HCB002,HCA003,HCB003,HCB004,HCB006,HCB041,HCB040 from DCSHCA left join DCSHCB on HCA001=HCB001  where HCB016=' + //20220523 modi by 11245 for X-1001321 优化
        quotedstr(xLaiYuan) + ' and HCB017=' + quotedstr(xDanHao);
      if xXUHao <> '' then
        mSQL := mSQL + ' and HCB018=' + quotedstr(xXUHao); } // 20221209 Mark by liucb(01684) for b-1001298 物料需求关联采购底稿条件修改
      mSQL := mSQL + ' order by HCA003,HCA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号  
      with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
      try
        if not IsEmpty then
          root_node := tvMain.Items.AddChild(xnode, '采购底稿');
        First;
        while not Eof do
        begin
          if FieldByName('HCB020').AsString = 'T' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('HCB001').AsString + ']' + '-' + fieldbyname('HCB002').AsString + ' ' +
//              TransDateOut(fieldbyname('HCA003').AsString, False) + ' 品号：' + FieldByName('HCB003').AsString + ' 品名：' + FieldByName('HCB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HCB006').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
              TransDateOut(fieldbyname('HCA003').AsString, False) + ' 品号：' + FieldByName('HCB003').AsString + ' 品名：' + FieldByName('HCB004').AsString + ' 规格：' + FieldByName('HCB040').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HCB006').AsFloat) + //20190605 modi by 11245 for B11-190605004 增加规格显示
              ' 已采量:' + FormatFloat(mFmtStr10, FieldByName('HCB041').AsFloat) + ' 已审核')
          else if FieldByName('HCB020').AsString = 'F' then
            cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('HCB001').AsString + ']' + '-' + fieldbyname('HCB002').AsString + ' ' +
              TransDateOut(fieldbyname('HCA003').AsString, False) + ' 品号：' + FieldByName('HCB003').AsString + ' 品名：' + FieldByName('HCB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HCB006').AsFloat) + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20190605 mark by 11245 for B11-190605004 增加规格显示
              TransDateOut(fieldbyname('HCA003').AsString, False) + ' 品号：' + FieldByName('HCB003').AsString + ' 品名：' + FieldByName('HCB004').AsString + ' 规格：' + FieldByName('HCB040').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('HCB006').AsFloat) + //20190605 modi by 11245 for B11-190605004 增加规格显示
              ' 已采量:' + FormatFloat(mFmtStr10, FieldByName('HCB041').AsFloat) + ' 未审核');
          GetCaiGouDan(cur_node, '13', fieldbyname('HCB001').AsString, fieldbyname('HCB002').AsString);
          Next;
        end;
      finally
        Free;
      end;
  //20140212 ADD BY 03277 FOR B11-140212001  ==BEGIN==
    end;
  finally
    Free;
  end;
    //20140212 ADD BY 03277 FOR B11-140212001  ==END==
end;
//20130719 ADD BY 601394 FOR B11-130718001 订单合并跑物料需求查看单据不全              ==END==

procedure TfrmCOPDR28.GetChaoHaoLingLiaoDan(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from SGMRBA left join SGMRBB on RBA001=RBB001 and RBA002=RBB002 where RBA001=''8A'' and RBB023=' + //20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select RBB013,RBB002,RBB003,RBA004,RBB004,RBB005,RBB009 from SGMRBA left join SGMRBB on RBA001=RBB001 and RBA002=RBB002 where RBA001=''8A'' and RBB023=' + //20220523 modi by 11245 for X-1001321 优化
    quotedstr(xLaiYuan) + ' and RBB010=' + quotedstr(xDanHao);
    mSQL := mSQL + ' order by RBA004,RBA002';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '超耗领料单');
    First;
    while not Eof do
    begin
      if FieldByName('RBB013').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RBB002').AsString + ']' + '-' + fieldbyname('RBB003').AsString + ' ' +
          TransDateOut(fieldbyname('RBA004').AsString, False) + ' 品号:' + FieldByName('RBB004').AsString +
          '  品名:' + FieldByName('RBB005').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('RBB009').AsFloat)
          + ' 已审核')
      else if FieldByName('RBB013').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RBB002').AsString + ']' + '-' + fieldbyname('RBB003').AsString + ' ' +
          TransDateOut(fieldbyname('RBA004').AsString, False) + ' 品号:' + FieldByName('RBB004').AsString +
          '  品名:' + FieldByName('RBB005').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('RBB009').AsFloat)
          + ' 未审核');
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.GetChongGongDan(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from SGMRKA left join SGMRKB on RKA001=RKB001 where  RKA010=' + quotedstr(xDanHao);//20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select RKA020,RKA001,RKA003,RKB003,RKB004,RKB008 from SGMRKA left join SGMRKB on RKA001=RKB001 where  RKA010=' + quotedstr(xDanHao); //20220523 modi by 11245 for X-1001321 优化
  mSQL := mSQL + ' order by RKA003,RKA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '重工单');
    First;
    while not Eof do
    begin
      if FieldByName('RKA020').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RKA001').AsString + ']' + ' ' +
          TransDateOut(fieldbyname('RKA003').AsString, False) + ' 品号:' + FieldByName('RKB003').AsString + '  品名:' + FieldByName('RKB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('RKB008').AsFloat)
          + ' 已审核')
      else if FieldByName('RKA020').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RKA001').AsString + ']' + ' ' +
          TransDateOut(fieldbyname('RKA003').AsString, False) + ' 品号:' + FieldByName('RKB003').AsString + '  品名:' + FieldByName('RKB004').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('RKB008').AsFloat)
          + ' 未审核');
      GetLingLiaoDan(cur_node, '97', fieldbyname('RKA001').AsString, '');
      GetChaoHaoLingLiaoDan(cur_node, '97', fieldbyname('RKA001').AsString, '');
      GetChaoLingDan(cur_node, '97', fieldbyname('RKA001').AsString, ''); // 20221008 Add by liucb(01684) for x-1000722 增加超领单
      GetTuiLiao(cur_node, '97', fieldbyname('RKA001').AsString, ''); // 20240327 Add by liucb(01684) for b-1002683 增加退料单
      GetShengChanRuKuDan(cur_node, '97', fieldbyname('RKA001').AsString, '', 2);
      GetShengChanRuKuJianYanDan(cur_node, '97', fieldbyname('RKA001').AsString, '');
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.GetLingLiaoDan(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from SGMRBA left join SGMRBB on RBA001=RBB001 and RBA002=RBB002 where RBA001=''82'' and RBB023=' + //20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select RBB013,RBA004,RBB002,RBB003,RBB004,RBB005,RBB009 from SGMRBA left join SGMRBB on RBA001=RBB001 and RBA002=RBB002 where RBA001=''82'' and RBB023=' + //20220523 modi by 11245 for X-1001321 优化
    quotedstr(xLaiYuan) + ' and RBB010=' + quotedstr(xDanHao);
  mSQL := mSQL + ' order by RBA004,RBA002';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号  
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '领料单');
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin==================
      if FieldByName('RBB013').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RBB002').AsString + ']' + '-' + fieldbyname('RBB003').AsString + ' ' +
          TransDateOut(fieldbyname('RBA004').AsString, False) + ' 品号:' + FieldByName('RBB004').AsString +
          '  品名:' + FieldByName('RBB005').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('RBB009').AsFloat)
          + ' 已审核')
      else if FieldByName('RBB013').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RBB002').AsString + ']' + '-' + fieldbyname('RBB003').AsString + ' ' +
          TransDateOut(fieldbyname('RBA004').AsString, False) + ' 品号:' + FieldByName('RBB004').AsString +
          '  品名:' + FieldByName('RBB005').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('RBB009').AsFloat)
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 end======================
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.GetShengChanRuKuDan(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXUHao: string; xtype: Integer);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from SGMRCA  left join SGMRCC on RCA001=RCC001 and RCA002=RCC002  where RCA001=''84'' and RCC003='+ //20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select RCA016,RCC002,RCA004,RCC006 from SGMRCA  left join SGMRCC on RCA001=RCC001 and RCA002=RCC002  where RCA001=''84'' and RCC003=' + //20220523 modi by 11245 for X-1001321 优化
    quotedstr(xLaiYuan) + ' and RCC004=' + quotedstr(xDanHao);
  if xXUHao <> '' then
    mSQL := mSQL + ' and RCC011=' + quotedstr(xXUHao);
  mSQL := mSQL + ' order by RCA004,RCA002';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号  
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '生产入库单');
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin=======================
      if FieldByName('RCA016').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RCC002').AsString + ']' + ' ' +
          TransDateOut(fieldbyname('RCA004').AsString, False) + ' 入库数量:' + FormatFloat(mFmtStr10, FieldByName('RCC006').AsFloat)
          + ' 已审核')
      else if FieldByName('RCA016').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RCC002').AsString + ']' + ' ' +
          TransDateOut(fieldbyname('RCA004').AsString, False) + ' 入库数量:' + FormatFloat(mFmtStr10, FieldByName('RCC006').AsFloat)
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 end=========================
      if xtype = 1 then
        GetFuChanPinRuKu(cur_node, '84', fieldbyname('RCC002').AsString, '', xLaiYuan, xDanHao, xXUHao);
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.GetShengChanRuKuJianYanDan(xnode: TTreeNode;
  xLaiYuan, xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
  ///生产入库检验单
//  mSQL := 'select * from QMSMAA left join QMSMAB on MAA001=MAB001  where MAB005=' + quotedstr(xLaiYuan) + ' and MAB006=' + quotedstr(xDanHao);//20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select MAA007,MAB001,MAB002,MAA003,MAB007,MAB008,MAB013,MAA001 from QMSMAA left join QMSMAB on MAA001=MAB001  where MAB005=' + quotedstr(xLaiYuan) + ' and MAB006=' + quotedstr(xDanHao); //20220523 modi by 11245 for X-1001321 优化
  mSQL := mSQL + ' order by MAA003,MAA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.Addchild(xnode, '生产入库检验单');
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin================
      if FieldByName('MAA007').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('MAB001').AsString + ']' + '-' + fieldbyname('MAB002').AsString + ' ' +
        //TransDateOut(fieldbyname('MAA003').AsString, False) + ' 合格数量:' + FormatFloat(mFmtStr10, FieldByName('MAB013').AsFloat));//20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
          TransDateOut(fieldbyname('MAA003').AsString, False) + ' 品号:' + FieldByName('MAB007').AsString + '  品名:' + FieldByName('MAB008').AsString + ' 合格数量:' + FormatFloat(mFmtStr10, FieldByName('MAB013').AsFloat)
          + ' 已审核')
      else if FieldByName('MAA007').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('MAB001').AsString + ']' + '-' + fieldbyname('MAB002').AsString + ' ' +
        //TransDateOut(fieldbyname('MAA003').AsString, False) + ' 合格数量:' + FormatFloat(mFmtStr10, FieldByName('MAB013').AsFloat));//20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
          TransDateOut(fieldbyname('MAA003').AsString, False) + ' 品号:' + FieldByName('MAB007').AsString + '  品名:' + FieldByName('MAB008').AsString + ' 合格数量:' + FormatFloat(mFmtStr10, FieldByName('MAB013').AsFloat)
          + ' 未审核');
      if xLaiYuan = '97' then
        GetShengChanRuKuDan(cur_node, 'A1', fieldbyname('MAA001').AsString, fieldbyname('MAB002').AsString, 2)
      else if xLaiYuan = '81' then
        GetShengChanRuKuDan(cur_node, 'A1', fieldbyname('MAA001').AsString, fieldbyname('MAB002').AsString, 1);
      Next;
    end;
  finally
    Free;
  end;

end;

procedure TfrmCOPDR28.GetWeiWaiChaoHaoSongLiaoDan(xnode: TTreeNode;
  xLaiYuan, xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from SGMRFA left join SGMRFB on RFA001=RFB001 and RFA002=RFB002 where RFB001=''8B'' and  RFB010=' + quotedstr(xDanHao);//20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select RFA015,RFB002,RFB003,RFA004,RFB004,RFB005,RFB009 from SGMRFA left join SGMRFB on RFA001=RFB001 and RFA002=RFB002 where RFB001=''8B'' and  RFB010=' + quotedstr(xDanHao); //20220523 modi by 11245 for X-1001321 优化
  mSQL := mSQL + ' order by RFA004,RFA002';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '委外超耗送料单');
    First;
    while not Eof do
    begin
      if FieldByName('RFA015').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RFB002').AsString + ']' + '-' + fieldbyname('RFB003').AsString + ' ' +
          TransDateOut(fieldbyname('RFA004').AsString, False) + ' 品号:' + FieldByName('RFB004').AsString +
          '  品名:' + FieldByName('RFB005').AsString + ' 送料数量:' + FormatFloat(mFmtStr10, FieldByName('RFB009').AsFloat)
          + ' 已审核')
      else if FieldByName('RFA015').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RFB002').AsString + ']' + '-' + fieldbyname('RFB003').AsString + ' ' +
          TransDateOut(fieldbyname('RFA004').AsString, False) + ' 品号:' + FieldByName('RFB004').AsString +
          '  品名:' + FieldByName('RFB005').AsString + ' 送料数量:' + FormatFloat(mFmtStr10, FieldByName('RFB009').AsFloat)
          + ' 未审核');
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.GetWeiWaiJianYanDan(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from QMSMCA left join QMSMCB  on MCA001=MCB001 where MCB005=' + quotedstr(xDanHao);//20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select MCA008,MCB001,MCB002,MCA003,MCB007,MCB008,MCB012 from QMSMCA left join QMSMCB  on MCA001=MCB001 where MCB005=' + quotedstr(xDanHao); //20220523 modi by 11245 for X-1001321 优化
  if xXUHao <> '' then
    mSQL := mSQL + ' and MCB006=' + quotedstr(xXUHao);
  mSQL := mSQL + ' order by MCA003,MCA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号  
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '委外检验单');
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin===============
      if FieldByName('MCA008').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('MCB001').AsString + ']' + '-' + fieldbyname('MCB002').AsString + ' ' +
        //TransDateOut(fieldbyname('MCA003').AsString, False) + ' 验收数量:' + FormatFloat(mFmtStr10, FieldByName('MCB012').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
          TransDateOut(fieldbyname('MCA003').AsString, False) + ' 品号:' + FieldByName('MCB007').AsString + '  品名:' + FieldByName('MCB008').AsString + ' 验收数量:' + FormatFloat(mFmtStr10, FieldByName('MCB012').AsFloat)
          + ' 已审核')
      else if FieldByName('MCA008').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('MCB001').AsString + ']' + '-' + fieldbyname('MCB002').AsString + ' ' +
        //TransDateOut(fieldbyname('MCA003').AsString, False) + ' 验收数量:' + FormatFloat(mFmtStr10, FieldByName('MCB012').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
          TransDateOut(fieldbyname('MCA003').AsString, False) + ' 品号:' + FieldByName('MCB007').AsString + '  品名:' + FieldByName('MCB008').AsString + ' 验收数量:' + FormatFloat(mFmtStr10, FieldByName('MCB012').AsFloat)
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 end==================
//      cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('MCB001').AsString + ']' + '-' + fieldbyname('MCB002').AsString + ' ' +
//        //TransDateOut(fieldbyname('MCA003').AsString, False) + ' 验收数量:' + FormatFloat(mFmtStr10, FieldByName('MCB012').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        TransDateOut(fieldbyname('MCA003').AsString, False) +' 品号:' + FieldByName('MCB007').AsString +'  品名:' + FieldByName('MCB008').AsString+ ' 验收数量:' + FormatFloat(mFmtStr10, FieldByName('MCB012').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
      GetWeiWaiJinHuoDan(cur_node, 'A3', fieldbyname('MCB001').AsString, fieldbyname('MCB002').AsString);
      Next;
    end;
  finally
    Free;
  end;

end;

procedure TfrmCOPDR28.GetWeiWaiJinHuoDan(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
  //mSQL := 'select * from SGMRGA left join SGMRGC  on RGA001=RGC001 and RGA002=RGC002 where RGA001=''89'' and  RGC036=' + quotedstr(xLaiYuan) + ' and RGC003=' + quotedstr(xDanHao);
  //mSQL := 'select * from SGMRGA left join SGMRGC  on RGA001=RGC001 and RGA002=RGC002 left join SGMRGB on RGA001=RGB001 and RGA002=RGB002 where RGA001=''89'' and  RGC036=' + quotedstr(xLaiYuan) + ' and RGC003=' + quotedstr(xDanHao); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示//20130402 mark by 03433 for B11-130402007 同一张单子下显示不同委外单的所有子件信息
//  mSQL := 'select * from SGMRGA left join SGMRGC  on RGA001=RGC001 and RGA002=RGC002 left join SGMRGB on RGA001=RGB001 and RGA002=RGB002 where RGA001=''89'' and  RGC036=' + quotedstr(xLaiYuan) + ' and RGC003=' + quotedstr(xDanHao)+' and RGB021='+quotedstr(xDanHao);//20130402 modi by 03433 for B11-130402007 同一张单子下显示不同委外单的所有子件信息//20130702 MODI BY 601394 FOR B11-130702003 取错字段
  //20140114 MARK BY 03277 FOR B11-140114001 多个子件时 信息重复 ======BEGIN==============================
  //20130702 ADD BY 601394 FOR B11-130702003 取错字段          ==BEGIN==
//  mSQL := ' select *,A.DEA002 AS RGC033C from SGMRGA left join SGMRGC  on RGA001=RGC001 and RGA002=RGC002 ' +
//	  ' left join SGMRGB on RGA001=RGB001 and RGA002=RGB002 LEFT JOIN TPADEA A ON A.DEA001=RGC033 ' +
//	  ' where RGA001=''89'' and  RGC036=' + quotedstr(xLaiYuan) + ' and RGC003=' + quotedstr(xDanHao)+' and RGB021='+quotedstr(xDanHao);
  //20130702 ADD BY 601394 FOR B11-130702003 取错字段          ==END==
  //20140114 MARK BY 03277 FOR B11-140114001 多个子件时 信息重复 ==END=====================================
 //20140114 MODI BY 03277 FOR B11-140114001 多个子件时 信息重复 ==BEGIN================================
//  mSQL := ' select *,A.DEA002 AS RGC033C from SGMRGA left join SGMRGC  on RGA001=RGC001 and RGA002=RGC002 ' + //20220523 modi by 11245 for X-1001321 优化
  mSQL := ' select RGA050,RGC002,RGC040,RGA004,RGC033,RGC005,A.DEA002 AS RGC033C from SGMRGA left join SGMRGC  on RGA001=RGC001 and RGA002=RGC002 ' + //20220523 modi by 11245 for X-1001321 优化
    ' LEFT JOIN TPADEA A ON A.DEA001=RGC033 ' +
    ' where RGA001=''89'' and  RGC036=' + quotedstr(xLaiYuan) + ' and RGC003=' + quotedstr(xDanHao);
 //20140114 MODI BY 03277 FOR B11-140114001 多个子件时 信息重复 ==END==================================
  if xXUHao <> '' then
    mSQL := mSQL + ' and RGC037=' + quotedstr(xXUHao);
  mSQL := mSQL + ' order by RGA004,RGA002';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号  
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '委外进货单');
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin=================
      //20130702 MODI BY 601394 FOR B11-130702003 取错字段              ==BEGIN==
//      if FieldByName('RGA050').AsString = 'T' then
//      //cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RGC002').AsString + ']' + '-' + fieldbyname('RGC002').AsString + ' ' +
//        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RGC002').AsString + ']' + '-' + fieldbyname('RGC040').AsString + ' ' + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('RGA004').AsString, False) + ' 品号:' + FieldByName('RGB004').AsString + '  品名:' + FieldByName('RGB005').AsString + ' 进货数量:' + FormatFloat(mFmtStr10, FieldByName('RGC005').AsFloat) //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          + ' 已审核')
//      else if FieldByName('RGA050').AsString = 'F' then
//        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RGC002').AsString + ']' + '-' + fieldbyname('RGC040').AsString + ' ' + //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//          TransDateOut(fieldbyname('RGA004').AsString, False) + ' 品号:' + FieldByName('RGB004').AsString + '  品名:' + FieldByName('RGB005').AsString + ' 进货数量:' + FormatFloat(mFmtStr10, FieldByName('RGC005').AsFloat)
//          + ' 未审核');
      //20130702 MODI BY 601394 FOR B11-130702003 取错字段              ==END==
      //20121225 modi by 603744 for Z30-12121700001 end======================
      //20130702 ADD BY 601394 FOR B11-130702003 取错字段              ==BEGIN==
      if FieldByName('RGA050').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RGC002').AsString + ']' + '-' + fieldbyname('RGC040').AsString + ' ' +
          TransDateOut(fieldbyname('RGA004').AsString, False) + ' 品号:' + FieldByName('RGC033').AsString + '  品名:' + FieldByName('RGC033C').AsString + ' 进货数量:' + FormatFloat(mFmtStr10, FieldByName('RGC005').AsFloat)
          + ' 已审核')
      else if FieldByName('RGA050').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RGC002').AsString + ']' + '-' + fieldbyname('RGC040').AsString + ' ' +
          TransDateOut(fieldbyname('RGA004').AsString, False) + ' 品号:' + FieldByName('RGC033').AsString + '  品名:' + FieldByName('RGC033C').AsString + ' 进货数量:' + FormatFloat(mFmtStr10, FieldByName('RGC005').AsFloat)
          + ' 未审核');
      //20130702 ADD BY 601394 FOR B11-130702003 取错字段              ==END==
      Next;
    end;
  finally
    Free;
  end;

end;

procedure TfrmCOPDR28.GetWeiWaiShouLiaoDan(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from QMSMBA left join QMSMBB  on MBA001=MBB001 where MBB010=' + quotedstr(xLaiYuan) + ' and MBB011=' + quotedstr(xDanHao);//20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select MBA008,MBB001,MBB002,MBA003,MBB003,MBB004,MBB007 from QMSMBA left join QMSMBB  on MBA001=MBB001 where MBB010=' + quotedstr(xLaiYuan) + ' and MBB011=' + quotedstr(xDanHao); //20220523 modi by 11245 for X-1001321 优化
  mSQL := mSQL + ' order by MBA003,MBA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '委外收料单');
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin==============
      if FieldByName('MBA008').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('MBB001').AsString + ']' + '-' + fieldbyname('MBB002').AsString + ' ' +
        //TransDateOut(fieldbyname('MBA003').AsString, False) + ' 收料数量:' + FormatFloat(mFmtStr10, FieldByName('MBB007').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
          TransDateOut(fieldbyname('MBA003').AsString, False) + ' 品号:' + FieldByName('MBB003').AsString + '  品名:' + FieldByName('MBB004').AsString + ' 收料数量:' + FormatFloat(mFmtStr10, FieldByName('MBB007').AsFloat)
          + ' 已审核')
      else if FieldByName('MBA008').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('MBB001').AsString + ']' + '-' + fieldbyname('MBB002').AsString + ' ' +
        //TransDateOut(fieldbyname('MBA003').AsString, False) + ' 收料数量:' + FormatFloat(mFmtStr10, FieldByName('MBB007').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
          TransDateOut(fieldbyname('MBA003').AsString, False) + ' 品号:' + FieldByName('MBB003').AsString + '  品名:' + FieldByName('MBB004').AsString + ' 收料数量:' + FormatFloat(mFmtStr10, FieldByName('MBB007').AsFloat)
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 end===============
//      cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('MBB001').AsString + ']' + '-' + fieldbyname('MBB002').AsString + ' ' +
//        //TransDateOut(fieldbyname('MBA003').AsString, False) + ' 收料数量:' + FormatFloat(mFmtStr10, FieldByName('MBB007').AsFloat)); //20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
//        TransDateOut(fieldbyname('MBA003').AsString, False) +' 品号:' + FieldByName('MBB003').AsString +'  品名:' + FieldByName('MBB004').AsString+ ' 收料数量:' + FormatFloat(mFmtStr10, FieldByName('MBB007').AsFloat));//20121204 modi by 603744 for P11-12070027 在单据显示后面增加品号和品名显示
      GetWeiWaiJianYanDan(cur_node, 'A2', fieldbyname('MBB001').AsString, fieldbyname('MBB002').AsString);
      Next;
    end;
  finally
    Free;
  end;

end;

procedure TfrmCOPDR28.GetWeiWaiSongLiaoDan(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
//  mSQL := 'select * from SGMRFA left join SGMRFB on RFA001=RFB001 and RFA002=RFB002 where RFB001=''87'' and  RFB010=' + quotedstr(xDanHao); //20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select RFA015,RFB002,RFB003,RFA004,RFB004,RFB005,RFB009 from SGMRFA left join SGMRFB on RFA001=RFB001 and RFA002=RFB002 where RFB001=''87'' and  RFB010=' + quotedstr(xDanHao); //20220523 modi by 11245 for X-1001321 优化
  mSQL := mSQL + ' order by RFA004,RFA002';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '委外送料单');
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin========================
      if FieldByName('RFA015').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RFB002').AsString + ']' + '-' + fieldbyname('RFB003').AsString + ' ' +
          TransDateOut(fieldbyname('RFA004').AsString, False) + ' 品号:' + FieldByName('RFB004').AsString +
          '  品名:' + FieldByName('RFB005').AsString + ' 送料数量:' + FormatFloat(mFmtStr10, FieldByName('RFB009').AsFloat)
          + ' 已审核')
      else if FieldByName('RFA015').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RFB002').AsString + ']' + '-' + fieldbyname('RFB003').AsString + ' ' +
          TransDateOut(fieldbyname('RFA004').AsString, False) + ' 品号:' + FieldByName('RFB004').AsString +
          '  品名:' + FieldByName('RFB005').AsString + ' 送料数量:' + FormatFloat(mFmtStr10, FieldByName('RFB009').AsFloat)
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 end=============================
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.GetFuChanPinRuKu(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXUHao, xDDLaiYuan, xDDDanHao, xDDXuHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
  ///副产品入库单
//  mSQL := 'select * from SGMRLA left join SGMRLB on RLA001=RLB001  where RLA014=' + quotedstr(xDanHao) + ' and RLA006=' + quotedstr(xDDDanHao);//20220523 modi by 11245 for X-1001321 优化
  mSQL := 'select RLA011,RLB001,RLB002,RLA003,RLB003,RLB004,RLB006 from SGMRLA left join SGMRLB on RLA001=RLB001  where RLA014=' + quotedstr(xDanHao) + ' and RLA006=' + quotedstr(xDDDanHao); //20220523 modi by 11245 for X-1001321 优化
  mSQL := mSQL + ' order by RLA003,RLA001';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.Addchild(xnode, '副产品入库单');
    First;
    while not Eof do
    begin
      //20121225 modi by 603744 for Z30-12121700001 begin====================
      if FieldByName('RLA011').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RLB001').AsString + ']' + '-' + fieldbyname('RLB002').AsString + ' ' +
          TransDateOut(fieldbyname('RLA003').AsString, False) + ' 品号:' + FieldByName('RLB003').AsString +
          '  品名:' + FieldByName('RLB004').AsString + ' 入库数量:' + FormatFloat(mFmtStr10, FieldByName('RLB006').AsFloat)
          + ' 已审核')
      else if FieldByName('RLA011').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RLB001').AsString + ']' + '-' + fieldbyname('RLB002').AsString + ' ' +
          TransDateOut(fieldbyname('RLA003').AsString, False) + ' 品号:' + FieldByName('RLB003').AsString +
          '  品名:' + FieldByName('RLB004').AsString + ' 入库数量:' + FormatFloat(mFmtStr10, FieldByName('RLB006').AsFloat)
          + ' 未审核');
      //20121225 modi by 603744 for Z30-12121700001 end====================
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.pcStepChange(Sender: TObject);
begin
  inherited;
//20220523 modi by 11245 for X-1001321 优化 ==begin==
  prgBar.Visible := False;
  prgBar.Position := 0;
  //20220523 modi by 11245 for X-1001321 优化 ==end==
end;

// 20221008 Add by liucb(01684) for x-1000722 增加超领单 ==begin==

procedure TfrmCOPDR28.GetChaoLingDan(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
  mSQL := 'select RBB013,RBB002,RBB003,RBA004,RBB004,RBB005,RBB009 from SGMRBA left join SGMRBB on RBA001=RBB001 and RBA002=RBB002 where RBA001=''8C'' and RBB023=' +
    quotedstr(xLaiYuan) + ' and RBB010=' + quotedstr(xDanHao);
  mSQL := mSQL + ' order by RBB004,RBB002';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '超领单');
    First;
    while not Eof do
    begin
      if FieldByName('RBB013').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RBB002').AsString + ']' + '-' + fieldbyname('RBB003').AsString + ' ' +
          TransDateOut(fieldbyname('RBA004').AsString, False) + ' 品号:' + FieldByName('RBB004').AsString +
          '  品名:' + FieldByName('RBB005').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('RBB009').AsFloat)
          + ' 已审核')
      else if FieldByName('RBB013').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RBB002').AsString + ']' + '-' + fieldbyname('RBB003').AsString + ' ' +
          TransDateOut(fieldbyname('RBA004').AsString, False) + ' 品号:' + FieldByName('RBB004').AsString +
          '  品名:' + FieldByName('RBB005').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('RBB009').AsFloat)
          + ' 未审核');
      Next;
    end;
  finally
    Free;
  end;

end;

procedure TfrmCOPDR28.GetWeiWaiChaoSongDan(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
  mSQL := 'select RFA015,RFB002,RFB003,RFA004,RFB004,RFB005,RFB009 from SGMRFA left join SGMRFB on RFA001=RFB001 and RFA002=RFB002 where RFB001=''8D'' and  RFB010=' + quotedstr(xDanHao);
  mSQL := mSQL + ' order by RFA004,RFA002';//20220915 modi by 11245 for x-1001635 增加排序，排序规则为：日期+单号
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '委外超送单');
    First;
    while not Eof do
    begin
      if FieldByName('RFA015').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RFB002').AsString + ']' + '-' + fieldbyname('RFB003').AsString + ' ' +
          TransDateOut(fieldbyname('RFA004').AsString, False) + ' 品号:' + FieldByName('RFB004').AsString +
          '  品名:' + FieldByName('RFB005').AsString + ' 送料数量:' + FormatFloat(mFmtStr10, FieldByName('RFB009').AsFloat)
          + ' 已审核')
      else if FieldByName('RFA015').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RFB002').AsString + ']' + '-' + fieldbyname('RFB003').AsString + ' ' +
          TransDateOut(fieldbyname('RFA004').AsString, False) + ' 品号:' + FieldByName('RFB004').AsString +
          '  品名:' + FieldByName('RFB005').AsString + ' 送料数量:' + FormatFloat(mFmtStr10, FieldByName('RFB009').AsFloat)
          + ' 未审核');
      Next;
    end;
  finally
    Free;
  end;
end;
// 20221008 Add by liucb(01684) for x-1000722 增加超领单 ==end==


//20221019 modi by 01514 for X-1000132 增加模糊查询  begin
procedure TfrmCOPDR28.tvMainCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  inherited;
  if (Node.Selected) then
  begin
    with Sender.Canvas do
    begin
      Brush.Color := clHighlight;
      Font.Color := clHighlightText;
    end;
  end;
end;

procedure TfrmCOPDR28.edtQueryChange(Sender: TObject);
begin
  inherited;
  edtQuery.Tag := 0;
end;

procedure TfrmCOPDR28.edtQueryKeyPress(Sender: TObject; var Key: Char);
var
  i: integer;
begin
  if not tvMain.Enabled then
    Exit;
  if edtQuery.Text = '' then
    Exit;
  if (Key = #13) then
  begin
    Key := #0;
    try
      for i := edtQuery.Tag + 1 to tvMain.Items.Count - 1 do
      begin
        if pos(UpperCase(edtQuery.Text), UpperCase(tvMain.Items[i].Text)) > 0 then
        begin
          edtQuery.Tag := i;
          tvMain.Items[i].Selected := True;
          Exit;
        end;
      end;
      edtQuery.Tag := 0;
    except
    end;
  end;

end;

procedure TfrmCOPDR28.edtQueryEnter(Sender: TObject);
begin
  inherited;
  self.KeyPreview := False;
  if edtQuery.Text = '      输入查询内容后请按回车键' then
  begin
    edtQuery.Text := '';
    edtQuery.Font.Color := clBlack;
    imgSearch.Visible := False;
  end;
end;

procedure TfrmCOPDR28.edtQueryExit(Sender: TObject);
begin
  inherited;
  self.KeyPreview := True;
  if edtQuery.Text = '' then
  begin
    edtQuery.Text := '      输入查询内容后请按回车键';
    edtQuery.Font.Color := clGray;
    imgSearch.Visible := True;
  end;
end;

//20221019 modi by 01514 for X-1000132 增加模糊查询  end

// 20240327 Add by liucb(01684) for b-1002683 增加退料单
procedure TfrmCOPDR28.GetTuiLiao(xnode: TTreeNode; xLaiYuan, xDanHao,
  xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
  mSQL := 'select RBB013,RBA004,RBB002,RBB003,RBB004,RBB005,RBB009 from SGMRBA left join SGMRBB on RBA001=RBB001 and RBA002=RBB002 where RBA001=''83'' and RBB023=' +
    quotedstr(xLaiYuan) + ' and RBB010=' + quotedstr(xDanHao);
  mSQL := mSQL + ' order by RBA004,RBA002';
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '退料单');
    First;
    while not Eof do
    begin
      if FieldByName('RBB013').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RBB002').AsString + ']' + '-' + fieldbyname('RBB003').AsString + ' ' +
          TransDateOut(fieldbyname('RBA004').AsString, False) + ' 品号:' + FieldByName('RBB004').AsString +
          '  品名:' + FieldByName('RBB005').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('RBB009').AsFloat)
          + ' 已审核')
      else if FieldByName('RBB013').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RBB002').AsString + ']' + '-' + fieldbyname('RBB003').AsString + ' ' +
          TransDateOut(fieldbyname('RBA004').AsString, False) + ' 品号:' + FieldByName('RBB004').AsString +
          '  品名:' + FieldByName('RBB005').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('RBB009').AsFloat)
          + ' 未审核');
      Next;
    end;
  finally
    Free;
  end;

end;

procedure TfrmCOPDR28.GetWeiWaiTuiLiaoDan(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL: string;
begin
  mSQL := 'select RFA015,RFB002,RFB003,RFA004,RFB004,RFB005,RFB009 from SGMRFA left join SGMRFB on RFA001=RFB001 and RFA002=RFB002 where RFB001=''88'' and  RFB010=' + quotedstr(xDanHao); //20220523 modi by 11245 for X-1001321 优化
  mSQL := mSQL + ' order by RFA004,RFA002';
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '委外退料单');
    First;
    while not Eof do
    begin
      if FieldByName('RFA015').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RFB002').AsString + ']' + '-' + fieldbyname('RFB003').AsString + ' ' +
          TransDateOut(fieldbyname('RFA004').AsString, False) + ' 品号:' + FieldByName('RFB004').AsString +
          '  品名:' + FieldByName('RFB005').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('RFB009').AsFloat)
          + ' 已审核')
      else if FieldByName('RFA015').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RFB002').AsString + ']' + '-' + fieldbyname('RFB003').AsString + ' ' +
          TransDateOut(fieldbyname('RFA004').AsString, False) + ' 品号:' + FieldByName('RFB004').AsString +
          '  品名:' + FieldByName('RFB005').AsString + ' 数量:' + FormatFloat(mFmtStr10, FieldByName('RFB009').AsFloat)
          + ' 未审核');
      Next;
    end;
  finally
    Free;
  end;

end;
// 20240327 Add by liucb(01684) for b-1002683 增加退料单

procedure TfrmCOPDR28.GetWeiWaiTuiHuoDan(xnode: TTreeNode; xLaiYuan,
  xDanHao, xXUHao: string);
var
  root_node, cur_node: TTreeNode;
  mSQL : string;  
begin
  mSQL := ' select RGA050,RGC002,RGC040,RGA004,RGC033,RGC005,A.DEA002 AS RGC033C from SGMRGA left join SGMRGC  on RGA001=RGC001 and RGA002=RGC002 ' + //20220523 modi by 11245 for X-1001321 优化
    ' LEFT JOIN TPADEA A ON A.DEA001=RGC033 ' +
    ' where RGA001=''90'' and  RGC036=' + quotedstr(xLaiYuan) + ' and RGC003=' + quotedstr(xDanHao);
  if xXUHao <> '' then
    mSQL := mSQL + ' and RGC037=' + quotedstr(xXUHao);
  mSQL := mSQL + ' order by RGA004,RGA002';
  with TdmCOPDR28(FDM).OpenQueryDataSet(mSQL) do
  try
    if not IsEmpty then
      root_node := tvMain.Items.AddChild(xnode, '委外退货单');
    First;
    while not Eof do
    begin
      if FieldByName('RGA050').AsString = 'T' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RGC002').AsString + ']' + '-' + fieldbyname('RGC040').AsString + ' ' +
          TransDateOut(fieldbyname('RGA004').AsString, False) + ' 品号:' + FieldByName('RGC033').AsString + '  品名:' + FieldByName('RGC033C').AsString + ' 退货数量:' + FormatFloat(mFmtStr10, FieldByName('RGC005').AsFloat)
          + ' 已审核')
      else if FieldByName('RGA050').AsString = 'F' then
        cur_node := tvMain.Items.AddChild(root_node, '[' + fieldbyname('RGC002').AsString + ']' + '-' + fieldbyname('RGC040').AsString + ' ' +
          TransDateOut(fieldbyname('RGA004').AsString, False) + ' 品号:' + FieldByName('RGC033').AsString + '  品名:' + FieldByName('RGC033C').AsString + ' 退货数量:' + FormatFloat(mFmtStr10, FieldByName('RGC005').AsFloat)
          + ' 未审核');
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCOPDR28.FormShow(Sender: TObject);
begin
  inherited;
  if spTicket.ListBox.Items.Count > 0 then spTicket.ListBox.ColumnAutoReSize; //单号
  if spCustom.ListBox.Items.Count > 0 then spCustom.ListBox.ColumnAutoReSize; //客户
end;

end.

