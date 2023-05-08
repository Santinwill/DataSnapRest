object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Cliente Cadastro'
  ClientHeight = 506
  ClientWidth = 704
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 704
    Height = 506
    ActivePage = CadastrarEditar
    Align = alClient
    TabOrder = 0
    object MostrarDados: TTabSheet
      Caption = 'Mostrar Dados'
      TabVisible = False
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 696
        Height = 41
        Align = alTop
        TabOrder = 0
      end
      object DBGrid: TDBGrid
        Left = 0
        Top = 41
        Width = 696
        Height = 414
        Align = alClient
        DataSource = DataSource
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object Panel3: TPanel
        Left = 0
        Top = 455
        Width = 696
        Height = 41
        Align = alBottom
        TabOrder = 2
        object ButtonNovo: TButton
          Left = 480
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Novo'
          TabOrder = 0
        end
        object ButtonBuscar: TButton
          Left = 398
          Top = 8
          Width = 76
          Height = 25
          Caption = 'Listar'
          TabOrder = 1
        end
        object ButtonInserirLotePessoas: TButton
          Left = 561
          Top = 8
          Width = 123
          Height = 25
          Caption = 'Inserir Lote Pessoas'
          TabOrder = 2
        end
      end
    end
    object CadastrarEditar: TTabSheet
      Caption = 'Cadastrar/Editar'
      ImageIndex = 1
      TabVisible = False
      object Label1: TLabel
        Left = 40
        Top = 43
        Width = 60
        Height = 13
        Caption = 'C'#243'd. Pessoa'
      end
      object Label2: TLabel
        Left = 40
        Top = 83
        Width = 52
        Height = 13
        Caption = 'FlNatureza'
      end
      object Label3: TLabel
        Left = 40
        Top = 120
        Width = 54
        Height = 13
        Caption = 'Documento'
      end
      object Label4: TLabel
        Left = 40
        Top = 163
        Width = 68
        Height = 13
        Caption = 'Primeiro Nome'
      end
      object Label5: TLabel
        Left = 40
        Top = 203
        Width = 72
        Height = 13
        Caption = 'Segundo Nome'
      end
      object Label6: TLabel
        Left = 40
        Top = 243
        Width = 66
        Height = 13
        Caption = 'Data Registro'
      end
      object Label7: TLabel
        Left = 40
        Top = 283
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object Label8: TLabel
        Left = 392
        Top = 43
        Width = 13
        Height = 13
        Caption = 'UF'
      end
      object Label9: TLabel
        Left = 392
        Top = 83
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object Label10: TLabel
        Left = 392
        Top = 120
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object Label11: TLabel
        Left = 392
        Top = 163
        Width = 55
        Height = 13
        Caption = 'Logradouro'
      end
      object Label12: TLabel
        Left = 392
        Top = 203
        Width = 65
        Height = 13
        Caption = 'Complemento'
      end
      object Label13: TLabel
        Left = 392
        Top = 243
        Width = 67
        Height = 13
        Caption = 'C'#243'd Endereco'
      end
      object Label14: TLabel
        Left = 392
        Top = 283
        Width = 101
        Height = 13
        Caption = 'Cod PessoaEndereco'
      end
      object Label15: TLabel
        Left = 392
        Top = 324
        Width = 124
        Height = 13
        Caption = 'Cod endereco_integracao'
      end
      object Panel2: TPanel
        Left = 0
        Top = 450
        Width = 696
        Height = 46
        Align = alBottom
        TabOrder = 0
        object ButtonSalvar: TButton
          Left = 208
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Salvar Novo'
          TabOrder = 0
        end
        object ButtonAtualizar: TButton
          Left = 305
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Atualizar'
          TabOrder = 1
        end
        object ButtonDeletar: TButton
          Left = 401
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Deletar'
          TabOrder = 2
        end
        object ButtonCancelar: TButton
          Left = 496
          Top = 16
          Width = 75
          Height = 25
          Cancel = True
          Caption = 'Cancelar'
          TabOrder = 3
        end
      end
      object EditIdPessoa: TEdit
        Left = 40
        Top = 56
        Width = 121
        Height = 21
        TabStop = False
        Color = clGradientActiveCaption
        ReadOnly = True
        TabOrder = 1
      end
      object EditFlnatureza: TEdit
        Left = 40
        Top = 96
        Width = 121
        Height = 21
        NumbersOnly = True
        TabOrder = 2
      end
      object EditDsdocumento: TEdit
        Left = 40
        Top = 136
        Width = 121
        Height = 21
        NumbersOnly = True
        TabOrder = 3
      end
      object EditNmprimeiro: TEdit
        Left = 40
        Top = 176
        Width = 121
        Height = 21
        TabOrder = 4
      end
      object EditNmsegundo: TEdit
        Left = 40
        Top = 216
        Width = 121
        Height = 21
        TabOrder = 5
      end
      object EditDtregistro: TEdit
        Left = 40
        Top = 256
        Width = 121
        Height = 21
        TabStop = False
        Color = clGradientActiveCaption
        ReadOnly = True
        TabOrder = 6
      end
      object EditDscep: TEdit
        Left = 40
        Top = 296
        Width = 121
        Height = 21
        MaxLength = 8
        NumbersOnly = True
        TabOrder = 7
      end
      object EditDsuf: TEdit
        Left = 392
        Top = 56
        Width = 121
        Height = 21
        TabStop = False
        Color = clGradientActiveCaption
        ReadOnly = True
        TabOrder = 9
      end
      object EditNmcidade: TEdit
        Left = 392
        Top = 96
        Width = 121
        Height = 21
        TabStop = False
        Color = clGradientActiveCaption
        ReadOnly = True
        TabOrder = 10
      end
      object EditNmbairro: TEdit
        Left = 392
        Top = 136
        Width = 121
        Height = 21
        TabStop = False
        Color = clGradientActiveCaption
        ReadOnly = True
        TabOrder = 11
      end
      object EditNmlogradouro: TEdit
        Left = 392
        Top = 176
        Width = 121
        Height = 21
        TabStop = False
        Color = clGradientActiveCaption
        ReadOnly = True
        TabOrder = 12
      end
      object EditDscomplemento: TEdit
        Left = 392
        Top = 216
        Width = 121
        Height = 21
        TabOrder = 8
      end
      object EditIdendereco: TEdit
        Left = 392
        Top = 256
        Width = 121
        Height = 21
        TabStop = False
        Color = clGradientActiveCaption
        ReadOnly = True
        TabOrder = 13
      end
      object EditIdpessoaendereco: TEdit
        Left = 392
        Top = 296
        Width = 121
        Height = 21
        TabStop = False
        Color = clGradientActiveCaption
        ReadOnly = True
        TabOrder = 14
      end
      object EditIdendereco_integracao: TEdit
        Left = 392
        Top = 337
        Width = 121
        Height = 21
        TabStop = False
        Color = clGradientActiveCaption
        ReadOnly = True
        TabOrder = 15
      end
    end
  end
  object FDStanStorageJSONLink: TFDStanStorageJSONLink
    Left = 312
    Top = 312
  end
  object FDStanStorageBinLink: TFDStanStorageBinLink
    Left = 304
    Top = 376
  end
  object FDMemTable: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 304
    Top = 184
  end
  object DataSource: TDataSource
    DataSet = FDMemTable
    Left = 320
    Top = 240
  end
end
