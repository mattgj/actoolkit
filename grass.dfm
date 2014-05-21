object Form8: TForm8
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Grass Style'
  ClientHeight = 100
  ClientWidth = 172
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
  object RadioButton1: TRadioButton
    Left = 8
    Top = 8
    Width = 156
    Height = 17
    Caption = 'Style 1'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object RadioButton2: TRadioButton
    Left = 8
    Top = 27
    Width = 156
    Height = 17
    Caption = 'Style 2'
    TabOrder = 1
  end
  object RadioButton3: TRadioButton
    Left = 8
    Top = 46
    Width = 156
    Height = 17
    Caption = 'Style 3'
    TabOrder = 2
  end
  object apply: TButton
    Left = 8
    Top = 69
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 3
    OnClick = applyClick
  end
  object cancel: TButton
    Left = 89
    Top = 69
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = cancelClick
  end
end
