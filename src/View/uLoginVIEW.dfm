object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 194
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 48
    Width = 57
    Height = 16
    Caption = 'Usuario :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 48
    Top = 88
    Width = 49
    Height = 16
    Caption = 'Senha :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object EDT_Usuario: TEdit
    Left = 111
    Top = 45
    Width = 135
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object EDT_Senha: TEdit
    Left = 111
    Top = 87
    Width = 135
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PasswordChar = #8226
    TabOrder = 1
  end
  object Btn_OK: TButton
    Left = 88
    Top = 136
    Width = 75
    Height = 25
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Btn_OKClick
  end
  object BTN_Cancelar: TButton
    Left = 169
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BTN_CancelarClick
  end
  object TB_Usuario: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider'
    Left = 151
    Top = 6
    object TB_UsuarioID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TB_UsuarioNOME_USUARIO: TStringField
      FieldName = 'NOME_USUARIO'
      Origin = 'NOME_USUARIO'
      Size = 60
    end
    object TB_UsuarioSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 100
    end
    object TB_UsuarioACESSO_LER: TStringField
      FieldName = 'ACESSO_LER'
      Origin = 'ACESSO_LER'
      FixedChar = True
      Size = 1
    end
    object TB_UsuarioACESSO_GRAVAR: TStringField
      FieldName = 'ACESSO_GRAVAR'
      Origin = 'ACESSO_GRAVAR'
      FixedChar = True
      Size = 1
    end
    object TB_UsuarioACESSO_DELETAR: TStringField
      FieldName = 'ACESSO_DELETAR'
      Origin = 'ACESSO_DELETAR'
      FixedChar = True
      Size = 1
    end
  end
  object ds_Usuario: TDataSource
    DataSet = TB_Usuario
    Left = 111
    Top = 6
  end
  object DataSetProvider: TDataSetProvider
    Left = 199
    Top = 6
  end
end
