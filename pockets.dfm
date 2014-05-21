object Form4: TForm4
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Pocket Editor'
  ClientHeight = 457
  ClientWidth = 504
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
    504
    457)
  PixelsPerInch = 96
  TextHeight = 13
  object replace: TSpeedButton
    Left = 71
    Top = 4
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Place'
    OnClick = replaceClick
  end
  object delete: TSpeedButton
    Left = 134
    Top = 4
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Delete'
    OnClick = deleteClick
  end
  object hexlabel: TLabel
    Left = 38
    Top = 32
    Width = 16
    Height = 13
    Caption = 'n/a'
  end
  object check: TSpeedButton
    Left = 8
    Top = 4
    Width = 57
    Height = 22
    GroupIndex = 1
    Down = True
    Caption = 'Check'
    OnClick = checkClick
  end
  object Label1: TLabel
    Left = 8
    Top = 32
    Width = 24
    Height = 13
    Caption = 'Info:'
  end
  object TreeView1: TTreeView
    Left = 326
    Top = 51
    Width = 170
    Height = 366
    HideSelection = False
    Indent = 19
    ReadOnly = True
    TabOrder = 0
    OnChange = TreeView1Change
    OnEnter = TreeView1Enter
    Items.NodeData = {
      0301000000320000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      0000000000010A4C006F006100640069006E0067002E002E002E00}
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 51
    Width = 258
    Height = 54
    DefaultColWidth = 50
    DefaultRowHeight = 16
    FixedCols = 0
    RowCount = 3
    FixedRows = 0
    Options = [goVertLine, goHorzLine]
    ScrollBars = ssNone
    TabOrder = 1
    OnDrawCell = StringGrid1DrawCell
    OnKeyDown = StringGrid1KeyDown
    OnMouseWheelDown = StringGrid1MouseWheelDown
    OnMouseWheelUp = StringGrid1MouseWheelUp
    OnSelectCell = StringGrid1SelectCell
  end
  object apply: TButton
    Left = 341
    Top = 424
    Width = 75
    Height = 25
    Anchors = [akRight]
    Caption = 'Apply'
    TabOrder = 2
    OnClick = applyClick
  end
  object cancel: TButton
    Left = 422
    Top = 424
    Width = 75
    Height = 25
    Anchors = [akRight]
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = cancelClick
  end
  object Button1: TButton
    Left = 439
    Top = 23
    Width = 57
    Height = 22
    Anchors = [akRight]
    Caption = 'Collapse'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 376
    Top = 23
    Width = 57
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'Find'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Top = 392
  end
end
