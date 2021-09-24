unit uViewPrincipal;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus,
    Vcl.Imaging.pngimage, Vcl.StdCtrls, System.UITypes,
    FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
    FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
    FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
    FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, FireDAC.UI.Intf,
    FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL,
    FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, uControllerConexao,
    uViewFuncionarios, uControllerFuncoes;

type
    TfrmViewPrincipal = class(TForm)
        Panel2: TPanel;
        Image1: TImage;
        Panel1: TPanel;
        Bevel1: TBevel;
        bitbtnFechar: TBitBtn;
        bitbtnRelatorio: TBitBtn;
        bitbtnFuncionarios: TBitBtn;
        bitbtnLojas: TBitBtn;
        procedure FormShow(Sender: TObject);
        procedure bitbtnFecharClick(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure bitbtnFuncionariosClick(Sender: TObject);
        procedure bitbtnLojasClick(Sender: TObject);
        private
            { Private declarations }
        public
            { Public declarations }
    end;

var
      frmViewPrincipal: TfrmViewPrincipal;

implementation

{$R *.dfm}


uses uViewLojas;

procedure TfrmViewPrincipal.bitbtnLojasClick(Sender: TObject);
var
      FechaFormulario: TControllerFuncoes;
begin
    FechaFormulario := TControllerFuncoes.Create;

    FechaFormulario.fechaForms;

    if (frmViewLojas = nil) then
        Application.CreateForm(TfrmViewLojas, frmViewLojas);
    frmViewLojas.ShowModal;
    FreeAndNil(frmViewLojas);

end;

procedure TfrmViewPrincipal.bitbtnFecharClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmViewPrincipal.bitbtnFuncionariosClick(Sender: TObject);
begin
    if (frmViewFuncionarios = nil) then
        Application.CreateForm(TfrmViewFuncionarios, frmViewFuncionarios);
    frmViewFuncionarios.ShowModal;
    FreeAndNil(frmViewFuncionarios);
end;

procedure TfrmViewPrincipal.FormCloseQuery(Sender: TObject;
    var CanClose: Boolean);
begin
    CanClose := False;
    If MessageDlg('Deseja realmente sair do sistema?', mtConfirmation, [mbyes, mbno], 0) = mryes then
        Application.Terminate;
end;

procedure TfrmViewPrincipal.FormShow(Sender: TObject);
begin
    TControllerConexao.getInstance().daoConexao.getConexao.Connected := True;
    Application.ProcessMessages;
end;

end.
