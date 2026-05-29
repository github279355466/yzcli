inherited optINVkr18: ToptINVkr18
  Left = 647
  Top = 176
  Width = 601
  Height = 611
  Caption = #24211#23384#21574#28382#20998#26512#34920
  PixelsPerInch = 96
  TextHeight = 17
  inherited Splitter1: TSplitter
    Height = 529
  end
  inherited pgPageCtrl: TurPageControl
    Width = 433
    Height = 529
    inherited tbsBase: TTabSheet
      inherited lblStyleName: TLabel
        Left = 17
        Top = 458
        Visible = False
      end
      object lblDate01: TLabel [1]
        Left = 18
        Top = 256
        Width = 48
        Height = 17
        Caption = #21574#28382#22825#25968
      end
      object lblDate02: TLabel [2]
        Left = 130
        Top = 256
        Width = 24
        Height = 17
        Caption = #20197#19978
      end
      inherited pnlFixStyle: TPanel
        Top = 485
        Width = 425
        Height = 12
        TabOrder = 4
      end
      inherited cboStyleName: TDcComboBox
        Left = 69
        Top = 455
        TabOrder = 5
        Visible = False
      end
      object gpbItem: TGroupBox
        Left = 16
        Top = 3
        Width = 369
        Height = 198
        Caption = #36215#27490#21830#21697#20381#25454
        TabOrder = 0
        object rbItem: TRadioButton
          Left = 16
          Top = 24
          Width = 57
          Height = 17
          Caption = #21697#21495
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rbItemClick
        end
        object rbType: TRadioButton
          Left = 175
          Top = 24
          Width = 75
          Height = 17
          Caption = #21830#21697#20998#31867
          TabOrder = 1
          OnClick = rbItemClick
        end
        object spCategory: TSelectPanel
          Left = 23
          Top = 53
          Width = 210
          Height = 129
          Caption = #21830#21697#20998#31867
          TabOrder = 2
          BeginWords.Strings = (
            #36215
            #36215)
          ColumnsAutoSize = True
          CanOpenWin = True
          ChildHints.Strings = (
            #29992#25143#33258#23450#36755#20837#26041#24335
            #21306#38388#36873#25321'-'#36215#22987#20449#24687
            #21306#38388#36873#25321'-'#36215#22987#20449#24687#24320#31383
            #21306#38388#36873#25321'-'#25130#27490#20449#24687
            #21306#38388#36873#25321'-'#25130#27490#20449#24687#24320#31383
            #22810#36873'-'#24049#36873#25321#30340#20449#24687
            #22810#36873'-'#20449#24687#24320#31383
            #22810#36873'-'#21024#38500#19968#31508#20449#24687
            #22810#36873'-'#21024#38500#24049#36873#20449#24687)
          Columns = <>
          DateSign = '/'
          FinalWords.Strings = (
            #27490
            #27490)
          GlyphIndex = 10
          HintWord = #21306#38388#36873#25321
          HideSelection = False
          OtherHeight = 140
          OtherWidth = 210
          ShowColumnHeader = False
          Style = sp_UserChoice
          UseDiscard = False
          UserChoice = True
          UseVertical = True
          ValueType = vt_String
          HotKey = 0
          OnDialog = urDBButtonEditDialog
          Text = '0'#9#9
        end
        object spGoodsNo: TSelectPanel
          Left = 23
          Top = 53
          Width = 210
          Height = 129
          Caption = #21697#21495
          TabOrder = 3
          BeginWords.Strings = (
            #36215
            #36215)
          ColumnsAutoSize = True
          CanOpenWin = True
          ChildHints.Strings = (
            #29992#25143#33258#23450#36755#20837#26041#24335
            #21306#38388#36873#25321'-'#36215#22987#20449#24687
            #21306#38388#36873#25321'-'#36215#22987#20449#24687#24320#31383
            #21306#38388#36873#25321'-'#25130#27490#20449#24687
            #21306#38388#36873#25321'-'#25130#27490#20449#24687#24320#31383
            #22810#36873'-'#24049#36873#25321#30340#20449#24687
            #22810#36873'-'#20449#24687#24320#31383
            #22810#36873'-'#21024#38500#19968#31508#20449#24687
            #22810#36873'-'#21024#38500#24049#36873#20449#24687)
          Columns = <>
          DateSign = '/'
          FinalWords.Strings = (
            #27490
            #27490)
          GlyphIndex = 13
          HintWord = #21306#38388#36873#25321
          HideSelection = False
          OtherHeight = 140
          OtherWidth = 210
          ShowColumnHeader = False
          Style = sp_UserChoice
          UseDiscard = False
          UserChoice = True
          UseVertical = True
          ValueType = vt_String
          HotKey = 0
          OnDialog = urDBButtonEditDialog
          Text = '0'#9#9
        end
      end
      object rgpDate: TRadioGroup
        Left = 16
        Top = 200
        Width = 369
        Height = 47
        Caption = #21574#28382#22825#25968#35745#31639#20381#25454
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #26368#36817#38144#36135#26085
          #26368#36817#24322#21160#26085)
        TabOrder = 1
      end
      object edDateNum: TwwDBSpinEdit
        Left = 71
        Top = 253
        Width = 54
        Height = 23
        Increment = 1
        MaxValue = 9999
        MinValue = 1
        Value = 1
        BorderStyle = bsNone
        TabOrder = 2
        UnboundDataType = wwDefault
      end
      object chkPH: TurCheckBox
        Left = 16
        Top = 413
        Width = 129
        Height = 17
        Caption = #26174#31034#24050#27880#38144#21697#21495
        TabOrder = 3
      end
      object chk1: TurCheckBox
        Left = 16
        Top = 434
        Width = 206
        Height = 17
        Caption = #26174#31034#24211#23384#20026'0'#19988#21574#28382#26399#26080#24322#21160#20449#24687
        TabOrder = 6
      end
      object spWareHouse: TSelectPanel
        Left = 16
        Top = 280
        Width = 210
        Height = 129
        Caption = #20179#24211
        TabOrder = 7
        BeginWords.Strings = (
          #36215
          #36215)
        ColumnsAutoSize = True
        CanOpenWin = True
        ChildHints.Strings = (
          #29992#25143#33258#23450#36755#20837#26041#24335
          #21306#38388#36873#25321'-'#36215#22987#20449#24687
          #21306#38388#36873#25321'-'#36215#22987#20449#24687#24320#31383
          #21306#38388#36873#25321'-'#25130#27490#20449#24687
          #21306#38388#36873#25321'-'#25130#27490#20449#24687#24320#31383
          #22810#36873'-'#24049#36873#25321#30340#20449#24687
          #22810#36873'-'#20449#24687#24320#31383
          #22810#36873'-'#21024#38500#19968#31508#20449#24687
          #22810#36873'-'#21024#38500#24049#36873#20449#24687)
        Columns = <>
        DateSign = '/'
        FinalWords.Strings = (
          #27490
          #27490)
        GlyphIndex = 9
        HintWord = #21306#38388#36873#25321
        HideSelection = False
        OtherHeight = 140
        OtherWidth = 210
        ShowColumnHeader = False
        Style = sp_UserChoice
        UseDiscard = False
        UserChoice = True
        UseVertical = True
        ValueType = vt_String
        HotKey = 0
        OnDialog = urDBButtonEditDialog
        Text = '0'#9#9
      end
    end
    inherited tbsSigninNote: TTabSheet
      inherited edtSignin: TurEdit
        Left = 3
        Width = 561
      end
      inherited mmoNote: TMemo
        Width = 563
        Height = 386
      end
      inherited pnl1: TPanel
        Left = 422
        Height = 497
      end
    end
  end
  inherited pnlToolbar: TPanel
    Width = 585
  end
  inherited pnlTreeView: TPanel
    Height = 529
    inherited tvCondition: TTreeView
      Height = 492
    end
    inherited pnlButton: TPanel
      Top = 493
    end
  end
  inherited CondStore: TurConditionStorage
    Items.Strings = (
      'cboStyleName.ItemIndex'
      'edtSigninID.Text'
      'edtNoteID.Text'
      'rbItem.Checked'
      'rbType.Checked'
      'rgpDate.ItemIndex'
      'edDateNum.Value'
      'chkPH.Checked'
      'spWareHouse.Text'
      'spCategory.Text'
      'spGoodsNo.Text')
  end
end
