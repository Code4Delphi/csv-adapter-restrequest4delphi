program Samples.Client;

uses
  Vcl.Forms,
  View.Main in 'Src\View\View.Main.pas' {ViewMain},
  CSV.Adapter.RESTRequest4D in '..\..\Src\CSV.Adapter.RESTRequest4D.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewMain, ViewMain);
  Application.Run;
end.
