object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 511
  ClientWidth = 684
  Color = clBtnFace
  Constraints.MinHeight = 550
  Constraints.MinWidth = 700
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = OnCreate
  OnResize = OnResize
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 684
    Height = 511
    ActivePage = SimulationConditions
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 663
    ExplicitHeight = 505
    object SimulationConditions: TTabSheet
      Caption = 'SimulationConditions'
      ExplicitWidth = 655
      ExplicitHeight = 477
      object RunSimulationSection: TGroupBox
        Left = 345
        Top = 293
        Width = 331
        Height = 190
        Align = alClient
        Caption = 'RunSimulationSection'
        TabOrder = 0
        ExplicitWidth = 310
        ExplicitHeight = 184
        object RunSimulationButton: TButton
          Left = 176
          Top = 127
          Width = 113
          Height = 34
          Caption = 'RunSimulationButton'
          TabOrder = 0
          OnClick = RunSimulationButtonClick
        end
      end
      object SimulationParam: TGroupBox
        Left = 0
        Top = 293
        Width = 345
        Height = 190
        Align = alLeft
        Caption = 'SimulationParam'
        TabOrder = 1
        ExplicitLeft = -6
        ExplicitTop = 297
        object TKEdit: TLabeledEdit
          Left = 48
          Top = 96
          Width = 121
          Height = 21
          EditLabel.Width = 30
          EditLabel.Height = 13
          EditLabel.Caption = 'TKEdit'
          TabOrder = 1
          Text = '100,0'
        end
        object T0Edit: TLabeledEdit
          Left = 48
          Top = 51
          Width = 121
          Height = 21
          EditLabel.Width = 30
          EditLabel.Height = 13
          EditLabel.Caption = 'T0Edit'
          TabOrder = 0
          Text = '0,0'
        end
        object DTEdit: TLabeledEdit
          Left = 48
          Top = 147
          Width = 121
          Height = 21
          EditLabel.Width = 31
          EditLabel.Height = 13
          EditLabel.Caption = 'DTEdit'
          TabOrder = 2
          Text = '0,1'
        end
      end
      object CreateOutput: TGroupBox
        Left = 0
        Top = 0
        Width = 676
        Height = 155
        Align = alTop
        Caption = 'CreateOutput'
        TabOrder = 2
        ExplicitWidth = 655
        object CreateLog: TMemo
          Left = 2
          Top = 15
          Width = 672
          Height = 138
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 651
        end
      end
      object CreateSection: TGroupBox
        Left = 0
        Top = 155
        Width = 676
        Height = 138
        Align = alTop
        Caption = 'CreateSection'
        TabOrder = 3
        ExplicitWidth = 655
        object CreateChoice: TComboBox
          Left = 3
          Top = 20
          Width = 125
          Height = 21
          TabOrder = 0
          Text = 'Create...'
          OnChange = CreateChoiceChange
          Items.Strings = (
            'Command Post'
            'RLS'
            'Aircraft'
            'Missile')
        end
        object ParamSection: TGroupBox
          Left = 159
          Top = 15
          Width = 515
          Height = 121
          Align = alRight
          Caption = 'ParamSection'
          TabOrder = 1
          ExplicitLeft = 138
        end
        object XParam: TLabeledEdit
          Left = 168
          Top = 48
          Width = 65
          Height = 21
          EditLabel.Width = 10
          EditLabel.Height = 13
          EditLabel.Caption = 'X:'
          TabOrder = 2
        end
        object YParam: TLabeledEdit
          Left = 247
          Top = 48
          Width = 65
          Height = 21
          EditLabel.Width = 10
          EditLabel.Height = 13
          EditLabel.Caption = 'Y:'
          TabOrder = 3
        end
        object ThirdParam: TLabeledEdit
          Left = 327
          Top = 48
          Width = 65
          Height = 21
          EditLabel.Width = 54
          EditLabel.Height = 13
          EditLabel.Caption = 'ThirdParam'
          TabOrder = 4
        end
        object PParam: TLabeledEdit
          Left = 168
          Top = 96
          Width = 65
          Height = 21
          EditLabel.Width = 10
          EditLabel.Height = 13
          EditLabel.Caption = 'P:'
          TabOrder = 5
        end
        object FuelMassParam: TLabeledEdit
          Left = 247
          Top = 96
          Width = 65
          Height = 21
          EditLabel.Width = 51
          EditLabel.Height = 13
          EditLabel.Caption = 'Fuel mass:'
          TabOrder = 6
        end
        object FuelConsParam: TLabeledEdit
          Left = 327
          Top = 96
          Width = 65
          Height = 21
          EditLabel.Width = 49
          EditLabel.Height = 13
          EditLabel.Caption = 'Fuel cons:'
          TabOrder = 7
        end
        object CritFuelParam: TLabeledEdit
          Left = 407
          Top = 96
          Width = 65
          Height = 21
          EditLabel.Width = 44
          EditLabel.Height = 13
          EditLabel.Caption = 'Crit Fuel:'
          TabOrder = 8
        end
        object SParam: TLabeledEdit
          Left = 487
          Top = 96
          Width = 65
          Height = 21
          EditLabel.Width = 10
          EditLabel.Height = 13
          EditLabel.Caption = 'S:'
          TabOrder = 9
        end
        object CxParam: TLabeledEdit
          Left = 567
          Top = 96
          Width = 65
          Height = 21
          EditLabel.Width = 17
          EditLabel.Height = 13
          EditLabel.Caption = 'Cx:'
          TabOrder = 10
        end
        object CreateButton: TButton
          Left = 32
          Top = 73
          Width = 75
          Height = 25
          Caption = 'CreateButton'
          TabOrder = 11
          OnClick = CreateButtonClick
        end
      end
    end
    object SimulationOutput: TTabSheet
      Caption = 'SimulationOutput'
      ImageIndex = 1
      ExplicitWidth = 672
      ExplicitHeight = 477
      object SimulationImage: TImage
        Left = 0
        Top = 32
        Width = 600
        Height = 400
      end
    end
  end
end
