unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, TownEditor, About, pockets, global, emotions, face,
  acres, map, house, settings, wait;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    Town1: TMenuItem;
    playerGroup: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MaxWallet: TButton;
    MaxABD: TButton;
    MaxPoints: TButton;
    Button4: TButton;
    Button6: TButton;
    walletLabel: TLabel;
    abdLabel: TLabel;
    pointLabel: TLabel;
    Player1: TMenuItem;
    Player11: TMenuItem;
    Player21: TMenuItem;
    Player31: TMenuItem;
    Player41: TMenuItem;
    Button1: TButton;
    own1: TMenuItem;
    GateS1: TMenuItem;
    Label4: TLabel;
    townLabel: TLabel;
    Button2: TButton;
    LostFound1: TMenuItem;
    RecycleBin1: TMenuItem;
    N2: TMenuItem;
    NooksItems1: TMenuItem;
    Nooks1: TMenuItem;
    Clearsoldoutflags1: TMenuItem;
    AcreEditor1: TMenuItem;
    ViewMap1: TMenuItem;
    ChangeStyle1: TMenuItem;
    Settings1: TMenuItem;
    EditHouse1: TMenuItem;
    A1: TMenuItem;
    B1: TMenuItem;
    C1: TMenuItem;
    D1: TMenuItem;
    Button3: TButton;
    N4: TMenuItem;
    ChangeName1: TMenuItem;
    ChangeLanguage1: TMenuItem;
    Fillout1: TMenuItem;
    Catalog1: TMenuItem;
    Music1: TMenuItem;
    Label6: TLabel;
    donationlabel: TLabel;
    Button5: TButton;
    N3: TMenuItem;
    NooksCranny1: TMenuItem;
    NookNGo1: TMenuItem;
    Nookway1: TMenuItem;
    Nookingtons1: TMenuItem;
    Style11: TMenuItem;
    Style21: TMenuItem;
    Style31: TMenuItem;
    Stone1: TMenuItem;
    Wood1: TMenuItem;
    Brick1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Town1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure MaxWalletClick(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button6Click(Sender: TObject);
    procedure MaxABDClick(Sender: TObject);
    procedure Player21Click(Sender: TObject);
    procedure Player11Click(Sender: TObject);
    procedure Player31Click(Sender: TObject);
    procedure Player41Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure MaxPointsClick(Sender: TObject);
    procedure GateS1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure LostFound1Click(Sender: TObject);
    procedure RecycleBin1Click(Sender: TObject);
    procedure NooksItems1Click(Sender: TObject);
    procedure Clearsoldoutflags1Click(Sender: TObject);
    procedure AcreEditor1Click(Sender: TObject);
    procedure ViewMap1Click(Sender: TObject);
    procedure ChangeStyle1Click(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure B1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ChangeName1Click(Sender: TObject);
    //procedure ChangeLanguage1Click(Sender: TObject);
    procedure Music1Click(Sender: TObject);
    procedure Catalog1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure NooksCranny1Click(Sender: TObject);
    procedure NookNGo1Click(Sender: TObject);
    procedure Nookway1Click(Sender: TObject);
    procedure Nookingtons1Click(Sender: TObject);
    procedure Style11Click(Sender: TObject);
    procedure Style21Click(Sender: TObject);
    procedure Style31Click(Sender: TObject);
    procedure Stone1Click(Sender: TObject);
    procedure Wood1Click(Sender: TObject);
    procedure Brick1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ReadPlayerStats();
    procedure ReadMisc();
    procedure ChangePlayer(index: Integer);
    procedure SwitchLang_Spanish();
  end;

  procedure UpdateTownName(c_id: word; special: byte; c_name: Array of WideChar; n_name: WideString);
  procedure UpdatePlayerName(c_id: word; special: byte; c_tname: Array of WideChar; c_pname: Array of WideChar; n_name: WideString);
  procedure SwitchLang(l: byte);
 // procedure ChangeStore(style: Byte);
  procedure ChangeStyle(styleid: Byte; style: Byte);
  function CatalogTotal(rangeStart: ULong; rangeEnd: ULong): Integer;
  procedure FillCatalog(rangeStart: ulong; rangeEnd: ULOng);

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$WARN SYMBOL_PLATFORM OFF}

procedure TForm1.A1Click(Sender: TObject);
var
  dialog: TForm11;
begin
  imode := 0;
  dialog := TForm11.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TForm1.About1Click(Sender: TObject);
var
  dialog: TAboutWin;
begin
  dialog := TAboutWin.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TForm1.MaxABDClick(Sender: TObject);
var
  Buffer: ULong;
  bells: string;
begin
  try
    if InputQuery('Set ABD','Type the number of Bells you want.', bells) then
    begin
      bells := Trim(StringReplace(bells, ',', '',[rfReplaceAll, rfIgnoreCase]));
      bells := StringReplace(bells, '-', '',[rfReplaceAll, rfIgnoreCase]);
      if StrToInt(bells) <= 999999999 then
      begin
        FS.Seek($115C + Player_Offset,0);
        buffer := Reverse(StrToInt(bells));
        FS.WriteBuffer(buffer,sizeof(buffer));
      end
      else
      MessageBox(Handle,'Number must be between 0 and 999,999,999','Error',MB_ICONERROR);
    end;
  except
  end;
  cm := true;
  ReadPlayerStats;
end;

procedure TForm1.MaxWalletClick(Sender: TObject);
var
  Buffer: ULong;
  bells: string;
begin
  try
    if InputQuery('Set Wallet','Type the number of Bells you want.', bells) then
    begin
      bells := Trim(StringReplace(bells, ',', '',[rfReplaceAll, rfIgnoreCase]));
      bells := StringReplace(bells, '-', '',[rfReplaceAll, rfIgnoreCase]);
      if StrToInt(bells) <= 99999 then
      begin
        FS.Seek($1154 + Player_Offset,0);
        buffer := Reverse(StrToInt(bells));
        FS.WriteBuffer(buffer,sizeof(buffer));
      end
      else
      MessageBox(Handle,'Number must be between 0 and 99,999','Error',MB_ICONERROR);
    end;
  except
  end;
  cm := true;
  ReadPlayerStats;
end;

procedure TForm1.MaxPointsClick(Sender: TObject);
var
  buffer,buffer2: word;
  points: string;
begin
  try
    if InputQuery('Set Points','Type the number of points you want.', points) then
    begin
      points := Trim(StringReplace(points, ',', '',[rfReplaceAll, rfIgnoreCase]));
      points := StringReplace(points, '-', '',[rfReplaceAll, rfIgnoreCase]);
      if StrToInt(points) <= $FFFF then
      begin
        FS.Seek($7FC0 + Player_Offset,0);
        buffer := ReverseW(StrToInt(points));
        FS.WriteBuffer(buffer,sizeof(buffer));
        FS.Seek($7FC4 + Player_Offset,0);
        FS.ReadBuffer(buffer2, sizeof(buffer2));
        FS.Position := FS.Position - 2;
        if buffer > buffer2 then
        FS.WriteBuffer(buffer,sizeof(buffer));
      end
      else
      MessageBox(Handle,'Number must be between 0 and 65,535','Error',MB_ICONERROR);
    end;
  except
  end;
  cm := true;
  ReadPlayerStats;
end;


procedure TForm1.Settings1Click(Sender: TObject);
var
  dialog: TForm10;
begin
  dialog := TForm10.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TForm1.Stone1Click(Sender: TObject);
begin
  Stone1.Checked := true;
  ChangeStyle(2,0);
end;

procedure TForm1.Style11Click(Sender: TObject);
begin
  Style11.Checked := true;
  ChangeStyle(1,0);
end;

procedure TForm1.Style21Click(Sender: TObject);
begin
  Style21.Checked := true;
  ChangeStyle(1,1);
end;

procedure TForm1.Style31Click(Sender: TObject);
begin
  Style31.Checked := true;
  ChangeStyle(1,2);
end;

procedure TForm1.AcreEditor1Click(Sender: TObject);
var
  dialog: TForm2;
begin
  dialog := TForm2.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TForm1.B1Click(Sender: TObject);
var
  dialog: TForm11;
begin
  imode := 1;
  dialog := TForm11.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TForm1.Brick1Click(Sender: TObject);
begin
  Brick1.Checked := true;
  ChangeStyle(2,2);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  dialog: TForm5;
begin
  dialog := TForm5.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TForm1.Nookingtons1Click(Sender: TObject);
begin
  Nookingtons1.Checked := true;
  ChangeStyle(0,3);
end;

procedure TForm1.Nookway1Click(Sender: TObject);
begin
  Nookway1.Checked := true;
  ChangeStyle(0,2);
end;

procedure TForm1.NookNGo1Click(Sender: TObject);
begin
  NookNGo1.Checked := true;
  ChangeStyle(0,1);
end;

procedure TForm1.NooksCranny1Click(Sender: TObject);
begin
  NooksCranny1.Checked := true;
  ChangeStyle(0,0);
end;

procedure TForm1.NooksItems1Click(Sender: TObject);
var
  dialog: TForm4;
begin
  imode := 4;
  dialog := TForm4.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  dialog: TForm4;
begin
  imode := 1;
  dialog := TForm4.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  c_id: word;
  c_name: Array[0..7] of WideChar;
  n_name: WideString;
  special: byte;
  dialog: TForm14;
begin
  SetLength(n_name,8);
  FS.Seek($7EE2 + Player_Offset, 0);
  FS.ReadBuffer(c_id,sizeof(c_id));
  FS.ReadBuffer(c_name,sizeof(c_name));
  FS.Seek($7EF6 + Player_Offset, 0);
  FS.ReadBuffer(special,sizeof(special));
  n_name := InputBox('Town Name','Type a new town name.',GetString(c_name));
  if n_name <> GetString(c_name) then
  if length(n_name) <= 8 then
  if Length(n_name) >= 4  then
  begin
    dialog := TForm14.Create(nil);
    dialog.Show;
    dialog.Refresh;
    UpdateTownName(c_id,special,c_name,n_name);
    dialog.Free;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  dialog: TForm4;
begin
  imode := 0; //Set Inventory editor mode to 0 (pockets)
  dialog := TForm4.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TForm1.Button5Click(Sender: TObject);
{var
  Buffer: ULong;
  bells: string; }
begin
  {try
    if InputQuery('Set Donations','Type the amount of bells to have been donated.', bells) then
    begin
      bells := Trim(StringReplace(bells, ',', '',[rfReplaceAll, rfIgnoreCase]));
      bells := StringReplace(bells, '-', '',[rfReplaceAll, rfIgnoreCase]);
      if StrToInt(bells) <= 999999999 then
      begin
        FS.Seek($5EC7C,0);
        buffer := Reverse(StrToInt(bells));
        FS.WriteBuffer(buffer,sizeof(buffer));
      end
      else
      MessageBox(Handle,'Number must be between 0 and 999,999,999','Error',MB_ICONERROR);
    end;
  except
  end;
  cm := true;
  ReadPlayerStats;     }
end;

procedure TForm1.C1Click(Sender: TObject);
var
  dialog: TForm11;
begin
  imode := 2;
  dialog := TForm11.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;


procedure TForm1.Music1Click(Sender: TObject);
var
  C: Integer;
begin
  {Music is oddly placed in the "catalog area" of the save file.
  So, we have to use different item codes to get the correct result.}
  C := CatalogTotal($D000,$D138);
  if MessageBox(Handle,PChar('Current music: ' + IntToStr(C) + '/78'#13#10#13#10 + 'Fill in?'),'Music',MB_ICONQUESTION or MB_YESNO) = IDNO then
  Exit;
  FillCatalog($D000,$D138);
  cm := true;
end;


function CatalogTotal(rangeStart: ULong; rangeEnd: ULong): Integer;
var
  Offset: ULong;
  I,total: Integer;
  buffer,C: byte;
begin
  Result := 0;
  total := (rangeEnd - rangeStart) div 4;
  for I := 0 to total - 1 do
  begin
    offset := $841A + Player_Offset + (((rangeStart - $9000) div 4) shr 3);
    FS.Seek(Offset,0);
    FS.ReadBuffer(buffer,sizeof(buffer));
    C := (1 shl ((((rangeStart - $9000) div 4) and $F) mod 8));

    if buffer and C = C then
    Result := Result + 1;

    rangeStart := rangeStart + 4;
  end;
end;

procedure FillCatalog(rangeStart: ULong; rangeEnd: ULong);
var
  offset: ULong;
  I,total: Integer;
  buffer: byte;
begin
  total := (rangeEnd - rangeStart) div 4;
  for I := 0 to total - 1 do
  begin
    offset := $841A + Player_Offset + (((rangeStart - $9000) div 4) shr 3);
    FS.Seek(offset,0);
    FS.ReadBuffer(buffer,sizeof(buffer));

    buffer := buffer or (1 shl ((((rangeStart - $9000) div 4) and $F) mod 8));
   // ShowMessage(IntToHex(offset,4) + #13#10 + IntToHex(buffer,2) + ' : ' + IntToHex(buffer2,2) + #13#10 + IntToHex(rangeStart,4));

    FS.Position := FS.Position - 1;
    FS.WriteBuffer(buffer,sizeof(buffer));
    rangeStart := rangeStart + 4;
  end;
end;

procedure TForm1.Catalog1Click(Sender: TObject);
var
  S,W,F,C,U,H,G,Fo,Fu: Integer;
begin
  Fu := CatalogTotal($B710,$C248); //Furniture
  S := CatalogTotal($9640,$974C);  //Paper, 1 is not dispalyed.
  W := CatalogTotal($9FA0,$A100);  //Wallpaper, 3 are not displayed.
  F := CatalogTotal($A2C0,$A418);  //Flooring, 3 are not displayed.
  C := CatalogTotal($A518,$AA80);  //Clothes
  U := CatalogTotal($AA90,$AB18);  //Umbrella
  H := CatalogTotal($AC20,$AD5C);  //Headgear (hats)
  H := H + CatalogTotal($ADB0,$AE7C);  //Headgear (hats)
  H := H + CatalogTotal($AF40,$AFFC);  //Headgear (glasses)
  G := CatalogTotal($B3F0,$B5EC);  //Gyroids
  Fo := CatalogTotal($CC28,$CD10); //Fossils

  Beep;
  if MessageBox(Handle,PChar('Current catalog:'#13#10 +
  'Furniture: ' + IntToStr(Fu) + '/718'#13#10 +
  'Wallpaper: ' + IntToStr(W) + '/88'#13#10 +
  'Flooring: ' + IntToStr(F) + '/86'#13#10 +
  'Clothes: ' + IntToStr(C) + '/346'#13#10 +
  'Umbrella: ' + IntToStr(U) + '/34'#13#10 +
  'Headgear: ' + IntToStr(H) + '/177'#13#10 +
  'Stationery: ' + IntToStr(S) + '/67'#13#10 +
  'Gyroids: ' + IntToStr(G) + '/127'#13#10 +
  'Fossils: ' + IntToStr(Fo) + '/58'#13#10#13#10 +
  'Fill in?'),'Catalog',MB_ICONQUESTION or MB_YESNO) = IDNO then
  Exit;

  FillCatalog($B710,$C248);  //Furniture
  FillCatalog($9640,$9750);  //Paper
  FillCatalog($9FA0,$A10C);  //Wallpaper
  FillCatalog($A2C0,$A424);  //Flooring
  FillCatalog($A518,$AA80);  //Clothes
  FillCatalog($AA90,$AB18);  //Umbrella
  FillCatalog($AC20,$AD5C);  //Headgear (hats)
  FillCatalog($ADB0,$AE7C);  //Headgear (hats)
  FillCatalog($AF40,$AFFC);  //Headgear (glasses)
  FillCatalog($B3F0,$B5EC);  //Gyroids
  FillCatalog($CC28,$CD10);  //Fossils

  cm := true;
end;

{procedure TForm1.ChangeLanguage1Click(Sender: TObject);
var
  dialog: TForm13;
begin
  dialog := TForm13.Create(nil);
  dialog.ShowModal;
  dialog.Free;
  SwitchLang(lang);
end;      }

procedure TForm1.ChangeName1Click(Sender: TObject);
var
  c_id: word;
  c_tname: Array[0..7] of WideChar;
  c_pname: Array[0..7] of WideChar;
  special: byte;
  n_name: WideString;
  dialog: TForm14;
begin
  FS.Seek($7EF6 + Player_Offset, 0);
  FS.ReadBuffer(special,sizeof(special));
  FS.Seek($7EE2 + Player_Offset, 0);
  FS.ReadBuffer(c_id,sizeof(c_id));
  FS.ReadBuffer(c_tname,sizeof(c_tname));
  FS.Seek($7EFA + Player_Offset, 0);
  FS.ReadBuffer(c_pname,sizeof(c_pname));

  n_name := InputBox('Resident''s Name','Type a new name.',GetString(c_pname));
  if n_name <> GetString(c_pname) then
  if length(n_name) <= 8 then
  if Length(n_name) >= 4  then
  begin
    dialog := TForm14.Create(nil);
    dialog.Show;
    dialog.Refresh;
    UpdatePlayerName(c_id,special,c_tname,c_pname,n_name);
    dialog.Free;
  end;
end;

procedure TForm1.ChangePlayer(index: Integer);
begin
  //playergroup.Caption := 'Resident ' + IntToStr(index);
  player := index;
  index := index - 1;
  Player_Offset := $86C0 * index;
  ReadPlayerStats();
end;

procedure TForm1.ChangeStyle1Click(Sender: TObject);
  //dialog: TForm8;
begin
  //dialog := TForm8.Create(nil);
  //dialog.ShowModal;
  //dialog.Free;
end;


procedure TForm1.Clearsoldoutflags1Click(Sender: TObject);
var
  I: Integer;
  buffer: byte;
begin
  buffer := 0;
  FS.Seek($630CA,0);
  for I := 0 to 36 - 1 do
  begin
    FS.WriteBuffer(buffer,sizeof(buffer));
    FS.Position := FS.Position + 3;
  end;
  cm := true;
  MessageBox(Handle,'Sold out flags cleared!','Info',MB_ICONINFORMATION);
end;

procedure TForm1.D1Click(Sender: TObject);
var
  dialog: TForm11;
begin
  imode := 3;
  dialog := TForm11.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  dialog: TForm3;
begin
  dialog := TForm3.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CleanUp(false);
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  id: integer;
begin
  if cm = true then
  begin
    id := MessageBox(Handle,'Exit?'#13#10 + 'Any unsaved changes will be lost.','Exit',MB_YESNO or MB_ICONWARNING);
    case id of
      idYes:
        CanClose := true;
      idNo:
        CanClose := false;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  ReadPlayerStats;
  ReadMisc;
  ReadDLC;
  ReadSettings;
  for I := 1 to ParamCount do
  if Lowercase(ParamStr(I)) = '-l' then
  begin
    try
      lang := StrToInt(ParamStr(I+1));
      if lang > 8 then
      lang := 0;
    except
      lang := 0;
    end;
  end;
  //SwitchLang(lang);
end;

procedure TForm1.GateS1Click(Sender: TObject);
  //dialog: TForm7;
begin
  //dialog := TForm7.Create(nil);
  //dialog.ShowModal;
  //dialog.Free;
end;

procedure TForm1.LostFound1Click(Sender: TObject);
var
  dialog: TForm4;
begin
  imode := 2; //Set Inventory editor mode to 2 (lost & found)
  dialog := TForm4.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TForm1.RecycleBin1Click(Sender: TObject);
var
  dialog: TForm4;
begin
  imode := 3; //Set Inventory editor mode to 3 (recycle bin)
  dialog := TForm4.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  if OpenFile then
  begin
    Player11.Checked := true;
    ChangePlayer(player);
    ReadDLC;
    if CheckTheSums = false then
    MessageBox(Handle, chkerror2, 'Warning', MB_ICONWARNING);
  end;
end;

procedure TForm1.Player11Click(Sender: TObject);
begin
  Player11.Checked := true;
  ChangePlayer(1);
end;

procedure TForm1.Player21Click(Sender: TObject);
begin
  Player21.Checked := true;
  ChangePlayer(2);
end;

procedure TForm1.Player31Click(Sender: TObject);
begin
  Player31.Checked := true;
  ChangePlayer(3);
end;

procedure TForm1.Player41Click(Sender: TObject);
begin
  Player41.Checked := true;
  ChangePlayer(4);
end;

procedure TForm1.Town1Click(Sender: TObject);
var
  dialog: TTownEditorWin;
begin
  dialog := TTownEditorWin.Create(nil);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TForm1.ViewMap1Click(Sender: TObject);
var
  dialog: TForm6;
begin
  dialog := TForm6.Create(nil);
  dialog.Show;
end;

procedure TForm1.Wood1Click(Sender: TObject);
begin
  Wood1.Checked := true;
  ChangeStyle(2,1);
end;

{function GetByte(offset: ulong): byte;
begin
  if offset mod 2 = 1 then
  result := data[trunc(extended(offset/2))] shr 8
  else
  result := data[trunc(extended(offset/2))] and $FF;
end; }

Procedure TForm1.ReadPlayerStats();
var
  Buffer: ULong;
  BufferS: Array[0..7] of WideChar;
  BufferW: word;
begin
  FS.Seek($1154 + Player_Offset, 0);
  FS.ReadBuffer(buffer, sizeof(buffer));
  walletLabel.Caption := IntToStr(Reverse(buffer)) + ' Bells';
  FS.Seek($115C + Player_Offset, 0);
  FS.ReadBuffer(buffer, sizeof(buffer));
  abdLabel.Caption := IntToStr(Reverse(buffer)) + ' Bells';
  FS.Seek($7FC0 + Player_Offset, 0);
  FS.ReadBuffer(BufferW,sizeof(BufferW));
  pointLabel.Caption := IntToStr(ReverseW(bufferW));
  FS.Seek($7EE4 + Player_Offset, 0);
  FS.Read(BufferS,sizeof(BufferS));
  townLabel.Caption := GetString(BufferS);
  FS.Seek($7EFA + Player_Offset, 0);
  FS.Read(BufferS,sizeof(BufferS));
  playerGroup.Caption := 'Resident ' + IntToStr(Player) +
  ' (' + GetString(BufferS) + ')';
  FS.Seek($5EC7C,0);
  FS.ReadBuffer(buffer, sizeof(buffer));
  donationLabel.Caption := IntToStr(Reverse(buffer)) + ' Bells';
end;

procedure UpdateTownName(c_id: word; special: byte; c_name: Array of WideChar; n_name: WideString);
var
  buffer: word;
  bufferS: Array[0..8] of WideChar;  //Read extra 0000
  I,C: Integer;
begin
  FS.Seek($1140,0);
  C := 0;
  while FS.Position < $20F320 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    if c_id = buffer then
    begin
      FS.ReadBuffer(bufferS,sizeof(bufferS));
      FS.ReadBuffer(buffer,sizeof(buffer));
      if buffer = special then
      if GetString(BufferS) = GetString(c_name) then
      begin
        FS.Position := FS.Position - 20;
        for I := 1 to 8 do
        begin
          buffer := ReverseW(word(n_name[I]));
          if length(n_name) < I then
          buffer := 0;
          FS.WriteBuffer(buffer,sizeof(buffer));
        end;
        C := C + 1;
      end;
    end;
  end;
  cm := true;
  Form1.ReadPlayerStats;
  MessageBox(Form1.Handle,PWideChar('Replaced ' + IntToStr(C) + ' strings.'),'Info',MB_ICONINFORMATION);
end;

procedure UpdatePlayerName(c_id: word; special: byte; c_tname: Array of WideChar; c_pname: Array of WideChar; n_name: WideString);
var
  buffer: word;
  bufferS: Array[0..8] of WideChar;  //Read extra 0000
  I,C: Integer;
begin
  FS.Seek($1140,0);
  C := 0;
  while FS.Position < $20F320 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    if c_id = buffer then
    begin
      FS.ReadBuffer(bufferS,sizeof(bufferS));
      FS.ReadBuffer(buffer,sizeof(buffer));
      if buffer = special then
      if GetString(BufferS) = GetString(c_tname) then
      begin
        FS.Position := FS.Position + 2;
        FS.ReadBuffer(bufferS,sizeof(bufferS));
        if GetString(BufferS) = GetString(c_pname) then
        begin
          FS.Position := FS.Position - 18;
          for I := 1 to 8 do
          begin
            buffer := ReverseW(word(n_name[I]));
            if length(n_name) < I then
            buffer := 0;
            FS.WriteBuffer(buffer,sizeof(buffer));
          end;
          C := C + 1;
        end;
      end;
    end;
  end;
  cm := true;
  Form1.ReadPlayerStats;
  MessageBox(Form1.Handle,PWideChar('Replaced ' + IntToStr(C) + ' strings.'),'Info',MB_ICONINFORMATION);
end;

procedure TForm1.Save1Click(Sender: TObject);
var
  input: Integer;
begin
  Beep;
  input := MessageBox(Handle,'Save changes?'#13#10 +
  'Make sure you have a backup in a safe place!','Save',MB_YESNO or MB_ICONQUESTION);
  if input = IdYes then
  begin
    try
      UpdateCRC_ALL;
      FS.Free;
      if CopyFile(PWideChar(filepath),PWideChar(filepathO),false) then
      begin
        if FileGetAttr(filepathO) and faHidden = faHidden then
        FileSetAttr(filepathO, FileGetAttr(filepathO) xor faHidden);
        FS := TFileStream.Create(filepath, fmOpenReadWrite);
        cm := false;
        MessageBox(Handle,'File was saved successfully.', 'Saved',MB_ICONINFORMATION);
      end
      else begin
        FS := TFileStream.Create(filepath, fmOpenReadWrite);
        Messagebox(Handle,'Unable to save!  Make sure the file is not in-use by another process.','Error',MB_ICONERROR);
      end;
    except
      CleanUp(true);
    end;
  end;
end;


procedure TForm1.ReadMisc();
var
 buffer: Byte;
begin
  FS.Seek($630C3,0);
  FS.ReadBuffer(buffer,sizeof(buffer));
  case buffer of
    1,5: NookNGo1.Checked := true;
    2,6: Nookway1.Checked := true;
    3,7: Nookingtons1.Checked := true;
    else NooksCranny1.Checked := true;
  end;

 FS.Seek($6D5B7,0);
 FS.ReadBuffer(buffer,sizeof(buffer));
 case buffer of
   0: Style11.Checked := true;
   1: Style21.Checked := true;
   2: Style31.Checked := true;
   else Style11.Checked := true;
 end;

 FS.Seek($5EAE0,0);
 FS.ReadBuffer(buffer,sizeof(buffer));
 case buffer of
   0: Stone1.Checked := true;
   1: Wood1.Checked := true;
   2: Brick1.Checked := true;
   else Stone1.Checked := true;
 end;


end;

procedure SwitchLang(l: Byte);
begin
  case l of
    1: Form1.SwitchLang_Spanish;
    4: Form1.SwitchLang_Spanish;
  end;
end;

procedure ChangeStyle(styleid: Byte; style: Byte);
begin
  case styleid of
    0:begin //nooks
      FS.Seek($630C3,0);
      FS.WriteBuffer(style,sizeof(style));
      FS.Position := FS.Position + 3;
    end;
    1:begin  //grass
      FS.Seek($6D5B7,0);
    end;
    2:begin //gate
      FS.Seek($5EAE0,0);
    end;
  end;
  FS.WriteBuffer(style,sizeof(style));
  cm := true;
end;

{procedure ChangeStore(style: Byte);
begin
  FS.Seek($630C3,0);
  FS.WriteBuffer(style,sizeof(style));
  FS.Seek($630C7,0);
  FS.WriteBuffer(style,sizeof(style));
end;    }

procedure TForm1.SwitchLang_Spanish();
begin
 { label1.Caption := 'Monedero:';
  label2.Caption := 'Banco:';
  label3.Caption := 'Puntos:';
  label4.Caption := 'Pueblo:';
  walletlabel.Left := walletlabel.Left + 15;
  abdlabel.Left := walletlabel.Left;
  pointlabel.Left := walletlabel.Left;
  townlabel.Left := walletlabel.Left;

  Button1.Caption := 'Apariencia';
  Button6.Caption := 'Emociones';
  Button4.Caption := 'Bolsillo';
  Button2.Caption := 'Armarios';

  File1.Caption := 'Archivo';
  Open1.Caption := 'Abrir';
  Save1.Caption := 'Guardar';
  Exit1.Caption := 'Salir';

  player1.Caption := 'Residentes';
  player11.Caption := 'Residente 1';
  player21.Caption := 'Residente 2';
  player31.Caption := 'Residente 3';
  player41.Caption := 'Residente 4';

  own1.Caption := 'Pueblo';

  help1.Caption := 'Ayuda';      }


end;

end.
