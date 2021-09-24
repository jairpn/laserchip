unit uControllerConexao;

interface

uses
    System.SysUtils, uDAOConexao;

type
    TControllerConexao = class

        private
            FConexao: TDAOConexao;

            constructor Create;
            destructor Destroy; Override;

        public

            property daoConexao: TDAOConexao read FConexao write FConexao;

            class function getInstance: TControllerConexao;

    end;

implementation

var
      InstanciaBD: TControllerConexao;

    { TControllerConexao }

constructor TControllerConexao.Create;
begin
    inherited Create;
    FConexao := TDAOConexao.Create;
end;

destructor TControllerConexao.Destroy;
begin
    inherited;
    FreeAndNil(FConexao);

end;

class function TControllerConexao.getInstance: TControllerConexao;
begin
    if (InstanciaBD = nil) then
        InstanciaBD := TControllerConexao.Create;

    Result := InstanciaBD;
end;

initialization

InstanciaBD := nil;

finalization

if (InstanciaBD <> nil) then
    FreeAndNil(InstanciaBD);

end.
