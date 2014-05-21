object TownEditorWin: TTownEditorWin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Town Editor'
  ClientHeight = 546
  ClientWidth = 892
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 900
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  DesignSize = (
    892
    546)
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 826
    Top = 12
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Acre'
    Visible = False
  end
  object bcheck: TSpeedButton
    Left = 292
    Top = 26
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Check'
    OnClick = bcheckClick
  end
  object bmove: TSpeedButton
    Left = 355
    Top = 26
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Move'
    OnClick = bmoveClick
  end
  object check: TSpeedButton
    Left = 7
    Top = 26
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Check'
    OnClick = checkClick
  end
  object delete: TSpeedButton
    Left = 133
    Top = 26
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Delete'
    OnClick = deleteClick
  end
  object replace: TSpeedButton
    Left = 70
    Top = 26
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Place'
    OnClick = replaceClick
  end
  object Label1: TLabel
    Left = 7
    Top = 7
    Width = 67
    Height = 13
    Caption = 'Item controls:'
  end
  object Label2: TLabel
    Left = 292
    Top = 8
    Width = 81
    Height = 13
    Caption = 'Building controls:'
  end
  object coords: TSpeedButton
    Left = 763
    Top = 12
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Coords'
    Visible = False
  end
  object hexlabel: TLabel
    Left = 40
    Top = 51
    Width = 16
    Height = 13
    Caption = 'n/a'
  end
  object Label3: TLabel
    Left = 10
    Top = 51
    Width = 24
    Height = 13
    Caption = 'Info:'
  end
  object buryitem: TSpeedButton
    Left = 196
    Top = 26
    Width = 76
    Height = 22
    GroupIndex = 1
    Caption = 'Bury/Unbury'
    OnClick = buryitemClick
  end
  object bplace: TSpeedButton
    Left = 417
    Top = 26
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Place'
    OnClick = bplaceClick
  end
  object bdelete: TSpeedButton
    Left = 480
    Top = 26
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Delete'
    OnClick = bdeleteClick
  end
  object Label4: TLabel
    Left = 556
    Top = 7
    Width = 72
    Height = 13
    Caption = 'Grass controls:'
  end
  object gcheck: TSpeedButton
    Left = 556
    Top = 26
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Check'
    OnClick = gcheckClick
  end
  object gset: TSpeedButton
    Left = 619
    Top = 26
    Width = 57
    Height = 22
    GroupIndex = 1
    Caption = 'Set'
    OnClick = gsetClick
  end
  object Label5: TLabel
    Left = 682
    Top = 29
    Width = 38
    Height = 13
    Caption = 'Quality:'
  end
  object StringGrid1: TStringGrid
    Left = 7
    Top = 68
    Width = 676
    Height = 470
    Hint = 'Test'
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
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnKeyDown = StringGrid1KeyDown
    OnMouseDown = StringGrid1MouseDown
    OnMouseMove = StringGrid1MouseMove
    OnMouseUp = StringGrid1MouseUp
    OnMouseWheelDown = StringGrid1MouseWheelDown
    OnMouseWheelUp = StringGrid1MouseWheelUp
    OnSelectCell = StringGrid1SelectCell
  end
  object TreeView1: TTreeView
    Left = 694
    Top = 68
    Width = 190
    Height = 470
    Anchors = [akLeft, akTop, akRight, akBottom]
    HideSelection = False
    Indent = 19
    ReadOnly = True
    TabOrder = 1
    OnChange = TreeView1Change
    OnEnter = TreeView1Enter
    Items.NodeData = {
      0301000000320000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      0000000000010A4C006F006100640069006E0067002E002E002E00}
  end
  object collapse: TButton
    Left = 826
    Top = 40
    Width = 57
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'Collapse'
    TabOrder = 2
    OnClick = collapseClick
  end
  object Button5: TButton
    Left = 763
    Top = 40
    Width = 57
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'Find'
    TabOrder = 3
    OnClick = Button5Click
  end
  object gval: TEdit
    Left = 726
    Top = 26
    Width = 29
    Height = 21
    MaxLength = 3
    TabOrder = 4
    Text = '0'
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 487
    Top = 72
  end
  object MainMenu1: TMainMenu
    Left = 431
    Top = 72
    object File1: TMenuItem
      Caption = 'File'
      object Import1: TMenuItem
        Caption = 'Import'
        OnClick = Import1Click
      end
      object Export1: TMenuItem
        Caption = 'Export'
        OnClick = Export1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Apply1: TMenuItem
        Caption = 'Apply'
        OnClick = Apply1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Cancel1: TMenuItem
        Caption = 'Cancel'
        OnClick = Cancel1Click
      end
    end
    object asks1: TMenuItem
      Caption = 'Tasks'
      object RemoveItems1: TMenuItem
        Caption = 'Remove items'
        OnClick = RemoveItems1Click
      end
      object Remove1: TMenuItem
        Caption = 'Remove terrain'
        OnClick = Remove1Click
      end
      object Removeweeds1: TMenuItem
        Caption = 'Remove weeds'
        OnClick = Removeweeds1Click
      end
      object Reviveflowers1: TMenuItem
        Caption = 'Revive flowers'
        OnClick = Reviveflowers1Click
      end
      object Replenishfruit1: TMenuItem
        Caption = 'Replenish fruit'
        OnClick = Replenishfruit1Click
      end
      object Restoregrass1: TMenuItem
        Caption = 'Restore grass'
        OnClick = Restoregrass1Click
      end
      object Removegrass1: TMenuItem
        Caption = 'Remove grass'
        OnClick = Removegrass1Click
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object Showacregrid1: TMenuItem
        Caption = 'Show acre grid'
        Checked = True
        ShortCut = 16449
        OnClick = Showacregrid1Click
      end
      object Showbackground1: TMenuItem
        Caption = 'Show background'
        Checked = True
        ShortCut = 16450
        OnClick = Showbackground1Click
      end
      object Showitemsterrain1: TMenuItem
        Caption = 'Show items && terrain'
        Checked = True
        ShortCut = 16457
        OnClick = Showitemsterrain1Click
      end
      object Showgrass1: TMenuItem
        Caption = 'Show grass'
        Checked = True
        ShortCut = 16455
        OnClick = Showgrass1Click
      end
      object ShowHint1: TMenuItem
        Caption = 'Show item names on grid'
        Checked = True
        ShortCut = 16462
        OnClick = ShowHint1Click
      end
    end
  end
end
