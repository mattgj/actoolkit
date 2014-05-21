object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Acre Editor'
  ClientHeight = 413
  ClientWidth = 532
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  DesignSize = (
    532
    413)
  PixelsPerInch = 96
  TextHeight = 13
  object hexlabel: TLabel
    Left = 137
    Top = 19
    Width = 16
    Height = 13
    Caption = 'n/a'
  end
  object Label3: TLabel
    Left = 137
    Top = 3
    Width = 24
    Height = 13
    Caption = 'Info:'
  end
  object replace: TSpeedButton
    Left = 71
    Top = 8
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Place'
    OnClick = replaceClick
  end
  object check: TSpeedButton
    Left = 8
    Top = 8
    Width = 57
    Height = 22
    GroupIndex = 1
    Down = True
    Caption = 'Check'
    OnClick = checkClick
  end
  object Label1: TLabel
    Left = 9
    Top = 361
    Width = 42
    Height = 13
    Caption = 'Preview:'
  end
  object apply: TButton
    Left = 368
    Top = 380
    Width = 75
    Height = 25
    Anchors = [akRight]
    Caption = 'Apply'
    TabOrder = 0
    OnClick = applyClick
  end
  object cancel: TButton
    Left = 449
    Top = 380
    Width = 75
    Height = 25
    Anchors = [akRight]
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = cancelClick
  end
  object TreeView1: TTreeView
    Left = 332
    Top = 36
    Width = 191
    Height = 338
    Anchors = [akRight]
    HideSelection = False
    Indent = 19
    ReadOnly = True
    TabOrder = 2
    OnChange = TreeView1Change
    Items.NodeData = {
      0301000000320000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      0000000000010A4C006F006100640069006E0067002E002E002E00}
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 36
    Width = 318
    Height = 318
    BevelEdges = []
    ColCount = 7
    Constraints.MaxHeight = 740
    Constraints.MaxWidth = 740
    DefaultColWidth = 44
    DefaultRowHeight = 44
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 7
    FixedRows = 0
    Options = [goVertLine, goHorzLine, goRangeSelect]
    ScrollBars = ssNone
    TabOrder = 3
    OnDrawCell = StringGrid1DrawCell
    OnKeyDown = StringGrid1KeyDown
    OnMouseWheelDown = StringGrid1MouseWheelDown
    OnMouseWheelUp = StringGrid1MouseWheelUp
    OnSelectCell = StringGrid1SelectCell
  end
  object collapse: TButton
    Left = 467
    Top = 8
    Width = 57
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'Collapse'
    TabOrder = 4
    OnClick = collapseClick
  end
  object StringGrid2: TStringGrid
    Left = 53
    Top = 361
    Width = 48
    Height = 48
    BevelEdges = []
    ColCount = 1
    Constraints.MaxHeight = 740
    Constraints.MaxWidth = 740
    DefaultColWidth = 44
    DefaultRowHeight = 44
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    GridLineWidth = 0
    Options = [goVertLine, goHorzLine, goRangeSelect]
    ScrollBars = ssNone
    TabOrder = 5
    OnDrawCell = StringGrid2DrawCell
  end
  object export: TButton
    Left = 272
    Top = 358
    Width = 54
    Height = 22
    Caption = 'Export'
    TabOrder = 6
    OnClick = exportClick
  end
  object import: TButton
    Left = 212
    Top = 358
    Width = 54
    Height = 22
    Caption = 'Import'
    TabOrder = 7
    OnClick = importClick
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 112
    Top = 360
  end
end
