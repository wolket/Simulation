unit SIM;
//������ ���������� �����

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, UTargets, Vcl.ComCtrls;

type
  TForm1 = class(TForm)  //����� ������� ��� ��������
    Choose_Label: TLabel;            //����� ��� RadioGroup
    ChooseRadioGroup: TRadioGroup;
    Param_Label: TLabel;             //����� ��� �����������
    Log: TMemo;                      //���
    Run: TButton;                    //������ ������� ���������
    Create: TButton;                 //������ �������� �������
    Sim_Label: TLabel;               //��������� ��� ����������(���������, �������� ����� � ���)
    T0_Label: TLabel;                //��������� �����
    TK_Label: TLabel;                //�������� �����
    Dt_Label: TLabel;                //���
    T0_Edit: TEdit;
    TK_Edit: TEdit;
    DT_Edit: TEdit;
    XLE: TLabeledEdit;               //���� ����� �
    YLE: TLabeledEdit;               //���� ����� �
    ThirdLE: TLabeledEdit;           //3 ��������
    ForthLE: TLabeledEdit;
    P0Label: TLabeledEdit;
    mFuelLabel: TLabeledEdit;
    mCritFuelLabel: TLabeledEdit;
    DmLabel: TLabeledEdit;
    CxLabel: TLabeledEdit;
    RoLabel: TLabeledEdit;
    SLabel: TLabeledEdit;
    //Simulator: TSimulator;
    procedure FormCreate(Sender: TObject);
    procedure ChooseRadioGroupClick(Sender: TObject);
    procedure CreateClick(Sender: TObject);
    procedure RunClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OnResize(Sender: TObject);
    function IsTarget: boolean;
    function GetValue(place: TControl): real;
    procedure SetInitParam(var initParam: array of real);
    procedure SwapVisibility(visibility: boolean);
    //��������� ������� ��������, ���������� ��� ������ �-��� OnResize
    //LeftRatio,TopRatio - ��������� �������� ���� Element.Left/Top � Length/Top
    //procedure ChangePosition(Element: TControl; Width, Height: real; LeftRatio, TopRatio: real);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Simulator: TSimulator;

implementation

procedure TForm1.FormCreate(Sender: TObject);  //��� �������� �����
var arr: array of real;
begin
  Name := 'Simulation';
  setLength(arr, 3);
  arr[0] := 0; arr[1] := 10; arr[2] := 0.1;
  Simulator := TSimulator.Create(arr);     //�������� ����������
  XLE.EditLabel.Caption := ' X: ';             //������ ���������, ��� ��� � ���� ������������
  YLE.EditLabel.Caption := ' Y: ';
  T0_Edit.Text := '0,0';                       //����������� �������� T0, TK, DT
  TK_Edit.Text := '10,0';
  DT_Edit.Text := '0,1';
  P0Label.Text := '1,0';
  mFuelLabel.Text := '1,0';
  mCritFuelLabel.Text := '1,0';
  DmLabel.Text := '0,1';
  CxLabel.Text := '1,0';
  RoLabel.Text := '1,0';
  SLabel.Text := '1,0';
  ThirdLE.Visible := False;
  ForthLE.Visible := False;
  SwapVisibility(False);
  Constraints.MinHeight := 421; Constraints.MaxHeight := 421;
  Constraints.MinWidth := 631; Constraints.MaxWidth := 631;
end;

procedure TForm1.SwapVisibility(visibility: boolean);
begin
  self.P0Label.Visible := visibility; self.P0Label.Text := '0,0';
  self.mFuelLabel.Visible := visibility; self.mFuelLabel.Text := '0,0';
  self.mCritFuelLabel.Visible := visibility; self.mCritFuelLabel.Text := '0,0';
  self.DmLabel.Visible := visibility; self.DmLabel.Text := '0,0';
  self.CxLabel.Visible := visibility; self.CxLabel.Text := '0,0';
  self.RoLabel.Visible := visibility; self.RoLabel.Text := '0,0';
  self.SLabel.Visible := visibility; self.SLabel.Text := '0,0';
end;

function TForm1.GetValue(place: TControl): real;
var PL: TLabeledEdit;
    PE: TEdit;
  MyClass: TComponent;
begin
  result := 0;
  if place is TLabeledEdit then PL := TLabeledEdit(place)
  else PE := TEdit(place);
  try
    if PE <> Nil then result := strToFloat(PE.Text)
    else result := strToFloat(PL.Text);
  except
    if PE <> Nil then showMessage('Not a float Value/Local issue in: ' + PL.EditLabel.Caption)
    else ShowMessage('Not a float Value/Local issue.');
  end;
end;

function TForm1.IsTarget;
begin
  if (self.ChooseRadioGroup.ItemIndex = 2) or (self.ChooseRadioGroup.ItemIndex = 3) then result := True
  else result := False;
end;

procedure TForm1.SetInitParam(var InitParam: array of real);
begin
  initParam[4] := strToFloat(P0Label.Text);
  initParam[5] := strToFloat(mFuelLabel.Text);
  initParam[6] := strToFloat(mCritFuelLabel.Text);
  initParam[7] := strToFloat(DmLabel.Text);
  initParam[8] := strToFloat(CxLabel.Text);
  initParam[9] := strToFloat(RoLabel.Text);
  initParam[10] := strToFloat(SLabel.Text);
end;

procedure TForm1.ChooseRadioGroupClick(Sender: TObject);  //����� ����, ��� �������
begin
  XLE.Visible := True; XLE.EditLabel.Caption := ' X: '; XLE.Text := '0,0';  //��� ���� ����������
  YLE.Visible := True; YLE.EditLabel.Caption := ' Y: '; YLE.Text := '0,0';
  ThirdLE.Visible := True; ThirdLE.Text := '0,0';
  ForthLE.Visible := False;
  self.SwapVisibility(False);
  case ChooseRadioGroup.ItemIndex of                    //3 �������� �������� � ����������� �� ���� ��� ��������
    0: ThirdLE.EditLabel.Caption := 'Safety Distance:';
    1: ThirdLE.EditLabel.Caption := 'Range:';
    2: begin ThirdLE.EditLabel.Caption := 'Velocity:'; self.SwapVisibility(true); end;
    3:
      begin
        self.SwapVisibility(true);
        ThirdLE.EditLabel.Caption := 'Velocity:';        //4 �������� ����������� ��� �������� ������
        ForthLE.EditLabel.Visible := True; ForthLE.EditLabel.Caption := 'Acceleration:';
        ForthLE.Visible := True; ForthLE.Text := '0,0';
      end;
  end;
  if (ChooseRadioGroup.ItemIndex <> 3) or (ChooseRadioGroup.ItemIndex <> 4) then begin

  end;

end;

{$R *.dfm}
procedure TForm1.CreateClick(Sender: TObject);
var initParam: array of real;
begin
  //� ����� ������ ����� ��� ������ ��� ���������
  if (XLE.Text <> '') and (YLE.Text <> '') and (ThirdLE.Text <> '') then begin
    setlength(initParam, 4);
    //initParam[0] := strToFloat(XLE.Text);
    initParam[0] := strToFloat(XLE.Text);
    initParam[1] := strToFloat(YLE.Text);
    initParam[2] := Simulator.T0;
    initParam[3] := strToFloat(ThirdLE.Text);
    if self.IsTarget then begin setLength(initParam, 11); SetInitParam(initParam); end;

    case ChooseRadioGroup.ItemIndex of

    0: if (Simulator.CP = Nil) then begin      //��������� �����, �� ����
         Simulator.CP := TCommandPost.Create(initParam);
         Log.Lines.Add('Created Command Post. Parameters: ');
         Log.Lines.Add('X:' + XLE.Text + '; Y:' + YLE.Text + '; Safety Distance:' + ThirdLE.Text);
      end
      else ShowMessage('CP has been already created!');

    1: if (Simulator.RLS = Nil) then begin     //RLS, �������� ���� ���
         Simulator.RLS := TRLS.Create(initParam);
         Log.Lines.Add('Created RLS. Parameters: ');
         Log.Lines.Add('X:' + XLE.Text + '; Y:' + YLE.Text + '; R max:' + ThirdLE.Text);
      end
      else ShowMessage('RLS has been already created!');

    2: begin                                   //�������� �������
         Simulator.TargetCount := Simulator.Targets.AddTarget(Air, initParam);
         Log.Lines.Add('Created Aircraft. Parameters: ');
         Log.Lines.Add('X:' + XLE.Text + '; Y:' + YLE.Text + '; Velocity:' + ThirdLE.Text + ';');
      end;

    3: begin                                   //�������� ������
        setlength(initParam, 12);
        initParam[11] := strToFloat(ForthLE.Text);
        Simulator.TargetCount := Simulator.Targets.AddTarget(Mis, initParam);
        Log.Lines.Add('Created Missile. Parameters: ');
        Log.Lines.Add('X:' + XLE.Text + '; Y:' + YLE.Text + '; Velocity:' + ThirdLE.Text + '; Acceleration:' + ForthLE.Text);
      end;

    end;//case end

  if isTarget then
    Log.Lines.Add('Total Targets: ' + intToStr(Simulator.TargetCount));
  end //if end
  else ShowMessage('You have Missed Some Parameters!');
end;

procedure TForm1.RunClick(Sender: TObject);     //������ �������������
begin
  //�������� �� �� ��� ������� ��� ������ ����������
  if (Simulator.RLS <> Nil) and (Simulator.CP <> Nil) and (Simulator.TargetCount <> 0) then begin
    //����� �����
    Simulator.T0 := strToFloat(T0_Edit.Text);
    Simulator.TK := strToFloat(TK_Edit.Text);
    Simulator.DT := strToFloat(DT_Edit.Text);
    Log.Lines.Add('Starting Simulation.');
    Simulator.Run;    //������ ���������
    Log.Lines.Add('Simulation Finished.');
  end
  else begin    //����� ����������� ������� ������������ ��� �������
    if Simulator.RLS = Nil then ShowMessage('Create RLS before Run')
    else if Simulator.CP = Nil then ShowMessage('Create CP before Run')
    else if Simulator.TargetCount = 0 then ShowMessage('Create Targets before Run');
  end;
end;

procedure TForm1.OnResize(Sender: TObject);
begin
  ClientHeight := 588;
  ClientWidth := 778;
end;

procedure TForm1.FormDestroy(Sender: TObject);  //��� ����������� �����
begin
  Simulator.Destroy;
end;

end.
