program lojas;

uses
  Vcl.Forms,
  uViewPrincipal in 'View\uViewPrincipal.pas' {frmViewPrincipal},
  uControllerConexao in 'Controller\uControllerConexao.pas',
  uDAOConexao in 'Dao\uDAOConexao.pas',
  uViewLojas in 'View\uViewLojas.pas' {frmViewLojas},
  uViewFuncionarios in 'View\uViewFuncionarios.pas' {frmViewFuncionarios},
  uModelFuncionarios in 'Model\uModelFuncionarios.pas',
  uDAOFuncionarios in 'Dao\uDAOFuncionarios.pas',
  uControllerFuncionarios in 'Controller\uControllerFuncionarios.pas',
  uModelEnumerador in 'Model\uModelEnumerador.pas',
  Vcl.Themes,
  Vcl.Styles,
  uControllerFuncoes in 'Controller\uControllerFuncoes.pas',
  uViewManutencao in 'View\uViewManutencao.pas' {frmViewManutencao},
  uControllerLojas in 'Controller\uControllerLojas.pas',
  uModelLojas in 'Model\uModelLojas.pas',
  uDAOLojas in 'Dao\uDAOLojas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 Clear Day');
  Application.CreateForm(TfrmViewPrincipal, frmViewPrincipal);
  Application.CreateForm(TfrmViewLojas, frmViewLojas);
  Application.CreateForm(TfrmViewFuncionarios, frmViewFuncionarios);
  Application.CreateForm(TfrmViewManutencao, frmViewManutencao);
  Application.Run;
end.
