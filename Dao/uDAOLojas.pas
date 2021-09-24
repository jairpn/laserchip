unit uDAOLojas;

interface

uses
    FireDAC.Stan.Intf, FireDAC.Stan.Option, System.SysUtils,
    FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
    FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
    Data.DB, FireDAC.Comp.Client, uDAOConexao, uControllerConexao, uModelLojas;

type

    TDAOLojas = class

        private

        protected

        public
            function persistir: boolean;

            function selecionarLojas: TFDQuery;

            function incluir(ModelLoja: TModelLojas): boolean;
            function excluir(ModelLoja: TModelLojas): boolean;
            function alterar(ModelLoja: TModelLojas): boolean;

        published
    end;

implementation

{ TDAOFuncionarios }

function TDAOLojas.alterar(ModelLoja: TModelLojas): boolean;
var
      qryLoja: TFDQuery;
begin

    qryLoja := TControllerConexao.getInstance().daoConexao.criarQuery;
    try
        try
            qryLoja.ExecSQL('update lojas set razao_social = :razaosocial,  cnpj = :cnpj where codigo_loja = :codigo', [ModelLoja.strRazaoSocial, ModelLoja.strCNPJ, ModelLoja.intCodigo]);

            Result := True;
        except
            Result := False;
        end;

    finally
        FreeAndNil(qryLoja);
    end;

end;

function TDAOLojas.excluir(ModelLoja: TModelLojas): boolean;
var
      qryLoja: TFDQuery;
begin

    qryLoja := TControllerConexao.getInstance().daoConexao.criarQuery;
    try
        try
            qryLoja.ExecSQL('delete from lojas where codigo_loja = :codigo', [ModelLoja.intCodigo]);
            Result := True;
        except
            Result := False;
        end;

    finally
        FreeAndNil(qryLoja);
    end;

end;

function TDAOLojas.incluir(ModelLoja: TModelLojas): boolean;
var
      qryLoja: TFDQuery;
begin

    qryLoja := TControllerConexao.getInstance().daoConexao.criarQuery;
    try
        try
            qryLoja.ExecSQL('INSERT INTO Lojas (razao_social, cnpj) VALUES(:razaosocial, :cnpj)', [ModelLoja.strRazaoSocial, ModelLoja.strCNPJ]);
            Result := True;
        except
            Result := False;
        end;

    finally
        FreeAndNil(qryLoja);
    end;

end;

function TDAOLojas.persistir: boolean;
var
      qryLoja: TFDQuery;
begin

end;

function TDAOLojas.selecionarLojas: TFDQuery;
var
      qryLoja: TFDQuery;

begin
    qryLoja := TControllerConexao.getInstance().daoConexao.criarQuery;

    qryLoja.Open('select codigo_loja, razao_social, cnpj from lojas');
    Result := qryLoja;
end;

end.
