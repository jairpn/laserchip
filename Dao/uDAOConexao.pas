unit uDAOConexao;

interface

uses
    FireDAC.Stan.Intf, FireDAC.Stan.Option, System.SysUtils,
    FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
    FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
    Data.DB, FireDAC.Comp.Client;

type
    TDAOConexao = class

        private
            fConexao: TFDConnection;

        public
            function getConexao: TFDConnection;
            function criarQuery: TFDQuery;

            constructor Create;
            destructor Destroy; Override;
    end;

implementation

{ TDAOConexao }

constructor TDAOConexao.Create;
begin
    inherited Create;

    fConexao := TFDConnection.Create(nil);

    fConexao.Params.DriverID := 'MSSQL';
    fConexao.Params.Database := 'laserchip';
    fConexao.Params.Add('Server=192.168.1.140');
    fConexao.Params.Add('User_name=jairpn');
    fConexao.Params.Add('Password=jair12345');
    fConexao.LoginPrompt := False;
end;

function TDAOConexao.criarQuery: TFDQuery;
var
      xQuery: TFDQuery;
begin
    xQuery := TFDQuery.Create(nil);
    xQuery.Connection := fConexao;
    Result := xQuery;
end;

destructor TDAOConexao.Destroy;
begin
    inherited;
    FreeAndNil(fConexao);
end;

function TDAOConexao.getConexao: TFDConnection;
begin
    Result := fConexao;
end;

end.
