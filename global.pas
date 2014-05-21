unit global;

interface

Uses
  Windows, Forms, Graphics, SysUtils, ComCtrls, classes, CRC32, Dialogs,
  iniFiles, StrUtils, items;

function OpenFile: boolean;
procedure LoadItems(Tree: TTreeView; Normal: boolean; Terrain: boolean; Acres: boolean);
procedure AddItem(Tree: TTreeView;i_array: Array of TItem; Parent: TTreeNode; name: string);
procedure CleanUp(Terminate: boolean);
procedure UpdateCRC_ALL;
procedure ReadSettings();
procedure WriteSettings();
procedure ReadDLC();
function CheckTheSums(): boolean;
function UpdateCRC_A(write: boolean): ULong;  //General player data
function UpdateCRC_B(write: boolean): ULong;  //Town data
function UpdateCRC_C(write: boolean): ULong;  //Building coordinate data
function UpdateCRC_D(write: boolean): ULong;  //More player data, includes storage
//function UpdateCRC_DLC(write: boolean): ULong;
function FindItemString(Tree: TTreeView; Name: String): boolean;
function ItemSearch(code: String): String;
function QuickFindItem(code: word; itemArray: Array of TItem): String;
function GetItemName(itemArray: TItem): String;
function FindItem(Tree: TTreeView; code: String): String;
function GetColor(code: String): TColor;
function Reverse(code: ULong): Ulong;
function ReverseW(code: word): word;
function GetString(buffer: Array of WideChar): String;

var
  player_offset: ulong;
  player,imode,lang: byte;
  cm,dlc: boolean;
  filepath, filepathO, prevname: String;
  FS: TFileStream;
  treec,flowerc,flower2c,weedc,itemc,item2c,patternc,rockc,otherc,gridc,
  buildingc, buriedc: TColor;

const
  hlmsg1: String = 'Click to see what item is there.';
  hlmsg2: String = 'Nothing selected.';
  hlmsg3: String = 'Click to see what building is there.';
  hlmsg4: String = 'Click to delete an item.';
  hlmsg5: String = 'This item is: ';
  hlmsg6: String = 'This building is: ';
  hlmsg7: String = 'Click to place ';
  hlmsg8: String = 'Click to see what acre is there.';
  hlmsg9: String = 'This acre is: ';
  hlmsg10: String = 'Click to bury/unbury an item.';
  hlmsg11: String = 'Click to delete a building. (DANGEROUS)';
  hlmsg12: String = 'Click to check the grass quality.';
  hlmsg13: String = 'Click to set the grass quality. The higher the number, the better.';
  chkerror: PWideChar = 'Checksums are invalid! Continue anyway?';
  chkerror2: PWideChar = 'Checksums are invalid!';
  nofind: PWideChar = 'Item not found!';

implementation

{$WARN SYMBOL_PLATFORM OFF}

Uses
  Main;

function OpenFile: boolean;
var
  C: Integer;
  OpenDialog: TOpenDialog;
  temp1,temp2: String;
  FS2: TFileStream;
begin
  result := false;
  OpenDialog := TOpenDialog.Create(nil);
  OpenDialog.FileName := 'RVFOREST.DAT';
  OpenDialog.DefaultExt := '*.dat';
  OpenDialog.Filter := 'Animal Crossing Save File (*.dat)|*.dat';
  OpenDialog.Options := [ofPathMustExist, ofFileMustExist, ofHideReadOnly];
  C := 1;
  if OpenDialog.Execute(GetDesktopWindow) then
  begin
    temp1 := OpenDialog.FileName;
    try
      temp2 := ExtractFilePath(ParamStr(0))+ '~save.tmp';
      while Fileexists(temp2) do
      begin
        temp2 := ExtractFilePath(ParamStr(0))+ '~save.tmp' + IntToStr(C);
        C := C + 1;
      end;
      try
        FS2 := TFileStream.Create(temp1, fmOpenRead);
      except
        MessageBox(Application.Handle,'Unable to access the file! Make sure it''s not in-use by another process.','Error',MB_ICONERROR);
        Exit;
      end;
      if FS2.Size <> $40F340 then
      begin
        FS2.Free;
        MessageBox(Application.Handle,'Invalid file!','Error',MB_ICONERROR);
        Exit;
      end;
      FS2.Free;
      if Length(filepath) > 0 then
      begin
        FS.Free;
        DeleteFile(filepath);
      end;
      filepathO := temp1;
      filepath := temp2;
      CopyFile(PWideChar(filepathO), PWideChar(filepath), false);

      if FileGetAttr(filepath) and faHidden = 0 then
      FileSetAttr(filepath, FileGetAttr(filepath) or faHidden);

      FS := TFileStream.Create(filepath, fmOpenReadWrite);
      cm := false;
      player := 1;
      player_offset := 0;
      Result := true;
    except
      //Result := false;
    end;
  end
  else begin
  //
  end;
  OpenDialog.Free;
end;

procedure ReadSettings();
var
  config: TiniFile;
begin
  try
    config := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    //lang := config.ReadInteger('settings','lang',0);
    treec := config.ReadInteger('colors','trees',$00FF00);
    flowerc := config.ReadInteger('colors','flowers',$9933FF);
    flower2c := config.ReadInteger('colors','flowers2',$CC6699);
    weedc := config.ReadInteger('colors','weeds',$0086CE);
    itemc := config.ReadInteger('colors','items',$00FFFF);
    item2c := config.ReadInteger('colors','items2',$FFFF00);
    patternc := config.ReadInteger('colors','patterns',$AADDFF);
    rockc := config.ReadInteger('colors','rocks',$000000);
    otherc := config.ReadInteger('colors','other',$170580);
    gridc := config.ReadInteger('colors','grid',$FF0000);
    buildingc := config.ReadInteger('colors','building',$FFFFFF);
    buriedc := config.ReadInteger('colors','buried',$0000FF);

    config.Free;
  except
  end;
end;

procedure WriteSettings();
var
  config: TiniFile;
begin
  try
    config := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    //config.WriteInteger('settings','lang',lang);
    config.WriteInteger('colors','trees',treec);
    config.WriteInteger('colors','flowers',flowerc);
    config.WriteInteger('colors','flowers2',flower2c);
    config.WriteInteger('colors','weeds',weedc);
    config.WriteInteger('colors','items',itemc);
    config.WriteInteger('colors','items2',item2c);
    config.WriteInteger('colors','patterns',patternc);
    config.WriteInteger('colors','rocks',rockc);
    config.WriteInteger('colors','other',otherc);
    config.WriteInteger('colors','grid',gridc);
    config.WriteInteger('colors','building',buildingc);
    config.WriteInteger('colors','buried',buriedc);
    config.Free;
  except
  end;
end;

procedure ReadDLC();
var
  buffer: ulong;
  bufferW: word;
  bufferS: Array[0..$10] of WideChar;
  I,L: Integer;
begin
  dlc := false;
  FS.Seek($20F324,0);
  for I := 0 to 255 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    if reverse(buffer) = $4249544D then
    begin
      FS.Position := FS.Position + $C;
      FS.ReadBuffer(bufferW,sizeof(bufferW));
      if reverseW(bufferW) = $1701 then
      begin
        FS.Position := FS.Position - $A;
        FS.ReadBuffer(bufferW,sizeof(bufferW));
        i_dlc[I].code := (ReverseW(bufferW) * 4) + $9000;
        FS.Position := FS.Position + 8;
        for L := 0 to 8 do
        begin
          FS.ReadBuffer(bufferS,sizeof(bufferS));
          case L of
            0: i_dlc[I].NameJA := GetString(bufferS);
            1: i_dlc[I].NameEA := GetString(bufferS);
            2: i_dlc[I].NameSA := GetString(bufferS);
            3: i_dlc[I].NameFC := GetString(bufferS);
            4: i_dlc[I].NameEU := GetString(bufferS);
            5: i_dlc[I].NameGE := GetString(bufferS);
            6: i_dlc[I].NameIT := GetString(bufferS);
            7: i_dlc[I].NameSE := GetString(bufferS);
            8: i_dlc[I].NameFE := GetString(bufferS);
          end;
        end;
        dlc := true;
      end;
    end;
    FS.Position := $20F324 + ($2000 * (I + 1));
  end;
end;

function GetColor(code: String): TColor;
begin

  result := otherc; //default to dark red (building color)

  if StrToInt(code) >= $9000 then //Items
  if StrToInt(code) <= $B2E4 then
  Result := itemc;

  if StrToInt(code) >= $CE80 then //Equipment
  if StrToInt(code) <= $CF54 then
  Result := itemc;

  if StrToInt(code) >= $B2E5 then //Furniature
  if StrToInt(code) <= $CE50 then
  Result := item2c;

  if StrToInt(code) >= $009E then //Flowers
  if StrToInt(code) <= $00BD then
  Result := flowerc;

  if StrToInt(code) >= $0057 then //Weeds
  if StrToInt(code) <= $005A then
  Result := weedc;

  if StrToInt(code) >= $00DE then //dandilions
  if StrToInt(code) <= $00DF then
  Result := weedc;

  if StrToInt(code) >= $00E0 then //clovers
  if StrToInt(code) <= $00E1 then
  Result := weedc;

  if StrToInt(code) >= $0001 then //Trees
  if StrToInt(code) <= $0056 then
  Result := treec;

  if StrToInt(code) >= $00BE then //Parched flowers
  if StrToInt(code) <= $00DD then
  Result := flower2c;

  if StrToInt(code) >= $0074 then //Patterns
  if StrToInt(code) <= $0093 then
  Result := patternc;
 // Result := RGB($FF,$99,$66);


  if StrToInt(code) >= $005B then //Rocks
  if StrToInt(code) <= $0073 then
  Result := rockc;

end;

function FindItemString(Tree: TTreeView; Name: String): boolean;
var
  I: Integer;
begin
  Result := false;
  if Tree.Selected = nil then
  Tree.Items[0].Selected := true;
  for I := Tree.Selected.AbsoluteIndex + 1 to Tree.Items.Count - 1 do
  begin
    if AnsiContainsStr(Lowercase(Tree.Items[I].Text),Lowercase(name)) then
    if Tree.Items[I].Parent <> nil then
    if Tree.Items[I].Parent.Parent <> nil then
    begin
      Tree.Items[I].Selected := true;
      Result := true;
      Exit;
    end;
  end;
end;

function ItemSearch(code: String): String;
var
  hex: word;
  I: Integer;
begin
  hex := StrToInt(code);
 if hex = $FFF1 then
  begin
    Result := 'none';
    Exit;
  end
  else if hex = $D000 then
  begin
    Result := 'Sign';
    Exit;
  end
  else if hex = $7003 then
  begin
    Result := 'Bus Stop';
    Exit;
  end
  else if hex = $F030 then
  begin
    Result := 'used space';
    Exit;
  end
  else if hex = $7000 then
  begin
    Result := 'Snowman 1';
    Exit;
  end
  else if hex = $7001 then
  begin
    Result := 'Snowman 2';
    Exit;
  end
  else if hex = $7002 then
  begin
    Result := 'Snowman 3';
    Exit;
  end;
  if hex < $9000 then
  begin
    for I := 0 to 7 do
    begin
    case I of
      0:Result := QuickFindItem(hex,t_flowers);
      1:Result := QuickFindItem(hex,t_flowers2);
      2:Result := QuickFindItem(hex,t_misc);
      3:Result := QuickFindItem(hex,t_patterns);
      4:Result := QuickFindItem(hex,t_rocks);
      5:Result := QuickFindItem(hex,t_trees);
      6:Result := QuickFindItem(hex,t_turnips);
      7:Result := QuickFindItem(hex,t_weeds);
    end;
    if Result <> '' then
    Break;
    end;
  end;

  if Result = '' then
  if hex < $B3F0 then
  begin
    for I := 0 to 15 do
    begin
    case I of
      0:Result := QuickFindItem(hex,i_bells);
      1:Result := QuickFindItem(hex,i_insects);
      2:Result := QuickFindItem(hex,i_fish);
      3:Result := QuickFindItem(hex,i_flooring);
      4:Result := QuickFindItem(hex,i_flowers);
      5:Result := QuickFindItem(hex,i_flowerbags);
      6:Result := QuickFindItem(hex,i_fruits);
      7:Result := QuickFindItem(hex,i_glasses);
      8:Result := QuickFindItem(hex,i_hats);
      9:Result := QuickFindItem(hex,i_songs);
      10:Result := QuickFindItem(hex,i_mushrooms);
      11:Result := QuickFindItem(hex,i_paper);
      12:Result := QuickFindItem(hex,i_seashells);
      13:Result := QuickFindItem(hex,i_shirts);
      14:Result := QuickFindItem(hex,i_umbrellas);
      15:Result := QuickFindItem(hex,i_wallpaper);
    end;
    if Result <> '' then
    Break;
    end;
  end;

  if Result = '' then
  begin
    for I := 0 to 21 do
    begin
    case I of
      0:Result := QuickFindItem(hex,i_equipment);
      1:Result := QuickFindItem(hex,i_dlc);
      2:Result := QuickFindItem(hex,i_series);
      3:Result := QuickFindItem(hex,i_boxing);
      4:Result := QuickFindItem(hex,i_classroom);
      5:Result := QuickFindItem(hex,i_construction);
      6:Result := QuickFindItem(hex,i_lab);
      7:Result := QuickFindItem(hex,i_mario);
      8:Result := QuickFindItem(hex,i_garden);
      9:Result := QuickFindItem(hex,i_nursery);
      10:Result := QuickFindItem(hex,i_ship);
      11:Result := QuickFindItem(hex,i_space);
      12:Result := QuickFindItem(hex,i_western);
      13:Result := QuickFindItem(hex,i_other1);
      14:Result := QuickFindItem(hex,i_other2);
      15:Result := QuickFindItem(hex,i_other3);
      16:Result := QuickFindItem(hex,i_nintendo);
      17:Result := QuickFindItem(hex,i_gyroids);
      18:Result := QuickFindItem(hex,i_fossils);
      19:Result := QuickFindItem(hex,i_paintings);
      20:Result := QuickFindItem(hex,i_plants);
      21:Result := QuickFindItem(hex,i_notused);
    end;
    if Result <> '' then
    Break;
    end;
  end;

end;

function QuickFindItem(code: word; itemArray: Array of TItem): String;
var
  I: Integer;
begin
  for I := Low(itemArray) to high(itemArray) do
  begin
    if itemArray[I].code = code then
    begin
      if code >= $9000 then
      case lang of
        0: Result := itemArray[I].NameEA;
        1: Result := itemArray[I].NameSA;
        2: Result := itemArray[I].NameFC;
        3: Result := itemArray[I].NameEU;
        4: Result := itemArray[I].NameSE;
        5: Result := itemArray[I].NameFE;
        6: Result := itemArray[I].NameIT;
        7: Result := itemArray[I].NameGE;
        8: Result := itemArray[I].NameJA;
      end
      else Result := itemArray[I].NameEA;

    end;
  end;
end;

function GetItemName(itemArray: TItem): String;
begin
  case lang of
    0: Result := itemArray.NameEA;
    1: Result := itemArray.NameSA;
    2: Result := itemArray.NameFC;
    3: Result := itemArray.NameEU;
    4: Result := itemArray.NameGE;
    5: Result := itemArray.NameIT;
    6: Result := itemArray.NameSE;
    7: Result := itemArray.NameFE;
    8: Result := itemArray.NameJA;
  end;
end;

function FindItem(Tree: TTreeView; code: String): String;
var
  tnode,snode: TTreeNode;
  found: Boolean;
  hex: word;
  I: Integer;
begin
  hex := StrToInt(code);
  if hex = $FFF1 then
  begin
    Result := 'none';
    Exit;
  end
  else if hex = $D000 then
  begin
    Result := 'Sign' + '. Signs can only be moved by using the building controls.';
    Exit;
  end
  else if hex = $7003 then
  begin
    Result := 'Bus Stop' + '. The Bus Stop can only be moved by using the building controls.';
    Exit;
  end
  else if hex = $F030 then
  begin
    Result := 'used space';
    Exit;
  end
  else if hex = $7000 then
  begin
    Result := 'Snowman 1';
    Exit;
  end
  else if hex = $7001 then
  begin
    Result := 'Snowman 2';
    Exit;
  end
  else if hex = $7002 then
  begin
    Result := 'Snowman 3';
    Exit;
  end;

  found := false;
  tnode := Tree.Items.GetFirstNode;
  tnode := tnode.getFirstChild;
  snode := tnode.getFirstChild;
  while tnode <> nil do
  begin
    while snode <> nil do
    begin
      if snode.Parent <> nil then
      if snode.Parent.Parent <> nil then
      if hex = snode.SelectedIndex then
      found := true
      else
      if snode.Parent.Parent.Text <> 'Terrain' then
      if snode.Parent.Parent.Text <> 'Acres' then
      begin
        //Paper loop
      {  if hex >= $9640 then
        if hex <= $974F then
        if snode.Parent.Text = 'Paper' then
        begin
          pnode := snode.getNextSibling;
          for I := 0 to 2 do
          begin
            if hex = pnode.SelectedIndex then
            begin
              found := true;
              snode := pnode;
              break;
            end;
            if pnode.getNextSibling <> nil then
            pnode := pnode.GetNextSibling;
          end;
        end;

        if found = false then      }
        if hex >= snode.SelectedIndex then
        if hex < snode.SelectedIndex + 4 then
        begin

          if snode.GetNextsibling <> nil then
          if snode.getNextSibling.SelectedIndex > snode.SelectedIndex then
          if snode.getNextSibling.SelectedIndex < snode.SelectedIndex + 4 then
          begin
            for I := 0 to 2 do
            begin
              if snode.SelectedIndex = hex then
              break
              else if snode.GetNextsibling <> nil then
              snode := snode.getNextSibling;
            end;
          end;

          found := true;

        end;

      end;

      if found = true then
      begin
        Result := snode.Text;
        Tree.Selected := snode;
        Tree.SetFocus;
        exit;
      end;

      snode := snode.GetNext;
    end;
    tnode := tnode.GetNext;
  end;

  if snode = nil then
  begin
    Result := 'Unknown';
  end;

end;

procedure LoadItems(Tree: TTreeView; Normal: boolean; Terrain: boolean; Acres: boolean);
var
  pnode: TTreeNode;
  tlang: byte;
begin
  if Acres then
  begin
    tlang := lang;
    lang := 0;
    pnode := Tree.Items.AddChild(nil,'Acres');
    AddItem(Tree,a_barrier,pnode,'Barrier');
    AddItem(Tree,a_normal,pnode,'Normal');
    AddItem(Tree,a_ocean,pnode,'Oceanfront');
    AddItem(Tree,a_river,pnode,'River');
    AddItem(Tree,a_transition,pnode,'Transition');
    lang := tlang;
  end;

  if Terrain then
  begin
    tlang := lang;
    lang := 0;
    pnode := Tree.Items.AddChild(nil,'Terrain');
    AddItem(Tree,t_flowers,pnode,'Flowers');
    AddItem(Tree,t_flowers2,pnode,'Flowers (parched)');
    AddItem(Tree,t_misc,pnode,'Misc.');
    AddItem(Tree,t_patterns,pnode,'Patterns');
    AddItem(Tree,t_rocks,pnode,'Rocks');
    AddItem(Tree,t_trees,pnode,'Trees');
    AddItem(Tree,t_turnips,pnode,'Turnips');
    AddItem(Tree,t_weeds,pnode,'Weeds');
    lang := tlang;
  end;

  if Normal then
  begin
    pnode := Tree.Items.AddChild(nil,'Items');
    AddItem(Tree,i_bells,pnode,'Bell Bags');
    AddItem(Tree,i_equipment,pnode,'Equipment');
    AddItem(Tree,i_fish,pnode,'Fish');
    AddItem(Tree,i_flooring,pnode,'Flooring');
    AddItem(Tree,i_flowers,pnode,'Flowers');
    AddItem(Tree,i_flowerbags,pnode,'Flower Bags');
    AddItem(Tree,i_fruits,pnode,'Fruits, Misc.');
    AddItem(Tree,i_glasses,pnode,'Glasses');
    AddItem(Tree,i_hats,pnode,'Hats');
    AddItem(Tree,i_insects,pnode,'Insects');
    AddItem(Tree,i_songs,pnode,'K.K. Songs');
    AddItem(Tree,i_mushrooms,pnode,'Mushrooms');
    AddItem(Tree,i_paper,pnode,'Paper');
    AddItem(Tree,i_seashells,pnode,'Seashells');
    AddItem(Tree,i_shirts,pnode,'Shirts');
    AddItem(Tree,i_umbrellas,pnode,'Umbrellas');
    AddItem(Tree,i_wallpaper,pnode,'Wallpaper');

    if dlc then
    AddItem(Tree,i_dlc,pnode,'Downloaded Content');

    pnode := Tree.Items.AddChild(nil,'Furniture');
    AddItem(Tree,i_series,pnode,'Series');
    AddItem(Tree,i_boxing,pnode,'Boxing Theme');
    AddItem(Tree,i_classroom,pnode,'Classroom Theme');
    AddItem(Tree,i_construction,pnode,'Construction Theme');
    AddItem(Tree,i_lab,pnode,'Mad Scientist Theme');
    AddItem(Tree,i_mario,pnode,'Mario Theme');
    AddItem(Tree,i_garden,pnode,'Mossy Garden Theme');
    AddItem(Tree,i_nursery,pnode,'Nursery Theme');
    AddItem(Tree,i_ship,pnode,'Pirate Ship Theme');
    AddItem(Tree,i_space,pnode,'Space Theme');
    AddItem(Tree,i_western,pnode,'Western Theme');
    AddItem(Tree,i_other1,pnode,'Other Sets 1');
    AddItem(Tree,i_other2,pnode,'Other Sets 2');
    AddItem(Tree,i_other3,pnode,'Other Sets 3');
    AddItem(Tree,i_nintendo,pnode,'Nintendo Items');
    AddItem(Tree,i_gyroids,pnode,'Gyroids');
    AddItem(Tree,i_fossils,pnode,'Fossils');
    AddItem(Tree,i_paintings,pnode,'Paintings');
    AddItem(Tree,i_plants,pnode,'Plants');
    AddItem(Tree,i_notused,pnode,'Not Used Items');
  end;


end;

procedure AddItem(Tree: TTreeView;i_array: Array of TItem; Parent: TTreeNode; name: string);
var
  snode,cnode: TTreeNode;
  I: Integer;
begin
  cnode := Tree.Items.AddChild(parent,name);
  for I := 0 to length(i_array) - 1 do
  begin
    if i_array[I].code <> 0 then
    begin
    case lang of
        1: snode := Tree.Items.AddChild(cnode,i_array[I].NameSA);
        2: snode := Tree.Items.AddChild(cnode,i_array[I].NameFC);
        3: snode := Tree.Items.AddChild(cnode,i_array[I].NameEU);
        4: snode := Tree.Items.AddChild(cnode,i_array[I].NameSE);
        5: snode := Tree.Items.AddChild(cnode,i_array[I].NameFE);
        6: snode := Tree.Items.AddChild(cnode,i_array[I].NameIT);
        7: snode := Tree.Items.AddChild(cnode,i_array[I].NameGE);
        8: snode := Tree.Items.AddChild(cnode,i_array[I].NameJA);
        else
        snode := Tree.Items.AddChild(cnode,i_array[I].NameEA);
    end;
      snode.SelectedIndex := i_array[I].code;
    end;
  end;
end;

{procedure LoadItems(Tree: TTreeView; Special: boolean; Acres: boolean);
var
  cnode, inode, tnode, snode: IXMLNode;
  parentNode,subParent, anode: TTreeNode;
begin
  Form1.xmldoc.Active := true;
  cnode := Form1.xmldoc.ChildNodes.FindNode('items');
  cnode := cnode.ChildNodes.FindNode('cat');
  if acres = false then
  cnode := cnode.NextSibling; //skips acres
  if special = false then
  cnode := cnode.NextSibling; //skips terrain items
  repeat
    parentNode := Tree.Items.AddChild(nil, cnode.ChildNodes['name'].Text);
    snode := cnode.ChildNodes.FindNode('sub');
    inode := snode.ChildNodes.FindNode('item');
  while snode <> nil do
  begin
    subParent := Tree.Items.AddChild(ParentNode, snode.ChildNodes['name'].Text);
    inode := snode.ChildNodes.FindNode('item');
    while inode <> nil do
    begin
      tnode := inode.ChildNodes['name'];
      anode := Tree.Items.AddChild(subParent, tnode.Text);
      anode.SelectedIndex := StrToInt('$' + tnode.NextSibling.Text);
      inode := inode.NextSibling;
    end;
    snode := snode.NextSibling;
  end;
    if acres = false then
    cnode := cnode.NextSibling
    else
    Break;
  until cnode = nil;
  Form1.xmldoc.Active := false;
end;  }

function Reverse(code: ULong): Ulong;
begin
  Result := swap(code shr 16) or (ulong(swap(code and $ffff)) shl 16);
end;

function ReverseW(code: word): word;
begin
 // a := (code shr 8);
 // b := (code and $FF);
  result := Swap(code);
end;

function CheckTheSums(): boolean;
var
  buffer,pcrc: ulong;
  I: Integer;
begin
  Result := true;

  for I := 0 to 3 do
  begin
    Player_Offset := $86C0 * I;
    FS.Seek($1140 + Player_Offset,0);
    FS.ReadBuffer(pcrc,sizeof(pcrc));
    pcrc := Reverse(pcrc);
    buffer := UpdateCRC_A(false);
    if buffer = $E4A45761 then
    begin
      case I of
        0:
          Form1.Player11.Enabled := false;
        1:
          Form1.Player21.Enabled := false;
        2:
          Form1.Player31.Enabled := false;
        3:
          Form1.Player41.Enabled := false;
      end;
    end
    else
    case I of
      0:
        Form1.Player11.Enabled := true;
      1:
        Form1.Player21.Enabled := true;
      2:
        Form1.Player31.Enabled := true;
      3:
        Form1.Player41.Enabled := true;
    end;

    if Form1.Player11.Enabled = false then   //Just in case player 1 does not exist.
    begin
      if Form1.player21.Enabled = true then
      begin
       Player := 2;
       Form1.Player21.Checked := true;
      end
      else if Form1.player31.Enabled = true then
      begin
       Player := 3;
       Form1.Player31.Checked := true;
      end
      else if Form1.player41.Enabled = true then
      begin
       Player := 4;
       Form1.Player41.Checked := true;
      end;
    end;
    if pcrc <> buffer then
    result := false;
  end;


  Player_Offset := (Player - 1) * $86C0;
  Form1.ReadPlayerStats;

  FS.Seek($5EC60,0);
  FS.Read(buffer,sizeof(buffer));
  if UpdateCRC_B(false) <> Reverse(buffer) then
  Result := false;

  FS.Seek($5EB04,0);
  FS.Read(buffer,sizeof(buffer));
  if UpdateCRC_C(false) <> Reverse(buffer) then
  Result := false;

  FS.Seek($73600,0);
  FS.Read(buffer,sizeof(buffer));
  if UpdateCRC_D(false) <> Reverse(buffer) then
  Result := false;
end;

function UpdateCRC_A(write: boolean): ULong;
var
  CRC: ULong;
begin

  CRC := Reverse(CRC32Stream(FS, $1144 + Player_Offset, $86E0 + Player_Offset, $FFFFFFFF));
  if write = true then
  begin
    FS.Seek($1140 + Player_Offset,0);
    FS.WriteBuffer(CRC,sizeof(CRC));
  end;
  Result := Reverse(CRC);
end;

procedure UpdateCRC_ALL;
var
  I: Integer;
begin
  for I := 0 to 3 do
  begin
    Player_Offset := $86C0 * I;
    UpdateCRC_A(true);
  end;
  Player_Offset := (Player - 1) * $86C0;
  UpdateCRC_B(true);
  UpdateCRC_C(true);
  UpdateCRC_D(true);
 // UpdateCRC_DLC(true);
end;


function UpdateCRC_B(write: boolean): ULong;
var
  CRC: ULong;
begin
  CRC := Reverse(CRC32Stream(FS, $5EC64, $735E0, $FFFFFFFF));
  if write = true then
  begin
    FS.Seek($5EC60,0);
    FS.WriteBuffer(CRC,sizeof(CRC));
  end;
  Result := Reverse(CRC);
end;

function UpdateCRC_C(write: boolean): ULong;
var
  CRC: ULong;
begin
  CRC := Reverse(CRC32Stream(FS, $5EB08, $5EC5A, $12141018));
  if write = true then
  begin
    FS.Seek($5EB04,0);
    FS.WriteBuffer(CRC,sizeof(CRC));
  end;
  Result := Reverse(CRC);
end;


function UpdateCRC_D(write: boolean): ULong;
var
  CRC: ULong;
begin
  CRC := Reverse(CRC32Stream(FS, $73604, $20F320, $FFFFFFFF));
  if write = true then
  begin
    FS.Seek($73600,0);
    FS.WriteBuffer(CRC,sizeof(CRC));
  end;
  Result := Reverse(CRC);
end;


{function UpdateCRC_DLC(write: boolean): ULong;
var
  CRC: ULong;
begin
  CRC := Reverse(CRC32Stream(FS, $20F324, $40F324, $04201018));
  if write = true then
  begin
    FS.Seek($20F320,0);
    FS.WriteBuffer(CRC,sizeof(CRC));
  end;
  Result := Reverse(CRC);
end;}


procedure CleanUp(Terminate: boolean);
begin
  try
    FS.Free;
    DeleteFile(filepath);
    if Terminate = true then
    Application.Terminate;
  except
  end;
end;

function GetString(buffer: Array of WideChar): String;
var
  I: Integer;
  str: String;
begin
  str := '';
  for I := 0 to Length(buffer) - 1 do
  begin
    if Word(buffer[I]) = 0 then
    Break;
    str := str + String(WideChar(Swap(Word(buffer[I]))));
  end;
    Result := str;
end;


end.
