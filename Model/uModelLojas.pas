unit uModelLojas;

interface

uses
    FireDAC.Stan.Intf, FireDAC.Stan.Option, System.SysUtils,
    FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
    FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
    Data.DB, FireDAC.Comp.Client, uDAOConexao, uControllerConexao,
    uModelEnumerador;

type
    TModelLojas = class

        private
            LCodigo_loja: integer;
            LRazaoSocial: string;
            LCNPJ: string;
            LEnumerador: TEnumerador;

        protected
        public

            property intCodigo: integer read LCodigo_loja write LCodigo_loja;
            property strRazaoSocial: string read LRazaoSocial write LRazaoSocial;
            property strCNPJ: string read LCNPJ write LCNPJ;

            property enuTipo: TEnumerador read LEnumerador write LEnumerador;

            function persistir: boolean;
            function selecionar: TFDQuery;
            function selecionarLoja: TFDQuery;

    end;

implementation

{ TModelLojas }

uses uDAOLojas;



function TModelLojas.persistir: boolean;
var
      daoLojas: TDAOLojas;
begin
    daoLojas := TDAOLojas.Create;
    try
        case LEnumerador of
            tipoInclusao:
                Result := daoLojas.incluir(Self);
            tipoExclusao:
                Result := daoLojas.excluir(Self);
            tipoAlteracao:
                Result := daoLojas.alterar(Self);
        end;
    finally
        FreeAndNil(daoLojas);
    end;
end;

function TModelLojas.selecionar: TFDQuery;
var
      daoLojas: TDAOLojas;
begin
    daoLojas := TDAOLojas.Create;
    try
        Result := daoLojas.selecionarLojas;
    finally
        FreeAndNil(daoLojas);
    end;

end;

function TModelLojas.selecionarLoja: TFDQuery;
var
      daoLojas: TDAOLojas;
begin
    daoLojas := TDAOLojas.Create;
    try
        Result := daoLojas.selecionarLojas;
    finally
        FreeAndNil(daoLojas);
    end;

end;

end.
