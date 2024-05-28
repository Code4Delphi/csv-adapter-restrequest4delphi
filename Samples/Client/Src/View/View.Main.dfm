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
    ExplicitTop = -1
    object Label1: TLabel
      AlignWithMargins = True
      Left = 239
      Top = 3
      Width = 93
      Height = 33
      Align = alLeft
      Caption = 'Registros a buscar:'
      Layout = tlCenter
      ExplicitLeft = 243
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
    object edtNumRegistros: TEdit
      AlignWithMargins = True
      Left = 338
      Top = 8
      Width = 54
      Height = 23
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alLeft
      NumbersOnly = True
      TabOrder = 0
      Text = '5'
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
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 123
    Width = 984
    Height = 418
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 41
    ExplicitHeight = 500
    object Splitter1: TSplitter
      Left = 505
      Top = 0
      Height = 418
      ExplicitLeft = 480
      ExplicitTop = 200
      ExplicitHeight = 100
    end
    object gBoxJSON: TGroupBox
      Left = 0
      Top = 0
      Width = 505
      Height = 418
      Align = alLeft
      Caption = ' JSON '
      TabOrder = 0
      ExplicitHeight = 500
      object mmJSON: TMemo
        Left = 2
        Top = 15
        Width = 501
        Height = 401
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitLeft = 3
      end
    end
    object GroupBox2: TGroupBox
      Left = 508
      Top = 0
      Width = 476
      Height = 418
      Align = alClient
      Caption = ' CSV '
      TabOrder = 1
      ExplicitHeight = 500
      object mmCSV: TMemo
        Left = 2
        Top = 15
        Width = 472
        Height = 401
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitHeight = 483
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
    ExplicitTop = 49
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
end
