object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'ACToolkit v1.3'
  ClientHeight = 196
  ClientWidth = 244
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  ScreenSnap = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object playerGroup: TGroupBox
    Left = 8
    Top = 8
    Width = 228
    Height = 121
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 21
      Width = 34
      Height = 13
      Caption = 'Wallet:'
    end
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 24
      Height = 13
      Caption = 'ABD:'
    end
    object Label3: TLabel
      Left = 8
      Top = 59
      Width = 33
      Height = 13
      Caption = 'Points:'
    end
    object walletLabel: TLabel
      Left = 74
      Top = 21
      Width = 4
      Height = 13
      Caption = '-'
    end
    object abdLabel: TLabel
      Left = 74
      Top = 40
      Width = 4
      Height = 13
      Caption = '-'
    end
    object pointLabel: TLabel
      Left = 74
      Top = 59
      Width = 4
      Height = 13
      Caption = '-'
    end
    object Label4: TLabel
      Left = 8
      Top = 77
      Width = 59
      Height = 13
      Caption = 'Town name:'
    end
    object townLabel: TLabel
      Left = 74
      Top = 78
      Width = 4
      Height = 13
      Caption = '-'
    end
    object Label6: TLabel
      Left = 8
      Top = 96
      Width = 55
      Height = 13
      Caption = 'Town fund:'
    end
    object donationlabel: TLabel
      Left = 74
      Top = 96
      Width = 4
      Height = 13
      Caption = '-'
    end
    object MaxWallet: TButton
      Left = 180
      Top = 20
      Width = 41
      Height = 17
      Caption = 'Set'
      TabOrder = 0
      OnClick = MaxWalletClick
    end
    object MaxABD: TButton
      Left = 180
      Top = 39
      Width = 41
      Height = 17
      Caption = 'Set'
      TabOrder = 1
      OnClick = MaxABDClick
    end
    object MaxPoints: TButton
      Left = 180
      Top = 58
      Width = 41
      Height = 17
      Caption = 'Set'
      TabOrder = 2
      OnClick = MaxPointsClick
    end
    object Button5: TButton
      Left = 180
      Top = 96
      Width = 41
      Height = 16
      Caption = 'Set'
      TabOrder = 3
      Visible = False
      OnClick = Button5Click
    end
  end
  object Button4: TButton
    Left = 8
    Top = 135
    Width = 111
    Height = 25
    Caption = 'Pockets'
    TabOrder = 1
    OnClick = Button4Click
  end
  object Button6: TButton
    Left = 125
    Top = 135
    Width = 111
    Height = 25
    Caption = 'Emotions'
    TabOrder = 2
    OnClick = Button6Click
  end
  object Button1: TButton
    Left = 125
    Top = 166
    Width = 111
    Height = 25
    Caption = 'Appearance'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 166
    Width = 111
    Height = 25
    Caption = 'Drawers'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 188
    Top = 85
    Width = 41
    Height = 16
    Caption = 'Set'
    TabOrder = 5
    OnClick = Button3Click
  end
  object MainMenu1: TMainMenu
    Left = 104
    Top = 56
    object File1: TMenuItem
      Caption = 'File'
      object Open1: TMenuItem
        Caption = 'Open...'
        OnClick = Open1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        OnClick = Save1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Player1: TMenuItem
      Caption = 'Residents'
      object Player11: TMenuItem
        Caption = 'Resident 1'
        Checked = True
        RadioItem = True
        OnClick = Player11Click
      end
      object Player21: TMenuItem
        Caption = 'Resident 2'
        RadioItem = True
        OnClick = Player21Click
      end
      object Player31: TMenuItem
        Caption = 'Resident 3'
        RadioItem = True
        OnClick = Player31Click
      end
      object Player41: TMenuItem
        Caption = 'Resident 4'
        RadioItem = True
        OnClick = Player41Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object ChangeName1: TMenuItem
        Caption = 'Resident'#39's Name'
        OnClick = ChangeName1Click
      end
      object Fillout1: TMenuItem
        Caption = 'Fill out...'
        object Catalog1: TMenuItem
          Caption = 'Catalog'
          OnClick = Catalog1Click
        end
        object Music1: TMenuItem
          Caption = 'Music'
          OnClick = Music1Click
        end
      end
    end
    object own1: TMenuItem
      Caption = 'Town'
      object ViewMap1: TMenuItem
        Caption = 'View Town Map'
        OnClick = ViewMap1Click
      end
      object GateS1: TMenuItem
        Caption = 'Gate Style'
        OnClick = GateS1Click
        object Stone1: TMenuItem
          Caption = 'Stone'
          RadioItem = True
          OnClick = Stone1Click
        end
        object Wood1: TMenuItem
          Caption = 'Wood'
          RadioItem = True
          OnClick = Wood1Click
        end
        object Brick1: TMenuItem
          Caption = 'Brick'
          RadioItem = True
          OnClick = Brick1Click
        end
      end
      object ChangeStyle1: TMenuItem
        Caption = 'Grass Style'
        OnClick = ChangeStyle1Click
        object Style11: TMenuItem
          Caption = 'Style 1'
          RadioItem = True
          OnClick = Style11Click
        end
        object Style21: TMenuItem
          Caption = 'Style 2'
          RadioItem = True
          OnClick = Style21Click
        end
        object Style31: TMenuItem
          Caption = 'Style 3'
          RadioItem = True
          OnClick = Style31Click
        end
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object AcreEditor1: TMenuItem
        Caption = 'Edit Acres'
        OnClick = AcreEditor1Click
      end
      object Town1: TMenuItem
        Caption = 'Edit Town'
        OnClick = Town1Click
      end
      object EditHouse1: TMenuItem
        Caption = 'Edit House'
        object A1: TMenuItem
          Caption = 'House A'
          OnClick = A1Click
        end
        object B1: TMenuItem
          Caption = 'House B'
          OnClick = B1Click
        end
        object C1: TMenuItem
          Caption = 'House C'
          OnClick = C1Click
        end
        object D1: TMenuItem
          Caption = 'House D'
          OnClick = D1Click
        end
      end
      object LostFound1: TMenuItem
        Caption = 'Edit Lost && Found'
        OnClick = LostFound1Click
      end
      object RecycleBin1: TMenuItem
        Caption = 'Edit Recycle Bin'
        OnClick = RecycleBin1Click
      end
      object Nooks1: TMenuItem
        Caption = 'Nook'#39's Store'
        object NooksItems1: TMenuItem
          Caption = 'Edit Items'
          OnClick = NooksItems1Click
        end
        object Clearsoldoutflags1: TMenuItem
          Caption = 'Clear sold out flags'
          OnClick = Clearsoldoutflags1Click
        end
        object N3: TMenuItem
          Caption = '-'
        end
        object NooksCranny1: TMenuItem
          Caption = 'Nook'#39's Cranny'
          RadioItem = True
          OnClick = NooksCranny1Click
        end
        object NookNGo1: TMenuItem
          Caption = 'Nook '#39'n'#39' Go'
          RadioItem = True
          OnClick = NookNGo1Click
        end
        object Nookway1: TMenuItem
          Caption = 'Nook Way'
          RadioItem = True
          OnClick = Nookway1Click
        end
        object Nookingtons1: TMenuItem
          Caption = 'Nookingtons'
          RadioItem = True
          OnClick = Nookingtons1Click
        end
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Settings1: TMenuItem
        Caption = 'Colors'
        OnClick = Settings1Click
      end
      object ChangeLanguage1: TMenuItem
        Caption = 'Language'
        Enabled = False
        Visible = False
      end
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
    end
  end
end
