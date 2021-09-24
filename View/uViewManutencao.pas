unit uViewManutencao;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
    Vcl.Mask, Vcl.ComCtrls, uControllerFuncionarios, uControllerFuncoes,
    uModelEnumerador, Vcl.DBCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.Client;

type
    TfrmViewManutencao = class(TForm)
        pgctrCrud: TPageControl;
        tabshtAlteracaoFuncionario: TTabSheet;
        tabshtPesquisarFuncionario: TTabSheet;
        tabshtIncluirFuncionario: TTabSheet;
        tabshtConsultaFuncionario: TTabSheet;
        lblNome: TLabel;
        lblEndereco: TLabel;
        lblCelular: TLabel;
        lblDataRegistro: TLabel;
        lblObservacoes: TLabel;
        lblCpf: TLabel;
        lblCodigo: TLabel;
        edtnome: TEdit;
        edtEndereco: TEdit;
        mmoObservacoes: TMemo;
        edtDataRegistro: TMaskEdit;
        edtCelular: TMaskEdit;
        edtCodigo: TEdit;
        cbxLoja: TComboBox;
        edtCpf: TEdit;
        lblLojas: TLabel;
        Panel1: TPanel;
        bitbtnRestaurar: TBitBtn;
        bitbtnOk: TBitBtn;
        bitbtnSair: TBitBtn;
        DBNavigator1: TDBNavigator;
        Label7: TLabel;
        Edit2: TEdit;
        Label8: TLabel;
        Edit3: TEdit;
        Label11: TLabel;
        Edit4: TEdit;
        Panel2: TPanel;
        BitBtn2: TBitBtn;
        BitBtn3: TBitBtn;
        SpeedButton1: TSpeedButton;
        dbgrdResultadoPesquisa: TDBGrid;
        lblResultadoPesquisa: TLabel;
        edtnomeIncluir: TEdit;
        lblNomeIncluir: TLabel;
        lblEnderecoIncluir: TLabel;
        edtEnderecoIncluir: TEdit;
        edtCelularIncluir: TMaskEdit;
        lblCelularIncluir: TLabel;
        lblDataRegistroIncluir: TLabel;
        lblCpfIncluir: TLabel;
        lblLojasIncluir: TLabel;
        cbxlojaIncluir: TComboBox;
        edtCpfIncluir: TEdit;
        edtDataRegistroIncluir: TMaskEdit;
        mmoObservacoesIncluir: TMemo;
        lblObservacoesIncluir: TLabel;
        Panel3: TPanel;
        bitbtnIncluir: TBitBtn;
        bitbtnFechar: TBitBtn;
        Panel4: TPanel;
        bitbtnConsultarFuncionario: TBitBtn;
        BitBtn5: TBitBtn;
        dbnavConsulta: TDBNavigator;
        dbgrdTodos: TDBGrid;
        tabshtPesquisarLojas: TTabSheet;
        Panel5: TPanel;
        bitbtnPesquisarLoja: TBitBtn;
        BitBtn6: TBitBtn;
        Edit1: TEdit;
        Edit5: TEdit;
        DBGrid1: TDBGrid;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        tabshtIncluirLojas: TTabSheet;
        Panel6: TPanel;
        bitbtnIncluirLoja: TBitBtn;
        BitBtn8: TBitBtn;
        edtCNPJ: TEdit;
        edtRazaoSocial: TEdit;
        Label5: TLabel;
        Label6: TLabel;
        tabshtAlteracaoLoja: TTabSheet;
        edtAlterarRazaoSocial: TEdit;
        edtAlterarCNPJ: TEdit;
        Label4: TLabel;
        Label9: TLabel;
        Panel7: TPanel;
        bitbtnRestaurarLoja: TBitBtn;
        bitbtnAlterarLoja: TBitBtn;
        BitBtn11: TBitBtn;
        DBNavigator2: TDBNavigator;
        lblCodigoLoja: TLabel;
        edtCodigoLoja: TEdit;
        tabshtConsultaLoja: TTabSheet;
        Panel8: TPanel;
        BitBtn1: TBitBtn;
        BitBtn4: TBitBtn;
        dbnavConsultaLoja: TDBNavigator;
        dbgrdTodosLoja: TDBGrid;
        procedure bitbtnSairClick(Sender: TObject);
        procedure bitbtnOkClick(Sender: TObject);
        procedure bitbtnIncluirClick(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure bitbtnIncluirLojaClick(Sender: TObject);
        procedure bitbtnAlterarLojaClick(Sender: TObject);
        private
            { Private declarations }
        public
            { Public declarations }
    end;

var
      frmViewManutencao: TfrmViewManutencao;

implementation

{$R *.dfm}


uses uViewFuncionarios, uControllerLojas, uViewLojas;

procedure TfrmViewManutencao.bitbtnIncluirLojaClick(Sender: TObject);
var
      controllerLoja: TControllerLojas;
    limparosEdits: TControllerFuncoes;
begin
    Screen.Cursor := -11;

    controllerLoja := TControllerLojas.Create;
    limparosEdits := TControllerFuncoes.Create;

    try

        controllerLoja.ModelLoja.enuTipo := uModelEnumerador.tipoInclusao; // Indicando que é um INSERT na tabela

        if (edtRazaoSocial.Text = '') or (edtCNPJ.Text = '') then
            begin
                ShowMessage('Por favor, preencha os dados que faltam!');
                Screen.Cursor := 0;
                edtRazaoSocial.SetFocus;
                exit;
            end;
        controllerLoja.ModelLoja.strRazaoSocial := edtRazaoSocial.Text;
        controllerLoja.ModelLoja.strCNPJ := edtCNPJ.Text;

        if (controllerLoja.persistir) then
            begin
                ShowMessage('Operação realizada com sucesso!');
            end
        else
            begin
                ShowMessage('Não foi possível realizar a operação!');
                exit;
            end;
    finally
        limparosEdits.limpaEdits(frmViewLojas);
        FreeAndNil(controllerLoja);
    end;

    frmViewLojas.bitbtnTodos.Click;
    Close;

end;

procedure TfrmViewManutencao.bitbtnAlterarLojaClick(Sender: TObject);
var
      controllerLoja: TControllerLojas;
    limparosEdits: TControllerFuncoes;
begin

    controllerLoja := TControllerLojas.Create;

    limparosEdits := TControllerFuncoes.Create;

    try
        controllerLoja.ModelLoja.enuTipo := uModelEnumerador.tipoAlteracao; // Indicando que é um ALTERACAO na tabela

        controllerLoja.ModelLoja.intCodigo := StrToInt(edtCodigoLoja.Text);
        controllerLoja.ModelLoja.strRazaoSocial := edtAlterarRazaoSocial.Text;
        controllerLoja.ModelLoja.strCNPJ := edtAlterarCNPJ.Text;

        if (controllerLoja.persistir) then
            begin
                ShowMessage('Operação realizada com sucesso!');
            end
        else
            begin
                ShowMessage('Não foi possível realizar a operação!');
            end;
    finally
        limparosEdits.limpaEdits(frmViewManutencao);
        FreeAndNil(controllerLoja);
        FreeAndNil(limparosEdits);
        frmViewLojas.bitbtnTodos.Click;
        Close;
    end;

end;

procedure TfrmViewManutencao.bitbtnIncluirClick(Sender: TObject);
var
      controllerFuncionario: TControllerFuncionarios;
    tamanho: integer;
    validaCpf: TControllerFuncoes;
    limparosEdits: TControllerFuncoes;
begin
    Screen.Cursor := -11;
    validaCpf := TControllerFuncoes.Create;
    tamanho := Length(edtCpf.Text);
    if (tamanho <> 0) then
        if not(validaCpf.IsValidCPF(edtCpf.Text)) then
            begin
                ShowMessage('CPF inválido!');
                edtCpf.SetFocus;
                edtCpf.Clear;
                exit;
            end;

    controllerFuncionario := TControllerFuncionarios.Create;
    limparosEdits := TControllerFuncoes.Create;

    try

        controllerFuncionario.ModelFuncionario.enuTipo := uModelEnumerador.tipoInclusao; // Indicando que é um INSERT na tabela

        if (edtnomeIncluir.Text = '') or (edtEnderecoIncluir.Text = '') or (edtCelularIncluir.Text = '') or (edtCpfIncluir.Text = '') then
            begin
                ShowMessage('Por favor, preencha os dados que faltam!');
                Screen.Cursor := 0;
                edtnomeIncluir.SetFocus;
                exit;
            end;
        controllerFuncionario.ModelFuncionario.strNome := edtnomeIncluir.Text;
        controllerFuncionario.ModelFuncionario.strEndereco := edtEnderecoIncluir.Text;
        controllerFuncionario.ModelFuncionario.strCelular := edtCelularIncluir.Text;
        controllerFuncionario.ModelFuncionario.dtData_Registro := StrToDate(edtDataRegistroIncluir.Text);
        controllerFuncionario.ModelFuncionario.strObservacoes := mmoObservacoesIncluir.Text;
        controllerFuncionario.ModelFuncionario.strCpf := edtCpfIncluir.Text;
        controllerFuncionario.ModelFuncionario.strLoja := cbxlojaIncluir.Text;

        if (controllerFuncionario.persistir) then
            begin
                ShowMessage('Operação realizada com sucesso!');
            end
        else
            begin
                ShowMessage('Não foi possível realizar a operação!');
                exit;
            end;
    finally
        limparosEdits.limpaEdits(frmViewFuncionarios);
        FreeAndNil(controllerFuncionario);
        FreeAndNil(validaCpf);
    end;

    frmViewFuncionarios.bitbtnTodos.Click;
    Close;
end;

procedure TfrmViewManutencao.FormShow(Sender: TObject);
var
      controllerFuncionario: TControllerFuncionarios;
    qryFuncionario: TFDQuery;
    memFuncionario: TFDMemTable;
    dsGrid: TDataSource;

    controllerLoja: TControllerLojas;
    qryLoja: TFDQuery;
    memloja: TFDMemTable;
    dsGridLoja: TDataSource;

begin

    if (tabshtConsultaFuncionario.TabVisible = true) then
        begin
            if (frmViewManutencao.tabshtConsultaFuncionario.TabVisible = true) then
                begin
                    estadoGrid := true;
                    qryFuncionario := TFDQuery.Create(nil);
                    controllerFuncionario := TControllerFuncionarios.Create;
                    memFuncionario := TFDMemTable.Create(nil);
                    dsGrid := TDataSource.Create(nil);

                    try
                        qryFuncionario := controllerFuncionario.selecionar;
                        try
                            dsGrid.DataSet := memFuncionario;
                            dbgrdTodos.DataSource := dsGrid;
                            dbnavConsulta.DataSource := dsGrid;
                            qryFuncionario.FetchAll;
                            memFuncionario.Close;
                            memFuncionario.Data := qryFuncionario.Data;
                        finally
                            qryFuncionario.Close;
                            FreeAndNil(qryFuncionario);
                        end;
                    finally
                        FreeAndNil(controllerFuncionario);
                    end;
                end;
        end
    else
        begin
            estadoGrid := true;
            qryLoja := TFDQuery.Create(nil);
            controllerLoja := TControllerLojas.Create;
            memloja := TFDMemTable.Create(nil);
            dsGridLoja := TDataSource.Create(nil);

            try
                qryLoja := controllerLoja.selecionar;
                try
                    dsGridLoja.DataSet := memloja;
                    dbgrdTodosLoja.DataSource := dsGridLoja;
                    dbnavConsultaLoja.DataSource := dsGridLoja;
                    qryLoja.FetchAll;
                    memloja.Close;
                    memloja.Data := qryLoja.Data;
                finally
                    qryLoja.Close;
                    FreeAndNil(qryLoja);
                end;
            finally
                FreeAndNil(controllerLoja);
            end;
        end;
end;

procedure TfrmViewManutencao.bitbtnOkClick(Sender: TObject);
var
      controllerFuncionario: TControllerFuncionarios;
    limparosEdits: TControllerFuncoes;
begin

    controllerFuncionario := TControllerFuncionarios.Create;

    limparosEdits := TControllerFuncoes.Create;

    try
        controllerFuncionario.ModelFuncionario.enuTipo := uModelEnumerador.tipoAlteracao; // Indicando que é um ALTERACAO na tabela

        controllerFuncionario.ModelFuncionario.intCodigo := StrToInt(edtCodigo.Text);
        controllerFuncionario.ModelFuncionario.strNome := edtnome.Text;
        controllerFuncionario.ModelFuncionario.strEndereco := edtEndereco.Text;
        controllerFuncionario.ModelFuncionario.strCelular := edtCelular.Text;
        controllerFuncionario.ModelFuncionario.dtData_Registro := StrToDate(edtDataRegistro.Text);
        controllerFuncionario.ModelFuncionario.strObservacoes := mmoObservacoes.Text;
        controllerFuncionario.ModelFuncionario.strCpf := edtCpf.Text;
        controllerFuncionario.ModelFuncionario.strLoja := cbxLoja.Text;

        if (controllerFuncionario.persistir) then
            begin
                ShowMessage('Operação realizada com sucesso!');
            end
        else
            begin
                ShowMessage('Não foi possível realizar a operação!');
            end;
    finally
        limparosEdits.limpaEdits(frmViewManutencao);
        FreeAndNil(controllerFuncionario);
        FreeAndNil(limparosEdits);
        frmViewFuncionarios.bitbtnTodos.Click;
        Close;
    end;
end;

procedure TfrmViewManutencao.bitbtnSairClick(Sender: TObject);
begin
    Close;
end;

end.
