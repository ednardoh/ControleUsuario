unit UConecta;

interface

 uses
   IniFiles, SysUtils, Forms, Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
   FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
   FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Async,
   FireDAC.Comp.UI, FireDAC.Phys.IBBase, Menus, Mask, DBCtrls, ShellApi,
   FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.Phys.MSSQL,
   FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase, FireDAC.Phys.FBDef;

type
   TConexaoDB = class
   private
    FPath: string;
    FServidor: string;
    FPorta: integer;
    FDatabase: string;
    FSenha: string;
    FUsuario: string;
    FDriver: string;
    FSecao: string;
    FConectouBanco: Boolean;
    FOSAuthent: Boolean;

   public
      property Path : string read FPath write FPath;
      property Servidor : string read FServidor write FServidor;
      property Porta : integer read FPorta write FPorta;
      property Database : string read FDatabase write FDatabase;
      property Senha : string read FSenha write FSenha;
      property Usuario : string read FUsuario write FUsuario;
      property Driver : string read FDriver write FDriver;
      property Secao : string read FSecao write FSecao;
      property ConectouBanco : Boolean read FConectouBanco write FConectouBanco;
      property OSAuthent : Boolean read FOSAuthent write FOSAuthent;

      constructor Create(Path: string; Secao: string);

      procedure LeINI(); virtual;
      procedure GravaINI(Usuario, Senha, Servidor, Banco, Driver: string; Porta: integer; OSAuthent: Boolean); virtual;
      procedure Conectar(var Conexao: TFDConnection); virtual;

   end;

implementation


{ TConexao }
procedure TConexaoDB.Conectar(var Conexao: TFDConnection);
begin
    LeINI();

     try
        //Passa os par�metros para o objeto Conex�o
        Conexao.Connected := false;
        Conexao.LoginPrompt := false;
        Conexao.Params.Clear;
        Conexao.Params.Add('Server='+ Servidor);
        Conexao.Params.Add('User_Name='+ Usuario);
        Conexao.Params.Add('Password='+ Senha);
        Conexao.Params.Add('port='+ IntToStr(Porta));
        Conexao.Params.Add('Database='+ Database);
        Conexao.Params.Add('DriverID='+ Driver);
        Conexao.Open();
     Except
        on E:Exception do
        ShowMessage('Erro ao carregar par�metros de conex�o!'#13#10 + E.Message);
     end;
end;

constructor TConexaoDB.Create(Path, Secao: string);
begin
  if FileExists(Path) then
  begin
     Self.Path := Path;
     Self.Secao := Secao;
     ConectouBanco:=True;
  end
  else
  begin
    Self.Path := Path;
    Self.Secao := Secao;
    ConectouBanco:=False;
    Showmessage('Arquivo INI para configura��o n�o encontrado.'#13#10'Favor Configurar o Banco.');
  end;
end;

procedure TConexaoDB.GravaINI(Usuario, Senha, Servidor, Banco, Driver: string;
  Porta: integer; OSAuthent: Boolean);
var
    ArqIni : TIniFile;
begin
  ArqIni := TIniFile.Create(Path);
  try
    ArqIni.WriteString(Secao, 'Usuario', Usuario);
    ArqIni.WriteString(Secao, 'Senha', Senha);
    ArqIni.WriteString(Secao, 'Database', Banco);
    ArqIni.WriteString(Secao, 'Servidor', Servidor);
    ArqIni.WriteInteger(Secao, 'Porta', Porta);
    ArqIni.WriteString(Secao, 'Driver', Driver);
  finally
     ArqIni.Free;
  end;
end;

procedure TConexaoDB.LeINI;
var
    ArqIni : TIniFile;
begin
  ArqIni := TIniFile.Create(Path);
  try
    Servidor    := ArqIni.ReadString(Secao, 'Servidor', '');
    Porta       := ArqIni.ReadInteger(Secao, 'Porta', 0);
    Database    := ArqIni.ReadString(Secao, 'Database', '');
    Senha       := ArqIni.ReadString(Secao, 'Senha', '');
    Usuario     := ArqIni.ReadString(Secao, 'Usuario', '');
    Driver      := ArqIni.ReadString(Secao, 'Driver', '');
  finally
     ArqIni.Free;
  end;
end;

end.
