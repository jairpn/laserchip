unit lojas.Model.Conexao;

interface

uses
    FireDAC.Stan.Intf, FireDAC.Stan.Option, System.SysUtils,
    FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
    FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
    FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client;

type
    TConexao = class
        private
            FConnexao: TFDConnection;       // Declaro a a variável que vai ser criada
            procedure ConfigurarConexao;   // Configuro passando os parâmetros necessários para conectar
            function CriarQuery: TFDQuery;

        public
            constructor Create;           // Crio a chamada a FConnexao
            destructor Destroy; override;     // No final destruo e libero da memória a FDConexao

            function GetConnexao: TFDConnection;    // Usando Get para não quebrar o encapsulamento do FConnexao : TFDConnection; que está no private
    End;

implementation

{ TConexao }

procedure TConexao.ConfigurarConexao;
begin
    FConnexao.Params.DriverID := 'MSSQL';
    FConnexao.Params.Database := 'laserchip';
    FConnexao.Params.Add('Server=192.168.1.140');
    FConnexao.Params.Add('User_name=sa');
    FConnexao.Params.Add('Password=J@pa0101');
    FConnexao.LoginPrompt := False;
end;

constructor TConexao.Create;
begin
    FConnexao := TFDConnection.Create(nil);
    self.ConfigurarConexao;
end;

function TConexao.CriarQuery: TFDQuery;
var
      xQuery: TFDQuery;
begin
    xQuery := TFDQuery.Create(nil);
    xQuery.Connection := FConnexao;
    Result := xQuery;
end;

destructor TConexao.Destroy;
begin
if Assigned(FConnexao) then
    FreeAndNil(FConnexao);
    inherited;
end;

function TConexao.GetConnexao: TFDConnection;
begin
    Result := FConnexao;
end;

end.
