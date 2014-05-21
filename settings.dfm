object Form10: TForm10
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Colors'
  ClientHeight = 213
  ClientWidth = 307
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
    Width = 31
    Height = 13
    Caption = 'Trees:'
  end
  object Label2: TLabel
    Left = 8
    Top = 39
    Width = 41
    Height = 13
    Caption = 'Flowers:'
  end
  object Label3: TLabel
    Left = 8
    Top = 67
    Width = 81
    Height = 13
    Caption = 'Parched flowers:'
  end
  object Label4: TLabel
    Left = 164
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Items:'
  end
  object Label5: TLabel
    Left = 164
    Top = 36
    Width = 48
    Height = 13
    Caption = 'Furniture:'
  end
  object Label6: TLabel
    Left = 8
    Top = 123
    Width = 32
    Height = 13
    Caption = 'Rocks:'
  end
  object Label7: TLabel
    Left = 8
    Top = 151
    Width = 45
    Height = 13
    Caption = 'Patterns:'
  end
  object Label8: TLabel
    Left = 8
    Top = 95
    Width = 37
    Height = 13
    Caption = 'Weeds:'
  end
  object Label9: TLabel
    Left = 164
    Top = 64
    Width = 32
    Height = 13
    Caption = 'Other:'
  end
  object Label10: TLabel
    Left = 164
    Top = 92
    Width = 47
    Height = 13
    Caption = 'Acre grid:'
  end
  object Label11: TLabel
    Left = 164
    Top = 148
    Width = 70
    Height = 13
    Caption = 'Buried symbol:'
  end
  object Label12: TLabel
    Left = 164
    Top = 120
    Width = 76
    Height = 13
    Caption = 'Building symbol:'
  end
  object treebox: TEdit
    Left = 93
    Top = 8
    Width = 49
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    MaxLength = 6
    ParentFont = False
    TabOrder = 0
    Text = 'FFFFFF'
    OnChange = treeboxChange
    OnDblClick = treeboxDblClick
  end
  object flowerbox: TEdit
    Left = 93
    Top = 36
    Width = 49
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    MaxLength = 6
    ParentFont = False
    TabOrder = 1
    Text = 'FFFFFF'
    OnChange = flowerboxChange
    OnDblClick = flowerboxDblClick
  end
  object flower2box: TEdit
    Left = 93
    Top = 64
    Width = 49
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    MaxLength = 6
    ParentFont = False
    TabOrder = 2
    Text = 'FFFFFF'
    OnChange = flower2boxChange
    OnDblClick = flower2boxDblClick
  end
  object itembox: TEdit
    Left = 249
    Top = 5
    Width = 49
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    MaxLength = 6
    ParentFont = False
    TabOrder = 3
    Text = 'FFFFFF'
    OnChange = itemboxChange
    OnDblClick = itemboxDblClick
  end
  object item2box: TEdit
    Left = 249
    Top = 33
    Width = 49
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    MaxLength = 6
    ParentFont = False
    TabOrder = 4
    Text = 'FFFFFF'
    OnChange = item2boxChange
    OnDblClick = item2boxDblClick
  end
  object rockbox: TEdit
    Left = 93
    Top = 120
    Width = 49
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    MaxLength = 6
    ParentFont = False
    TabOrder = 5
    Text = 'FFFFFF'
    OnChange = rockboxChange
    OnDblClick = rockboxDblClick
  end
  object patternbox: TEdit
    Left = 93
    Top = 148
    Width = 49
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    MaxLength = 6
    ParentFont = False
    TabOrder = 6
    Text = 'FFFFFF'
    OnChange = patternboxChange
    OnDblClick = patternboxDblClick
  end
  object weedbox: TEdit
    Left = 93
    Top = 92
    Width = 49
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    MaxLength = 6
    ParentFont = False
    TabOrder = 7
    Text = 'FFFFFF'
    OnChange = weedboxChange
    OnDblClick = weedboxDblClick
  end
  object otherbox: TEdit
    Left = 249
    Top = 61
    Width = 49
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    MaxLength = 6
    ParentFont = False
    TabOrder = 8
    Text = 'FFFFFF'
    OnChange = otherboxChange
    OnDblClick = otherboxDblClick
  end
  object gridbox: TEdit
    Left = 249
    Top = 89
    Width = 49
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    MaxLength = 6
    ParentFont = False
    TabOrder = 9
    Text = 'FFFFFF'
    OnChange = gridboxChange
    OnDblClick = gridboxDblClick
  end
  object Apply: TButton
    Left = 143
    Top = 180
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 10
    OnClick = ApplyClick
  end
  object Cancel: TButton
    Left = 224
    Top = 180
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 11
    OnClick = CancelClick
  end
  object buriedbox: TEdit
    Left = 249
    Top = 145
    Width = 49
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    MaxLength = 6
    ParentFont = False
    TabOrder = 12
    Text = 'FFFFFF'
    OnChange = buriedboxChange
    OnDblClick = buriedboxDblClick
  end
  object buildingbox: TEdit
    Left = 249
    Top = 117
    Width = 49
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    MaxLength = 6
    ParentFont = False
    TabOrder = 13
    Text = 'FFFFFF'
    OnChange = buildingboxChange
    OnDblClick = buildingboxDblClick
  end
  object ColorDialog1: TColorDialog
    Top = 184
  end
end
