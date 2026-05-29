//20060331 modi by 35939 for B11-060329004
//20070807 modi by guojianbing for B11-070807001 商品信息中有的品号而现有库存量档中没有时，起止品号相等则查不出数据  更改dataset中数据类型
//20080107 modi by 41815 for Z40-07122800001 更改字段LOA003,LOA004,LOA005,LOA006的数据类型为FLOAT
//20080124 modi by 40589 Z30-07110800004 商品分类层级显示
//20081203 modi by 40425 for B11-081203001 修改呆滞天数类型为数值型
//20121114 modi by 603744 for B11-121114002 增加‘仓库名称’字段
//20170418 MODI BY 03277 FOR Z30-17041700001 增加显示借出数量，借出成本
unit INVkr18g;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RPBaseGridF, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, dxPSGlbl, dxPSUtl, dxPSEngn,
  dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPScxGridLnk, dxPSCore, dxPSContainerLnk,
  cxPropertiesStore, ImgList, cxGridCustomPopupMenu, cxGridPopupMenu,
  Menus, ADODB, urADODataSet, ComCtrls, ToolWin, cxGridLevel,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGrid, StdCtrls, ExtCtrls, cxImageComboBox;

type
  TgrdINVkr18 = class(TRPBaseGrid)
    AdsMainDEA001: TStringField;
    AdsMainDEA002: TStringField;
    AdsMainDEA003: TStringField;
    AdsMainMAXDATE: TStringField;
    gdMainDBViewDEA001: TcxGridDBColumn;
    gdMainDBViewDEA002: TcxGridDBColumn;
    gdMainDBViewMAXDATE: TcxGridDBColumn;
    gdMainDBViewDELAYDAYS: TcxGridDBColumn;
    gdMainDBViewLOA003: TcxGridDBColumn;
    gdMainDBViewLOA005: TcxGridDBColumn;
    gdMainDBViewDEA003: TcxGridDBColumn;
    gdMainDBViewLOA004: TcxGridDBColumn;
    gdMainDBViewLOA006: TcxGridDBColumn;
    adsMainLOA003: TFloatField;
    adsMainLOA005: TFloatField;
    adsMainLOA004: TFloatField;
    adsMainLOA006: TFloatField;
    adsMainDEA005: TStringField;
    adsMainDED003: TStringField;
    adsMainNO1: TStringField;
    adsMainNO1M: TStringField;
    adsMainNO2: TStringField;
    adsMainNO2M: TStringField;
    adsMainNO3: TStringField;
    adsMainNO3M: TStringField;
    adsMainNO4: TStringField;
    adsMainNO4M: TStringField;
    adsMainNO5: TStringField;
    adsMainNO5M: TStringField;
    adsMainNO6: TStringField;
    adsMainNO6M: TStringField;
    adsMainDEA057: TStringField;
    adsMainDELAYDAYS: TIntegerField;
    adsMainLOA002: TStringField;
    gdMainDBBandViewDEA001: TcxGridDBBandedColumn;
    gdMainDBBandViewDEA002: TcxGridDBBandedColumn;
    gdMainDBBandViewDEA057: TcxGridDBBandedColumn;
    gdMainDBBandViewLOA002: TcxGridDBBandedColumn;
    gdMainDBBandViewMAXDATE: TcxGridDBBandedColumn;
    gdMainDBBandViewDELAYDAYS: TcxGridDBBandedColumn;
    gdMainDBBandViewLOA003: TcxGridDBBandedColumn;
    gdMainDBBandViewLOA005: TcxGridDBBandedColumn;
    gdMainDBBandViewDEA003: TcxGridDBBandedColumn;
    gdMainDBBandViewLOA004: TcxGridDBBandedColumn;
    gdMainDBBandViewLOA006: TcxGridDBBandedColumn;
    gdMainDBBandViewDEA005: TcxGridDBBandedColumn;
    gdMainDBBandViewDED003: TcxGridDBBandedColumn;
    gdMainDBBandViewNO1: TcxGridDBBandedColumn;
    gdMainDBBandViewNO1M: TcxGridDBBandedColumn;
    gdMainDBBandViewNO2: TcxGridDBBandedColumn;
    gdMainDBBandViewNO2M: TcxGridDBBandedColumn;
    gdMainDBBandViewNO3: TcxGridDBBandedColumn;
    gdMainDBBandViewNO3M: TcxGridDBBandedColumn;
    gdMainDBBandViewNO4: TcxGridDBBandedColumn;
    gdMainDBBandViewNO4M: TcxGridDBBandedColumn;
    gdMainDBBandViewNO5: TcxGridDBBandedColumn;
    gdMainDBBandViewNO5M: TcxGridDBBandedColumn;
    gdMainDBBandViewNO6: TcxGridDBBandedColumn;
    gdMainDBBandViewNO6M: TcxGridDBBandedColumn;
    adsMainDDA003: TStringField; //20121114 modi by 603744 for B11-121114002 增加‘仓库名称’字段
    gdMainDBBandViewDDA003: TcxGridDBBandedColumn;
    adsMainDEA006: TStringField;
    adsMainDED003C: TStringField;
    gdMainDBBandViewDEA006: TcxGridDBBandedColumn;
    gdMainDBBandViewDED003C: TcxGridDBBandedColumn;
    adsMainLOA007: TFloatField;
    adsMainLOA008: TFloatField;
    gdMainDBBandViewLOA007: TcxGridDBBandedColumn;
    gdMainDBBandViewLOA008: TcxGridDBBandedColumn; //20121114 modi by 603744 for B11-121114002 增加‘仓库名称’字段
    procedure btnLoadFormatClick(Sender: TObject);
    procedure adsMainDELAYDAYSGetText(Sender: TField; var Text: string;
      DisplayText: Boolean); //20060331 modi by 35939 for B11-060329004
  private
    { Private declarations }
    procedure SetColumnsCaption; //20060331 modi by 35939 for B11-060329004
  public
    { Public declarations }
    function DoMyReport: Boolean; override;
  protected
    procedure SetFormatStoreCondition; override; //20060331 modi by 35939 for B11-060329004
  end;

var
  grdINVkr18: TgrdINVkr18;

implementation

{$R *.dfm}

uses INVkr18r, LibTPA, INVkr18o;

{ Tgrdjskkr18 }

function TgrdINVkr18.DoMyReport: Boolean;
var
  mDate, mMaxDate: string;
  mIdleDays: Integer;
  mDelayDays: Integer; //20081203 modi by 40425 for B11-081203001 修改呆滞天数类型为数值型
begin
  Result := inherited DoMyReport;
  if not Result then Exit;
  //20060331 modi by 35939 for B11-060329004 begin
  with ToptINVkr18(Self.Owner) do
    gdMainDBBandViewMAXDATE.Caption := rgpDate.Items.Strings[rgpDate.ItemIndex];
  //20060331 modi by 35939 for B11-060329004 end

  with TfmtINVkr18(MyRPBaseFmt) do
  begin
    urADODataSet1.First;

    while not urADODataSet1.Eof do
    begin
      mMaxDate := '***'; //最近销货日
     // mDelayDays := '***';        //呆滞天数 //20081203 modi by 40425 for B11-081203001 修改呆滞天数类型为数值型
      mDelayDays := 0; //呆滞天数 //20081203 modi by 40425 for B11-081203001 修改呆滞天数类型为数值型
      if Trim(urADODataSet1.FieldByName('MAXDATE').AsString) <> '' then
      begin
        try
          mMaxDate := TransDateOut(urADODataSet1.FieldByName('MAXDATE').AsString, DateType, DateSign);
          mDate := urADODataSet1.FieldByName('MAXDATE').AsString;
          mIdleDays := Trunc(SysUtils.Date - EncodeDate(StrToInt(copy(mDate, 1, 4)), StrToInt(copy(mDate, 5, 2)), StrToInt(copy(mDate, 7, 2))));
         // mDelayDays := IntToStr( mIdleDays ); //20081203 modi by 40425 for B11-081203001 修改呆滞天数类型为数值型
          mDelayDays := mIdleDays; //20081203 modi by 40425 for B11-081203001 修改呆滞天数类型为数值型
        except
        end;
      end;
      WriteToTempTable(0, [urADODataSet1.FieldByName('DEA001').AsString,
        urADODataSet1.FieldByName('DEA002').AsString,
          urADODataSet1.FieldByName('DEA057').AsString, //20080808 Add By 46124 for Z30-08072100001 规格字段
          urADODataSet1.FieldByName('LOA002').AsString, //20111125 add by 602092
          urADODataSet1.FieldByName('DDA003').AsString, //20121114 modi by 603744 for B11-121114002 增加‘仓库名称’字段
          mMaxDate,
          mDelayDays,
          urADODataSet1.FieldByName('LOA003').AsString,
          urADODataSet1.FieldByName('LOA005').AsString,
          urADODataSet1.FieldByName('DEA003').AsString,
          urADODataSet1.FieldByName('LOA004').AsString,
          urADODataSet1.FieldByName('LOA006').AsString
                            //20080124 add by 40589 Z30-07110800004 begin
        , urADODataSet1.FieldByName('DEA005').AsString
          , urADODataSet1.FieldByName('DED003').AsString
          , urADODataSet1.FieldByName('NO1').AsString
          , urADODataSet1.FieldByName('NO1M').AsString
          , urADODataSet1.FieldByName('NO2').AsString
          , urADODataSet1.FieldByName('NO2M').AsString
          , urADODataSet1.FieldByName('NO3').AsString
          , urADODataSet1.FieldByName('NO3M').AsString
          , urADODataSet1.FieldByName('NO4').AsString
          , urADODataSet1.FieldByName('NO4M').AsString
          , urADODataSet1.FieldByName('NO5').AsString
          , urADODataSet1.FieldByName('NO5M').AsString
          , urADODataSet1.FieldByName('NO6').AsString
          , urADODataSet1.FieldByName('NO6M').AsString
                            //20080124 add by 40589 Z30-07110800004 end;
        , urADODataSet1.fieldbyname('DEA006').AsString //20130531 modi by 03433 for Z30-13052700002 开放会计分类编号和名称
          , urADODataSet1.fieldbyname('DED003C').AsString //20130531 modi by 03433 for Z30-13052700002 开放会计分类编号和名称
          ,urADODataSet1.FieldByName('LOA007').asfloat //20170418 MODI BY 03277 FOR Z30-17041700001 增加显示借出数量，借出成本
          ,urADODataSet1.FieldByName('LOA008').asfloat //20170418 MODI BY 03277 FOR Z30-17041700001 增加显示借出数量，借出成本
          ]
          , '', '');
      urADODataSet1.Next;
    end;
  end;
end;

//20060331 modi by 35939 for B11-060329004 begin

procedure TgrdINVkr18.SetColumnsCaption;
begin
  with ToptINVkr18(Self.Owner) do
    gdMainDBBandViewMAXDATE.Caption := rgpDate.Items.Strings[rgpDate.ItemIndex];
end;

procedure TgrdINVkr18.SetFormatStoreCondition;
begin
  inherited;
  SetColumnsCaption;
end;

procedure TgrdINVkr18.btnLoadFormatClick(Sender: TObject);
begin
  inherited;
  SetColumnsCaption;
end;
//20060331 modi by 35939 for B11-060329004 end
//20081203 modi by 40425 for B11-081203001 修改呆滞天数类型为数值型 begin

procedure TgrdINVkr18.adsMainDELAYDAYSGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.AsInteger = 0 then
    Text := '***'
  else
    Text := IntToStr(Sender.AsInteger);
end;
//20081203 modi by 40425 for B11-081203001 修改呆滞天数类型为数值型 end
end.

