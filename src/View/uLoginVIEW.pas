unit uLoginVIEW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Datasnap.Provider,
  Data.DB, Datasnap.DBClient, uUsuarioControl;

type
  TfrmLogin = class(TForm)
    Label1: TLabel;
    EDT_Usuario: TEdit;
    Label2: TLabel;
    EDT_Senha: TEdit;
    Btn_OK: TButton;
    BTN_Cancelar: TButton;
    TB_Usuario: TClientDataSet;
    TB_UsuarioID: TIntegerField;
    TB_UsuarioNOME_USUARIO: TStringField;
    TB_UsuarioSENHA: TStringField;
    TB_UsuarioACESSO_LER: TStringField;
    TB_UsuarioACESSO_GRAVAR: TStringField;
    TB_UsuarioACESSO_DELETAR: TStringField;
    ds_Usuario: TDataSource;
    DataSetProvider: TDataSetProvider;
    procedure Btn_OKClick(Sender: TObject);
    procedure BTN_CancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FUsuario: TUsuarioControl;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses uPrincipalVIEW;

procedure TfrmLogin.BTN_CancelarClick(Sender: TObject);
begin
  application.Terminate;
end;

procedure TfrmLogin.Btn_OKClick(Sender: TObject);
var
  SenhaOk: String;
begin
  if Trim(EDT_Usuario.Text) = '' then
    begin
      Showmessage('Usu�rio n�o pode ser vazio');
      EDT_Usuario.SetFocus;
      Abort;
    end;

  if Trim(EDT_Senha.Text) = '' then
    begin
      Showmessage('Senha n�o pode ser vazia');
      EDT_Usuario.SetFocus;
      Abort;
    end;

  try
    FUsuario:= TUsuarioControl.Create;
    SenhaOk := frmPrincipal.CRIPTO_SENHA(FUsuario.RetornaSenhaOk(Trim(EDT_Usuario.Text)));
    if SenhaOk = Trim(EDT_Senha.Text) then
      close
    else
    begin
      Showmessage('Nome de Usu�rio ou Senha Inv�lida');
      EDT_Usuario.SetFocus;
      Abort;
    end;
  finally
    frmPrincipal.gblNomeUsuario := Trim(EDT_Usuario.Text);
    FUsuario.Free;
  end;

end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action :=cafree;
end;

procedure TfrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    application.Terminate;
  if Key = VK_RETURN then
   perform(WM_NEXTDLGCTL,0,0);
end;

end.
