object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 480
  ClientWidth = 675
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 675
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Button1: TButton
      Left = 0
      Top = 0
      Width = 75
      Height = 41
      Align = alLeft
      Caption = 'Executar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 75
      Top = 0
      Width = 75
      Height = 41
      Align = alLeft
      Caption = 'Files'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 320
    Width = 675
    Height = 160
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 675
      Height = 25
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'Log'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object Panel5: TPanel
      Left = 0
      Top = 25
      Width = 675
      Height = 135
      Align = alClient
      BevelOuter = bvNone
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 1
      object Memo2: TMemo
        Left = 5
        Top = 5
        Width = 665
        Height = 125
        Align = alClient
        TabOrder = 0
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 41
    Width = 675
    Height = 279
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 2
    object Memo1: TMemo
      Left = 5
      Top = 5
      Width = 665
      Height = 269
      Align = alClient
      TabOrder = 0
    end
  end
  object FDScript1: TFDScript
    SQLScripts = <>
    Connection = DataModule2.FDConnection1
    Params = <>
    Macros = <>
    OnConsolePut = FDScript1ConsolePut
    Left = 504
    Top = 89
  end
  object FDGUIxScriptDialog1: TFDGUIxScriptDialog
    Provider = 'Forms'
    Left = 592
    Top = 89
  end
  object OpenDialog1: TOpenDialog
    Left = 528
    Top = 161
  end
end
