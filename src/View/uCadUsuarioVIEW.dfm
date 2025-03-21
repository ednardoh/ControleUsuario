object FrmCadUsuario: TFrmCadUsuario
  Left = 0
  Top = 0
  Caption = 'Cadastro de Usu'#225'rio'
  ClientHeight = 368
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 11
    Height = 13
    Caption = 'ID'
  end
  object Label2: TLabel
    Left = 24
    Top = 64
    Width = 66
    Height = 13
    Caption = 'Nome Usuario'
  end
  object Label3: TLabel
    Left = 24
    Top = 113
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object Label4: TLabel
    Left = 24
    Top = 167
    Width = 52
    Height = 13
    Caption = 'Acesso Ler'
  end
  object Label5: TLabel
    Left = 216
    Top = 167
    Width = 70
    Height = 13
    Caption = 'Acesso Gravar'
  end
  object Label6: TLabel
    Left = 435
    Top = 167
    Width = 72
    Height = 13
    Caption = 'Acesso Deletar'
  end
  object DBE_Id: TDBEdit
    Left = 24
    Top = 32
    Width = 41
    Height = 21
    TabStop = False
    DataField = 'ID'
    DataSource = ds_Usuario
    Enabled = False
    TabOrder = 0
  end
  object DBE_NomeUsuario: TDBEdit
    Left = 24
    Top = 80
    Width = 513
    Height = 21
    DataField = 'NOME_USUARIO'
    DataSource = ds_Usuario
    TabOrder = 1
  end
  object DBE_Senha: TDBEdit
    Left = 24
    Top = 132
    Width = 513
    Height = 21
    DataField = 'SENHA'
    DataSource = ds_Usuario
    TabOrder = 2
  end
  object DBE_ACessoLer: TDBEdit
    Left = 82
    Top = 160
    Width = 23
    Height = 21
    DataField = 'ACESSO_LER'
    DataSource = ds_Usuario
    TabOrder = 3
  end
  object DBEdit1: TDBEdit
    Left = 293
    Top = 160
    Width = 23
    Height = 21
    DataField = 'ACESSO_GRAVAR'
    DataSource = ds_Usuario
    TabOrder = 4
  end
  object DBEdit2: TDBEdit
    Left = 515
    Top = 160
    Width = 23
    Height = 21
    DataField = 'ACESSO_DELETAR'
    DataSource = ds_Usuario
    TabOrder = 5
  end
  object DBG_Usuario: TDBGrid
    Left = 12
    Top = 200
    Width = 665
    Height = 160
    DataSource = ds_Usuario
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_USUARIO'
        Title.Caption = 'Nome Usu'#225'rio'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SENHA'
        Title.Caption = 'Senha'
        Width = 314
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACESSO_LER'
        Title.Caption = 'Acesso Ler'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACESSO_GRAVAR'
        Title.Caption = 'Acesso Gravar'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACESSO_DELETAR'
        Title.Caption = 'Acesso Deletar'
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 293
    Top = 25
    Width = 243
    Height = 33
    DataSource = ds_Usuario
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
    ConfirmDelete = False
    TabOrder = 7
  end
  object Button1: TButton
    Left = 544
    Top = 130
    Width = 138
    Height = 25
    Caption = 'Criptografar/Descritografar'
    TabOrder = 8
    OnClick = Button1Click
  end
  object TB_Usuario: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider'
    BeforePost = TB_UsuarioBeforePost
    BeforeDelete = TB_UsuarioBeforeDelete
    Left = 464
    Top = 320
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
    Left = 504
    Top = 320
  end
  object DataSetProvider: TDataSetProvider
    Left = 544
    Top = 320
  end
end
