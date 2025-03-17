unit uUsuarioModel;

interface

uses
  uEnumerado, FireDAC.Comp.Client;

type
  TUsuarioModel = class
    Private
      FAcao           : TAcao;
      FID             : Integer;
      FNOME_USUARIO   : String;
      FSENHA          : String;
      FACESSO_LER     : String;
      FACESSO_GRAVAR  : String;
      FACESSO_DELETAR : String;

      procedure SetAcao(const Value: TAcao);
      procedure SetID(const Value: Integer);
      procedure SetNOME_USUARIO(const Value: String);
      procedure SetSENHA(const Value: String);
      procedure SetACESSO_LER(const Value: String);
      procedure SetACESSO_GRAVAR(const Value: String);
      procedure SetACESSO_DELETAR(const Value: String);
    Public
      function GetId: Integer;
      function RetornaSenhaOk(Nome: String) : String;
      function Salvar: Boolean;
      function RetornaSQL: TFDQuery;

      property Acao: TAcao read FAcao write SetAcao;
      property ID             : Integer read FID write SetID;
      property NOME_USUARIO   : String read FNOME_USUARIO write SetNOME_USUARIO;
      property SENHA          : String read FSENHA write SetSENHA;
      property ACESSO_LER     : String read FACESSO_LER write SetACESSO_LER;
      property ACESSO_GRAVAR  : String read FACESSO_GRAVAR write SetACESSO_GRAVAR;
      property ACESSO_DELETAR : String read FACESSO_DELETAR write SetACESSO_DELETAR;
  end;

implementation

{ TUsuarioModel }

Uses uUsuarioDAO;

function TUsuarioModel.GetId: Integer;
var
  vUsuarioDao: TUsuarioDao;
begin
  vUsuarioDao := TUsuarioDao.Create;
  try
    Result := vUsuarioDao.GetId;
  finally
    vUsuarioDao.Free;
  end;
end;

function TUsuarioModel.RetornaSenhaOk(Nome: String): String;
var
  vUsuarioDao: TUsuarioDao;
begin
  vUsuarioDao := TUsuarioDao.Create;
  try
    Result := vUsuarioDao.RetornaSenhaOk(Nome);
  finally
    vUsuarioDao.Free;
  end;
end;

function TUsuarioModel.RetornaSQL: TFDQuery;
var
  vUsuarioDao: TUsuarioDao;
begin
  vUsuarioDao := TUsuarioDao.Create;
  try
    Result := vUsuarioDao.RetornaSQL;
  finally
    vUsuarioDao.Free;
  end;
end;

function TUsuarioModel.Salvar: Boolean;
var
  vUsuarioDao: TUsuarioDao;
begin
  Result := False;

  vUsuarioDao := TUsuarioDao.Create;
  try
    case FAcao of
      uEnumerado.tacIncluir: Result := vUsuarioDao.Incluir(Self);
      uEnumerado.tacAlterar: Result := vUsuarioDao.Alterar(Self);
      uEnumerado.tacExcluir: Result := vUsuarioDao.Excluir(Self);
    end;
  finally
    vUsuarioDao.Free;
  end;
end;

procedure TUsuarioModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TUsuarioModel.SetACESSO_DELETAR(const Value: String);
begin
  FACESSO_DELETAR := Value;
end;

procedure TUsuarioModel.SetACESSO_GRAVAR(const Value: String);
begin
  FACESSO_GRAVAR := Value;
end;

procedure TUsuarioModel.SetACESSO_LER(const Value: String);
begin
  FACESSO_LER := Value;
end;

procedure TUsuarioModel.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TUsuarioModel.SetNOME_USUARIO(const Value: String);
begin
  FNOME_USUARIO := Value;
end;

procedure TUsuarioModel.SetSENHA(const Value: String);
begin
  FSENHA := Value;
end;

end.
