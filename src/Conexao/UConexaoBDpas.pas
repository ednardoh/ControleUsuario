unit UConexaoBDpas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UConecta,
  uPrincipalVIEW, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Async,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase, Menus, Mask, DBCtrls, ShellApi,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.FBDef;

type
  TfrmConectaDB = class(TForm)
    pn_Bottom: TPanel;
    pn_Client: TPanel;
    btn_Testaconexao: TButton;
    btnConectar: TButton;
    btnFechar: TButton;
    Edt_Host: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edt_Porta: TEdit;
    Label3: TLabel;
    Edt_Senha: TEdit;
    Label4: TLabel;
    edt_DataBase: TEdit;
    Label5: TLabel;
    edt_Usuario: TEdit;
    btn_Openbanco: TBitBtn;
    ODG_Abrebanco: TOpenDialog;
    lblConexao: TLabel;
    btn_GravaINI: TButton;
    ckb_AutenticWin: TCheckBox;
    DBConect: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_OpenbancoClick(Sender: TObject);
    procedure Edt_HostEnter(Sender: TObject);
    procedure Edt_HostExit(Sender: TObject);
    procedure Edt_HostKeyPress(Sender: TObject; var Key: Char);
    procedure btn_TestaconexaoClick(Sender: TObject);
    procedure ConexaoBeforeConnect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_GravaINIClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ckb_AutenticWinClick(Sender: TObject);
  private
    { Private declarations }
    procedure VerificaConexao();
  public
    { Public declarations }
  end;

var
  frmConectaDB: TfrmConectaDB;
  conexaoClass : TConexaoDB;

implementation

{$R *.dfm}

procedure TfrmConectaDB.btnFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmConectaDB.btn_GravaINIClick(Sender: TObject);
begin
  conexaoClass.GravaINI(edt_Usuario.Text,
                        Edt_Senha.Text,
                        Edt_Host.Text,
                        edt_DataBase.Text,
                        'FB',
                        StrToInt(edt_Porta.Text),
                        ckb_AutenticWin.checked);
  MessageDlg('Gravado com sucesso!', mtConfirmation, [mbOK], 0);
end;

procedure TfrmConectaDB.btn_OpenbancoClick(Sender: TObject);
begin
  ODG_Abrebanco.InitialDir := ExtractFilePath(Application.ExeName);
  if ODG_Abrebanco.Execute then
  begin
    edt_DataBase.Text := ODG_Abrebanco.FileName;
  end;
end;

procedure TfrmConectaDB.btn_TestaconexaoClick(Sender: TObject);
begin
  btn_GravaINIClick(Self);
  if not DBConect.Connected then
  begin
      lblConexao.Caption     := 'Banco Conectado com sucesso...';
      btnConectar.Caption    := 'Desconectar';
      conexaoClass.Conectar(DBConect);
      DBConect.Connected     := True;
  end
  else
  begin
      lblConexao.Caption     := 'Banco desconectado...';
      btnConectar.Caption    := 'Conectar';
      DBConect.Connected     := false;
  end;
end;

procedure TfrmConectaDB.ckb_AutenticWinClick(Sender: TObject);
begin
  if ckb_AutenticWin.Checked then
  begin
    edt_Usuario.Clear;
    Edt_Senha.Clear;
  end;
end;

procedure TfrmConectaDB.ConexaoBeforeConnect(Sender: TObject);
begin
  conexaoClass.Conectar(DBConect);
end;

procedure TfrmConectaDB.Edt_HostEnter(Sender: TObject);
begin
  TEdit(Sender).Color := $00A0FAF8;
end;

procedure TfrmConectaDB.Edt_HostExit(Sender: TObject);
begin
  TEdit(Sender).Color := clwindow;
end;

procedure TfrmConectaDB.Edt_HostKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    PERFORM(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmConectaDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmConectaDB.FormCreate(Sender: TObject);
begin
  conexaoClass := TConexaoDB.Create(ExtractFilePath(Application.ExeName) + 'ConfigDB.ini', 'Conexao');
end;

procedure TfrmConectaDB.FormShow(Sender: TObject);
begin
  frmConectaDB.SetFocus;
end;

procedure TfrmConectaDB.VerificaConexao;
begin

   if DBConect.Connected = true then
   begin
     btnConectar.Caption := 'Desconectar';
     lblConexao.Caption  := 'Conectado...!';
     lblConexao.Font.Color := clGreen;
   end
   else
   begin
     btnConectar.Caption := 'Conectar';
     lblConexao.Caption  := 'Desconectado...';
     lblConexao.Font.Color := clRed;
   end;

end;

end.
