unit uViewLojas;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
    Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Comp.Client;

type
    TfrmViewLojas = class(TForm)
        Panel2: TPanel;
        Panel1: TPanel;
        bitbtnFiltrar: TBitBtn;
        bitbtnTodos: TBitBtn;
        bitbtnAlterar: TBitBtn;
        bitbtnIncluirLoja: TBitBtn;
        bitbtnConsultar: TBitBtn;
        bitbtnExcluir: TBitBtn;
        bitbtnSair: TBitBtn;
    dbgrdTodosLoja: TDBGrid;
        procedure bitbtnTodosClick(Sender: TObject);
        procedure bitbtnSairClick(Sender: TObject);
        procedure bitbtnFiltrarClick(Sender: TObject);
        procedure bitbtnIncluirLojaClick(Sender: TObject);
        procedure bitbtnAlterarClick(Sender: TObject);
        procedure bitbtnExcluirClick(Sender: TObject);
    procedure bitbtnConsultarClick(Sender: TObject);
        private
            { Private declarations }
        public
            { Public declarations }
    end;

var
      frmViewLojas: TfrmViewLojas;
    estadoGrid: boolean;

implementation

{$R *.dfm}


uses uControllerLojas, uViewManutencao, uControllerFuncoes, uModelEnumerador;

procedure TfrmViewLojas.bitbtnAlterarClick(Sender: TObject);
begin

    if (estadoGrid = False) then // JAPA
        exit;

    if (frmViewManutencao = nil) then
        Application.CreateForm(TfrmViewManutencao, frmViewManutencao);

    frmViewManutencao.bitbtnRestaurarLoja.Visible := True;

    frmViewManutencao.edtCodigoLoja.Text := dbgrdTodosLoja.Fields[0].AsString;
    frmViewManutencao.edtAlterarRazaoSocial.Text := dbgrdTodosLoja.Fields[1].AsString;
    frmViewManutencao.edtAlterarCNPJ.Text := dbgrdTodosLoja.Fields[2].AsString;

    frmViewManutencao.tabshtAlteracaoFuncionario.TabVisible := False;
    frmViewManutencao.tabshtPesquisarFuncionario.TabVisible := False;
    frmViewManutencao.tabshtIncluirFuncionario.TabVisible := False;
    frmViewManutencao.tabshtConsultaFuncionario.TabVisible := False;
    frmViewManutencao.tabshtPesquisarLojas.TabVisible := False;
    frmViewManutencao.tabshtIncluirLojas.TabVisible := False;
    frmViewManutencao.tabshtAlteracaoLoja.TabVisible := True;

    frmViewManutencao.ShowModal;
    FreeAndNil(frmViewManutencao); // JAPA

end;

procedure TfrmViewLojas.bitbtnConsultarClick(Sender: TObject);
begin
          if (frmViewManutencao = nil) then
        Application.CreateForm(TfrmViewManutencao, frmViewManutencao);

    frmViewManutencao.tabshtAlteracaoFuncionario.TabVisible := False;
    frmViewManutencao.tabshtPesquisarFuncionario.TabVisible := False;
    frmViewManutencao.tabshtIncluirFuncionario.TabVisible := False;
    frmViewManutencao.tabshtConsultaFuncionario.TabVisible := False;
    frmViewManutencao.tabshtPesquisarLojas.TabVisible := False;
    frmViewManutencao.tabshtIncluirLojas.TabVisible := False;
    frmViewManutencao.tabshtConsultaLoja.TabVisible := True;
        frmViewManutencao.tabshtAlteracaoLoja.TabVisible := False;

    frmViewManutencao.ShowModal;

    FreeAndNil(frmViewManutencao);
end;

procedure TfrmViewLojas.bitbtnExcluirClick(Sender: TObject);
var
      controllerLoja: TControllerLojas;
    limparosEdits: TControllerFuncoes;
begin

    if (estadoGrid = False) then
        exit;

    If MessageDlg('Deseja excluir o funcionário ' + dbgrdTodosLoja.Fields[1].Value + ' ?', mtConfirmation, [mbyes, mbno], 0) = mryes then
        begin

            controllerLoja := TControllerLojas.Create;

            limparosEdits := TControllerFuncoes.Create;

            try
                controllerLoja.ModelLoja.enuTipo := uModelEnumerador.tipoExclusao; // Indicando que é um EXCLUSÃO na tabela

                controllerLoja.ModelLoja.intCodigo := StrToInt(dbgrdTodosLoja.Fields[0].Value);

                if (controllerLoja.persistir) then
                    begin
                        bitbtnTodos.Click;
                        ShowMessage('Operação realizada com sucesso!');
                    end
                else
                    begin
                        ShowMessage('Não foi possível realizar a operação!');
                    end;
            finally

                limparosEdits.limpaEdits(frmViewLojas);
                FreeAndNil(controllerLoja);
                FreeAndNil(limparosEdits);
            end
        end;
end;

procedure TfrmViewLojas.bitbtnFiltrarClick(Sender: TObject);
begin
    if (frmViewManutencao = nil) then
        Application.CreateForm(TfrmViewManutencao, frmViewManutencao);

    frmViewManutencao.tabshtAlteracaoFuncionario.TabVisible := False;
    frmViewManutencao.tabshtPesquisarFuncionario.TabVisible := False;
    frmViewManutencao.tabshtIncluirFuncionario.TabVisible := False;
    frmViewManutencao.tabshtConsultaFuncionario.TabVisible := False;
    frmViewManutencao.tabshtPesquisarLojas.TabVisible := True;

    frmViewManutencao.ShowModal;
    FreeAndNil(frmViewManutencao);
end;

procedure TfrmViewLojas.bitbtnIncluirLojaClick(Sender: TObject);
var
      qryLoja: TFDQuery;
    controllerLoja: TControllerLojas;
begin

    qryLoja := TFDQuery.Create(nil);
    controllerLoja := TControllerLojas.Create;

    qryLoja := controllerLoja.selecionarLojas;

    qryLoja.FetchAll;

    qryLoja.First;

    if (frmViewManutencao = nil) then
        Application.CreateForm(TfrmViewManutencao, frmViewManutencao);

    frmViewManutencao.tabshtAlteracaoFuncionario.TabVisible := False;
    frmViewManutencao.tabshtPesquisarFuncionario.TabVisible := False;
    frmViewManutencao.tabshtIncluirFuncionario.TabVisible := False;
    frmViewManutencao.tabshtConsultaFuncionario.TabVisible := False;
    frmViewManutencao.tabshtPesquisarLojas.TabVisible := False;
    frmViewManutencao.ShowModal;
    FreeAndNil(frmViewManutencao);

end;

procedure TfrmViewLojas.bitbtnSairClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmViewLojas.bitbtnTodosClick(Sender: TObject);
var
      controllerLoja: TControllerLojas;
    qryLoja: TFDQuery;
    memLoja: TFDMemTable;
    dsGrid: TDataSource;
begin
    estadoGrid := True;
    qryLoja := TFDQuery.Create(nil);
    controllerLoja := TControllerLojas.Create;
    memLoja := TFDMemTable.Create(nil);
    dsGrid := TDataSource.Create(nil);

    try
        qryLoja := controllerLoja.selecionar;
        try
            dsGrid.DataSet := memLoja;
            dbgrdTodosLoja.DataSource := dsGrid;
            qryLoja.FetchAll;
            memLoja.Close;
            memLoja.Data := qryLoja.Data;
        finally
            qryLoja.Close;
            FreeAndNil(qryLoja);
        end;
    finally
        FreeAndNil(controllerLoja);
    end;

end;

end.
