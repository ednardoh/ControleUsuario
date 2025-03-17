unit uUsuarioDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, uUsuarioModel, System.SysUtils, uSistemaControl,
  uEnumerado, Data.DB, Vcl.Dialogs;

type
  TUsuarioDAO = class
    Private
      FConexao: TConexao;
    Public
    constructor Create;

    function Incluir(AUsuarioModel: TUsuarioModel): Boolean;
    function Alterar(AUsuarioModel: TUsuarioModel): Boolean;
    function Excluir(AUsuarioModel: TUsuarioModel): Boolean;
    function GetId: Integer;
    function RetornaSQL: TFDQuery;
    function RetornaSenhaOk(Nome: String) : String;

  end;

implementation

{ TUsuarioDAO }

constructor TUsuarioDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance().Conexao
end;

function TUsuarioDAO.Incluir(AUsuarioModel: TUsuarioModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    try
      vQry.ExecSQL('INSERT INTO TB_USUARIO(        '+
                   '              ID,              '+
                   '              NOME_USUARIO,    '+
                   '              SENHA,           '+
                   '              ACESSO_LER,      '+
                   '              ACESSO_GRAVAR,   '+
                   '              ACESSO_DELETAR)  '+
                   '       VALUES(:ID,             '+
                   '              :NOME_USUARIO,   '+
                   '              :SENHA,          '+
                   '              :ACESSO_LER,     '+
                   '              :ACESSO_GRAVAR,  '+
                   '              :ACESSO_DELETAR) ',
                    [AUsuarioModel.ID,
                     AUsuarioModel.NOME_USUARIO,
                     AUsuarioModel.SENHA,
                     AUsuarioModel.ACESSO_LER,
                     AUsuarioModel.ACESSO_GRAVAR,
                     AUsuarioModel.ACESSO_DELETAR]);

      Result := True;
    except
    on E: Exception do
      begin
        Result := False;
      end;
    end;
  finally
    vQry.Free;
  end;
end;

function TUsuarioDAO.Alterar(AUsuarioModel: TUsuarioModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    try
      vQry.ExecSQL('UPDATE TB_USUARIO SET NOME_USUARIO  =:NOME_USUARIO,  '+
                   '                      SENHA         =:SENHA,         '+
                   '                      ACESSO_LER    =:ACESSO_LER,    '+
                   '                      ACESSO_GRAVAR =:ACESSO_GRAVAR, '+
                   '                      ACESSO_DELETAR=:ACESSO_DELETAR '+
                   '                  WHERE ID      =:ID                 ',
                    [AUsuarioModel.NOME_USUARIO,
                     AUsuarioModel.SENHA,
                     AUsuarioModel.ACESSO_LER,
                     AUsuarioModel.ACESSO_GRAVAR,
                     AUsuarioModel.ACESSO_DELETAR,
                     AUsuarioModel.ID]);

      Result := True;
    except
    on E: Exception do
      begin
        Result := False;
      end;
    end;
  finally
    vQry.Free;
  end;
end;

function TUsuarioDAO.Excluir(AUsuarioModel: TUsuarioModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    try
      vQry.ExecSQL('DELETE FROM TB_USUARIO WHERE ID=:ID ',
                    [AUsuarioModel.ID]);
      Result := True;
    except
    on E: Exception do
      begin
        Result := False;
      end;
    end;
  finally
    vQry.Free;
  end;
end;

function TUsuarioDAO.GetId: Integer;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    vQry.Open('SELECT coalesce(MAX(ID),0)+1 AS ID FROM TB_USUARIO');
    try
      Result := vQry.Fields[0].AsInteger;
    finally
      vQry.Close;
    end;
  finally
    vQry.Free;
  end;
end;

function TUsuarioDAO.RetornaSenhaOk(Nome: String): String;
var
  vQry: TFDQuery;
  sSQL: String;
begin
  vQry := FConexao.CriarQuery();
  sSQL :='';
  sSQL :='SELECT NOME_USUARIO,              '+
         '        SENHA                     '+
         ' FROM TB_USUARIO                  '+
         ' WHERE NOME_USUARIO=:NOME_USUARIO ';
  vQry.Close;
  vQry.SQL.Add(sSQL);
  vQry.Params.ParamByName('NOME_USUARIO').AsString := Nome;
  vQry.Open;
  Result := vQry.FieldByName('SENHA').AsString;
end;

function TUsuarioDAO.RetornaSQL: TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  vQry.Open('SELECT ID, NOME_USUARIO, SENHA, ACESSO_LER, ACESSO_GRAVAR, ACESSO_DELETAR FROM TB_USUARIO ORDER BY ID');
  Result := vQry;
end;

end.
