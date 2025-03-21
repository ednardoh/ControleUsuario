unit uUsuarioControl;

interface

uses
  uUsuarioModel, System.SysUtils, FireDAC.Comp.Client;

type
  TUsuarioControl = class
    private
      FUsuarioModel: TUsuarioModel;
    Public
      constructor Create;
      destructor Destroy; override;

      function GetId: Integer;
      function RetornaSQL: TFDQuery;
      function RetornaSenhaOk(Nome: String) : String;
      function Salvar: Boolean;

      property UsuarioModel: TUsuarioModel read FUsuarioModel write FUsuarioModel;
  end;

implementation

{ TUsuarioControl }

constructor TUsuarioControl.Create;
begin
  FUsuarioModel := TUsuarioModel.Create;
end;

destructor TUsuarioControl.Destroy;
begin
  FUsuarioModel.Free;
  inherited;
end;

function TUsuarioControl.GetId: Integer;
begin
  Result := FUsuarioModel.GetId;
end;

function TUsuarioControl.RetornaSenhaOk(Nome: String): String;
begin
  Result := FUsuarioModel.RetornaSenhaOk(Nome);
end;

function TUsuarioControl.RetornaSQL: TFDQuery;
begin
  Result := FUsuarioModel.RetornaSQL;
end;

function TUsuarioControl.Salvar: Boolean;
begin
  Result := FUsuarioModel.Salvar;
end;

end.
