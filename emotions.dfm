object Form3: TForm3
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Emotions'
  ClientHeight = 150
  ClientWidth = 222
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
    Width = 51
    Height = 13
    Caption = 'Emotion 1:'
  end
  object Label2: TLabel
    Left = 8
    Top = 38
    Width = 51
    Height = 13
    Caption = 'Emotion 2:'
  end
  object Label3: TLabel
    Left = 8
    Top = 65
    Width = 51
    Height = 13
    Caption = 'Emotion 3:'
  end
  object Label4: TLabel
    Left = 8
    Top = 92
    Width = 51
    Height = 13
    Caption = 'Emotion 4:'
  end
  object ComboBox2: TComboBox
    Left = 65
    Top = 35
    Width = 145
    Height = 19
    Style = csOwnerDrawFixed
    ItemHeight = 13
    TabOrder = 1
  end
  object ComboBox3: TComboBox
    Left = 65
    Top = 62
    Width = 145
    Height = 19
    Style = csOwnerDrawFixed
    ItemHeight = 13
    TabOrder = 2
  end
  object ComboBox4: TComboBox
    Left = 65
    Top = 89
    Width = 145
    Height = 19
    Style = csOwnerDrawFixed
    ItemHeight = 13
    TabOrder = 3
  end
  object apply: TButton
    Left = 56
    Top = 117
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 4
    OnClick = applyClick
  end
  object cancel: TButton
    Left = 137
    Top = 116
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 5
    OnClick = cancelClick
  end
  object ComboBox1: TComboBox
    Left = 65
    Top = 8
    Width = 145
    Height = 19
    Style = csOwnerDrawFixed
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = 'None'
    Items.Strings = (
      'None'
      'Close'
      'Anger'
      'Shock'
      'Laughter'
      'Surprise'
      'Outrage'
      'Distress'
      'Fear'
      'Sorrow'
      'Disinterest'
      'Joy'
      'Curiosity'
      'Inspiration'
      'Glee'
      'Thought'
      'Sadness'
      'Heartbreak'
      'Mischief'
      'Sleepiness'
      'Love'
      'Happiness'
      'Irritation'
      'Worry'
      'Bashfulness'
      'Disbelief'
      'Agreement'
      'Delight'
      'Resignation'
      'Disappointment'
      'Realization')
  end
end
