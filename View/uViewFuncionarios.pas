unit uViewFuncionarios;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Math, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
    FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
    Data.DB, FireDAC.Comp.Client, uModelFuncionarios, Vcl.Mask, Vcl.DBCtrls,
    uDAOFuncionarios, FireDAC.Stan.Intf, FireDAC.Stan.Option,
    FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
    Vcl.Grids, Vcl.DBGrids, FireDAC.DApt, uControllerFuncoes, Vcl.ExtCtrls,
    Vcl.Buttons, uViewManutencao;

type
    TfrmViewFuncionarios = class(TForm)
        btnSalvar: TButton;
        Panel2: TPanel;
        Panel1: TPanel;
        bitbtnFiltrar: TBitBtn;
        bitbtnTodos: TBitBtn;
        bitbtnAlterar: TBitBtn;
        bitbtnIncluir: TBitBtn;
        bitbtnConsultar: TBitBtn;
        bitbtnExcluir: TBitBtn;
        bitbtnSair: TBitBtn;
        dbgrdTodos: TDBGrid;
        procedure bitbtnTodosClick(Sender: TObject);
        procedure bitbtnSairClick(Sender: TObject);
        procedure bitbtnIncluirClick(Sender: TObject);
        procedure bitbtnExcluirClick(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure bitbtnAlterarClick(Sender: TObject);
        procedure bitbtnFiltrarClick(Sender: TObject);
        procedure bitbtnConsultarClick(Sender: TObject);

        private
            { Private declarations }
        public
            { Public declarations }
    end;

var
      frmViewFuncionarios: TfrmViewFuncionarios;
    estadoGrid: boolean;

implementation

{$R *.dfm}


uses uDAOConexao, uControllerConexao, uModelEnumerador, uControllerFuncionarios,
    uViewPrincipal;

procedure TfrmViewFuncionarios.bitbtnAlterarClick(Sender: TObject);
var
      qryLoja: TFDQuery;
    controllerFuncionario: TControllerFuncionarios;
begin

    if (estadoGrid = False) then
        exit;
    qryLoja := TFDQuery.Create(nil);
    controllerFuncionario := TControllerFuncionarios.Create;

    qryLoja := controllerFuncionario.selecionarLojas;

    qryLoja.FetchAll;

    qryLoja.First;

    if (frmViewManutencao = nil) then
        Application.CreateForm(TfrmViewManutencao, frmViewManutencao);

    frmViewManutencao.bitbtnRestaurar.Visible := True;
    frmViewManutencao.edtCodigo.Text := dbgrdTodos.Fields[0].AsString;
    frmViewManutencao.edtnome.Text := dbgrdTodos.Fields[1].AsString;
    frmViewManutencao.edtEndereco.Text := dbgrdTodos.Fields[2].AsString;
    frmViewManutencao.edtCelular.Text := dbgrdTodos.Fields[3].AsString;
    frmViewManutencao.edtDataRegistro.Text := dbgrdTodos.Fields[4].AsString;
    frmViewManutencao.mmoObservacoes.Text := dbgrdTodos.Fields[5].AsString;
    frmViewManutencao.edtCpf.Text := dbgrdTodos.Fields[6].AsString;

    frmViewManutencao.tabshtAlteracao.TabVisible := True;
    frmViewManutencao.tabshtPesquisar.TabVisible := False;
    frmViewManutencao.tabshtIncluir.TabVisible := False;
    frmViewManutencao.tabshtConsulta.TabVisible := False;

    while not(qryLoja.Eof) do
        begin
            frmViewManutencao.cbxLoja.Items.Add(qryLoja.Fields[1].Value);
            qryLoja.Next;
        end;

    frmViewManutencao.cbxLoja.Text := dbgrdTodos.Fields[7].AsString;

    frmViewManutencao.ShowModal;
    FreeAndNil(frmViewManutencao);
end;

procedure TfrmViewFuncionarios.bitbtnConsultarClick(Sender: TObject);
begin
    if (frmViewManutencao = nil) then
        Application.CreateForm(TfrmViewManutencao, frmViewManutencao);

    frmViewManutencao.tabshtAlteracao.TabVisible := False;
    frmViewManutencao.tabshtPesquisar.TabVisible := False;
    frmViewManutencao.tabshtIncluir.TabVisible := False;
    frmViewManutencao.tabshtConsulta.TabVisible := True;

    frmViewManutencao.ShowModal;

    FreeAndNil(frmViewManutencao);

end;

procedure TfrmViewFuncionarios.bitbtnExcluirClick(Sender: TObject);
var
      controllerFuncionario: TControllerFuncionarios;
    limparosEdits: TControllerFuncoes;
begin

    if (estadoGrid = False) then
        exit;

    If MessageDlg('Deseja excluir o funcionário ' + dbgrdTodos.Fields[1].Value + ' ?', mtConfirmation, [mbyes, mbno], 0) = mryes then
        begin

            controllerFuncionario := TControllerFuncionarios.Create;

            limparosEdits := TControllerFuncoes.Create;

            try
                controllerFuncionario.ModelFuncionario.enuTipo := uModelEnumerador.tipoExclusao; // Indicando que é um EXCLUSÃO na tabela

                controllerFuncionario.ModelFuncionario.intCodigo := StrToInt(dbgrdTodos.Fields[0].Value);

                if (controllerFuncionario.persistir) then
                    begin
                        bitbtnTodos.Click;
                        ShowMessage('Operação realizada com sucesso!');
                    end
                else
                    begin
                        ShowMessage('Não foi possível realizar a operação!');
                    end;
            finally

                limparosEdits.limpaEdits(frmViewFuncionarios);
                FreeAndNil(controllerFuncionario);
                FreeAndNil(limparosEdits);
            end
        end;
end;

procedure TfrmViewFuncionarios.bitbtnFiltrarClick(Sender: TObject);
begin
    if (frmViewManutencao = nil) then
        Application.CreateForm(TfrmViewManutencao, frmViewManutencao);

    frmViewManutencao.tabshtAlteracao.TabVisible := False;
    frmViewManutencao.tabshtPesquisar.TabVisible := True;
    frmViewManutencao.tabshtIncluir.TabVisible := False;
    frmViewManutencao.tabshtConsulta.TabVisible := False;

    frmViewManutencao.ShowModal;
    FreeAndNil(frmViewManutencao);
end;

procedure TfrmViewFuncionarios.bitbtnIncluirClick(Sender: TObject);
var
      qryLoja: TFDQuery;
    controllerFuncionario: TControllerFuncionarios;
begin

    qryLoja := TFDQuery.Create(nil);
    controllerFuncionario := TControllerFuncionarios.Create;

    qryLoja := controllerFuncionario.selecionarLojas;

    qryLoja.FetchAll;

    qryLoja.First;

    if (frmViewManutencao = nil) then
        Application.CreateForm(TfrmViewManutencao, frmViewManutencao);

    while not(qryLoja.Eof) do
        begin
            frmViewManutencao.cbxlojaIncluir.Items.Add(qryLoja.Fields[1].Value);
            qryLoja.Next;
        end;

    frmViewManutencao.edtDataRegistroIncluir.Text := DateToStr(date);
    frmViewManutencao.tabshtAlteracao.TabVisible := False;
    frmViewManutencao.tabshtPesquisar.TabVisible := False;
    frmViewManutencao.tabshtIncluir.TabVisible := True;
    frmViewManutencao.tabshtConsulta.TabVisible := False;
    frmViewManutencao.ShowModal;
    FreeAndNil(frmViewManutencao);
end;

procedure TfrmViewFuncionarios.bitbtnSairClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmViewFuncionarios.bitbtnTodosClick(Sender: TObject);
var
      controllerFuncionario: TControllerFuncionarios;
    qryFuncionario: TFDQuery;
    memFuncionario: TFDMemTable;
    dsGrid: TDataSource;
begin
    estadoGrid := True;
    qryFuncionario := TFDQuery.Create(nil);
    controllerFuncionario := TControllerFuncionarios.Create;
    memFuncionario := TFDMemTable.Create(nil);
    dsGrid := TDataSource.Create(nil);

    try
        qryFuncionario := controllerFuncionario.selecionar;
        try
            dsGrid.DataSet := memFuncionario;
            dbgrdTodos.DataSource := dsGrid;
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

procedure TfrmViewFuncionarios.FormShow(Sender: TObject);
begin
    estadoGrid := False;
end;

end.
