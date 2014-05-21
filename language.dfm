object Form13: TForm13
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Language'
  ClientHeight = 97
  ClientWidth = 202
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
    Top = 66
    Width = 177
    Height = 13
    Caption = 'Changing the language only changes'
  end
  object Label2: TLabel
    Left = 8
    Top = 80
    Width = 114
    Height = 13
    Caption = 'item names at this time.'
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 8
    Width = 184
    Height = 21
    Style = csDropDownList
    DropDownCount = 9
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = 'English (American)'
    Items.Strings = (
      'English (American)'
      'English (British)'
      'Espa'#241'ol (American)'
      'Fran'#231'ais (Canadian)'
      'Espa'#241'ol (European)'
      'Fran'#231'ais (European)'
      'Italiano'
      'Deutsch'
      #26085#26412#35486)
  end
  object Button1: TButton
    Left = 36
    Top = 35
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 117
    Top = 35
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = Button2Click
  end
end
