object Form9: TForm9
  Left = 0
  Top = 0
  Caption = 'Grass Editor'
  ClientHeight = 603
  ClientWidth = 735
  Color = clBtnFace
  Constraints.MinHeight = 632
  Constraints.MinWidth = 743
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    735
    603)
  PixelsPerInch = 96
  TextHeight = 13
  object check: TSpeedButton
    Left = 8
    Top = 8
    Width = 57
    Height = 22
    GroupIndex = 1
    Down = True
    Caption = 'Check'
  end
  object replace: TSpeedButton
    Left = 71
    Top = 8
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Set'
  end
  object Label1: TLabel
    Left = 136
    Top = 11
    Width = 30
    Height = 13
    Caption = 'Value:'
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 36
    Width = 719
    Height = 528
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 80
    Constraints.MaxHeight = 740
    Constraints.MaxWidth = 740
    DefaultColWidth = 8
    DefaultRowHeight = 8
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 80
    FixedRows = 0
    Options = [goVertLine, goHorzLine]
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnSelectCell = StringGrid1SelectCell
    ExplicitHeight = 530
  end
  object gval: TEdit
    Left = 172
    Top = 8
    Width = 29
    Height = 21
    MaxLength = 3
    TabOrder = 1
    Text = '0'
  end
  object apply: TButton
    Left = 573
    Top = 570
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Apply'
    TabOrder = 2
    OnClick = applyClick
    ExplicitTop = 572
  end
  object cancel: TButton
    Left = 654
    Top = 570
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = cancelClick
    ExplicitTop = 572
  end
  object backdrop: TCheckBox
    Left = 619
    Top = 3
    Width = 108
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Show background'
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnClick = backdropClick
  end
  object acregrid: TCheckBox
    Left = 619
    Top = 17
    Width = 108
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Show acre grid'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = acregridClick
  end
  object Button1: TButton
    Left = 8
    Top = 570
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Restore all'
    TabOrder = 6
    OnClick = Button1Click
    ExplicitTop = 572
  end
  object Button2: TButton
    Left = 89
    Top = 570
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Remove all'
    TabOrder = 7
    OnClick = Button2Click
    ExplicitTop = 572
  end
end
