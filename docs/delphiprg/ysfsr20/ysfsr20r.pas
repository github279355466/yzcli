//20071225 add by 36006 for Z30-07121100001 权限管理
//20100907  modi by 601209 for Z30-10090700001  易助5.0Patch 开发增加客户全称字段
//20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析
unit ysfsr20r;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RPDetailFmtF, QRExport, DB, ADODB, urADODataSet, QRCtrls,
  QuickRpt, ExtCtrls;

type
  TFmtysfsr20 = class(TRPDetailFmt)
    qrgpHeader: TQRGroup;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    lblDFA002: TQRLabel;
    lblDate: TQRLabel;
    lblDate01: TQRLabel;
    txtDFA002: TQRDBText;
    txtGCA016E: TQRDBText;
    QRLabel5: TQRLabel;
    lblCustNo01: TQRLabel;
    lblGCA003: TQRLabel;
    lbl01: TQRLabel;
    txtGCA003: TQRDBText;
    txtGCA016D: TQRDBText;
    txtGCA016C: TQRDBText;
    txtGCA016B: TQRDBText;
    txtGCA016A: TQRDBText;
    lbl02: TQRLabel;
    lbl03: TQRLabel;
    lbl04: TQRLabel;
    lbl05: TQRLabel;
    lbl06: TQRLabel;
    txtGCA016F: TQRDBText;
    QRLabel1: TQRLabel;
    lblGCA016A: TQRLabel;
    lblGCA016B: TQRLabel;
    lblGCA016C: TQRLabel;
    lblGCA016D: TQRLabel;
    lblGCA016E: TQRLabel;
    lblGCA016F: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape4: TQRShape;
    lblTotalBad016A: TQRLabel;
    lblTotalBad016B: TQRLabel;
    lblTotalBad016C: TQRLabel;
    lblTotalBad016D: TQRLabel;
    lblTotalBad016E: TQRLabel;
    lblTotalBadAll: TQRLabel;
    lblSumBad016A: TQRLabel;
    lblSumBad016B: TQRLabel;
    lblSumBad016C: TQRLabel;
    lblSumBad016D: TQRLabel;
    lblSumBad016E: TQRLabel;
    lblSumBadAll: TQRLabel;
    procedure bndSummaryBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bndDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    FSum: array [1..5] of double;
  protected
    procedure FormInit; override;
    function  MakeSQLCommand(vCond : variant): boolean; override;
    procedure SetupRPCtrlObj; override;
    procedure SetupRPCtrlField; override;
  public
    FPercent: array[1..5] of double;
    procedure Init; override;
  end;

var
  Fmtysfsr20: TFmtysfsr20;

implementation
uses libtpa, RPConstDef,ysfsr20o ;
{$R *.dfm}

procedure TFmtysfsr20.FormInit;
begin
  Inherited ;
  //是否使用信息浏览
  //UseDataView := False;
  //指定此作业传送支持功能
  //FSendOutSupport := SENDOUTSUPPORT_EMAIL + SENDOUTSUPPORT_FAX;
  UseReplaceTableOff:=True;//20071109 add by 40589 for P10-07080005
end;

procedure TFmtysfsr20.SetupRPCtrlObj;
begin
  inherited;
  //小数取位 , 成本权限控制 for ReportView
  self.AddRPCostObj('txtGCA016A', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('txtGCA016B', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('txtGCA016C', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('txtGCA016D', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('txtGCA016E', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('txtGCA016F', True , NUMSTYLE_NOWMONEY) ; //金额

  self.AddRPCostObj('lblGCA016A', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblGCA016B', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblGCA016C', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblGCA016D', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblGCA016E', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblGCA016F', True , NUMSTYLE_NOWMONEY) ; //金额

  self.AddRPCostObj('lblSumBad016A', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblSumBad016B', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblSumBad016C', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblSumBad016D', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblSumBad016E', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblSumBadAll' , True , NUMSTYLE_NOWMONEY) ; //金额

  self.AddRPCostObj('lblTotalBad016A', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblTotalBad016B', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblTotalBad016C', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblTotalBad016D', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblTotalBad016E', True , NUMSTYLE_NOWMONEY) ; //金额
  self.AddRPCostObj('lblTotalBadAll' , True , NUMSTYLE_NOWMONEY) ; //金额
end;

procedure TFmtysfsr20.SetupRPCtrlField;
begin
  inherited;
  //日期字段
  self.AddRPDateField('GCA004'); // 来源日期
  self.AddRPDateField('GCA019');//20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析
end;

//组条件SQL
function  TFmtysfsr20.MakeSQLCommand(vCond : variant): boolean;
begin
  Inherited MakeSQLCommand(vCond);
//  lblCustNo01.Caption   := vCond[0][0]+' ~ '+vCond[0][1];
  lblDate01.Caption := TransDateOut(vCond[1][0], self.DateType, self.DateSign);
  if trim(vCond[3][1])='' then
    FPercent[1]:=0
  else
    FPercent[1]:=strtoFloat(trim(vCond[3][1]))/100;
  if trim(vCond[4][2])='' then
    FPercent[2]:=0
  else
    FPercent[2]:=strtoFloat(trim(vCond[4][2]))/100;
  if trim(vCond[5][2])='' then
    FPercent[3]:=0
  else
    FPercent[3]:=strtoFloat(trim(vCond[5][2]))/100;
  if trim(vCond[6][2])='' then
    FPercent[4]:=0
  else
    FPercent[4]:=strtoFloat(trim(vCond[6][2]))/100;
  if trim(vCond[7][1])='' then
    FPercent[5]:=0
  else
    FPercent[5]:=strtoFloat(trim(vCond[7][1]))/100;

  lbl01.Caption     := vCond[3][0] + '天以内';
  lbl02.Caption     := vCond[4][0] + '天~'+ vCond[4][1]+'天';
  lbl03.Caption     := vCond[5][0] + '天~'+ vCond[5][1]+'天';
  lbl04.Caption     := vCond[6][0] + '天~'+ vCond[6][1]+'天';
  lbl05.Caption     := vCond[7][0] + '天以上';

  //FSQLSelect := ' select GCA003,DFA002, '  +  //20100907  modi by 601209 for Z30-10090700001  易助5.0Patch 开发增加客户全称字段
  FSQLSelect := ' select GCA003,DFA002,DFA003, '  +   //20100907  modi by 601209 for Z30-10090700001  易助5.0Patch 开发增加客户全称字段
                ' sum(GCA016X) as GCA016A,'+
                ' sum(GCA016Y) as GCA016B,'+
                ' sum(GCA016Z) as GCA016C,'+
                ' sum(GCA016P) as GCA016D,'+
                ' sum(GCA016Q) as GCA016E,'+
                ' sum(GCA016X + GCA016Y + GCA016Z + GCA016P + GCA016Q) as GCA016F '+
                ' from '+
                //' (select GCA003,GCA001,GCA016,GCA017,GCA004,GCA018, '+//20071225 add by 36006 for Z30-07121100001 权限管理
                //' (select GCA003,GCA901,GCA001,GCA016,GCA017,GCA004,GCA018, ';//20071225 add by 36006 for Z30-07121100001 权限管理//20130528 mark by 03433 for Z30-13050800006 增加按预收款日分析
  //20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析 begin=================================================
                ' (select GCA003,GCA901,GCA001,GCA016,GCA017,GCA004,GCA018,GCA019, ';
  if TOptysfsr20(Self.Owner).rbDJDate.Checked then
    FSQLSelect:=FSQLSelect+format(' GCA016X= ( case  when datediff(day,%s,''%s'') <=''%s''                  then ((GCA016-GCA017)*GCA020) else 0 end ), ',[ vCond[1][1], vCond[1][0], vCond[3][0] ] )+
                           format(' GCA016Y= ( case  when datediff(day,%s,''%s'') between ''%s'' and ''%s'' then ((GCA016-GCA017)*GCA020) else 0 end ), ',[ vCond[1][1], vCond[1][0], vCond[4][0], vCond[4][1] ] )+
                           format(' GCA016Z= ( case  when datediff(day,%s,''%s'') between ''%s'' and ''%s'' then ((GCA016-GCA017)*GCA020) else 0 end ), ',[ vCond[1][1], vCond[1][0], vCond[5][0], vCond[5][1] ] )+
                           format(' GCA016P= ( case  when datediff(day,%s,''%s'') between ''%s'' and ''%s'' then ((GCA016-GCA017)*GCA020) else 0 end ), ',[ vCond[1][1], vCond[1][0], vCond[6][0], vCond[6][1] ] )+
                           format(' GCA016Q= ( case  when datediff(day,%s,''%s'') >=''%s''                  then ((GCA016-GCA017)*GCA020) else 0 end )  ',[ vCond[1][1], vCond[1][0], vCond[7][0] ] )
  else if TOptysfsr20(Self.Owner).rbSKDate.Checked then
    FSQLSelect:=FSQLSelect+format(' GCA016X= ( case  when datediff(day,%s,''%s'') <=''%s''                  then ((GCA016-GCA017)*GCA020) else 0 end ), ',[ vCond[8][1], vCond[8][0], vCond[3][0] ] )+
                           format(' GCA016Y= ( case  when datediff(day,%s,''%s'') between ''%s'' and ''%s'' then ((GCA016-GCA017)*GCA020) else 0 end ), ',[ vCond[8][1], vCond[8][0], vCond[4][0], vCond[4][1] ] )+
                           format(' GCA016Z= ( case  when datediff(day,%s,''%s'') between ''%s'' and ''%s'' then ((GCA016-GCA017)*GCA020) else 0 end ), ',[ vCond[8][1], vCond[8][0], vCond[5][0], vCond[5][1] ] )+
                           format(' GCA016P= ( case  when datediff(day,%s,''%s'') between ''%s'' and ''%s'' then ((GCA016-GCA017)*GCA020) else 0 end ), ',[ vCond[8][1], vCond[8][0], vCond[6][0], vCond[6][1] ] )+
                           format(' GCA016Q= ( case  when datediff(day,%s,''%s'') >=''%s''                  then ((GCA016-GCA017)*GCA020) else 0 end )  ',[ vCond[8][1], vCond[8][0], vCond[7][0] ] );
  FSQLSelect:=FSQLSelect+' from YSFGCA ) as YSFGCA left join TPADFA on ( DFA001=GCA003 ) ';
  //20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析 end====================================================
  if vCond[2] then  // 是否含其他应收帐款
    FSQLWhere  := 'where ( GCA001=''35'' or GCA001=''59'' or GCA001=''60'' or GCA001=''51'' or GCA001=''53'' ) and ( (GCA016-GCA017)<>0 ) '
  else
    FSQLWhere  := 'where ( GCA001=''35'' or GCA001=''59'' or GCA001=''60'' or GCA001=''51'' ) and ( (GCA016-GCA017)<>0 ) ';
  FSQLWhere:=FSQLWhere+AddSecurity('YSFGCA','','GCA003') ;//20071225 add by 36006 for Z30-07121100001 权限管理
  //FSQLWhere  := FSQLWhere + Format( 'and ( GCA004<=%s )', [ vCond[1][0] ]);  // 截止单据日期 //20130528 mark by 03433 for Z30-13050800006 增加按预收款日分析
  //20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析 begin==================
  if TOptysfsr20(Self.Owner).rbDJDate.Checked then
    FSQLWhere  := FSQLWhere + Format( 'and ( GCA004<=%s )', [ vCond[1][0] ])
  else if TOptysfsr20(Self.Owner).rbSKDate.Checked then
    FSQLWhere  := FSQLWhere + Format( 'and ( GCA019<=%s )', [ vCond[8][0] ]);
  //20130528 modi by 03433 for Z30-13050800006 增加按预收款日分析 end========================
  FSQLWhere  := libtpa.GenStartEndSQLsp( FSQLWhere, 'GCA003', vCond[0]) ;  // 起讫请款客户
  //FSQLOrder  := ' group by GCA003,DFA002  order by GCA003 '; //20100907  modi by 601209 for Z30-10090700001  易助5.0Patch 开发增加客户全称字段
  FSQLOrder  := ' group by GCA003,DFA002,DFA003  order by GCA003 ';//20100907  modi by 601209 for Z30-10090700001  易助5.0Patch 开发增加客户全称字段

  Result := True;
end;

procedure TFmtysfsr20.Init;
begin
  Inherited ;
  //
end;

procedure TFmtysfsr20.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var I:integer;
begin
  inherited;
  for I:=1 to 5 do
    FSum[I]:=0;
end;

procedure TFmtysfsr20.bndDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var mBadSum:double;
begin
  inherited;

  with  urADODataSet1 do
  begin
    lblSumBad016A.Caption := FormatByNumStyle(FieldByName('GCA016A').AsFloat*FPercent[1],NUMSTYLE_NOWMONEY);
    lblSumBad016B.Caption := FormatByNumStyle(FieldByName('GCA016B').AsFloat*FPercent[2],NUMSTYLE_NOWMONEY);
    lblSumBad016C.Caption := FormatByNumStyle(FieldByName('GCA016C').AsFloat*FPercent[3],NUMSTYLE_NOWMONEY);
    lblSumBad016D.Caption := FormatByNumStyle(FieldByName('GCA016D').AsFloat*FPercent[4],NUMSTYLE_NOWMONEY);
    lblSumBad016E.Caption := FormatByNumStyle(FieldByName('GCA016E').AsFloat*FPercent[5],NUMSTYLE_NOWMONEY);
    mBadSum:=FieldByName('GCA016A').AsFloat*FPercent[1]+FieldByName('GCA016B').AsFloat*FPercent[2]+FieldByName('GCA016C').AsFloat*FPercent[3]+FieldByName('GCA016D').AsFloat*FPercent[4]+FieldByName('GCA016E').AsFloat*FPercent[5];
    lblSumBadAll.Caption  := FormatByNumStyle(mBadSum,NUMSTYLE_NOWMONEY);

    FSum[1]:=FSum[1]+LibTpa.FourOutFiveIn(FieldByName('GCA016A').AsFloat,FNumTypePrecision[NUMSTYLE_NOWMONEY]) ;
    FSum[2]:=FSum[2]+LibTpa.FourOutFiveIn(FieldByName('GCA016B').AsFloat,FNumTypePrecision[NUMSTYLE_NOWMONEY]) ;
    FSum[3]:=FSum[3]+LibTpa.FourOutFiveIn(FieldByName('GCA016C').AsFloat,FNumTypePrecision[NUMSTYLE_NOWMONEY]) ;
    FSum[4]:=FSum[4]+LibTpa.FourOutFiveIn(FieldByName('GCA016D').AsFloat,FNumTypePrecision[NUMSTYLE_NOWMONEY]) ;
    FSum[5]:=FSum[5]+LibTpa.FourOutFiveIn(FieldByName('GCA016E').AsFloat,FNumTypePrecision[NUMSTYLE_NOWMONEY]) ;

  end;

end;

procedure TFmtysfsr20.bndSummaryBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  lblGCA016A.Caption := FormatByNumStyle(FSum[1],NUMSTYLE_NOWMONEY);
  lblGCA016B.Caption := FormatByNumStyle(FSum[2],NUMSTYLE_NOWMONEY);
  lblGCA016C.Caption := FormatByNumStyle(FSum[3],NUMSTYLE_NOWMONEY);
  lblGCA016D.Caption := FormatByNumStyle(FSum[4],NUMSTYLE_NOWMONEY);
  lblGCA016E.Caption := FormatByNumStyle(FSum[5],NUMSTYLE_NOWMONEY);
  lblGCA016F.Caption := FormatByNumStyle(FSum[1]+FSum[2]+FSum[3]+FSum[4]+FSum[5],NUMSTYLE_NOWMONEY);

  lblTotalBad016A.Caption := FormatByNumStyle(FSum[1]*FPercent[1],NUMSTYLE_NOWMONEY);
  lblTotalBad016B.Caption := FormatByNumStyle(FSum[2]*FPercent[2],NUMSTYLE_NOWMONEY);
  lblTotalBad016C.Caption := FormatByNumStyle(FSum[3]*FPercent[3],NUMSTYLE_NOWMONEY);
  lblTotalBad016D.Caption := FormatByNumStyle(FSum[4]*FPercent[4],NUMSTYLE_NOWMONEY);
  lblTotalBad016E.Caption := FormatByNumStyle(FSum[5]*FPercent[5],NUMSTYLE_NOWMONEY);
  lblTotalBadAll.Caption  := FormatByNumStyle(FSum[1]*FPercent[1]+FSum[2]*FPercent[2]+FSum[3]*FPercent[3]+FSum[4]*FPercent[4]+FSum[5]*FPercent[5],NUMSTYLE_NOWMONEY);

end;


end.
