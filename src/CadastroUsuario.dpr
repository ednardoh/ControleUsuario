program CadastroUsuario;

uses
  Vcl.Forms,
  uPrincipalVIEW in 'View\uPrincipalVIEW.pas' {frmPrincipal},
  UConecta in 'Conexao\UConecta.pas',
  uConexao in 'Conexao\uConexao.pas',
  UConexaoBDpas in 'Conexao\UConexaoBDpas.pas' {frmConectaDB},
  uUsuarioDAO in 'DAO\uUsuarioDAO.pas',
  uSistemaControl in 'Controller\uSistemaControl.pas',
  uEnumerado in 'Model\uEnumerado.pas',
  uUsuarioModel in 'Model\uUsuarioModel.pas',
  uUsuarioControl in 'Controller\uUsuarioControl.pas',
  uCadUsuarioVIEW in 'View\uCadUsuarioVIEW.pas' {FrmCadUsuario},
  uLoginVIEW in 'View\uLoginVIEW.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmConectaDB, frmConectaDB);
  Application.Run;
end.
