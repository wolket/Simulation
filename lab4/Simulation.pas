unit Simulation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, extctrls, Vcl.StdCtrls,
  Vcl.Menus, UTargets;

const
  EditLabelWidth = 65;
  EditLabelHeight = 34;
  EditLabelWidthGap = 15;
  EditLabelHeightGap = 14;

type

  TForm2 = class(TForm)
    PageControl1: TPageControl;
    SimulationConditions: TTabSheet;
    SimulationOutput: TTabSheet;
    CreateOutput: TGroupBox;
    CreateSection: TGroupBox;
    SimulationParam: TGroupBox;
    RunSimulationSection: TGroupBox;
    SimulationImage: TImage;
    CreateChoice: TComboBox;
    ParamSection: TGroupBox;
    T0Edit: TLabeledEdit;
    TKEdit: TLabeledEdit;
    DTEdit: TLabeledEdit;
    RunSimulationButton: TButton;
    XParam: TLabeledEdit;
    YParam: TLabeledEdit;
    ThirdParam: TLabeledEdit;
    PParam: TLabeledEdit;
    FuelMassParam: TLabeledEdit;
    FuelConsParam: TLabeledEdit;
    CritFuelParam: TLabeledEdit;
    SParam: TLabeledEdit;
    CxParam: TLabeledEdit;
    CreateButton: TButton;
    CreateLog: TMemo;
    procedure OnResize(Sender: TObject);
    procedure CreateChoiceChange(Sender: TObject);
    procedure SwapActive(choice: boolean);
    procedure OnCreate(Sender: TObject);
    procedure CreateButtonClick(Sender: TObject);
    procedure DrawSimulation(var msg: TMessage); message WM_DRAW_SIMULATION;
    procedure RunSimulationButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  Simulator: TSimulator;

implementation

{$R *.dfm}

procedure TForm2.CreateButtonClick(Sender: TObject);
var initParam: array of real;
procedure fillParam;
begin
  setLength(initParam, 9);
  initParam[3]:=strToFloat(ThirdParam.Text);
  initParam[4]:=strToFloat(PParam.Text);
  initParam[5]:=strToFloat(FuelMassParam.Text);
  initParam[6]:=strToFloat(FuelConsParam.Text);
  initParam[7]:=strToFloat(CritFuelParam.Text);
  initParam[8]:=strToFloat(SParam.Text);
  initParam[9]:=strToFloat(CxParam.Text);
end;
procedure showTargetParam;
begin
  CreateLog.Lines.Add('X: ' + floatToStr(initParam[0]) + '; Y: ' + floatToStr(initParam[1]) + '; Mass: ' + floatToStr(initParam[3]));
  CreateLog.Lines.Add('P: ' + floatToStr(InitParam[4]) + '; Fuel Mass: ' + floatToStr(initParam[5]) + '; Fuel Consumption: ' + floatToStr(initParam[6]) + '; Critical Fuel Mass: ' + floatToStr(initParam[7]));
  CreateLog.Lines.Add('Square: ' + floatToStr(initParam[8]) + '; Cx: ' + floatToStr(initParam[9]));
end;
  begin
  setLength(initParam, 4);
  initParam[0] := strToFloat(self.XParam.Text);
  initParam[1] := strToFloat(self.YParam.Text);
  initParam[2] := strToFloat(self.T0Edit.Text);
  initParam[3] := strToFLoat(self.ThirdParam.Text);
  case self.CreateChoice.ItemIndex of
    0:
    begin
      Simulator.CreateCP(initParam);
      CreateLog.Lines.Add('CP Created.');
      CreateLog.Lines.Add('X: ' +  floatToStr(initParam[0]) + '; Y: ' + floatToStr(initParam[1]) + '; Safe Distance: ' + floatToStr(initParam[3]));
    end;
    1:
    begin
      Simulator.CreateRLS(InitParam);
      CreateLog.Lines.Add('RLS Created.');
      CreateLog.Lines.Add('X: ' +  floatToStr(initParam[0]) + '; Y: ' + floatToStr(initParam[1]) + '; R Max: ' + floatToStr(initParam[3]));
    end;
    2:
    begin
      fillParam;
      Simulator.Targets.AddTarget(Air,initParam);
      CreateLog.Lines.Add('Aircraft Created.');
      showTargetParam;
    end;
    3:
    begin
      fillParam;
      Simulator.Targets.AddTarget(Mis,initParam);
      CreateLog.Lines.Add('Missile Created.');
      showTargetParam;
    end;
  end;

end;

procedure TForm2.CreateChoiceChange(Sender: TObject);
begin
  case self.CreateChoice.ItemIndex of
  0: self.ThirdParam.EditLabel.Caption := 'Safe Dist:';
  1: self.ThirdParam.EditLabel.Caption := 'R max:';
  else self.ThirdParam.EditLabel.Caption := 'Mass: ';
  end;
  if (self.CreateChoice.ItemIndex=0) or (self.CreateChoice.ItemIndex=1) then self.SwapActive(false)
  else self.SwapActive(True);
end;

procedure TForm2.OnCreate(Sender: TObject);
var initParam: array[0..2] of real;
begin
  initParam[0] := 0; initParam[1] := 100; initParam[2] := 0.1;
  Simulator := TSimulator.Create(initParam, self.Handle);
  self.Constraints.MinHeight := 550;
  self.Constraints.MinWidth := 700;
  self.PageControl1.Constraints.MinHeight := self.Constraints.MinHeight;
  self.PageControl1.Constraints.MinWidth := self.Constraints.MinWidth;
  self.T0Edit.Text := '0,0';
  self.TKEdit.Text := '100,0';
  self.DTEdit.Text := '0,1';
end;

procedure TForm2.OnResize(Sender: TObject);
begin
  self.XParam.Top := self.ParamSection.Top + 25 + 10; self.XParam.Left := self.ParamSection.Left + 30;
  self.YParam.Top := self.XParam.Top; self.YParam.Left := self.XParam.Left + EditLabelWidth + EditLabelWidthGap;
  self.ThirdParam.Top := self.XParam.Top; self.ThirdParam.Left := self.YParam.Left + EditLabelWidth + EditLabelWidthGap;

  self.PParam.Top := self.XParam.Top + EditLabelHeight + 10 + 10; self.PParam.Left := self.XParam.Left;
  self.FuelMassParam.Top := self.PParam.Top; self.FuelMassParam.Left := self.PParam.Left + EditLabelWidth + EditLabelWidthGap;
  self.FuelConsParam.Top := self.PParam.Top; self.FuelConsParam.Left := self.PParam.Left + 2*EditLabelWidth + 2*EditLabelWidthGap;
  self.CritFuelParam.Top := self.PParam.Top; self.CritFuelParam.Left := self.PParam.Left + 3*EditLabelWidth + 3*EditLabelWidthGap;
  self.SParam.Top := self.PParam.Top; self.SParam.Left := self.PParam.Left + 4*EditLabelWidth + 4*EditLabelWidthGap;
  self.CxParam.Top := self.PParam.Top; self.CxParam.Left := self.PParam.Left + 5*EditLabelWidth + 5*EditLabelWidthGap;

  self.CreateChoice.Left := 5;
  self.CreateChoice.Top := 20;

  self.CreateButton.Left := 25;
  self.CreateButton.Top := 70;

  self.RunSimulationButton.Left := self.RunSimulationSection.Width - 150;
  self.RunSimulationButton.Top := self.RunSimulationSection.Top - 175;

  self.SimulationImage.Top := 50;
  self.SimulationImage.Left := 10;
end;

procedure TForm2.RunSimulationButtonClick(Sender: TObject);
begin
  if (Simulator.CP <> Nil) and (Simulator.RLS <> Nil) and (Simulator.Targets.Count <> 0) then begin
    Simulator.T0 := strToFloat(self.T0Edit.Text);
    Simulator.TK := strToFloat(self.TKEdit.Text);
    Simulator.DT := strToFloat(self.DTEdit.Text);
    CreateLog.Lines.Add('Starting Simulation.');
    Simulator.Run;
    CreateLog.Lines.Add('Simulation Finished.');
  end;
end;

procedure TForm2.SwapActive(choice: boolean);
begin
  self.PParam.Enabled := choice;
  self.FuelMassParam.Enabled := choice;
  self.FuelConsParam.Enabled := choice;
  self.CritFuelParam.Enabled := choice;
  self.SParam.Enabled := choice;
  self.CxParam.Enabled := choice;
end;

procedure TForm2.DrawSimulation(var msg: TMessage);
var target: TTarget; initParam: array[0..3] of integer;
begin
  self.SimulationImage.Canvas.Brush.Color := RGB(255,0,0);
  (*target := Simulator.Targets[0];
  initParam[0]:=Trunc(Target.CurPosition.x);
  initParam[1]:=Trunc(Target.CurPosition.y);
  initParam[2]:=Trunc(Target.CurPosition.x) + 10;
  initParam[3]:=Trunc(Target.CurPosition.y) + 10;
  self.SimulationImage.Canvas.Rectangle(initParam[0], initParam[1], initParam[2], initParam[3]);*)
  self.SimulationImage.Canvas.Ellipse(100,100,200,200);
end;

end.
