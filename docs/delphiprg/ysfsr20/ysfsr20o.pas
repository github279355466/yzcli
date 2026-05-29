//20040326 by 28982(shiliang) for P10-04030002 增加报表直接查询功能
//20060124 modi by 33509 for P10-05120023 更改报表呈现方式
//20060323 ADD BY 36006 FOR Q10-06032200002  修改格式档标题字段
//20061206 modi by 35916 for P10-04070012 删除代码控制，在属性中设置
//20080409 modi by 41815 for B10-0804009001
unit ysfsr20o;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RPBaseOptF, DSDesigner, urConditionStorage, StdCtrls, ExtCtrls,
  urEdit, ComCtrls, urPage, Mask, urChkBox, Spin, DB, ADODB, urADODataSet,
  Menus, DCComboBox, ImgList, DianJinReport, SelectPnl;

type
  TOptysfsr20 = class(TRPBaseOpt)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    sp01A: TurEdit;
    sp02A: TurEdit;
    Label2: TLabel;
    sp02B: TurEdit;
    sp03A: TurEdit;
    Label3: TLabel;
    sp03B: TurEdit;
    sp04A: TurEdit;
    Label4: TLabel;
    sp04B: TurEdit;
    Label5: TLabel;
    sp05A: TurEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    chkOther: TurCheckBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Edit01: TurEdit;
    Edit02: TurEdit;
    Edit03: TurEdit;
    Edit04: TurEdit;
    Edit05: TurEdit;
    rbDJDate: TRadioButton;
    rbSKDate: TRadioButton;
    edDJDate: TurDateEdit;
    edSKDate: TurDateEdit;
    spCustom: TSelectPanel;
    procedure sp01AKeyPress(Sender: TObject; var Key: Char);
    procedure sp01AExit(Sender: TObject);
    procedure sp02BExit(Sender: TObject);
    procedure sp03BExit(Sender: TObject);
    procedure sp04BExit(Sender: TObject);
    procedure Edit01Exit(Sender: TObject);
    procedure Edit01KeyPress(Sender: TObject; var Key: Char);
    procedure rbDJDateClick(Sender: TObject);
    procedure rbSKDateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure FormInit; override;
    function BeforeStart: Boolean; override;
    procedure OpenF2Window(var Key: Word; ActiveCtrl: TWinControl); override;
    function MakeCondition(var vCond: variant): boolean; override;
  public
    { Public declarations }
  end;

var
  Optysfsr20: TOptysfsr20;

implementation
uses ysfsr20r, DateSelecter, LibTPA, ysfsr20g;

{$R *.dfm}

procedure TOptysfsr20.FormInit;
begin
  inherited;
  //指定报表生成Form物件
  RPBaseFmtClass := Tfmtysfsr20;
  //指定此作业传送支持功能
  //self.SetSendoutSupport(SENDOUTSUPPORT_EMAIL + SENDOUTSUPPORT_FAX) ;
  //设置采用固定式选择报表样式
  //Self.SetStyleSelectType(True) ;

  //20040326 by 28982(shiliang) for P10-04030002 down
  UseRPSQL := False;
  RPBaseGridClass := Tgrdysfsr20;
  //20040326 by 28982(shiliang) for P10-04030002 up
end;

function TOptysfsr20.BeforeStart: Boolean;
begin
  Result := inherited BeforeStart;
  if not Result then exit;

  // 缺省为单据日期
  //20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析 begin====
  rbDJDate.Checked := True;
  rbSKDate.Checked := False;
  edDJDate.Text := FormatDateTime('YYYYMMDD', now);
  //20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析 end======
  // 含其他应收帐款明细
  //chkOther.Checked := True;  //20061206 modi by 35916

  //日期的历别 , 间隔符号设置
  edDJDate.SetDateFormat(Self.DateType, Self.DateSign);
  edSKDate.SetDateFormat(Self.DateType, Self.DateSign);
  edSKDate.Enabled := False; //20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析
  sp01A.OnExit(Self); //20080409 modi by 41815 for B10-0804009001

end;

procedure TOptysfsr20.OpenF2Window(var Key: Word; ActiveCtrl: TWinControl);
begin
  inherited;
  // 请款客户开窗
//  if (ActiveCtrl = edCustNo01) or (ActiveCtrl = edCustNo02) then
//    Self.PutDatas(OpenF2Form('TPADFA', '001', [], ['DFA001']), ActiveCtrl)
//  else
  //日期
//    if (ActiveCtrl = edDJDate) then
//      Self.PutDatas(Self.OpenPartner('UWCALENDAR', [TurDateEdit(ActiveCtrl).Text]), ActiveCtrl)
//    else if (ActiveCtrl = edSKDate) then //20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析
//      Self.PutDatas(Self.OpenPartner('UWCALENDAR', [TurDateEdit(ActiveCtrl).Text]), ActiveCtrl); //20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析

  if (ActiveCtrl is TurDateEdit) then  //日期 
    PutDatas( OpenPartner( 'UWCALENDAR', [TurDateEdit(ActiveCtrl).Text] ), ActiveCtrl )
  else if (ActiveCtrl=spCustom.edBegin) or (ActiveCtrl=spCustom.edFinal) then  //客户
    PutDatas(OpenF2Form('TPADFA', '001', [], ['DFA001']), ActiveCtrl)
  else if ActiveCtrl = spCustom.ListBox then
    spCustom.PutDatas(OpenF2Form('TPADFA', '001', [], ['DFA001','DFA002'],True));
end;

function TOptysfsr20.MakeCondition(var vCond: variant): boolean;
begin
  inherited MakeCondition(vCond);
  //先检查条件是否符合 ?
  Result := True;
  //20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析 begin========
  if rbDJDate.Checked then
  begin
    if trim(edDJDate.Text) = '' then // 检查截止日期不可空白
    begin
      Result := False;
    // Msg : %s 不可为空白!
      Self.TPAMsgDlg('203031003', ['单据日期']);
      edDJDate.SetFocus;
    end;
  end
  else if rbSKDate.Checked then
  begin
    if trim(edSKDate.Text) = '' then // 检查预收款日不可空白
    begin
      Result := False;
    // Msg : %s 不可为空白!
      Self.TPAMsgDlg('203031003', ['预收款日']);
      edSKDate.SetFocus;
    end;
  end;
  //20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析 end========
//20130528 mark by 03433 for Z30-13050800006 增加按预收款日分析 begin===========
//  if  trim(edDJDate.Text)= '' then   // 检查截止日期不可空白
//  begin
//    Result := False;
//    // Msg : %s 不可为空白!
//    Self.TPAMsgDlg( '203031003', [edDJDate.text]);
//    edDJDate.SetFocus ;
//  end;
//20130528 mark by 03433 for Z30-13050800006 增加按预收款日分析 end===============
  //sp04B.OnExit(Self); //为了更新最后一格的天数(避免用户未按enter 即退出)
  sp01A.OnExit(Self); //20080409 modi by 41815 for B10-0804009001
  //制作条件
  //vCond    := VarArrayCreate([0,7], varVariant) ;//20130528 mark by 03433 for Z30-13050800006 增加按预收款日分析
  vCond := VarArrayCreate([0, 8], varVariant); //20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析
  vCond[0] := spCustom.GetDatas; //客户
  vCond[1] := VarArrayOf([edDJDate.Text, 'GCA004']); // 单据日期
  vCond[2] := chkOther.Checked; // 含其他应收帐款明细
  vCond[3] := VarArrayOf([sp01A.Text, edit01.text]);
  vCond[4] := VarArrayOf([sp02A.Text, sp02B.Text, edit02.text]);
  vCond[5] := VarArrayOf([sp03A.Text, sp03B.Text, edit03.text]);
  vCond[6] := VarArrayOf([sp04A.Text, sp04B.Text, edit04.text]);
  vCond[7] := VarArrayOf([sp05A.Text, edit05.text]);
  vCond[8] := VarArrayOf([edSKDate.Text, 'GCA019']); //预收款日//20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析
  CondOne := GenCond(spCustom); //20060124 add by 33509 for P10-05120023
end;

procedure TOptysfsr20.sp01AKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not ((key in ['0'..'9']) or (key = #8)) then Key := #0;
end;

procedure TOptysfsr20.sp01AExit(Sender: TObject);
begin
  inherited;
  sp02A.Text := IntToStr(StrToIntDef(sp01A.Text, 0) + 1);
  if StrToIntDef(sp02B.Text, 0) < StrToIntDef(sp02A.Text, 0) then
    sp02B.Text := sp02A.Text;
  sp02BExit(nil);
end;

procedure TOptysfsr20.sp02BExit(Sender: TObject);
begin
  inherited;
  if StrToIntDef(sp02B.Text, 0) < StrToIntDef(sp02A.Text, 0) then
  begin
    Self.TPAMsgDlg('200161000', [sp02A.Text]); //输入值须大于等于 %s
    sp02B.Text := sp02A.Text;
  end;
  sp03A.Text := IntToStr(StrToIntDef(sp02B.Text, 0) + 1);
  if StrToIntDef(sp03B.Text, 0) < StrToIntDef(sp03A.Text, 0) then
    sp03B.Text := sp03A.Text;
  sp03BExit(nil);
end;

procedure TOptysfsr20.sp03BExit(Sender: TObject);
begin
  inherited;
  if StrToIntDef(sp03B.Text, 0) < StrToIntDef(sp03A.Text, 0) then
  begin
    Self.TPAMsgDlg('200161000', [sp03A.Text]); //输入值须大于等于 %s
    sp03B.Text := sp03A.Text;
  end;
  sp04A.Text := IntToStr(StrToIntDef(sp03B.Text, 0) + 1);
  if StrToIntDef(sp04B.Text, 0) < StrToIntDef(sp04A.Text, 0) then
    sp04B.Text := sp04A.Text;
  sp04BExit(nil);
end;

procedure TOptysfsr20.sp04BExit(Sender: TObject);
begin
  inherited;
  if StrToIntDef(sp04B.Text, 0) < StrToIntDef(sp04A.Text, 0) then
  begin
    Self.TPAMsgDlg('200161000', [sp04A.Text]); //输入值须大于等于 %s
    sp04B.Text := sp04A.Text;
  end;
  sp05A.Text := IntToStr(StrToIntDef(sp04B.Text, 0) + 1);
end;

procedure TOptysfsr20.Edit01Exit(Sender: TObject);
var mEditName: string;
begin
  inherited;
  if (Sender is TEdit) then
  begin
    try
      mEditName := 'Edit' + Copy(TEdit(Sender).Name, 5, Length(TEdit(Sender).Name) - 4);
      if (trim(TEdit(Self.FindComponent(mEditName)).Text) = '') or (strtofloat(TEdit(Self.FindComponent(mEditName)).Text) = 0) then
        TEdit(Self.FindComponent(mEditName)).Text := '0.00';
      if (strtofloat(TEdit(Self.FindComponent(mEditName)).Text) < 0) or (strtofloat(TEdit(Self.FindComponent(mEditName)).Text) > 100) then
      begin
        Self.TPAMsgDlg('200251006', ['坏账提列比率 ', ' 0 ', ' 100 ']); //%s须大于等于 %s 小于等于 %s
        TEdit(Self.FindComponent(mEditName)).SetFocus;
      end;
    except
      Self.TPAMsgDlg('200011000', ['坏账提列比率 输入']); //坏账提列比率输入错误,请重输.
      TEdit(Self.FindComponent(mEditName)).SetFocus;
    end;
  end;
end;

procedure TOptysfsr20.Edit01KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not ((key in ['0'..'9']) or (key = #8) or (key = #46)) then Key := #0;

end;

//20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析 begin=========
procedure TOptysfsr20.rbDJDateClick(Sender: TObject);
begin
  inherited;
  edDJDate.Enabled := True;
  edDJDate.Text :=FormatDateTime('YYYYMMDD',now);
  edSKDate.Text := '';
  edSKDate.Enabled := False;
end;

procedure TOptysfsr20.rbSKDateClick(Sender: TObject);
begin
  inherited;
  edDJDate.Text:='';
  edDJDate.Enabled := False;
  edSKDate.Enabled := True;
  edSKDate.Text :=FormatDateTime('YYYYMMDD',now);
end;
//20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析 end===========

procedure TOptysfsr20.FormShow(Sender: TObject);
begin
  inherited;
  if spCustom.ListBox.Items.Count > 0 then spCustom.ListBox.ColumnAutoReSize; //客户
end;

end.

