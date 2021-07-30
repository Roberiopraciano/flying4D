object DataModule2: TDataModule2
  OldCreateOrder = False
  Height = 255
  Width = 330
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Criacao\Documents\GitHub\BoasPraticasCRUDDelph' +
        'i\ExemplosCRUD\database\Dados.sdb'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginDialog = FDGUIxLoginDialog1
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Caption = 'FireDAC Executor Error'
    Left = 168
    Top = 16
  end
  object FDGUIxLoginDialog1: TFDGUIxLoginDialog
    Provider = 'Forms'
    Left = 168
    Top = 72
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 160
    Top = 128
  end
  object FDGUIxAsyncExecuteDialog1: TFDGUIxAsyncExecuteDialog
    Provider = 'Forms'
    Caption = 'FireDAC Executor Working'
    Left = 160
    Top = 184
  end
end
