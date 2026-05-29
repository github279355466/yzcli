//20100907  modi by 601209 for Z30-10090700001  易助5.0Patch 开发增加客户全称字段
unit ysfsr20g;

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
  cxGridDBBandedTableView, cxGrid, StdCtrls, ExtCtrls;

type
  Tgrdysfsr20 = class(TRPBaseGrid)
    AdsMainGCA016A: TFloatField;
    AdsMainGCA016B: TFloatField;
    AdsMainGCA016C: TFloatField;
    AdsMainGCA016D: TFloatField;
    AdsMainGCA016E: TFloatField;
    AdsMainGCA016F: TFloatField;
    AdsMainGCA003: TStringField;
    AdsMainDFA002: TStringField;
    adsMainBAD016A: TFloatField;
    adsMainBAD016B: TFloatField;
    adsMainBAD016C: TFloatField;
    adsMainBAD016D: TFloatField;
    adsMainBAD016E: TFloatField;
    adsMainBAD016F: TFloatField;
    gdMainDBBandViewGCA003: TcxGridDBBandedColumn;
    gdMainDBBandViewDFA002: TcxGridDBBandedColumn;
    gdMainDBBandViewGCA016A: TcxGridDBBandedColumn;
    gdMainDBBandViewBAD016A: TcxGridDBBandedColumn;
    gdMainDBBandViewGCA016B: TcxGridDBBandedColumn;
    gdMainDBBandViewBAD016B: TcxGridDBBandedColumn;
    gdMainDBBandViewGCA016C: TcxGridDBBandedColumn;
    gdMainDBBandViewBAD016C: TcxGridDBBandedColumn;
    gdMainDBBandViewGCA016D: TcxGridDBBandedColumn;
    gdMainDBBandViewBAD016D: TcxGridDBBandedColumn;
    gdMainDBBandViewGCA016E: TcxGridDBBandedColumn;
    gdMainDBBandViewBAD016E: TcxGridDBBandedColumn;
    gdMainDBBandViewGCA016F: TcxGridDBBandedColumn;
    gdMainDBBandViewBAD016F: TcxGridDBBandedColumn;
    adsMainDFA003: TStringField;
    gdMainDBBandViewDFA003: TcxGridDBBandedColumn;
    procedure btnLoadFormatClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetColumnsCaption; //20060323 ADD BY 36006 FOR Q10-06032200002  修改格式档标题字段
  protected
    procedure SetFormatStoreCondition; override; //20060323 ADD BY 36006 FOR Q10-06032200002  修改格式档标题字段
  public
    { Public declarations }
    function DoMyReport :Boolean;override ;  //报表具体的动作
  end;

var
  grdysfsr20: Tgrdysfsr20;

implementation

uses ysfsr20r;

{$R *.dfm}

function Tgrdysfsr20.DoMyReport: Boolean;
var
  mPutDays:integer;
  mDate1,mDate2:Tdatetime;
begin
  Result := Inherited DoMyReport;
  if not Result then Exit;

  with Tfmtysfsr20(self.MyRPBaseFmt) do
  begin
    urADODataSet1.First;
    gdMainDBBandViewGCA016A.Caption := lbl01.Caption;
    gdMainDBBandViewGCA016B.Caption := lbl02.Caption;
    gdMainDBBandViewGCA016C.Caption := lbl03.Caption;
    gdMainDBBandViewGCA016D.Caption := lbl04.Caption;
    gdMainDBBandViewGCA016E.Caption := lbl05.Caption;
    while not urADODataSet1.Eof do
    begin
      WriteToTempTable(0, [
                            urADODataSet1.FieldByName('GCA003').AsString,     //请款客户
                            urADODataSet1.FieldByName('DFA002').AsString,     //客户简称
                            urADODataSet1.FieldByName('DFA003').AsString,     //客户全称   //20100907  modi by 601209 for Z30-10090700001  易助5.0Patch 开发增加客户全称字段
                            urADODataSet1.FieldByName('GCA016A').AsFloat,     //GCA016A
                            urADODataSet1.FieldByName('GCA016A').AsFloat*FPercent[1],
                            urADODataSet1.FieldByName('GCA016B').AsFloat,     //GCA016B
                            urADODataSet1.FieldByName('GCA016B').AsFloat*FPercent[2],
                            urADODataSet1.FieldByName('GCA016C').AsFloat,     //GCA016C
                            urADODataSet1.FieldByName('GCA016C').AsFloat*FPercent[3],
                            urADODataSet1.FieldByName('GCA016D').AsFloat,     //GCA016D
                            urADODataSet1.FieldByName('GCA016D').AsFloat*FPercent[4],
                            urADODataSet1.FieldByName('GCA016E').AsFloat,     //GCA016E
                            urADODataSet1.FieldByName('GCA016E').AsFloat*FPercent[5],
                            urADODataSet1.FieldByName('GCA016F').AsFloat,      //合计应收
                            urADODataSet1.FieldByName('GCA016A').AsFloat*FPercent[1]+urADODataSet1.FieldByName('GCA016B').AsFloat*FPercent[2]+urADODataSet1.FieldByName('GCA016C').AsFloat*FPercent[3]+urADODataSet1.FieldByName('GCA016D').AsFloat*FPercent[4]+urADODataSet1.FieldByName('GCA016E').AsFloat*FPercent[5]
                            ]
                            , 0, 0);

      urAdoDataSet1.Next;
    end;
  end;
end;
//20060323 ADD BY 36006 FOR Q10-06032200002  修改格式档标题字段 begin
procedure Tgrdysfsr20.btnLoadFormatClick(Sender: TObject);
begin
  inherited;
  SetColumnsCaption;
end;

procedure Tgrdysfsr20.SetColumnsCaption;
begin
  with Tfmtysfsr20(self.MyRPBaseFmt) do
  begin
  gdMainDBBandViewGCA016A.Caption := lbl01.Caption;
  gdMainDBBandViewGCA016B.Caption := lbl02.Caption;
  gdMainDBBandViewGCA016C.Caption := lbl03.Caption;
  gdMainDBBandViewGCA016D.Caption := lbl04.Caption;
  gdMainDBBandViewGCA016E.Caption := lbl05.Caption;
  end;
end;

procedure Tgrdysfsr20.SetFormatStoreCondition;
begin
  inherited;
  SetColumnsCaption;
end;
//20060323 ADD BY 36006 FOR Q10-06032200002  修改格式档标题字段 end
end.
