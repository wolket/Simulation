unit Simulation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, extctrls, Vcl.StdCtrls,
  Vcl.Menus;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

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
  self.SimulationImage.Canvas.Brush.Color := RGB(100,50,200);
  self.SimulationImage.Canvas.Rectangle(0,0, self.Width, self.Height);
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

end.
