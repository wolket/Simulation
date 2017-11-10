program Simulation1;

uses
  Vcl.Forms,
  SIM in '..\SIM\SIM.pas' {Form1},
  Window in 'Window.pas' {Form2},
  MTarget in 'MTarget.pas',
  SIMULATION in 'SIMULATION.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
