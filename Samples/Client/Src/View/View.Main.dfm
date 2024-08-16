object ViewMain: TViewMain
  Left = 0
  Top = 0
  Caption = 'CSV Adapter For Restrequest4Delphi'
  ClientHeight = 541
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel9: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 41
    Align = alTop
    BevelEdges = [beLeft, beTop, beRight]
    BevelKind = bkTile
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = 49
    object Label1: TLabel
      AlignWithMargins = True
      Left = 454
      Top = 3
      Width = 80
      Height = 33
      Align = alLeft
      Caption = 'Number records:'
      Layout = tlCenter
      ExplicitHeight = 13
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 71
      Height = 33
      Align = alLeft
      AutoSize = False
      Caption = 'Base URL:'
      Layout = tlCenter
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 239
      Top = 3
      Width = 50
      Height = 33
      Align = alLeft
      AutoSize = False
      Caption = 'Resource:'
      Layout = tlCenter
    end
    object edtNumRegistros: TEdit
      AlignWithMargins = True
      Left = 540
      Top = 8
      Width = 54
      Height = 23
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alLeft
      NumbersOnly = True
      TabOrder = 0
      Text = '5'
      ExplicitHeight = 21
    end
    object edtBaseURL: TEdit
      AlignWithMargins = True
      Left = 80
      Top = 8
      Width = 153
      Height = 23
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alLeft
      NumbersOnly = True
      TabOrder = 1
      Text = 'http://localhost:9050/'
      ExplicitHeight = 21
    end
    object edtResource: TEdit
      AlignWithMargins = True
      Left = 295
      Top = 8
      Width = 153
      Height = 23
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alLeft
      NumbersOnly = True
      TabOrder = 2
      Text = 'clients'
      ExplicitHeight = 21
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 172
    Width = 984
    Height = 369
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 505
      Top = 0
      Height = 369
      ExplicitLeft = 480
      ExplicitTop = 200
      ExplicitHeight = 100
    end
    object gBoxJSON: TGroupBox
      Left = 0
      Top = 0
      Width = 505
      Height = 369
      Align = alLeft
      Caption = ' JSON '
      TabOrder = 0
      object mmJSON: TMemo
        Left = 2
        Top = 15
        Width = 501
        Height = 352
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitLeft = 3
        ExplicitTop = 14
      end
    end
    object GroupBox2: TGroupBox
      Left = 508
      Top = 0
      Width = 476
      Height = 369
      Align = alClient
      Caption = ' CSV '
      TabOrder = 1
      object mmCSV: TMemo
        Left = 2
        Top = 15
        Width = 472
        Height = 352
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 984
    Height = 41
    Align = alTop
    BevelKind = bkTile
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 90
    object Label2: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 71
      Height = 31
      Align = alLeft
      AutoSize = False
      Caption = 'Save to file:'
      Layout = tlCenter
    end
    object btnGetObjectSaveToFile: TButton
      AlignWithMargins = True
      Left = 80
      Top = 3
      Width = 153
      Height = 31
      Align = alLeft
      Caption = 'Get Object - Save to file'
      TabOrder = 0
      OnClick = btnGetObjectSaveToFileClick
      ExplicitTop = 2
    end
    object btnGetArraySaveToFile: TButton
      AlignWithMargins = True
      Left = 239
      Top = 3
      Width = 153
      Height = 31
      Align = alLeft
      Caption = 'Get Array - Save to file'
      TabOrder = 1
      OnClick = btnGetArraySaveToFileClick
      ExplicitTop = 2
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 82
    Width = 984
    Height = 41
    Align = alTop
    BevelKind = bkTile
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    ExplicitTop = 83
    object Label4: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 71
      Height = 31
      Align = alLeft
      AutoSize = False
      Caption = 'Get to TString:'
      Layout = tlCenter
      ExplicitTop = 2
    end
    object btnGetObjectToTString: TButton
      AlignWithMargins = True
      Left = 80
      Top = 3
      Width = 153
      Height = 31
      Align = alLeft
      Caption = 'Get Object - To TString'
      TabOrder = 0
      OnClick = btnGetObjectToTStringClick
      ExplicitTop = 2
    end
    object btnGetArrayToTString: TButton
      AlignWithMargins = True
      Left = 239
      Top = 3
      Width = 153
      Height = 31
      Align = alLeft
      Caption = 'Get Array - To TString'
      TabOrder = 1
      OnClick = btnGetArrayToTStringClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 123
    Width = 984
    Height = 49
    Align = alTop
    Caption = '   Configuration '
    TabOrder = 4
    ExplicitTop = 124
    object Label6: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 71
      Height = 26
      Align = alLeft
      AutoSize = False
      Caption = 'Separator:'
      Layout = tlCenter
      ExplicitLeft = 3
      ExplicitTop = 3
      ExplicitHeight = 33
    end
    object Label7: TLabel
      AlignWithMargins = True
      Left = 135
      Top = 18
      Width = 71
      Height = 26
      Align = alLeft
      AutoSize = False
      Caption = 'Get to TString:'
      Layout = tlCenter
      ExplicitLeft = 677
      ExplicitTop = 6
    end
    object cBoxSeparator: TComboBox
      AlignWithMargins = True
      Left = 82
      Top = 20
      Width = 47
      Height = 21
      Margins.Top = 5
      Margins.Bottom = 8
      Align = alLeft
      ItemIndex = 0
      TabOrder = 0
      Text = ';'
      Items.Strings = (
        ';'
        '|')
    end
    object btnGetObjectToTStringConfig: TButton
      AlignWithMargins = True
      Left = 212
      Top = 18
      Width = 238
      Height = 26
      Align = alLeft
      Caption = 'Get Object - With Inline Settings'
      TabOrder = 1
      OnClick = btnGetObjectToTStringConfigClick
    end
    object btnGetArrayToTStringConfig: TButton
      AlignWithMargins = True
      Left = 456
      Top = 18
      Width = 153
      Height = 26
      Align = alLeft
      Caption = 'Get Array - With Settings in variable'
      TabOrder = 2
      OnClick = btnGetArrayToTStringConfigClick
      ExplicitLeft = 371
      ExplicitTop = 17
    end
  end
end
