object Form12: TForm12
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Find'
  ClientHeight = 62
  ClientWidth = 216
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    OnKeyDown = Edit1KeyDown
  end
  object Button1: TButton
    Left = 135
    Top = 8
    Width = 74
    Height = 21
    Caption = 'Find next'
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 135
    Top = 35
    Width = 74
    Height = 21
    Caption = 'Close'
    TabOrder = 2
    OnClick = Button3Click
  end
end
