unit uPrincipalVIEW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, FireDAC.Phys.FBDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.IBBase, Vcl.ComCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenuPrincipal: TMainMenu;
    CadastrodeUsurios1: TMenuItem;
    Usurios1: TMenuItem;
    Sair1: TMenuItem;
    StatusBar1: TStatusBar;
    procedure Sair1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Usurios1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    gblNomeUsuario: String;
    Function CRIPTO_SENHA(wStri: String): string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses UConexaoBDpas, uCadUsuarioVIEW, uLoginVIEW;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  if not FileExists(pchar(ExtractFilePath(Application.ExeName) + 'ConfigDB.ini')) then
    begin
      frmConectaDB := TfrmConectaDB.create(Self);
      frmConectaDB.Showmodal;
      close;
    end;

  frmLogin := TfrmLogin.Create(Application);
  frmLogin.ShowModal;
  StatusBar1.Panels[0].Text := 'Usu�rio do Sistema : '+  gblNomeUsuario;
  StatusBar1.Panels[1].Text := 'Data do Sistema : ' + FormatDateTime('dd/mm/yyyy',Date);
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.Usurios1Click(Sender: TObject);
begin
  FrmCadUsuario :=TFrmCadUsuario.Create(Self);
  FrmCadUsuario.ShowModal;
end;

function TfrmPrincipal.CRIPTO_SENHA(wStri: String): string;
var Simbolos : array [0..4] of String;
     x            : Integer;
begin
  Simbolos[1]:=
  'ABCDEFGHIJLMNOPQRSTUVXZYWK ~!@#$%^&*()';

  Simbolos[2]:=
  '�����׃����5�����Ѫ�������������������';

  Simbolos[3]:='abcdefghijlmnopqrstuvxzywk1234567890';

  Simbolos[4]:='���������龶����-+��߸������յ��졫�';

  for x := 1 to Length(Trim(wStri)) do begin
     if pos(copy(wStri,x,1),Simbolos[1])>0 then
        Result := Result+copy(Simbolos[2],
                      pos(copy(wStri,x,1),Simbolos[1]),1)

     else if pos(copy(wStri,x,1),Simbolos[2])>0 then
        Result := Result+copy(Simbolos[1],
                      pos(copy(wStri,x,1),Simbolos[2]),1)

     else if pos(copy(wStri,x,1),Simbolos[3])>0 then
        Result := Result+copy(Simbolos[4],
                      pos(copy(wStri,x,1),Simbolos[3]),1)

     else if pos(copy(wStri,x,1),Simbolos[4])>0 then
        Result := Result+copy(Simbolos[3],
                      pos(copy(wStri,x,1),Simbolos[4]),1);
  end;
end;

end.
