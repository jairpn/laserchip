unit uDAOFuncionarios;

interface

uses
    FireDAC.Stan.Intf, FireDAC.Stan.Option, System.SysUtils,
    FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
    FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
    Data.DB, FireDAC.Comp.Client, uDAOConexao, uControllerConexao,
    uModelFuncionarios;

type

    TDAOFuncionarios = class

        private

        protected

        public
            function persistir: boolean;

            function selecionarFuncionarios: TFDQuery;

            function selecionarLojas: TFDQuery;
            function incluir(ModelFuncionario: TModelFuncionarios): boolean;
            function excluir(ModelFuncionario: TModelFuncionarios): boolean;
            function alterar(ModelFuncionario: TModelFuncionarios): boolean;

        published
    end;

implementation

{ TModelFuncionarios }

function TDAOFuncionarios.alterar(ModelFuncionario: TModelFuncionarios): boolean;
var
      qryFuncionario: TFDQuery;
begin

    qryFuncionario := TControllerConexao.getInstance().daoConexao.criarQuery;
    try
        try
            qryFuncionario.ExecSQL('update funcionarios set nome = :nome,  endereco = :endereco, celular = :celular,  data_registro = :data_registro, observacoes = :observacoes,  cpf = :cpf, loja = :loja where codigo_funcionario = :codigo', [ModelFuncionario.strNome, ModelFuncionario.strEndereco, ModelFuncionario.strCelular, ModelFuncionario.dtData_Registro, ModelFuncionario.strObservacoes, ModelFuncionario.strCpf, ModelFuncionario.strLoja, ModelFuncionario.intCodigo]);

            Result := True;
        except
            Result := False;
        end;

    finally
        FreeAndNil(qryFuncionario);
    end;

end;

function TDAOFuncionarios.excluir(ModelFuncionario: TModelFuncionarios): boolean;
var
      qryFuncionario: TFDQuery;
begin

    qryFuncionario := TControllerConexao.getInstance().daoConexao.criarQuery;
    try
        try
            qryFuncionario.ExecSQL('delete from funcionarios where codigo_funcionario = :codigo', [ModelFuncionario.intCodigo]);
            Result := True;
        except
            Result := False;
        end;

    finally
        FreeAndNil(qryFuncionario);
    end;

end;

function TDAOFuncionarios.incluir(ModelFuncionario: TModelFuncionarios): boolean;
var
      qryFuncionario: TFDQuery;
begin

    qryFuncionario := TControllerConexao.getInstance().daoConexao.criarQuery;
    try
        try
            qryFuncionario.ExecSQL('INSERT INTO Funcionarios (nome, endereco, celular, data_registro, observacoes, cpf, loja ) VALUES(:nome, :endereco, :celular, :data_registro, :observacoes, :cpf, :loja)', [ModelFuncionario.strNome, ModelFuncionario.strEndereco, ModelFuncionario.strCelular, ModelFuncionario.dtData_Registro, ModelFuncionario.strObservacoes, ModelFuncionario.strCpf, ModelFuncionario.strLoja]);
            Result := True;
        except
            Result := False;
        end;

    finally
        FreeAndNil(qryFuncionario);
    end;

end;

function TDAOFuncionarios.persistir: boolean;
var
      qryFuncionario: TFDQuery;
begin

end;

function TDAOFuncionarios.selecionarFuncionarios: TFDQuery;
var
      qryFuncionario: TFDQuery;
begin
    qryFuncionario := TControllerConexao.getInstance().daoConexao.criarQuery;

    qryFuncionario.Open('select codigo_funcionario, nome, endereco, celular, data_registro, cpf, observacoes, loja from funcionarios');
    Result := qryFuncionario;
end;

function TDAOFuncionarios.selecionarLojas: TFDQuery;
var
      qryLoja: TFDQuery;

begin
    qryLoja := TControllerConexao.getInstance().daoConexao.criarQuery;

    qryLoja.Open('select codigo_loja, razao_social, cnpj from lojas');
    Result := qryLoja;
end;


end.
