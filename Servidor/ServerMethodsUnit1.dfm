object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 375
  Width = 425
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=CADASTRO'
      'User_Name=postgres'
      'Password=postgres'
      'Server=localhost'
      'DriverID=pG')
    Connected = True
    LoginPrompt = False
    Left = 88
    Top = 56
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 88
    Top = 176
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 
      'C:\Users\des42\Desktop\ProvaDelphi-WillianPedroSantin\Servidor\W' +
      'in64\Debug\libpq.dll'
    Left = 88
    Top = 120
  end
  object FDStanStorageJSONLink: TFDStanStorageJSONLink
    Left = 240
    Top = 144
  end
  object FDStanStorageBinLink: TFDStanStorageBinLink
    Left = 240
    Top = 192
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 344
    Top = 296
  end
end
