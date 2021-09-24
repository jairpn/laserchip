unit uControllerLojas;

interface

uses
    uModelLojas, System.SysUtils, FireDAC.Comp.Client;

type

    TControllerLojas = class
        private
            LModelLojas: TModelLojas;

        public

            property ModelLoja: TModelLojas read LModelLojas write LModelLojas;

            function persistir: boolean;
            function selecionar: TFDQuery;
            function selecionarLojas: TFDQuery;

            constructor Create;
            destructor Destroy; override;
    end;

implementation

{ TControllerLojas }

constructor TControllerLojas.Create;
begin
    LModelLojas := TModelLojas.Create;
    inherited Create;
end;

destructor TControllerLojas.Destroy;
begin
    FreeAndNil(LModelLojas);
    inherited;
end;

function TControllerLojas.persistir: boolean;
begin
    Result := LModelLojas.persistir;
end;

function TControllerLojas.selecionar: TFDQuery;
begin
    Result := LModelLojas.selecionar;
end;

function TControllerLojas.selecionarLojas: TFDQuery;
begin
    Result := LModelLojas.selecionarLoja;
end;

end.
