object Form11: TForm11
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'House Editor'
  ClientHeight = 657
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object delete: TSpeedButton
    Left = 134
    Top = 8
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Delete'
    OnClick = deleteClick
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
  object hexlabel: TLabel
    Left = 38
    Top = 36
    Width = 16
    Height = 13
    Caption = 'n/a'
  end
  object Label1: TLabel
    Left = 8
    Top = 36
    Width = 24
    Height = 13
    Caption = 'Info:'
  end
  object Label2: TLabel
    Left = 8
    Top = 52
    Width = 53
    Height = 13
    Caption = 'Main room:'
  end
  object Label3: TLabel
    Left = 8
    Top = 252
    Width = 64
    Height = 13
    Caption = 'Second floor:'
  end
  object Label4: TLabel
    Left = 8
    Top = 452
    Width = 51
    Height = 13
    Caption = 'Basement:'
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 68
    Width = 179
    Height = 179
    ColCount = 16
    Constraints.MaxHeight = 740
    Constraints.MaxWidth = 740
    DefaultColWidth = 10
    DefaultRowHeight = 10
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 16
    FixedRows = 0
    Options = [goVertLine, goHorzLine]
    ScrollBars = ssNone
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnKeyDown = StringGrid1KeyDown
    OnMouseWheelDown = StringGrid1MouseWheelDown
    OnMouseWheelUp = StringGrid1MouseWheelUp
    OnSelectCell = StringGrid1SelectCell
  end
  object Button1: TButton
    Left = 497
    Top = 40
    Width = 57
    Height = 22
    Caption = 'Collapse'
    TabOrder = 1
    OnClick = Button1Click
  end
  object cancel: TButton
    Left = 479
    Top = 621
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = cancelClick
  end
  object apply: TButton
    Left = 398
    Top = 621
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 3
    OnClick = applyClick
  end
  object TreeView1: TTreeView
    Left = 384
    Top = 68
    Width = 170
    Height = 547
    HideSelection = False
    Indent = 19
    ReadOnly = True
    TabOrder = 4
    OnChange = TreeView1Change
    OnEnter = TreeView1Enter
    Items.NodeData = {
      0301000000320000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      0000000000010A4C006F006100640069006E0067002E002E002E00}
  end
  object StringGrid2: TStringGrid
    Left = 192
    Top = 68
    Width = 179
    Height = 179
    ColCount = 16
    Constraints.MaxHeight = 740
    Constraints.MaxWidth = 740
    DefaultColWidth = 10
    DefaultRowHeight = 10
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 16
    FixedRows = 0
    Options = [goVertLine, goHorzLine]
    ScrollBars = ssNone
    TabOrder = 5
    OnDrawCell = StringGrid2DrawCell
    OnKeyDown = StringGrid2KeyDown
    OnMouseWheelDown = StringGrid2MouseWheelDown
    OnMouseWheelUp = StringGrid2MouseWheelUp
    OnSelectCell = StringGrid2SelectCell
  end
  object StringGrid4: TStringGrid
    Left = 192
    Top = 268
    Width = 179
    Height = 179
    ColCount = 16
    Constraints.MaxHeight = 740
    Constraints.MaxWidth = 740
    DefaultColWidth = 10
    DefaultRowHeight = 10
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 16
    FixedRows = 0
    Options = [goVertLine, goHorzLine]
    ScrollBars = ssNone
    TabOrder = 6
    OnDrawCell = StringGrid4DrawCell
    OnKeyDown = StringGrid4KeyDown
    OnMouseWheelDown = StringGrid4MouseWheelDown
    OnMouseWheelUp = StringGrid4MouseWheelUp
    OnSelectCell = StringGrid4SelectCell
  end
  object StringGrid3: TStringGrid
    Left = 8
    Top = 268
    Width = 179
    Height = 179
    ColCount = 16
    Constraints.MaxHeight = 740
    Constraints.MaxWidth = 740
    DefaultColWidth = 10
    DefaultRowHeight = 10
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 16
    FixedRows = 0
    Options = [goVertLine, goHorzLine]
    ScrollBars = ssNone
    TabOrder = 7
    OnDrawCell = StringGrid3DrawCell
    OnKeyDown = StringGrid3KeyDown
    OnMouseWheelDown = StringGrid3MouseWheelDown
    OnMouseWheelUp = StringGrid3MouseWheelUp
    OnSelectCell = StringGrid3SelectCell
  end
  object StringGrid6: TStringGrid
    Left = 192
    Top = 468
    Width = 179
    Height = 179
    ColCount = 16
    Constraints.MaxHeight = 740
    Constraints.MaxWidth = 740
    DefaultColWidth = 10
    DefaultRowHeight = 10
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 16
    FixedRows = 0
    Options = [goVertLine, goHorzLine]
    ScrollBars = ssNone
    TabOrder = 8
    OnDrawCell = StringGrid6DrawCell
    OnKeyDown = StringGrid6KeyDown
    OnMouseWheelDown = StringGrid6MouseWheelDown
    OnMouseWheelUp = StringGrid6MouseWheelUp
    OnSelectCell = StringGrid6SelectCell
  end
  object StringGrid5: TStringGrid
    Left = 8
    Top = 468
    Width = 179
    Height = 179
    ColCount = 16
    Constraints.MaxHeight = 740
    Constraints.MaxWidth = 740
    DefaultColWidth = 10
    DefaultRowHeight = 10
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 16
    FixedRows = 0
    Options = [goVertLine, goHorzLine]
    ScrollBars = ssNone
    TabOrder = 9
    OnDrawCell = StringGrid5DrawCell
    OnKeyDown = StringGrid5KeyDown
    OnMouseWheelDown = StringGrid5MouseWheelDown
    OnMouseWheelUp = StringGrid5MouseWheelUp
    OnSelectCell = StringGrid5SelectCell
  end
  object Button2: TButton
    Left = 434
    Top = 40
    Width = 57
    Height = 22
    Caption = 'Find'
    TabOrder = 10
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 304
    Top = 24
  end
end
