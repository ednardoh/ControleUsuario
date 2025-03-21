unit uCadUsuarioVIEW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, FireDAC.Phys.IBBase, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, uUsuarioControl, uEnumerado, Vcl.ExtCtrls;

type
  TFrmCadUsuario = class(TForm)
    TB_Usuario: TClientDataSet;
    ds_Usuario: TDataSource;
    DataSetProvider: TDataSetProvider;
    TB_UsuarioID: TIntegerField;
    TB_UsuarioNOME_USUARIO: TStringField;
    TB_UsuarioSENHA: TStringField;
    TB_UsuarioACESSO_LER: TStringField;
    TB_UsuarioACESSO_GRAVAR: TStringField;
    TB_UsuarioACESSO_DELETAR: TStringField;
    Label1: TLabel;
    DBE_Id: TDBEdit;
    Label2: TLabel;
    DBE_NomeUsuario: TDBEdit;
    Label3: TLabel;
    DBE_Senha: TDBEdit;
    Label4: TLabel;
    DBE_ACessoLer: TDBEdit;
    DBEdit1: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit2: TDBEdit;
    DBG_Usuario: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure TB_UsuarioBeforePost(DataSet: TDataSet);
    procedure TB_UsuarioBeforeDelete(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FUsuario: TUsuarioControl;
    ATipo: TAcao;
    procedure BuscaSelect;
  public
    { Public declarations }
  end;

var
  FrmCadUsuario: TFrmCadUsuario;

implementation

{$R *.dfm}

uses uPrincipalVIEW;

{ TFrmCadUsuario }

procedure TFrmCadUsuario.BuscaSelect;
begin
  try
    TB_Usuario.Close;
    FUsuario := TUsuarioControl.Create;
    DataSetProvider.DataSet := FUsuario.RetornaSQL;
    TB_Usuario.Open;
  finally
     FUsuario.Free;
     Abort;
  end;
end;

procedure TFrmCadUsuario.Button1Click(Sender: TObject);
begin
  if TB_Usuario.State in [dsInsert, dsEdit] then
    TB_UsuarioSENHA.AsString := frmPrincipal.CRIPTO_SENHA(TB_UsuarioSENHA.AsString);
end;

procedure TFrmCadUsuario.Button7Click(Sender: TObject);
begin
  TB_Usuario.Cancel;
end;

procedure TFrmCadUsuario.FormCreate(Sender: TObject);
begin
  BuscaSelect;
end;

procedure TFrmCadUsuario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    close;
  if Key = VK_RETURN then
   perform(WM_NEXTDLGCTL,0,0);
end;

procedure TFrmCadUsuario.TB_UsuarioBeforeDelete(DataSet: TDataSet);
begin
  ATipo := uEnumerado.tacExcluir;
  if MessageDlg('Deseja realmente exluir essa informação ?',mtConfirmation, [mbYes,mbNo],1) = mrYes then
  begin
    try
      FUsuario := TUsuarioControl.Create;
      FUsuario.UsuarioModel.Acao  := ATipo;
      FUsuario.UsuarioModel.ID    := TB_UsuarioID.AsInteger;
      FUsuario.Salvar;
    finally
      messagedlg('Dado Excluido com sucesso!',mtinformation,[mbok],0);
      FUsuario.Free;
    end;
  end;
  BuscaSelect;
end;

procedure TFrmCadUsuario.TB_UsuarioBeforePost(DataSet: TDataSet);
var
  iID: Integer;
begin
  if TB_Usuario.State = dsInsert then
  begin
    ATipo := uEnumerado.tacIncluir;
    try
      iID      := FUsuario.UsuarioModel.GetId;
      FUsuario := TUsuarioControl.Create;
      FUsuario.UsuarioModel.Acao           := ATipo;
      FUsuario.UsuarioModel.ID             := iID;
      FUsuario.UsuarioModel.NOME_USUARIO   := TB_UsuarioNOME_USUARIO.AsString;
      FUsuario.UsuarioModel.SENHA          := TB_UsuarioSENHA.AsString;
      FUsuario.UsuarioModel.ACESSO_LER     := TB_UsuarioACESSO_LER.AsString;
      FUsuario.UsuarioModel.ACESSO_GRAVAR  := TB_UsuarioACESSO_GRAVAR.AsString;
      FUsuario.UsuarioModel.ACESSO_DELETAR := TB_UsuarioACESSO_DELETAR.AsString;
      FUsuario.Salvar;
      TB_Usuario.Cancel;
    finally
      messagedlg('Dados gravados com sucesso!',mtinformation,[mbok],0);
      FUsuario.Free;
    end;
  end
  else
    if TB_Usuario.State = dsEdit then
    begin
      ATipo := uEnumerado.tacAlterar;
      try
        iID      := TB_UsuarioID.AsInteger;
        FUsuario := TUsuarioControl.Create;
        FUsuario.UsuarioModel.Acao           := ATipo;
        FUsuario.UsuarioModel.ID             := iID;
        FUsuario.UsuarioModel.NOME_USUARIO   := TB_UsuarioNOME_USUARIO.AsString;
        FUsuario.UsuarioModel.SENHA          := TB_UsuarioSENHA.AsString;
        FUsuario.UsuarioModel.ACESSO_LER     := TB_UsuarioACESSO_LER.AsString;
        FUsuario.UsuarioModel.ACESSO_GRAVAR  := TB_UsuarioACESSO_GRAVAR.AsString;
        FUsuario.UsuarioModel.ACESSO_DELETAR := TB_UsuarioACESSO_DELETAR.AsString;
        FUsuario.Salvar;
        TB_Usuario.Cancel;
      finally
        messagedlg('Dados gravados com sucesso!',mtinformation,[mbok],0);
        FUsuario.Free;
      end;
    end;
  BuscaSelect;
end;

end.
