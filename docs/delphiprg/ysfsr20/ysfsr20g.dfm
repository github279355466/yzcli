inherited grdysfsr20: Tgrdysfsr20
  Left = 510
  Top = 31
  Width = 808
  Height = 580
  Caption = 'grdysfsr20'
  PixelsPerInch = 96
  TextHeight = 12
  inherited pnlMain: TPanel
    Width = 800
    Height = 522
    inherited pnlTitle: TPanel
      Width = 798
      inherited lblCompany: TLabel
        Width = 796
      end
      inherited lblReportName: TLabel
        Width = 796
      end
      inherited lblCondOne: TLabel
        Width = 796
      end
      inherited lblCondTwo: TLabel
        Width = 796
      end
      inherited lblCondThr: TLabel
        Width = 796
      end
      inherited lblUser: TLabel
        Left = 750
      end
    end
    inherited pnlGrid: TPanel
      Width = 798
      Height = 422
      inherited gdMain: TcxGrid
        Width = 798
        Height = 422
        inherited gdMainDBBandView: TcxGridDBBandedTableView
          Bands = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
          object gdMainDBBandViewGCA003: TcxGridDBBandedColumn
            Index = 0
            DisplayType = #3
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.LineCount = 2
            Position.RowIndex = 0
            DataBinding.FieldName = 'GCA003'
          end
          object gdMainDBBandViewDFA002: TcxGridDBBandedColumn
            Index = 1
            DisplayType = #3
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.LineCount = 2
            Position.RowIndex = 0
            DataBinding.FieldName = 'DFA002'
          end
          object gdMainDBBandViewDFA003: TcxGridDBBandedColumn
            Index = 2
            DisplayType = #3
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.LineCount = 2
            Position.RowIndex = 0
            DataBinding.FieldName = 'DFA003'
          end
          object gdMainDBBandViewGCA016A: TcxGridDBBandedColumn
            Index = 3
            Width = 75
            DisplayType = #3
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'GCA016A'
          end
          object gdMainDBBandViewBAD016A: TcxGridDBBandedColumn
            Index = 4
            DisplayType = #3
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 1
            DataBinding.FieldName = 'BAD016A'
          end
          object gdMainDBBandViewGCA016B: TcxGridDBBandedColumn
            Index = 5
            Width = 78
            DisplayType = #3
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'GCA016B'
          end
          object gdMainDBBandViewBAD016B: TcxGridDBBandedColumn
            Index = 6
            DisplayType = #3
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 1
            DataBinding.FieldName = 'BAD016B'
          end
          object gdMainDBBandViewGCA016C: TcxGridDBBandedColumn
            Index = 7
            Width = 79
            DisplayType = #3
            Position.BandIndex = 3
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'GCA016C'
          end
          object gdMainDBBandViewBAD016C: TcxGridDBBandedColumn
            Index = 8
            DisplayType = #3
            Position.BandIndex = 3
            Position.ColIndex = 0
            Position.RowIndex = 1
            DataBinding.FieldName = 'BAD016C'
          end
          object gdMainDBBandViewGCA016D: TcxGridDBBandedColumn
            Index = 9
            Width = 82
            DisplayType = #3
            Position.BandIndex = 4
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'GCA016D'
          end
          object gdMainDBBandViewBAD016D: TcxGridDBBandedColumn
            Index = 10
            DisplayType = #3
            Position.BandIndex = 4
            Position.ColIndex = 0
            Position.RowIndex = 1
            DataBinding.FieldName = 'BAD016D'
          end
          object gdMainDBBandViewGCA016E: TcxGridDBBandedColumn
            Index = 11
            Width = 77
            DisplayType = #3
            Position.BandIndex = 5
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'GCA016E'
          end
          object gdMainDBBandViewBAD016E: TcxGridDBBandedColumn
            Index = 12
            DisplayType = #3
            Position.BandIndex = 5
            Position.ColIndex = 0
            Position.RowIndex = 1
            DataBinding.FieldName = 'BAD016E'
          end
          object gdMainDBBandViewGCA016F: TcxGridDBBandedColumn
            Index = 13
            Width = 101
            DisplayType = #3
            Position.BandIndex = 6
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'GCA016F'
          end
          object gdMainDBBandViewBAD016F: TcxGridDBBandedColumn
            Index = 14
            DisplayType = #3
            Position.BandIndex = 6
            Position.ColIndex = 0
            Position.RowIndex = 1
            DataBinding.FieldName = 'BAD016F'
          end
        end
      end
    end
    inherited pnlFooter: TPanel
      Top = 497
      Width = 798
    end
  end
  inherited ToolBar1: TToolBar
    Width = 800
  end
  inherited adsMain: TurADODataSet
    object AdsMainGCA003: TStringField
      DisplayLabel = #35831#27454#23458#25143
      FieldName = 'GCA003'
    end
    object AdsMainDFA002: TStringField
      DisplayLabel = #23458#25143#31616#31216
      FieldName = 'DFA002'
    end
    object adsMainDFA003: TStringField
      DisplayLabel = #23458#25143#20840#31216
      DisplayWidth = 30
      FieldName = 'DFA003'
      Size = 72
    end
    object AdsMainGCA016A: TFloatField
      FieldName = 'GCA016A'
    end
    object adsMainBAD016A: TFloatField
      DisplayLabel = #39044#25552#22351#24080
      FieldName = 'BAD016A'
    end
    object AdsMainGCA016B: TFloatField
      FieldName = 'GCA016B'
    end
    object adsMainBAD016B: TFloatField
      DisplayLabel = #39044#25552#22351#24080
      FieldName = 'BAD016B'
    end
    object AdsMainGCA016C: TFloatField
      FieldName = 'GCA016C'
    end
    object adsMainBAD016C: TFloatField
      DisplayLabel = #39044#25552#22351#24080
      FieldName = 'BAD016C'
    end
    object AdsMainGCA016D: TFloatField
      FieldName = 'GCA016D'
    end
    object adsMainBAD016D: TFloatField
      DisplayLabel = #39044#25552#22351#24080
      FieldName = 'BAD016D'
    end
    object AdsMainGCA016E: TFloatField
      FieldName = 'GCA016E'
    end
    object adsMainBAD016E: TFloatField
      DisplayLabel = #39044#25552#22351#24080
      FieldName = 'BAD016E'
    end
    object AdsMainGCA016F: TFloatField
      DisplayLabel = #21512#35745#26410#25910
      FieldName = 'GCA016F'
    end
    object adsMainBAD016F: TFloatField
      DisplayLabel = #39044#25552#22351#24080#21512#35745
      FieldName = 'BAD016F'
    end
  end
  inherited prtMain: TdxComponentPrinter
    inherited prtMainLink1: TdxCustomContainerReportLink
      Component = Owner
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 38072.7766876736
      BuiltInReportLink = True
      HiddenComponents = {}
      ExcludedComponents = {}
    end
    inherited prtMainLink2: TdxGridReportLink
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 38072.7766877894
      BuiltInReportLink = True
    end
    inherited prtMainLink3: TdxCustomContainerReportLink
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      BuiltInReportLink = True
      HiddenComponents = {}
      ExcludedComponents = {}
    end
  end
end
