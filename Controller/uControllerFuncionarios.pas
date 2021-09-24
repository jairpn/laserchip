unit uControllerFuncionarios;

interface

uses uModelFuncionarios, System.SysUtils, FireDAC.Comp.Client;

type

    TControllerFuncionarios = class
        private
            FModelFuncionarios: TModelFuncionarios;

        public

            property ModelFuncionario: TModelFuncionarios read FModelFuncionarios write FModelFuncionarios;

            function persistir: boolean;
            function selecionar: TFDQuery;
            function selecionarLojas: TFDQuery;

            constructor Create;
            destructor Destroy; override;

    end;

implementation

{ TControllerFuncionarios }

constructor TControllerFuncionarios.Create;
begin
    FModelFuncionarios := TModelFuncionarios.Create;
    inherited Create;
end;

destructor TControllerFuncionarios.Destroy;
begin
    FreeAndNil(FModelFuncionarios);
    inherited;
end;

function TControllerFuncionarios.persistir: boolean;
begin
    Result := FModelFuncionarios.persistir;
end;

function TControllerFuncionarios.selecionar: TFDQuery;
begin
    Result := FModelFuncionarios.selecionar;
end;

function TControllerFuncionarios.selecionarLojas: TFDQuery;
begin
    Result := FModelFuncionarios.selecionarLoja;
end;

end.
