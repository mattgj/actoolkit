object Form6: TForm6
  Left = 0
  Top = 0
  AlphaBlend = True
  BorderStyle = bsNone
  Caption = 'Town Map'
  ClientHeight = 370
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ScreenSnap = True
  SnapBuffer = 20
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 318
    Height = 318
    BevelEdges = []
    BorderStyle = bsNone
    ColCount = 7
    Constraints.MaxHeight = 740
    Constraints.MaxWidth = 740
    DefaultColWidth = 44
    DefaultRowHeight = 44
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 7
    FixedRows = 0
    GridLineWidth = 0
    Options = [goVertLine, goHorzLine]
    ScrollBars = ssNone
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnMouseDown = StringGrid1MouseDown
    OnMouseEnter = StringGrid1MouseEnter
  end
  object PopupMenu1: TPopupMenu
    Left = 80
    Top = 48
    object Refresh1: TMenuItem
      Caption = 'Refresh'
      OnClick = Refresh1Click
    end
    object Save1: TMenuItem
      Caption = 'Save'
      OnClick = Save1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Close1: TMenuItem
      Caption = 'Close'
      OnClick = Close1Click
    end
  end
end
