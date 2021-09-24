unit uModelFuncionarios;

interface

uses
    FireDAC.Stan.Intf, FireDAC.Stan.Option, System.SysUtils,
    FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
    FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
    Data.DB, FireDAC.Comp.Client, uDAOConexao, uControllerConexao,
    uModelEnumerador;

type

    TModelFuncionarios = class

        private
            FCodigo_funcionario: integer;
            FNome: string;
            FEndereco: string;
            FCelular: string;
            FData_Registro: TDateTime;
            FObservacoes: string;
            FCpf: string;
            FLoja: string;
            FEnumerador: TEnumerador;

        protected
        public

            property intCodigo: integer read FCodigo_funcionario write FCodigo_funcionario;
            property strNome: string read FNome write FNome;
            property strEndereco: string read FEndereco write FEndereco;
            property strCelular: string read FCelular write FCelular;
            property dtData_Registro: TDateTime read FData_Registro write FData_Registro;
            property strObservacoes: string read FObservacoes write FObservacoes;
            property strCpf: string read FCpf write FCpf;
            property strLoja: string read FLoja write FLoja;

            property enuTipo: TEnumerador read FEnumerador write FEnumerador;

            function persistir: boolean;
            function selecionar: TFDQuery;
            function selecionarLoja: TFDQuery;


        published
    end;

implementation

{ TModelFuncionarios }

uses uDAOFuncionarios;

{ TModelFuncionarios }

function TModelFuncionarios.persistir: boolean;
var
      daoFuncionarios: TDAOFuncionarios;
begin
    daoFuncionarios := TDAOFuncionarios.Create;
    try
        case FEnumerador of
            tipoInclusao:
                Result := daoFuncionarios.incluir(Self);
            tipoExclusao:
                Result := daoFuncionarios.excluir(Self);
            tipoAlteracao:
                Result := daoFuncionarios.alterar(Self);
        end;
    finally
        FreeAndNil(daoFuncionarios);
    end;
end;

function TModelFuncionarios.selecionar: TFDQuery;
var
      daoFuncionarios: TDAOFuncionarios;
begin
    daoFuncionarios := TDAOFuncionarios.Create;
    try
        Result := daoFuncionarios.selecionarFuncionarios;
    finally
        FreeAndNil(daoFuncionarios);
    end;

end;

function TModelFuncionarios.selecionarLoja: TFDQuery;
var
      daoFuncionarios: TDAOFuncionarios;
begin
    daoFuncionarios := TDAOFuncionarios.Create;
    try
        Result := daoFuncionarios.selecionarLojas;
    finally
        FreeAndNil(daoFuncionarios);
    end;

end;

end.
