object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 382
  ClientWidth = 615
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = OnResize
  PixelsPerInch = 96
  TextHeight = 13
  object Choose_Label: TLabel
    Left = 16
    Top = 11
    Width = 114
    Height = 13
    Caption = 'Choose what to create:'
  end
  object Param_Label: TLabel
    Left = 175
    Top = 11
    Width = 59
    Height = 13
    Caption = 'Parameters:'
  end
  object Sim_Label: TLabel
    Left = 16
    Top = 273
    Width = 106
    Height = 13
    Caption = 'Simulation Parameters'
  end
  object T0_Label: TLabel
    Left = 16
    Top = 297
    Width = 49
    Height = 13
    Caption = 'Start Time'
  end
  object TK_Label: TLabel
    Left = 16
    Top = 324
    Width = 52
    Height = 13
    Caption = 'Finish Time'
  end
  object Dt_Label: TLabel
    Left = 16
    Top = 351
    Width = 11
    Height = 13
    Caption = 'Dt'
  end
  object ChooseRadioGroup: TRadioGroup
    Left = 16
    Top = 30
    Width = 129
    Height = 160
    Items.Strings = (
      'Command Post'
      'RLS'
      'Aircraft'
      'Missile')
    TabOrder = 0
    OnClick = ChooseRadioGroupClick
  end
  object Log: TMemo
    Left = 320
    Top = 8
    Width = 281
    Height = 182
    Align = alCustom
    Lines.Strings = (
      'Log start:')
    TabOrder = 1
  end
  object Run: TButton
    Left = 526
    Top = 346
    Width = 75
    Height = 25
    Caption = 'Run'
    TabOrder = 2
    OnClick = RunClick
  end
  object Create: TButton
    Left = 408
    Top = 346
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 3
    OnClick = CreateClick
  end
  object T0_Edit: TEdit
    Left = 128
    Top = 297
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '0'
  end
  object TK_Edit: TEdit
    Left = 128
    Top = 324
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '10'
  end
  object DT_Edit: TEdit
    Left = 128
    Top = 351
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '0,1'
  end
  object XLE: TLabeledEdit
    Left = 175
    Top = 46
    Width = 121
    Height = 21
    EditLabel.Width = 6
    EditLabel.Height = 13
    EditLabel.Caption = 'X'
    TabOrder = 7
  end
  object YLE: TLabeledEdit
    Left = 175
    Top = 89
    Width = 121
    Height = 21
    EditLabel.Width = 6
    EditLabel.Height = 13
    EditLabel.Caption = 'Y'
    TabOrder = 8
  end
  object ThirdLE: TLabeledEdit
    Left = 175
    Top = 129
    Width = 121
    Height = 21
    EditLabel.Width = 60
    EditLabel.Height = 13
    EditLabel.Caption = 'Third_Param'
    TabOrder = 9
  end
  object ForthLE: TLabeledEdit
    Left = 175
    Top = 169
    Width = 121
    Height = 21
    EditLabel.Width = 56
    EditLabel.Height = 13
    EditLabel.Caption = 'ForthParam'
    TabOrder = 10
  end
  object P0Label: TLabeledEdit
    Left = 17
    Top = 238
    Width = 72
    Height = 21
    EditLabel.Width = 16
    EditLabel.Height = 13
    EditLabel.Caption = 'P0:'
    TabOrder = 11
  end
  object mFuelLabel: TLabeledEdit
    Left = 345
    Top = 238
    Width = 65
    Height = 21
    EditLabel.Width = 51
    EditLabel.Height = 13
    EditLabel.Caption = 'Fuel Mass:'
    TabOrder = 12
  end
  object mCritFuelLabel: TLabeledEdit
    Left = 424
    Top = 238
    Width = 67
    Height = 21
    EditLabel.Width = 39
    EditLabel.Height = 13
    EditLabel.Caption = 'CFuelM:'
    TabOrder = 13
  end
  object DmLabel: TLabeledEdit
    Left = 505
    Top = 238
    Width = 64
    Height = 21
    EditLabel.Width = 19
    EditLabel.Height = 13
    EditLabel.Caption = 'Dm:'
    TabOrder = 14
  end
  object CxLabel: TLabeledEdit
    Left = 104
    Top = 238
    Width = 65
    Height = 21
    EditLabel.Width = 20
    EditLabel.Height = 13
    EditLabel.Caption = 'Cx: '
    TabOrder = 15
  end
  object RoLabel: TLabeledEdit
    Left = 184
    Top = 238
    Width = 65
    Height = 21
    EditLabel.Width = 20
    EditLabel.Height = 13
    EditLabel.Caption = 'Ro: '
    TabOrder = 16
  end
  object SLabel: TLabeledEdit
    Left = 264
    Top = 238
    Width = 65
    Height = 21
    EditLabel.Width = 10
    EditLabel.Height = 13
    EditLabel.Caption = 'S:'
    TabOrder = 17
  end
end
