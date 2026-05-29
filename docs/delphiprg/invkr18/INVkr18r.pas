//20080124 modi by 40589 Z30-07110800004 商品分类层级显示
//20120809 MODI BY 603269 FOR Z30-12080600004
//20121114 modi by 603744 for B11-121114002 增加‘仓库名称’字段
//20130531 modi by 03433 for Z30-13052700002 开放会计分类编号和名称
//20130806 MODI BY 601394 FOR B11-130806001 商品分类编码为手动，商品层级查询不能直接截取
//20170418 MODI BY 03277 FOR Z30-17041700001 增加是否显示"库存为0且呆滞期无异动"的选项
//20170418 MODI BY 03277 FOR Z30-17041700001 增加显示借出数量，借出成本
unit INVkr18r;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RPDetailFmtF, QRExport, DB, ADODB, urADODataSet, QRCtrls,
  QuickRpt, ExtCtrls;

type
  TfmtINVkr18 = class(TRPDetailFmt)
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    lblMaxDateC: TQRLabel;
    lblDEA001: TQRLabel;
    lblDEA002: TQRLabel;
    lblLOA003: TQRLabel;
    lblIdleDaysC: TQRLabel;
    lblDate: TQRLabel;
    lblItvDate: TQRLabel;
    txtDEA001: TQRDBText;
    txtDEA002: TQRDBText;
    lblIdleDays: TQRLabel;
    lblLOA006: TQRLabel;
    lblLOA005: TQRLabel;
    lblItem: TQRLabel;
    lblItvItem: TQRLabel;
    lblLOA004: TQRLabel;
    lblDEA003: TQRLabel;
    txtDEA003: TQRDBText;
    lblSumValue: TQRLabel;
    txtLOA003: TQRDBText;
    lblSumLOA003: TQRLabel;
    lblSumLOA005: TQRLabel;
    lblSumLOA004: TQRLabel;
    lblSumLOA006: TQRLabel;
    txtLOA005: TQRDBText;
    txtLOA004: TQRDBText;
    txtLOA006: TQRDBText;
    lblMaxDate: TQRLabel;
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bndSummaryBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    FSumLOA003, FSumLOA005: Double; //库存量,借入量 合计
    FSumLOA004, FSumLOA006: Double; //库存成本,借入成本 合计
    function CombineSubSQL(vCond: variant): string;
  protected
    procedure FormInit; override;
    procedure SetupRPCtrlObj; override;
    procedure SetupRPCtrlField; override;
    function MakeSQLCommand(vCond: variant): boolean; override;
  public
    { Public declarations }
  end;

//var
//  fmtjskkr18: Tfmtjskkr18;

implementation
uses LibTPA, LibDefine, RPConstDef;
{$R *.dfm}

procedure TfmtINVkr18.SetupRPCtrlObj;
begin
  inherited;
  //小数取位 , 成本权限控制 for ReportView
  Self.AddRPCostObj('txtLOA003', False, NUMSTYLE_QTY); //库存量
  Self.AddRPCostObj('txtLOA005', False, NUMSTYLE_QTY); //借入量
  Self.AddRPCostObj('lblSumLOA003', False, NUMSTYLE_QTY); //库存量合计
  Self.AddRPCostObj('lblSumLOA005', False, NUMSTYLE_QTY); //借入量合计

  Self.AddRPCostObj('txtLOA004', True, NUMSTYLE_NOWMONEY); //库存成本
  Self.AddRPCostObj('txtLOA006', True, NUMSTYLE_NOWMONEY); //借入成本
  Self.AddRPCostObj('lblSumLOA004', True, NUMSTYLE_NOWMONEY); //库存成本合计
  Self.AddRPCostObj('lblSumLOA006', True, NUMSTYLE_NOWMONEY); //借入成本合计

  // 编号转换
  // Self.AddRPIDConvObj('ObjName','ConvID');
end;

procedure TfmtINVkr18.SetupRPCtrlField;
begin
  inherited;
  //小数取位 , 成本权限控制 for DataView
  Self.AddRPCostField('LOA003', False, NUMSTYLE_QTY); //库存量
  Self.AddRPCostField('LOA005', False, NUMSTYLE_QTY); //借入量
  Self.AddRPCostField('LOA004', True, NUMSTYLE_NOWMONEY); //库存成本
  Self.AddRPCostField('LOA006', True, NUMSTYLE_NOWMONEY); //借入成本
   Self.AddRPCostField('LOA007', False, NUMSTYLE_QTY); //20170418 MODI BY 03277 FOR Z30-17041700001 增加显示借出数量，借出成本
   Self.AddRPCostField('LOA008', False, NUMSTYLE_NOWMONEY); //20170418 MODI BY 03277 FOR Z30-17041700001 增加显示借出数量，借出成本
  //日期字段
  //Self.AddRPDateField('MAXDATE') ;   //最近销货日/最近异动日,这里请不要添加控制,因为若由祖先控制,则null时,'***'印不出来;所以改由本支自已控制

  //编号转换
  //self.AddRPIDConvField('FieldName','ConvID');
end;

procedure TfmtINVkr18.FormInit;
begin
  inherited;
  //是否使用信息浏览
  //UseDataView := True;
  //指定此作业传送支持功能
  //FSendOutSupport := SENDOUTSUPPORT_EMAIL + SENDOUTSUPPORT_FAX;
end;

//组条件SQL

function TfmtINVkr18.MakeSQLCommand(vCond: variant): boolean;
var mSubJSKLOA: string;
begin
  inherited MakeSQLCommand(vCond);
  //取出现存库保存内容
  //mSubJSKLOA := ' select LOA001,LOA002,sum(LOA003) as LOA003,sum(LOA005) as LOA005,sum(LOA004) as LOA004,sum(LOA006) as LOA006 ' +
 // mSubJSKLOA := ' select LOA001,LOA002,DDA003,sum(LOA003) as LOA003,sum(LOA005) as LOA005,sum(LOA004) as LOA004,sum(LOA006) as LOA006 ' + //20121114 modi by 603744 for B11-121114002 增加‘仓库名称’字段
  mSubJSKLOA := ' select LOA001,LOA002,DDA003,sum(LOA003) as LOA003,sum(LOA005) as LOA005,sum(LOA004) as LOA004,sum(LOA006) as LOA006 ,sum(LOA007) as LOA007,sum(LOA008) as LOA008 ' + //20170418 MODI BY 03277 FOR Z30-17041700001 增加显示借出数量，借出成本
    ' from JSKLOA ' +
    ' left join TPADDA on DDA001=LOA002 ' + //20121114 modi by 603744 for B11-121114002 增加‘仓库名称’字段
    ' group by LOA001,LOA002,DDA003';

                //步骤1, 取出商品信息档
  //FSQLSelect := ' select DEA001,DEA002,DEA003,MAXDATE,LOA003,LOA005,LOA004,LOA006 '+ //20080125 mark by 40589 Z30-08011700002
  FSQLSelect := ' select DEA001,DEA002,DEA057,DEA003,MAXDATE,ISNULL(LOA003,0) AS LOA003,ISNULL(LOA005,0) AS LOA005,ISNULL(LOA004,0) AS LOA004,ISNULL(LOA006,0) AS LOA006 ' + //20080125 modi by 40589 Z30-08011700002
                //20080124 add by 40589 Z30-07110800004 BEGIN
//  ',DEA005,C.DED003,NO1=CASE WHEN  E.DED007>=1 THEN SUBSTRING(DEA005,1,2) ELSE '''' END,NO1M=CASE WHEN E.DED007>=1 THEN E.DED003 ELSE '''' END,  ' +
//    ' NO2=CASE WHEN  F.DED007>=2 THEN SUBSTRING(DEA005,1,4) ELSE '''' END,NO2M=CASE WHEN F.DED007>=2 THEN F.DED003 ELSE '''' END,  ' +
//    ' NO3=CASE WHEN  G.DED007>=3 THEN SUBSTRING(DEA005,1,6) ELSE '''' END,NO3M=CASE WHEN G.DED007>=3 THEN G.DED003 ELSE '''' END, ' +
//    ' NO4=CASE WHEN  H.DED007>=4 THEN SUBSTRING(DEA005,1,8) ELSE '''' END,NO4M=CASE WHEN H.DED007>=4 THEN H.DED003 ELSE '''' END,  ' +
//    ' NO5=CASE WHEN  I.DED007>=5 THEN SUBSTRING(DEA005,1,10) ELSE '''' END,NO5M=CASE WHEN I.DED007>=5 THEN I.DED003 ELSE '''' END,  ' +
//    ' NO6=CASE WHEN  K.DED007>=6 THEN SUBSTRING(DEA005,1,12) ELSE '''' END,NO6M=CASE WHEN K.DED007>=6 THEN K.DED003 ELSE '''' END  ' +
//20130806 ADD BY 601394 FOR B11-130806001 商品分类编码为手动，商品层级查询不能直接截取                ==BEGIN==
  ',DEA005,C.DED003,NO1=CASE WHEN C.DED007>=1 THEN TEMPDED1.DED002 ELSE '''' END,NO1M=CASE WHEN C.DED007>=1 THEN TEMPDED1.DED003 ELSE '''' END,  ' +
    ' NO2=CASE WHEN C.DED007>=2 THEN TEMPDED2.DED002 ELSE '''' END,NO2M=CASE WHEN C.DED007>=2 THEN TEMPDED2.DED003 ELSE '''' END,  ' +
    ' NO3=CASE WHEN C.DED007>=3 THEN TEMPDED3.DED002 ELSE '''' END,NO3M=CASE WHEN C.DED007>=3 THEN TEMPDED3.DED003 ELSE '''' END, ' +
    ' NO4=CASE WHEN C.DED007>=4 THEN TEMPDED4.DED002 ELSE '''' END,NO4M=CASE WHEN C.DED007>=4 THEN TEMPDED4.DED003 ELSE '''' END,  ' +
    ' NO5=CASE WHEN C.DED007>=5 THEN TEMPDED5.DED002 ELSE '''' END,NO5M=CASE WHEN C.DED007>=5 THEN TEMPDED5.DED003 ELSE '''' END,  ' +
    ' NO6=CASE WHEN C.DED007>=6 THEN TEMPDED6.DED002 ELSE '''' END,NO6M=CASE WHEN C.DED007>=6 THEN TEMPDED6.DED003 ELSE '''' END  ' +
//20130806 ADD BY 601394 FOR B11-130806001 商品分类编码为手动，商品层级查询不能直接截取                ==END==
    //',LOA002 ' + //20111125 ADD BY 602092
  ',LOA002,DDA003 ' + //20121114 modi by 603744 for B11-121114002 增加‘仓库名称’字段
                //20080124 add by 40589 Z30-07110800004 END;
  ' ,DEA006,M.DED003 AS DED003C ' + //20130531 modi by 03433 for Z30-13052700002 开放会计分类编号和名称
  ' ,ISNULL(LOA007,0) AS LOA007,ISNULL(LOA008,0) AS LOA008 '+//20170418 MODI BY 03277 FOR Z30-17041700001 增加显示借出数量，借出成本
    ' from TPADEA ' +
                //20080124 add by 40589 Z30-07110800004 BEGIN
  ' left join TPADED C on (DEA005=DED002) AND (DED001=''0'') ' +
//    ' left join TPADED E on (SUBSTRING(DEA005,1,2)=E.DED002) AND (E.DED001=''0'') ' +
//    ' left join TPADED F on (SUBSTRING(DEA005,1,4)=F.DED002) AND (F.DED001=''0'') ' +
//    ' left join TPADED G on (SUBSTRING(DEA005,1,6)=G.DED002) AND (G.DED001=''0'') ' +
//    ' left join TPADED H on (SUBSTRING(DEA005,1,8)=H.DED002) AND (H.DED001=''0'') ' +
//    ' left join TPADED I on (SUBSTRING(DEA005,1,10)=I.DED002) AND (I.DED001=''0'') ' +
//    ' left join TPADED K on (SUBSTRING(DEA005,1,12)=K.DED002) AND (K.DED001=''0'') ' +
//20130806 ADD BY 601394 FOR B11-130806001 商品分类编码为手动，商品层级查询不能直接截取                ==BEGIN==
  '  LEFT JOIN TPADED AS TEMPDED1 ON (SUBSTRING(C.DED008,1, 2)=TEMPDED1.DED008) AND (TEMPDED1.DED001=''0'') ' +
    '  LEFT JOIN TPADED AS TEMPDED2 ON (SUBSTRING(C.DED008,1, 4)=TEMPDED2.DED008) AND (TEMPDED2.DED001=''0'') ' +
    '  LEFT JOIN TPADED AS TEMPDED3 ON (SUBSTRING(C.DED008,1, 6)=TEMPDED3.DED008) AND (TEMPDED3.DED001=''0'') ' +
    '  LEFT JOIN TPADED AS TEMPDED4 ON (SUBSTRING(C.DED008,1, 8)=TEMPDED4.DED008) AND (TEMPDED4.DED001=''0'') ' +
    '  LEFT JOIN TPADED AS TEMPDED5 ON (SUBSTRING(C.DED008,1, 10)=TEMPDED5.DED008) AND (TEMPDED5.DED001=''0'') ' +
    '  LEFT JOIN TPADED AS TEMPDED6 ON (SUBSTRING(C.DED008,1, 12)=TEMPDED6.DED008) AND (TEMPDED6.DED001=''0'') ' +
//20130806 ADD BY 601394 FOR B11-130806001 商品分类编码为手动，商品层级查询不能直接截取                ==END==
  ' left join TPADED M on M.DED002=DEA006 and M.DED001=''1'' ' + //20130531 modi by 03433 for Z30-13052700002 开放会计分类编号和名称
                 //20080124 add by 40589 Z30-07110800004 END;
                //步骤2, 关联异动档内容
//  Format(' left join (%s) as JSKLNA2 on DEA001=LNA005 ', [Self.CombineSubSQL(vCond)]) +
//		//步骤3, 关联现存库保存内容
// // Format(' left join (%s) as JSKLOA2 on DEA001=LOA001 ', [mSubJSKLOA]);
//20120809 MODI BY 603269 FOR Z30-12080600004 ==BEGIN==
  Format(' left join (%s) as JSKLOA2 on DEA001=LOA001 ', [mSubJSKLOA]) +
    Format(' left join (%s) as JSKLNA2 on DEA001=LNA005 and LOA002=LNA007 ', [Self.CombineSubSQL(vCond)]);
  //20120809 MODI BY 603269 FOR Z30-12080600004 ==END==
                //步骤4, 限定条件: 异动档的最大来源日为null者(即商品信息档关联不到异动档),或
  //          系统日-异动档的最大来源日 >= 呆滞天数 者,才打印
                //          (经转换,变成: 异动档的最大来源日 <= 系统日-呆滞天数 者,才打印)
      //20170418 MODI BY 03277 FOR Z30-17041700001 增加是否显示"库存为0且呆滞期无异动"的选项==BEGIN==
  if not vCond[8] then
    FSQLWhere := Format(' where (LOA003<>0) and ((MAXDATE <= %s) or (MAXDATE is null)) ', [SysUtils.QuotedStr(LibTPA.GetAfterNDays(FormatDateTime('yyyymmdd', Now), vCond[5] * -1))])
  else       //20170418 MODI BY 03277 FOR Z30-17041700001 增加是否显示"库存为0且呆滞期无异动"的选项==END==
    FSQLWhere := Format(' where ((MAXDATE <= %s) or (MAXDATE is null)) ', [SysUtils.QuotedStr(LibTPA.GetAfterNDays(FormatDateTime('yyyymmdd', Now), vCond[5] * -1))]);
  FSQLWhere := LibTPA.GenStartEndSQLsp(FSQLWhere, LibTPA.IIf(vCond[0] = 0, 'DEA001', 'DEA005'), vCond[2]); //取得起止品号/或起止商品分类
  //20111125 ADD BY 602092 begin===
  FSQLWhere := LibTPA.GenStartEndSQLsp(FSQLWhere, 'LOA002', vCond[6]); //仓库  //20111125 ADD BY 602092
  if vCond[7] then
  begin
    FSQLWhere := FSQLWhere;
  end
  else
    FSQLWhere := FSQLWhere + ' and DEA013 =''F'' ';
  //20111125 ADD BY 602092 end ====
  FSQLWhere := FSQLWhere + AddSecurity('TPADDA','DDA001','','LOA002');//20210726 modi by 11245 for B31-210723004 限定基础数据模板限定了仓库需要加上筛选
 // FSQLOrder := ' order by DEA001 '; //排序:品号
  FSQLOrder := ' order by DEA001,LOA002 '; //排序:品号+仓库 //20120809 MODI BY 603269 FOR Z30-12080600004
  lblItvDate.Caption := IntToStr(vCond[5]);
  lblItem.Caption := '起止' + vCond[1] + '：';
  lblItvItem.Left := lblItem.Left + lblItem.Width + 1;
//  lblItvItem.Caption := vCond[2][0] + ' ~ ' + vCond[2][1];
  lblMaxDateC.Caption := vCond[4];
  Result := True;
end;

procedure TfmtINVkr18.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;
  FSumLOA003 := 0; //库存量合计
  FSumLOA005 := 0; //借入量合计
  FSumLOA004 := 0; //库存成本合计
  FSumLOA006 := 0; //借入成本合计
end;

procedure TfmtINVkr18.bndDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  mDate: string;
  mIdleDays: integer;
begin
  inherited;
  lblIdleDays.Caption := '***';
  if Trim(urADODataSet1.FieldByName('MAXDATE').AsString) <> '' then
  begin
    try
      mDate := urADODataSet1.FieldByName('MAXDATE').AsString;
      mIdleDays := Trunc(SysUtils.Date - EncodeDate(StrToInt(copy(mDate, 1, 4)), StrToInt(copy(mDate, 5, 2)), StrToInt(copy(mDate, 7, 2))));
      lblIdleDays.Caption := IntToStr(mIdleDays);
    except
    end;
  end;

  if urADODataSet1.FieldByName('MAXDATE').AsString <> '' then
    lblMaxDate.Caption := LibTPA.TransDateOut(urADODataSet1.FieldByName('MAXDATE').AsString, self.DateType, self.DateSign)
  else
    lblMaxDate.Caption := '***';

  FSumLOA003 := FSumLOA003 + urADODataSet1.FieldByName('LOA003').AsFloat;
  FSumLOA005 := FSumLOA005 + urADODataSet1.FieldByName('LOA005').AsFloat;
  FSumLOA004 := FSumLOA004 + urADODataSet1.FieldByName('LOA004').AsFloat;
  FSumLOA006 := FSumLOA006 + urADODataSet1.FieldByName('LOA006').AsFloat;
end;

procedure TfmtINVkr18.bndSummaryBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  lblSumLOA003.Caption := Self.FormatByNumStyle(FSumLOA003, NUMSTYLE_QTY);
  lblSumLOA005.Caption := Self.FormatByNumStyle(FSumLOA005, NUMSTYLE_QTY);
  lblSumLOA004.Caption := Self.FormatByNumStyle(FSumLOA004, NUMSTYLE_NOWMONEY);
  lblSumLOA006.Caption := Self.FormatByNumStyle(FSumLOA006, NUMSTYLE_NOWMONEY);
end;

function TfmtINVkr18.CombineSubSQL(vCond: variant): string;

  function GetSubSQL(xFldItem1, xFldItem2, xFldDate, xTbName: string): string;
  begin
   // Result := Format(' select %s,max(%s) as MAXDATE from %s group by %s ', [xFldItem, xFldDate, xTbName, xFldItem]) + #13#10;
    Result := Format(' select %s,%s,max(%s) as MAXDATE from %s group by %s,%s ', [xFldItem1, xFldItem2, xFldDate, xTbName, xFldItem1, xFldItem2]) + #13#10;
  end;

var mSubSQL: string;
begin
  //天数计算按最近销货日,取 JSKLNA 档
  if vCond[3] = 0 then
  begin
    Result := ' select LNA005,LNA007,max(LNA006) as MAXDATE ' +
      ' from JSKLNA ' +
      ' where LNA001=''33'' ' +
     // ' group by LNA005 ';
    ' group by LNA005,LNA007 '; //20120809 MODI BY 603269 FOR Z30-12080600004
  end
  else
  //按最近异动日,取3个异动明细档 union 起来
  begin
   // mSubSQL := GetSubSQL('LNA005', 'LNA006', 'JSKLNA') + ' union all ' + #13#10 +
     // GetSubSQL('JGA006', 'JGA005', 'JSKJGA') + ' union all ' + #13#10 +
    //  GetSubSQL('KCA006', 'KCA005', 'JSKKCA');
    //  Result := ' select LNA005,max(MAXDATE) as MAXDATE ' +
   //  Format(' from (%s) as JSKLNA2 ', [mSubSQL]) +
  // ' group by LNA005 ';
  //20120809 MODI BY 603269 FOR Z30-12080600004 ==BEGIN==
    mSubSQL := GetSubSQL('LNA005', 'LNA007', 'LNA006', 'JSKLNA') + ' union all ' + #13#10 +
      GetSubSQL('JGA006', 'JGA007', 'JGA005', 'JSKJGA') + ' union all ' + #13#10 +
      GetSubSQL('KCA006', 'KCA007', 'KCA005', 'JSKKCA');
    Result := ' select LNA005,LNA007,max(MAXDATE) as MAXDATE ' +
      Format(' from (%s) as JSKLNA2 ', [mSubSQL]) +
      ' group by LNA005,LNA007 ';
    //20120809 MODI BY 603269 FOR Z30-12080600004 ==END==
  end;
end;

end.

