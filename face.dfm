object Form5: TForm5
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Appearance'
  ClientHeight = 183
  ClientWidth = 243
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 27
    Height = 13
    Caption = 'Face:'
  end
  object Label2: TLabel
    Left = 8
    Top = 39
    Width = 49
    Height = 13
    Caption = 'Hair style:'
  end
  object Label3: TLabel
    Left = 8
    Top = 67
    Width = 49
    Height = 13
    Caption = 'Hair color:'
  end
  object Label4: TLabel
    Left = 8
    Top = 95
    Width = 54
    Height = 13
    Caption = 'Shoe style:'
  end
  object Label5: TLabel
    Left = 8
    Top = 121
    Width = 22
    Height = 13
    Caption = 'Tan:'
  end
  object ComboBox1: TComboBox
    Left = 64
    Top = 8
    Width = 171
    Height = 19
    Style = csOwnerDrawFixed
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = 'Male brown eyes, mascara '
    Items.Strings = (
      'Male brown eyes, mascara '
      'Male brows '
      'Male blue eyes, lids '
      'Male blue, small pupil, brows '
      'Male normal brown eyes '
      'Male arch eyes '
      'Male cheeky '
      'Male small pupil, no brows '
      'Female anime eyes '
      'Female oval eyelash '
      'Female cheeky '
      'Female blue eyes, lids '
      'Female mascara '
      'Female arch eyes, lash '
      'Female standard'
      'Female mascara, brows ')
  end
  object ComboBox2: TComboBox
    Left = 63
    Top = 36
    Width = 171
    Height = 19
    Style = csOwnerDrawFixed
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'Male regular'
    Items.Strings = (
      'Male regular'
      'Male cowlick'
      'Male covereye'
      'Male spikey'
      'Male coiff'
      'Male one spike'
      'Male bowlcut, 2 lines'
      'Male bowlcut'
      'Male cone'
      'Male long, shaggy'
      'Male parted'
      'Male short, shaggy'
      'Male messy'
      'Female regular'
      'Female ears long'
      'Female pig tails'
      'Female triangle spikes'
      'Female pony tail'
      'Female pony stub'
      'Female ears short'
      'Female curls'
      'Female long, pony tail'
      'Female bangs down'
      'Female bangs up'
      'Female parted'
      'Female messy')
  end
  object ComboBox3: TComboBox
    Left = 64
    Top = 64
    Width = 171
    Height = 19
    Style = csOwnerDrawFixed
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = 'Dark brown'
    Items.Strings = (
      'Dark brown'
      'Light brown'
      'Orange'
      'Blue'
      'Yellow'
      'Green'
      'Pink'
      'White')
  end
  object apply: TButton
    Left = 79
    Top = 150
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 3
    OnClick = applyClick
  end
  object cancel: TButton
    Left = 160
    Top = 150
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = cancelClick
  end
  object ComboBox4: TComboBox
    Left = 64
    Top = 92
    Width = 171
    Height = 19
    Style = csOwnerDrawFixed
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 5
    Text = 'Yellow, pink'
    Items.Strings = (
      'Yellow, pink'
      'Red'
      'Orange'
      'Green'
      'Blue'
      'Blue, purple'
      'Black, green'
      'Purple'
      'Brown'
      'Pink'
      'Yellow, green'
      'Red'
      'Orange'
      'Green'
      'Blue'
      'White'
      'Black'
      'Purple'
      'Brown'
      'Pink')
  end
  object ComboBox5: TComboBox
    Left = 64
    Top = 118
    Width = 171
    Height = 19
    Style = csOwnerDrawFixed
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 6
    Text = '0 - None'
    Items.Strings = (
      '0 - None'
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7 - Dark')
  end
end
