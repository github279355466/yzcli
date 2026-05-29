//20030219 by zhubiao P10-02030002 修改品号长度30->60
//20040311 modi by wangyjb P10-04030002  直接查询
//20170418 MODI BY 03277 FOR Z30-17041700001 增加是否显示"库存为0且呆滞期无异动"的选项
unit INVkr18o;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RPBaseOptF, DSDesigner, urConditionStorage, StdCtrls, ExtCtrls,
  urEdit, ComCtrls, urPage, Mask, urChkBox, Spin, DB, ADODB, urADODataSet,
  Menus, DCComboBox, wwdbedit, Wwdbspin, DianJinReport, ImgList, SelectPnl;

type
  ToptINVkr18 = class(TRPBaseOpt)
    gpbItem: TGroupBox;
    rbItem: TRadioButton;
    rbType: TRadioButton;
    rgpDate: TRadioGroup;
    lblDate01: TLabel;
    lblDate02: TLabel;
    edDateNum: TwwDBSpinEdit;
    chkPH: TurCheckBox;
    chk1: TurCheckBox;
    spCategory: TSelectPanel;
    spGoodsNo: TSelectPanel;
    spWareHouse: TSelectPanel;
    procedure rbItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure FormInit; override;
    function  BeforeStart: Boolean; override;
    procedure OpenF2Window(var Key: Word; ActiveCtrl: TWinControl); override;
    function  MakeCondition(var vCond: variant): boolean; override;
  public
    { Public declarations }
  end;

var        
  optINVkr18: ToptINVkr18;

implementation
uses INVkr18r, INVkr18g,LibTPA ;

{$R *.dfm}
procedure ToptINVkr18.FormInit;
begin
  inherited ;
  //指定报表生成Form物件
  RPBaseFmtClass := TfmtINVkr18;
  //指定此作业传送支持功能
  //self.SetSendoutSupport(SENDOUTSUPPORT_EMAIL + SENDOUTSUPPORT_FAX) ;
  //设置采用固定式选择报表样式
  //Self.SetStyleSelectType(True) ;
//20040311 add by wangyjb begin
  UseRPSQL := False;
  RPBaseGridClass := TgrdINVkr18;
//20040311 add by wangyjb end
end;

function  ToptINVkr18.BeforeStart: Boolean;
begin
  Result := inherited BeforeStart;
  if not Result then exit;

  Self.rbItemClick( nil );
end;

procedure ToptINVkr18.OpenF2Window(var Key: Word; ActiveCtrl: TWinControl);
begin
  inherited ;
  //品号开窗
//  if (ActiveCtrl = edItem01) or (ActiveCtrl = edItem02) then
//    PutDatas( OpenF2Form( 'TPADEA', '001', [], ['DEA001'] ), ActiveCtrl )
//  else
  //分类开窗
//  if (ActiveCtrl = edType01) or (ActiveCtrl = edType02) then
//    PutDatas( OpenF2Form( 'TPADED', '001', ['0'], ['DED002'] ), ActiveCtrl )
//    else
//    if (ActiveCtrl = edstore01) or (ActiveCtrl = edstore02) then         //20111124 ADD BY 602092
//    PutDatas( OpenF2Form( 'TPADDA', '001', [], ['DDA001'] ), ActiveCtrl );

   if (ActiveCtrl=spCategory.edBegin) or (ActiveCtrl=spCategory.edFinal) then  //商品分类
    PutDatas(OpenF2Form('TPADED', '001', ['0'], ['DED002']), ActiveCtrl)
  else if ActiveCtrl = spCategory.ListBox then
    spCategory.PutDatas(OpenF2Form('TPADED', '001', ['0'], ['DED002','DED003'],True))

  else if (ActiveCtrl=spGoodsNo.edBegin) or (ActiveCtrl=spGoodsNo.edFinal) then  //品号
    PutDatas(OpenF2Form('TPADEA', '001', [], ['DEA001']), ActiveCtrl)
  else if ActiveCtrl = spGoodsNo.ListBox then
    spGoodsNo.PutDatas(OpenF2Form('TPADEA', '001', [], ['DEA001','DEA002'],True))
 else if (ActiveCtrl=spWareHouse.edBegin) or (ActiveCtrl=spWareHouse.edFinal) then  //仓库
    PutDatas(OpenF2Form('TPADDA', '001', [], ['DDA001']), ActiveCtrl)
  else if ActiveCtrl = spWareHouse.ListBox then
    spWareHouse.PutDatas(OpenF2Form('TPADDA', '001', [], ['DDA001','DDA003'],True))   
end;

procedure ToptINVkr18.rbItemClick(Sender: TObject);
begin
  inherited;
  spGoodsNo.Visible := rbItem.Checked;
  spCategory.Visible := not spGoodsNo.Visible;
end;

function  ToptINVkr18.MakeCondition(var vCond: variant): boolean;
begin
  inherited MakeCondition(vCond);
  //先检查条件是否符合 ?
  //制作条件
//  vCond    := VarArrayCreate([0,5], varVariant) ;
  vCond    := VarArrayCreate([0,8], varVariant) ;
  if rbItem.Checked then
  begin
    vCond[0] := 0;//起止商品依据=品号
    vCond[1] := rbItem.Caption;
    vCond[2] := spGoodsNo.GetDatas; //品号
  end
  else
  begin
    vCond[0] := 1;//起止商品依据=商品分类
    vCond[1] := rbType.Caption;
    vCond[2] := spCategory.GetDatas; //商品分类
  end;

  vCond[3] := rgpDate.ItemIndex;                                    //呆滞天数计数依据
  vCond[4] := rgpDate.Items.Strings[rgpDate.ItemIndex];
  vCond[5] := edDateNum.Value;                                      //呆滞天数

  vCond[6] := spWareHouse.GetDatas; //仓库  //20111124 ADD BY 602092
  vCond[7] := chkPH.Checked;                                    //20111124 ADD BY 602092
  vCond[8] := chk1.Checked;      //20170418 ADD BY 03277 FOR Z30-17041700001
  Result   := True ;

  if rbItem.Checked then
     CondOne := GenCond(spGoodsNo)
  else
     CondOne := GenCond(spCategory);
  //CondTwo :=  lblDate01.Caption + ': ' +inttostr(edDateNum.Value) ;           //20090527 Mark By 46124 For P10-09040003
  CondTwo :=  lblDate01.Caption + ': ' +FloatToStr(edDateNum.Value) ;           //20090527 Add  By 46124 For P10-09040003
end;

procedure ToptINVkr18.FormShow(Sender: TObject);
begin
  inherited;
  if spCategory.ListBox.Items.Count > 0 then spCategory.ListBox.ColumnAutoReSize; //商品分类
  if spGoodsNo.ListBox.Items.Count > 0 then spGoodsNo.ListBox.ColumnAutoReSize; //品号
  if spWareHouse.ListBox.Items.Count > 0 then spWareHouse.ListBox.ColumnAutoReSize; //仓库
end;

end.

