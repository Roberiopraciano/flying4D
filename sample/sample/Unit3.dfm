object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 213
  ClientWidth = 534
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
  object Button1: TButton
    Left = 8
    Top = 9
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 40
    Width = 518
    Height = 164
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Criacao\Documents\GitHub\BoasPraticasCRUDDelph' +
        'i\ExemplosCRUD\database\Dados.sdb'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 408
    Top = 32
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from produto')
    Left = 480
    Top = 88
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 264
    Top = 144
  end
  object FDConnection2: TFDConnection
    Params.Strings = (
      'Database=dev'
      'User_Name=root'
      'Password=1'
      'Server=localhost'
      'DriverID=PG')
    LoginPrompt = False
    Left = 248
    Top = 16
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 
      'C:\Users\Criacao\Documents\GitHub\flying4D\sample\sample\Win32\D' +
      'ebug\libpq.dll'
    Left = 144
    Top = 8
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection2
    SQL.Strings = (
      'select * from produtos')
    Left = 352
    Top = 128
  end
end
