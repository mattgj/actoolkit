{

  *********************************************
  * Town Editor code by Virus                 *
  * Copyright (C) 2008-2009 Game-Hackers.com  *
  * All rights reserved.                      *
  *********************************************

}

unit towneditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Buttons, StdCtrls, ComCtrls, global, ExtCtrls, Types, find,
  building, Menus;

type
  TTownEditorWin = class(TForm)
    StringGrid1: TStringGrid;
    check: TSpeedButton;
    replace: TSpeedButton;
    delete: TSpeedButton;
    SpeedButton1: TSpeedButton;
    TreeView1: TTreeView;
    bcheck: TSpeedButton;
    bmove: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    collapse: TButton;
    Timer1: TTimer;
    coords: TSpeedButton;
    hexlabel: TLabel;
    Label3: TLabel;
    buryitem: TSpeedButton;
    Button5: TButton;
    bplace: TSpeedButton;
    bdelete: TSpeedButton;
    Label4: TLabel;
    gcheck: TSpeedButton;
    gset: TSpeedButton;
    gval: TEdit;
    MainMenu1: TMainMenu;
    Apply1: TMenuItem;
    Cancel1: TMenuItem;
    asks1: TMenuItem;
    View1: TMenuItem;
    RemoveItems1: TMenuItem;
    Remove1: TMenuItem;
    Removeweeds1: TMenuItem;
    Reviveflowers1: TMenuItem;
    Replenishfruit1: TMenuItem;
    Restoregrass1: TMenuItem;
    Removegrass1: TMenuItem;
    Showbackground1: TMenuItem;
    Showacregrid1: TMenuItem;
    Showgrass1: TMenuItem;
    Import1: TMenuItem;
    Export1: TMenuItem;
    Label5: TLabel;
    Showitemsterrain1: TMenuItem;
    File1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    ShowHint1: TMenuItem;
    procedure cancelClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure replaceClick(Sender: TObject);
    procedure backdropClick(Sender: TObject);
    procedure TreeView1Enter(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure deleteClick(Sender: TObject);
    procedure bcheckClick(Sender: TObject);
    procedure bmoveClick(Sender: TObject);
    procedure collapseClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure checkClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure buryitemClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure bplaceClick(Sender: TObject);
    procedure bdeleteClick(Sender: TObject);
    procedure exportClick(Sender: TObject);
    procedure showgrassClick(Sender: TObject);
    procedure Showgrass1Click(Sender: TObject);
    procedure Showacregrid1Click(Sender: TObject);
    procedure Showbackground1Click(Sender: TObject);
    procedure RemoveItems1Click(Sender: TObject);
    procedure Remove1Click(Sender: TObject);
    procedure Removeweeds1Click(Sender: TObject);
    procedure Reviveflowers1Click(Sender: TObject);
    procedure Replenishfruit1Click(Sender: TObject);
    procedure Restoregrass1Click(Sender: TObject);
    procedure Removegrass1Click(Sender: TObject);
    procedure Import1Click(Sender: TObject);
    procedure Export1Click(Sender: TObject);
    procedure Cancel1Click(Sender: TObject);
    procedure Apply1Click(Sender: TObject);
    procedure gcheckClick(Sender: TObject);
    procedure gsetClick(Sender: TObject);
    procedure Showitemsterrain1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShowHint1Click(Sender: TObject);
  private
    { Private declarations }
    procedure OnIdle(Sender: TObject; var Done: Boolean);
  public
    { Public declarations }
    procedure UpdateUsed(buildingID: Byte);
    procedure DrawGrid;
  end;

  function GetBuilding(bID: byte): String;
  function IsBuried(ACol: Integer; ARow: Integer; Acre: Integer): boolean;
  procedure ApplyBury(ACol: Integer; ARow: Integer; Acre: Integer);

var
  TownEditorWin: TTownEditorWin;
  Acres: Array[0..24] of Word;                //Acre layout
  G: Array[0..79] of Array[0..79] of Byte;    //Grass
  B: Array[0..34] of Array[0..1] of Byte;     //Building coordinate array
  B2: Array[0..99] of Array[0..1] of Byte;    //Sign coordinate array
  BE: Array[0..34] of Boolean;                //Building exists (non-zero coordinates) array
  BE2: Array[0..99] of Boolean;               //Sign exists
  Buried: Array[0..399] of word;              //Buried items
  Old: Array[0..0] of Array[0..1] of Byte;    //Stores old grid coordinate of a building
  Used: Array[0..296] of Array[0..1] of Byte; //Stores used building areas
  bID: byte = $FF;                            //Building ID. Used to identify building's name.
  pb: byte;                                   //Place building
  //boot: boolean;                              //if true, the acre grid will not automatically draw.
  drawUsed: boolean;                          //Can used spaces be drawn.
  fc: TColor;
  bmp: TBitmap;
  OldB: Word;
  oldP: TPoint;

implementation

{$R *.dfm}
//{$R ACREBMP.RES}

procedure TTownEditorWin.OnIdle(Sender: TObject; var Done: Boolean);
begin
  DrawGrid;
end;


procedure TTownEditorWin.Apply1Click(Sender: TObject);
var
  A,X,Y,X2,Y2: Integer;
  buffer: Word;
  bufferB: byte;
begin

  FS.Seek($68476, 0);

  for A := 0 to 25 - 1 do
  for Y := 0 to 16 - 1 do
  for X := 0 to 16 - 1 do
  begin
    buffer := ReverseW(StrToInt(stringGrid1.Cells[X + (A mod 5) * 16, Y + trunc(extended(A / 5)) * 16]));
    FS.WriteBuffer(buffer,sizeof(buffer));
  end;

  FS.Seek($6BCB6,0);

  for A := 0 to 25 - 1 do       //save grass
  for Y2 := 0 to 3 do
  for X2 := 0 to 1 do
  for Y := 0 to 4 - 1 do
  for X := 0 to 8 - 1 do
  begin
    bufferB := G[(X+(X2*8)) + ((A mod 5) * 16),(Y+(Y2*4)) + ((A div 5) * 16)];
    FS.WriteBuffer(bufferB,sizeof(bufferB));
  end;

 FS.Seek($5EB0A,0);
 for X := 0 to 32 do
 for Y := 0 to 1 do
 begin
   bufferB := B[X,Y];
   FS.WriteBuffer(bufferB, sizeof(bufferB))
 end;

 FS.Seek($5EB90,0);
 for Y := 0 to 1 do
 begin
   bufferB := B[33,Y];
   FS.WriteBuffer(bufferB, sizeof(bufferB))
 end;

 FS.Seek($5EB8A,0);
 for Y := 0 to 1 do
 begin
   bufferB := B[34,Y];
   FS.WriteBuffer(bufferB, sizeof(bufferB))
 end;

 FS.Seek($5EB92,0);
 for X := 0 to 99 do
 for Y := 0 to 1 do
 begin
   bufferB := B2[X,Y];
   FS.WriteBuffer(bufferB,sizeof(bufferB))
 end;

 FS.Seek($6B676,0);
 for X := 0 to 399 do
 begin
   buffer := ReverseW(Buried[X]);
   FS.WriteBuffer(buffer,sizeof(buffer));;
 end;

 cm := true;
 Close;
end;

procedure TTownEditorWin.backdropClick(Sender: TObject);
begin
//  boot := true;
  StringGrid1.Refresh;
 // DrawGrid;
 // boot := false;
end;

procedure TTownEditorWin.bcheckClick(Sender: TObject);
begin
  hexlabel.Caption := hlmsg3;
  bID := $FF;
end;

procedure TTownEditorWin.bdeleteClick(Sender: TObject);
begin
  hexlabel.Caption := hlmsg11;
end;

procedure TTownEditorWin.bmoveClick(Sender: TObject);
begin
  if bID <> $FF then
  hexlabel.Caption := 'Click to move ' + GetBuilding(bID)
  else
  hexlabel.Caption := hlmsg2;
end;

procedure TTownEditorWin.buryitemClick(Sender: TObject);
begin
  hexlabel.Caption := hlmsg10;
end;

procedure TTownEditorWin.collapseClick(Sender: TObject);
begin
  TreeView1.FullCollapse;
  TreeView1.Items[0].Selected := true;
  Check.Down := true;
  hexlabel.Caption := hlmsg1;
  bID := $FF;
end;

procedure TTownEditorWin.Button5Click(Sender: TObject);
var
  Dialog: TForm12;
begin
  dialog := TForm12.Create(self);
  Dialog.ShowModal;
  if Dialog.ModalResult = mrOk then
  begin
    if FindItemString(TreeView1,prevname) = false then
    MessageBox(Handle,nofind,'Info',MB_ICONINFORMATION);
  end;
  Dialog.Free;
end;

procedure TTownEditorWin.Cancel1Click(Sender: TObject);
begin
  Close;
end;

procedure TTownEditorWin.cancelClick(Sender: TObject);
begin
  Close;
end;

procedure TTownEditorWin.checkClick(Sender: TObject);
begin
  hexlabel.Caption := hlmsg1;
end;

procedure TTownEditorWin.deleteClick(Sender: TObject);
begin
  hexlabel.Caption := hlmsg4;
end;


procedure TTownEditorWin.Remove1Click(Sender: TObject);
var
  X,Y,C: Integer;
  r,f,t,p: boolean;
begin
  C := 0;
  r := false; f := false; t := false; p := false;
  if MessageBox(Handle,'Remove trees?','Remove',MB_ICONQUESTION or MB_YESNO) = idYes then
  t := true;
  if MessageBox(Handle,'Remove flowers?','Remove',MB_ICONQUESTION or MB_YESNO) = idYes then
  f := true;
  if MessageBox(Handle,'Remove rocks?','Remove',MB_ICONQUESTION or MB_YESNO) = idYes then
  r := true;
  if MessageBox(Handle,'Remove patterns?','Remove',MB_ICONQUESTION or MB_YESNO) = idYes then
  p := true;

  for X := 0 to 80 - 1 do
  for Y := 0 to 80 - 1 do
  begin
    if t then
    if StrToInt(StringGrid1.Cells[X,Y]) >= $0001 then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $0056 then
    begin
      StringGrid1.Cells[X, Y] := '$FFF1';
      C := C + 1;
    end;
    if f then
    if StrToInt(StringGrid1.Cells[X,Y]) >= $009E then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $00DD then
    begin
      StringGrid1.Cells[X, Y] := '$FFF1';
      C := C + 1;
    end;
    if r then
    if StrToInt(StringGrid1.Cells[X,Y]) >= $005B then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $0073 then
    begin
      StringGrid1.Cells[X, Y] := '$FFF1';
      C := C + 1;
    end;
    if p then
    if StrToInt(StringGrid1.Cells[X,Y]) >= $0074 then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $0093 then
    begin
      StringGrid1.Cells[X, Y] := '$FFF1';
      C := C + 1;
    end;
  end;
  DrawGrid;
  MessageBox(handle,PWideChar('Removed ' + IntToStr(C) + ' object(s).'),'Info',MB_ICONINFORMATION);

end;

procedure TTownEditorWin.Removegrass1Click(Sender: TObject);
var
  X,Y: Integer;
begin
  for Y := 0 to 79 do
  for X := 0 to 79 do
  G[X,Y] := 0;
  if ShowGrass1.Checked then
  begin
   // boot := true;
    StringGrid1.Refresh;
    DrawGrid;
   // //boot := false;
  end;
  MessageBox(Handle,'Grass removed.','Info',MB_ICONINFORMATION);
end;

procedure TTownEditorWin.RemoveItems1Click(Sender: TObject);
var
  A,C,X,Y: Integer;
begin
  C := 0;
  for Y := 0 to 80 - 1 do
  for X := 0 to 80 - 1 do
  begin
    A := trunc(extended(X / 16)) + trunc(extended(Y / 16))* 5;
    if StrToInt(StringGrid1.Cells[X,Y]) >= $9000 then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $CF54 then
    begin
      StringGrid1.Cells[X,Y] := '$FFF1';
      if IsBuried(X,Y,A) then
      ApplyBury(X,Y,A);
      C := C + 1;
    end;
  end;
  DrawGrid;
  MessageBox(handle,PWideChar('Removed ' + IntToStr(C) + ' item(s).'),'Info',MB_ICONINFORMATION);
end;

procedure TTownEditorWin.Removeweeds1Click(Sender: TObject);
var
  C,X,Y: Integer;
begin
  C := 0;
  for X := 0 to 80 - 1 do
  for Y := 0 to 80 - 1 do
  begin
    if StrToInt(StringGrid1.Cells[X,Y]) >= $0057 then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $005A then
    begin
      StringGrid1.Cells[X, Y] := '$FFF1';
      C := C + 1;
    end;
    if StrToInt(StringGrid1.Cells[X,Y]) >= $00DE then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $00DF then
    begin
      StringGrid1.Cells[X, Y] := '$FFF1';
      C := C + 1;
    end;
    if StrToInt(StringGrid1.Cells[X,Y]) >= $00E0 then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $00E1 then
    begin
      StringGrid1.Cells[X, Y] := '$FFF1';
      C := C + 1;
    end;
  end;
  DrawGrid;
  MessageBox(handle,PWideChar('Removed ' + IntToStr(C) + ' weed(s).'),'Info',MB_ICONINFORMATION);
end;

procedure TTownEditorWin.exportClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
  FS2: TFileStream;
  X,Y: Integer;
  buffer: word;
  bufferB: byte;
begin
  SaveDialog := TSaveDialog.Create(nil);
  SaveDialog.DefaultExt := '*.bin';
  SaveDialog.Filter := 'Town Layout (*.bin)|*.bin';
  SaveDialog.Options := [ofOverwritePrompt,ofPathMustExist,ofHideReadOnly];
  if SaveDialog.Execute(Handle) then
  begin
    try
      FS2 := TFileStream.Create(SaveDialog.FileName, fmCreate);

        FS.Seek($6BCB6,0);

      for Y := 0 to 79 do //Dump the grass
      for X := 0 to 79 do
      begin
        bufferB := G[X,Y];
        FS2.WriteBuffer(bufferB,sizeof(bufferB));
      end;

      for X := 0 to 34 do //Dump the buildings
      for Y := 0 to 1 do
      begin
        bufferB := B[X,Y];
        FS2.WriteBuffer(bufferB,sizeof(bufferB));
      end;
      for X := 0 to 99 do //Dump the signs
      for Y := 0 to 1 do
      begin
        bufferB := B2[X,Y];
        FS2.WriteBuffer(bufferB,sizeof(bufferB));
      end;

      for X := 0 to 399 do //dump the buried map
      begin
        buffer := ReverseW(Buried[X]);
        FS2.WriteBuffer(buffer,sizeof(buffer));
      end;

      for Y := 0 to 79 do //Dump the grid
      for X := 0 to 79 do
      begin
        buffer := ReverseW(StrToInt(StringGrid1.Cells[X,Y]));
        FS2.WriteBuffer(buffer,sizeof(buffer));
      end;

      FS2.Free;
      SaveDialog.Free;
    except
      MessageBox(Handle,'Unable to town layout!','Error',MB_ICONERROR);
    end;
  end;
end;

procedure TTownEditorWin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bmp.Free;
end;

procedure TTownEditorWin.FormCreate(Sender: TObject);
var
  A,X,Y,X2,Y2: integer;
  Buffer: Word;
  bufferB: byte;
begin
  //boot := true;
  Application.OnIdle := OnIdle;
  check.Down := true;
  hexlabel.Caption := hlmsg1;
  StringGrid1.Canvas.Font.Style := [fsBold];
  StringGrid1.Canvas.Font.Size := 6;
  StringGrid1.Canvas.Brush.Color := clWhite;
  bmp := TBitmap.Create;
  OldB := 0;

  for X := 0 to Length(Used) - 1 do
  for Y := 0 to 1 do
  Used[X,Y] := $FF;  //Prevents any non-existant buildings to display used spaces at 0,0

  FS.Seek($68476, 0);

  for A := 0 to 25 - 1 do
  for Y := 0 to 16 - 1 do
  for X := 0 to 16 - 1 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    stringGrid1.Cells[X + (A mod 5) * 16, Y + trunc(extended(A / 5)) * 16] := '$' + IntToHex(ReverseW(buffer),4);
 end;

  FS.Seek($6BCB6,0);

  for A := 0 to 25 - 1 do       //Read grass
  for Y2 := 0 to 3 do
  for X2 := 0 to 1 do
  for Y := 0 to 4 - 1 do
  for X := 0 to 8 - 1 do
  begin
    FS.ReadBuffer(bufferB,sizeof(bufferB));
    G[(X+(X2*8)) + ((A mod 5) * 16),(Y+(Y2*4)) + ((A div 5) * 16)] := bufferB;
  end;

  FS.Seek($68424,0);  //Read acres
  for X := 0 to 4 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    Acres[X] := ReverseW(buffer);
  end;
  FS.Position := FS.Position + 4;
  for X := 5 to 9 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    Acres[X] := ReverseW(buffer);
  end;
  FS.Position := FS.Position + 4;
  for X := 10 to 14 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    Acres[X] := ReverseW(buffer);
  end;
  FS.Position := FS.Position + 4;
  for X := 15 to 19 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    Acres[X] := ReverseW(buffer);
  end;
  FS.Position := FS.Position + 4;
  for X := 20 to 24 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    Acres[X] := ReverseW(buffer);
  end;



  for X := 0 to 24 do
  if Acres[X] > 367 then
  Acres[X] := Acres[X] and $FF;

 FS.Seek($5EB0A,0); //Read buildings
 for X := 0 to 32 do
 for Y := 0 to 1 do
 begin
   FS.ReadBuffer(bufferB, sizeof(bufferB));
   B[X,Y] := bufferB;
   if bufferB <> 0 then
   begin
     BE[X] := true;
   end
   else
   BE[X] := false;
 end;

 FS.Seek($5EB90,0); //Read Pave's building
 for Y := 0 to 1 do
 begin
   FS.ReadBuffer(bufferB, sizeof(bufferB));
   B[33,Y] := bufferB;
   if bufferB <> 0 then
   begin
     BE[33] := true;
   end
   else
   BE[33] := false;
 end;


 FS.Seek($5EB8A,0);  //Read Bus Stop
 for Y := 0 to 1 do
 begin
   FS.ReadBuffer(bufferB, sizeof(bufferB));
   B[34,Y] := bufferB;
   if bufferB <> 0 then
   begin
     BE[34] := true;
   end
   else
   BE[34] := false;
 end;

 FS.Seek($5EB92, 0);  //Read sign locations
 for X := 0 to 99 do
 for Y := 0 to 1 do
 begin
   FS.ReadBuffer(bufferB,sizeof(bufferB));
   B2[X,Y] := bufferB;
   if bufferB <> 0 then
   begin
     BE2[X] := true;
   end
   else
   BE2[X] := false;
 end;

 FS.Seek($6B676,0);        //Read buried map
 for X := 0 to 399 do
 begin
   FS.ReadBuffer(buffer,sizeof(buffer));
   Buried[X] := ReverseW(buffer);
 end;

 UpdateUsed($FF);

end;

procedure TTownEditorWin.FormDestroy(Sender: TObject);
begin
  Application.OnIdle := nil;
end;

procedure TTownEditorWin.FormResize(Sender: TObject);
begin
  Treeview1.Left := StringGrid1.Left + StringGrid1.Width + 5;
  TreeView1.Width := Width - StringGrid1.Width - 28;
  collapse.Left := TreeView1.Left + (TreeView1.Width - collapse.Width);
end;

procedure TTownEditorWin.gcheckClick(Sender: TObject);
begin
  hexlabel.Caption := hlmsg12;
end;

procedure TTownEditorWin.gsetClick(Sender: TObject);
begin
  hexlabel.Caption := hlmsg13;
end;

procedure TTownEditorWin.Import1Click(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  FS2: TFileStream;
  X,Y: Integer;
  buffer: word;
  bufferB: byte;
  ib,safe: boolean;
begin
  OpenDialog := TOpenDialog.Create(nil);
  OpenDialog.DefaultExt := '*.bin';
  OpenDialog.Filter := 'Town Layout (*.bin)|*.bin';
  OpenDialog.Options := [ofPathMustExist, ofFileMustExist, ofHideReadOnly];
  if OpenDialog.Execute(Handle) then
  begin
    try
      FS2 := TFileStream.Create(OpenDialog.FileName, fmOpenRead);
      if FS2.Size = $4F2E then
      begin
      if MessageBox(Handle,'Import buildings and signs?','Import',MB_YESNO or MB_ICONQUESTION) = idYes then
      ib := true
      else ib := false;

      //boot := true;

      for Y := 0 to 79 do //import the grass
      for X := 0 to 79 do
      begin
        FS2.ReadBuffer(bufferB,sizeof(bufferB));
        G[X,Y] := bufferB;
      end;

      for X := 0 to 34 do //import the buildings
      for Y := 0 to 1 do
      begin
        FS2.ReadBuffer(bufferB,sizeof(bufferB));
        if ib then
        begin
          B[X,Y] := bufferB;
          if bufferB <> 0 then
          BE[X] := true
          else BE[X] := false;
        end;
      end;

      for X := 0 to 99 do //import the signs
      for Y := 0 to 1 do
      begin
        FS2.ReadBuffer(bufferB,sizeof(bufferB));
        if ib then
        begin
          B2[X,Y] := bufferB;
          if bufferB <> 0 then
          BE2[X] := true
          else BE2[X] := false;
        end;
      end;


      for X := 0 to 399 do //import the buried map
      begin
        FS2.ReadBuffer(buffer,sizeof(buffer));
        Buried[X] := ReverseW(buffer);
      end;

      for Y := 0 to 79 do //import the grid
      for X := 0 to 79 do
      begin
        safe := true;
        FS2.ReadBuffer(buffer,sizeof(buffer));

        if not ib then
        begin
          if StringGrid1.Cells[X,Y] = '$7003' then
          safe := false
          else if StringGrid1.Cells[X,Y] = '$D000' then
          safe := false;

          if ReverseW(buffer) = $7003 then
          safe := false
          else if ReverseW(buffer) = $D000 then
          safe := false;
        end;

        if ReverseW(buffer) >= $7000 then   //Do not import snowmen
        if ReverseW(buffer) < $7003 then
        safe := false;

        if safe then
        StringGrid1.Cells[X,Y] := '$' + IntToHex(ReverseW(buffer),4);
      end;

      UpdateUsed($FF);
      StringGrid1.Refresh;
      //DrawGrid;
      //boot := false;

      end
      else
      MessageBox(Handle,'Invalid file!','Error',MB_ICONERROR);
      FS2.Free;
      OpenDialog.Free;
    except
     // //boot := false;
      MessageBox(Handle,'Unable to import layout!','Error',MB_ICONERROR);
    end;
  end;

end;

procedure TTownEditorWin.replaceClick(Sender: TObject);
begin
  if TreeView1.Selected <> nil then
  begin
    if TreeView1.Selected.HasChildren = false then
    hexlabel.Caption := hlmsg7 + TreeView1.Selected.Text
    else
    hexlabel.Caption := hlmsg2;
  end
  else
  hexlabel.Caption := hlmsg2;
end;

procedure TTownEditorWin.Replenishfruit1Click(Sender: TObject);
var
  C,X,Y: Integer;
begin
  C := 0;
  for X := 0 to 80 - 1 do
  for Y := 0 to 80 - 1 do
  begin
    if StrToInt(StringGrid1.Cells[X,Y]) >= $001D then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $001F then
    begin
      StringGrid1.Cells[X,Y] := '$0020';
      C := C + 1;
    end;
    if StrToInt(StringGrid1.Cells[X,Y]) >= $0025 then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $0027 then
    begin
      StringGrid1.Cells[X,Y] := '$0028';
      C := C + 1;
    end;
    if StrToInt(StringGrid1.Cells[X,Y]) >= $001D then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $001F then
    begin
      StringGrid1.Cells[X,Y] := '$0020';
      C := C + 1;
    end;
    if StrToInt(StringGrid1.Cells[X,Y]) >= $002D then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $002F then
    begin
      StringGrid1.Cells[X,Y] := '$0030';
      C := C + 1;
    end;
    if StrToInt(StringGrid1.Cells[X,Y]) >= $0035 then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $0037 then
    begin
      StringGrid1.Cells[X,Y] := '$0038';
      C := C + 1;
    end;
    if StrToInt(StringGrid1.Cells[X,Y]) >= $003D then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $003F then
    begin
      StringGrid1.Cells[X,Y] := '$0040';
      C := C + 1;
    end;
    if StrToInt(StringGrid1.Cells[X,Y]) >= $0045 then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $0047 then
    begin
      StringGrid1.Cells[X,Y] := '$0048';
      C := C + 1;
    end;
  end;
  DrawGrid;
  MessageBox(Handle,PWideChar('Replenished ' + IntToStr(C) + ' tree(s).'),'Info',MB_ICONINFORMATION);
end;

procedure TTownEditorWin.Restoregrass1Click(Sender: TObject);
var
  X,Y: Integer;
begin
  for Y := 0 to 79 do
  for X := 0 to 79 do
  G[X,Y] := 255;
  if ShowGrass1.Checked then
  begin
    //boot := true;
    StringGrid1.Refresh;
    DrawGrid;
    //boot := false;
  end;
  MessageBox(Handle,'Grass restored.','Info',MB_ICONINFORMATION);
end;

procedure TTownEditorWin.Reviveflowers1Click(Sender: TObject);
var
  C,X,Y: Integer;
begin
  C := 0;
  for X := 0 to 80 - 1 do
  for Y := 0 to 80 - 1 do
  begin
    if StrToInt(StringGrid1.Cells[X,Y]) >= $00BE then
    if StrToInt(StringGrid1.Cells[X,Y]) <= $00DD then
    begin
      StringGrid1.Cells[X, Y] := '$' + IntToHex(StrToInt(StringGrid1.Cells[X, Y]) - $20,4);
      C := C + 1;
    end;
  end;
  DrawGrid;
  MessageBox(handle,PWideChar('Revived ' + IntToStr(C) + ' flower(s).'),'Info',MB_ICONINFORMATION);
end;

procedure TTownEditorWin.Showacregrid1Click(Sender: TObject);
begin
  if Showacregrid1.Checked then
  begin
    Showacregrid1.Checked := false;
    StringGrid1.Refresh;
  end
  else begin
    Showacregrid1.Checked := true;
    //DrawGrid;
  end;
end;

procedure TTownEditorWin.Showbackground1Click(Sender: TObject);
begin
  if Showbackground1.Checked then
  Showbackground1.Checked := false
  else Showbackground1.Checked := true;
  //boot := true;
  StringGrid1.Refresh;
 // DrawGrid;
  //boot := false;
end;

procedure TTownEditorWin.Showgrass1Click(Sender: TObject);
begin
  if Showgrass1.Checked then
  Showgrass1.Checked := false
  else Showgrass1.Checked := true;

  //boot := true;
  StringGrid1.Refresh;
  //DrawGrid;
  //boot := false;

end;

procedure TTownEditorWin.showgrassClick(Sender: TObject);
begin
  //boot := true;
  StringGrid1.Refresh;
  //DrawGrid;
  //boot := false;
end;

procedure TTownEditorWin.UpdateUsed(buildingID: Byte);
var
  I: Integer;
  start: byte;
begin
  drawUsed := false;
  if buildingID = $FF then
  begin
    start := 0;
    buildingID := 34;
  end
  else begin
    start := buildingID;
    for I := 0 to Length(Used) - 1 do
    StringGrid1.Cells[Used[I,0],Used[I,1]] := StringGrid1.Cells[Used[I,0],Used[I,1]];
  end;
  for I := start to buildingID do
  begin
  //  if BE[I] = true then
    case I of
    0..3:begin
        Used[0 + (I * 12),0] := B[I,0] - 1 - $10;
        Used[0 + (I * 12),1] := B[I,1] - $10;
        Used[1 + (I * 12),0] := B[I,0] - 2 - $10;
        Used[1 + (I * 12),1] := B[I,1] - $10;
        Used[2 + (I * 12),0] := B[I,0] + 1 - $10;
        Used[2 + (I * 12),1] := B[I,1] - $10;
        Used[3 + (I * 12),0] := B[I,0] - 1 - $10;
        Used[3 + (I * 12),1] := B[I,1] - 1 - $10;
        Used[4 + (I * 12),0] := B[I,0] - 2 - $10;
        Used[4 + (I * 12),1] := B[I,1] - 1 - $10;
        Used[5 + (I * 12),0] := B[I,0] + 1 - $10;
        Used[5 + (I * 12),1] := B[I,1] - 1 - $10;
        Used[6 + (I * 12),0] := B[I,0] - 1 - $10;
        Used[6 + (I * 12),1] := B[I,1] + 1 - $10;
        Used[7 + (I * 12),0] := B[I,0] - 2 - $10;
        Used[7 + (I * 12),1] := B[I,1] + 1 - $10;
        Used[8 + (I * 12),0] := B[I,0] + 1 - $10;
        Used[8 + (I * 12),1] := B[I,1] + 1 - $10;
        Used[9 + (I * 12),0] := B[I,0] - $10;
        Used[9 + (I * 12),1] := B[I,1] + 2 - $10;
        Used[10 + (I * 12),0] := B[I,0] - $10;
        Used[10 + (I * 12),1] := B[I,1] - 1 - $10;
        Used[11 + (I * 12),0] := B[I,0] - $10;
        Used[11 + (I * 12),1] := B[I,1] + 1 - $10;
      end;
    8..16:begin
        Used[0 + ((I - 4) * 12),0] := B[I,0] - 1 - $10;
        Used[0 + ((I - 4) * 12),1] := B[I,1] - $10;
        Used[1 + ((I - 4) * 12),0] := B[I,0] - 2 - $10;
        Used[1 + ((I - 4) * 12),1] := B[I,1] - $10;
        Used[2 + ((I - 4) * 12),0] := B[I,0] + 1 - $10;
        Used[2 + ((I - 4) * 12),1] := B[I,1] - $10;
        Used[3 + ((I - 4) * 12),0] := B[I,0] - 1 - $10;
        Used[3 + ((I - 4) * 12),1] := B[I,1] - 1 - $10;
        Used[4 + ((I - 4) * 12),0] := B[I,0] - 2 - $10;
        Used[4 + ((I - 4) * 12),1] := B[I,1] - 1 - $10;
        Used[5 + ((I - 4) * 12),0] := B[I,0] + 1 - $10;
        Used[5 + ((I - 4) * 12),1] := B[I,1] - 1 - $10;
        Used[6 + ((I - 4) * 12),0] := B[I,0] - 1 - $10;
        Used[6 + ((I - 4) * 12),1] := B[I,1] + 1 - $10;
        Used[7 + ((I - 4) * 12),0] := B[I,0] - 2 - $10;
        Used[7 + ((I - 4) * 12),1] := B[I,1] + 1 - $10;
        Used[8 + ((I - 4) * 12),0] := B[I,0] + 1 - $10;
        Used[8 + ((I - 4) * 12),1] := B[I,1] + 1 - $10;
        Used[9 + ((I - 4) * 12),0] := B[I,0] - $10;
        Used[9 + ((I - 4) * 12),1] := B[I,1] + 2 - $10;
        Used[10 + ((I - 4) * 12),0] := B[I,0] - $10;
        Used[10 + ((I - 4) * 12),1] := B[I,1] - 1 - $10;
        Used[11 + ((I - 4) * 12),0] := B[I,0] - $10;
        Used[11 + ((I - 4) * 12),1] := B[I,1] + 1 - $10;
      end;
      17:begin
        Used[234,0] := B[I,0] - 1 - $10;
        Used[234,1] := B[I,1] - $10;
        Used[235,0] := B[I,0] - 2 - $10;
        Used[235,1] := B[I,1] - $10;
        Used[236,0] := B[I,0] + 1 - $10;
        Used[236,1] := B[I,1] - $10;
        Used[237,0] := B[I,0] - 1 - $10;
        Used[237,1] := B[I,1] - 1 - $10;
        Used[238,0] := B[I,0] - 2 - $10;
        Used[238,1] := B[I,1] - 1 - $10;
        Used[239,0] := B[I,0] + 1 - $10;
        Used[239,1] := B[I,1] - 1 - $10;
        Used[240,0] := B[I,0] - 1 - $10;
        Used[240,1] := B[I,1] + 1 - $10;
        Used[241,0] := B[I,0] - 2 - $10;
        Used[241,1] := B[I,1] + 1 - $10;
        Used[242,0] := B[I,0] + 1 - $10;
        Used[242,1] := B[I,1] + 1 - $10;
        Used[243,0] := B[I,0] - $10;
        Used[243,1] := B[I,1] + 2 - $10;
        Used[244,0] := B[I,0] - $10;
        Used[244,1] := B[I,1] - 1 - $10;
        Used[245,0] := B[I,0] - $10;
        Used[245,1] := B[I,1] + 1 - $10;
      end;
      18:begin
        Used[156,0] := B[I,0] - 3 - $10;
        Used[156,1] := B[I,1] - $10;
        Used[157,0] := B[I,0] - 2 - $10;
        Used[157,1] := B[I,1] - $10;
        Used[158,0] := B[I,0] - 1 - $10;
        Used[158,1] := B[I,1] - $10;
        Used[159,0] := B[I,0] + 1 - $10;
        Used[159,1] := B[I,1] - $10;
        Used[160,0] := B[I,0] + 2 - $10;
        Used[160,1] := B[I,1] - $10;
        Used[161,0] := B[I,0] + 3 - $10;
        Used[161,1] := B[I,1] - $10;
        Used[162,0] := B[I,0] - 3 - $10;
        Used[162,1] := B[I,1] - 1 - $10;
        Used[163,0] := B[I,0] - 2 - $10;
        Used[163,1] := B[I,1] - 1 - $10;
        Used[164,0] := B[I,0] - 1 - $10;
        Used[164,1] := B[I,1] - 1 - $10;
        Used[165,0] := B[I,0] - $10;
        Used[165,1] := B[I,1] - 1 - $10;
        Used[166,0] := B[I,0] + 1 - $10;
        Used[166,1] := B[I,1] - 1 - $10;
        Used[167,0] := B[I,0] + 2 - $10;
        Used[167,1] := B[I,1] - 1 - $10;
        Used[168,0] := B[I,0] + 3 - $10;
        Used[168,1] := B[I,1] - 1 - $10;
        Used[169,0] := B[I,0] - 2 - $10;
        Used[169,1] := B[I,1] + 1 - $10;
        Used[170,0] := B[I,0] - 1 - $10;
        Used[170,1] := B[I,1] + 1 - $10;
        Used[171,0] := B[I,0] - $10;
        Used[171,1] := B[I,1] + 1 - $10;
        Used[172,0] := B[I,0] + 1 - $10;
        Used[172,1] := B[I,1] + 1 - $10;
        Used[173,0] := B[I,0] + 2 - $10;
        Used[173,1] := B[I,1] + 1 - $10;
        Used[174,0] := B[I,0] - $10;
        Used[174,1] := B[I,1] + 2 - $10;
      end;
      19:begin
        Used[175,0] := B[I,0] - 3 - $10;
        Used[175,1] := B[I,1] - $10;
        Used[176,0] := B[I,0] - 2 - $10;
        Used[176,1] := B[I,1] - $10;
        Used[177,0] := B[I,0] + 1 - $10;
        Used[177,1] := B[I,1] - $10;
        Used[178,0] := B[I,0] + 3 - $10;
        Used[178,1] := B[I,1] - $10;
        Used[179,0] := B[I,0] + 4 - $10;
        Used[179,1] := B[I,1] - $10;
      end;
      20:begin
        Used[180,0] := B[I,0] - 4 - $10;
        Used[180,1] := B[I,1] - 1 - $10;
        Used[181,0] := B[I,0] - 3 - $10;
        Used[181,1] := B[I,1] - 1 - $10;
        Used[182,0] := B[I,0] - 2 - $10;
        Used[182,1] := B[I,1] - 1 - $10;
        Used[183,0] := B[I,0] - 1 - $10;
        Used[183,1] := B[I,1] - 1 - $10;
        Used[184,0] := B[I,0] - $10;
        Used[184,1] := B[I,1] - 1 - $10;
        Used[185,0] := B[I,0] + 1 - $10;
        Used[185,1] := B[I,1] - 1 - $10;
        Used[186,0] := B[I,0] - 4 - $10;
        Used[186,1] := B[I,1] - $10;
        Used[187,0] := B[I,0] - 3 - $10;
        Used[187,1] := B[I,1] - $10;
        Used[188,0] := B[I,0] - 2 - $10;
        Used[188,1] := B[I,1] - $10;
        Used[189,0] := B[I,0] - 1 - $10;
        Used[189,1] := B[I,1] - $10;
        Used[190,0] := B[I,0] + 1 - $10;
        Used[190,1] := B[I,1] - $10;
        Used[191,0] := B[I,0] - 4 - $10;
        Used[191,1] := B[I,1] - 2 - $10;
        Used[192,0] := B[I,0] - 3 - $10;
        Used[192,1] := B[I,1] - 2 - $10;
        Used[193,0] := B[I,0] - 2 - $10;
        Used[193,1] := B[I,1] - 2 - $10;
        Used[194,0] := B[I,0] + 1 - $10;
        Used[194,1] := B[I,1] - 2 - $10;
        Used[195,0] := B[I,0] - $10;
        Used[195,1] := B[I,1] - 2 - $10;
        Used[196,0] := B[I,0] - 1 - $10;
        Used[196,1] := B[I,1] - 2 - $10;
        Used[197,0] := B[I,0] - $10;
        Used[197,1] := B[I,1] + 1 - $10;
      end;
      21:begin
        Used[198,0] := B[I,0] - 2 - $10;
        Used[198,1] := B[I,1] - 2 - $10;
        Used[199,0] := B[I,0] - 1 - $10;
        Used[199,1] := B[I,1] - 2 - $10;
        Used[200,0] := B[I,0] - $10;
        Used[200,1] := B[I,1] - 2 - $10;
        Used[201,0] := B[I,0] + 1 - $10;
        Used[201,1] := B[I,1] - 2 - $10;
        Used[202,0] := B[I,0] - 2 - $10;
        Used[202,1] := B[I,1] - 1 - $10;
        Used[203,0] := B[I,0] - 1 - $10;
        Used[203,1] := B[I,1] - 1 - $10;
        Used[204,0] := B[I,0] - $10;
        Used[204,1] := B[I,1] - 1 - $10;
        Used[205,0] := B[I,0] + 1 - $10;
        Used[205,1] := B[I,1] - 1 - $10;
        Used[206,0] := B[I,0] - 1 - $10;
        Used[206,1] := B[I,1] - $10;
        Used[207,0] := B[I,0] + 1 - $10;
        Used[207,1] := B[I,1] - $10;
        Used[208,0] := B[I,0] - $10;
        Used[208,1] := B[I,1] + 1 - $10;
      end;
      22:begin
        Used[209,0] := B[I,0] - 3 - $10;
        Used[209,1] := B[I,1] - 2 - $10;
        Used[210,0] := B[I,0] - 2 - $10;
        Used[210,1] := B[I,1] - 2 - $10;
        Used[211,0] := B[I,0] - 1 - $10;
        Used[211,1] := B[I,1] - 2 - $10;
        Used[212,0] := B[I,0] - $10;
        Used[212,1] := B[I,1] - 2 - $10;
        Used[213,0] := B[I,0] + 1 - $10;
        Used[213,1] := B[I,1] - 2 - $10;
        Used[214,0] := B[I,0] + 2 - $10;
        Used[214,1] := B[I,1] - 2 - $10;
        Used[215,0] := B[I,0] + 3 - $10;
        Used[215,1] := B[I,1] - 2 - $10;
        Used[216,0] := B[I,0] - 3 - $10;
        Used[216,1] := B[I,1] - 1 - $10;
        Used[217,0] := B[I,0] - 2 - $10;
        Used[217,1] := B[I,1] - 1 - $10;
        Used[218,0] := B[I,0] - 1 - $10;
        Used[218,1] := B[I,1] - 1 - $10;
        Used[219,0] := B[I,0] - $10;
        Used[219,1] := B[I,1] - 1 - $10;
        Used[220,0] := B[I,0] + 1 - $10;
        Used[220,1] := B[I,1] - 1 - $10;
        Used[221,0] := B[I,0] + 2 - $10;
        Used[221,1] := B[I,1] - 1 - $10;
        Used[222,0] := B[I,0] + 3 - $10;
        Used[222,1] := B[I,1] - 1 - $10;
        Used[223,0] := B[I,0] - 3 - $10;
        Used[223,1] := B[I,1] - $10;
        Used[224,0] := B[I,0] - 2 - $10;
        Used[224,1] := B[I,1] - $10;
        Used[225,0] := B[I,0] - 1 - $10;
        Used[225,1] := B[I,1] - $10;
        Used[226,0] := B[I,0] + 1 - $10;
        Used[226,1] := B[I,1] - $10;
        Used[227,0] := B[I,0] + 2 - $10;
        Used[227,1] := B[I,1] - $10;
        Used[228,0] := B[I,0] + 3 - $10;
        Used[228,1] := B[I,1] - $10;
        Used[229,0] := B[I,0] - $10;
        Used[229,1] := B[I,1] + 1 - $10;
      end;
      23:begin
        Used[230,0] := B[I,0] - 1 - $10;
        Used[230,1] := B[I,1] - $10;
      end;
      34:begin
        Used[231,0] := B[I,0] - 3 - $10;
        Used[231,1] := B[I,1] - $10;
        Used[232,0] := B[I,0] - 2 - $10;
        Used[232,1] := B[I,1] - $10;
        Used[233,0] := B[I,0] - 1 - $10;
        Used[233,1] := B[I,1] - $10;
      end;
      29:begin
        Used[246,0] := B[I,0] - 1 - $10;
        Used[246,1] := B[I,1] - 1 - $10;
        Used[247,0] := B[I,0] - $10;
        Used[247,1] := B[I,1] - 1 - $10;
        Used[248,0] := B[I,0] + 1 - $10;
        Used[248,1] := B[I,1] - 1 - $10;
        Used[249,0] := B[I,0] + 2 - $10;
        Used[249,1] := B[I,1] - 1 - $10;
        Used[250,0] := B[I,0] - 1 - $10;
        Used[250,1] := B[I,1] - $10;
        Used[251,0] := B[I,0] + 1 - $10;
        Used[251,1] := B[I,1] - $10;
        Used[252,0] := B[I,0] + 2 - $10;
        Used[252,1] := B[I,1] - $10;
        Used[253,0] := B[I,0] - 1 - $10;
        Used[253,1] := B[I,1] + 1 - $10;
        Used[254,0] := B[I,0] - $10;
        Used[254,1] := B[I,1] + 1 - $10;
        Used[255,0] := B[I,0] + 1 - $10;
        Used[255,1] := B[I,1] + 1 - $10;
        Used[256,0] := B[I,0] + 2 - $10;
        Used[256,1] := B[I,1] + 1 - $10;
        Used[257,0] := B[I,0] - 1 - $10;
        Used[257,1] := B[I,1] + 2 - $10;
        Used[258,0] := B[I,0] - $10;
        Used[258,1] := B[I,1] + 2 - $10;
        Used[259,0] := B[I,0] + 1 - $10;
        Used[259,1] := B[I,1] + 2 - $10;
        Used[260,0] := B[I,0] + 2 - $10;
        Used[260,1] := B[I,1] + 2 - $10;
      end;
      27..28:begin
        Used[261 + ((I-27)*3),0] := B[I,0] + 1 - $10;
        Used[261 + ((I-27)*3),1] := B[I,1] - $10;
        Used[262 + ((I-27)*3),0] := B[I,0] - $10;
        Used[262 + ((I-27)*3),1] := B[I,1] + 1 - $10;
        Used[263 + ((I-27)*3),0] := B[I,0] + 1 - $10;
        Used[263 + ((I-27)*3),1] := B[I,1] + 1 - $10;
      end;
      25..26:begin
        Used[267 + ((I-25)*8),0] := B[I,0] - 1 - $10;
        Used[267 + ((I-25)*8),1] := B[I,1] - 2 - $10;
        Used[268 + ((I-25)*8),0] := B[I,0] + 1 - $10;
        Used[268 + ((I-25)*8),1] := B[I,1] - 2 - $10;
        Used[269 + ((I-25)*8),0] := B[I,0] - $10;
        Used[269 + ((I-25)*8),1] := B[I,1] - 2 - $10;
        Used[270 + ((I-25)*8),0] := B[I,0] - 1 - $10;
        Used[270 + ((I-25)*8),1] := B[I,1] - 1 - $10;
        Used[271 + ((I-25)*8),0] := B[I,0] + 1 - $10;
        Used[271 + ((I-25)*8),1] := B[I,1] - 1 - $10;
        Used[272 + ((I-25)*8),0] := B[I,0] - $10;
        Used[272 + ((I-25)*8),1] := B[I,1] - 1 - $10;
        Used[273 + ((I-25)*8),0] := B[I,0] - 1 - $10;
        Used[273 + ((I-25)*8),1] := B[I,1] - $10;
        Used[274 + ((I-25)*8),0] := B[I,0] + 1 - $10;
        Used[274 + ((I-25)*8),1] := B[I,1] - $10;
      end;
      30..31:begin
        Used[283 + ((I-30)*5),0] := B[I,0] - 1 - $10;
        Used[283 + ((I-30)*5),1] := B[I,1] - 1 - $10;
        Used[284 + ((I-30)*5),0] := B[I,0] + 1 - $10;
        Used[284 + ((I-30)*5),1] := B[I,1] - 1 - $10;
        Used[285 + ((I-30)*5),0] := B[I,0] - $10;
        Used[285 + ((I-30)*5),1] := B[I,1] - 1 - $10;
        Used[286 + ((I-30)*5),0] := B[I,0] - 1 - $10;
        Used[286 + ((I-30)*5),1] := B[I,1] - $10;
        Used[287 + ((I-30)*5),0] := B[I,0] + 1 - $10;
        Used[287 + ((I-30)*5),1] := B[I,1] - $10;
      end;
      24:begin
        Used[293,0] := B[I,0] - 1 - $10;
        Used[293,1] := B[I,1] - $10;
        Used[294,0] := B[I,0] + 1 - $10;
        Used[294,1] := B[I,1] - $10;
      end;
      33:begin
        Used[295,0] := B[I,0] - 1 - $10;
        Used[295,1] := B[I,1] - $10;
        Used[296,0] := B[I,0] + 1 - $10;
        Used[296,1] := B[I,1] - $10;
      end;

    end;
  end;
  drawUsed := true;
  for I := 0 to Length(Used) - 1 do
  begin
    StringGrid1.Cells[Used[I,0],Used[I,1]] := StringGrid1.Cells[Used[I,0],Used[I,1]];
  end;
end;

procedure TTownEditorWin.bplaceClick(Sender: TObject);
var
  dialog: TForm15;
begin
  dialog := TForm15.Create(nil);
  dialog.ShowModal;
  dialog.Free;
  if pb <> $FF then
  hexlabel.Caption := hlmsg7 + GetBuilding(pb)
  else begin
    bcheck.Down := true;
    hexlabel.Caption := hlmsg3;
  end;
end;

procedure TTownEditorWin.ShowHint1Click(Sender: TObject);
begin
  if ShowHint1.Checked = false then
  begin
    Application.ShowHint := true;
    ShowHint1.Checked := true;
  end else
  begin
    Application.ShowHint := false;
    ShowHint1.Checked := false;
  end;
end;

procedure TTownEditorWin.Showitemsterrain1Click(Sender: TObject);
begin
  if Showitemsterrain1.Checked then
  Showitemsterrain1.Checked := false
  else Showitemsterrain1.Checked := true;

  //boot := true;
  StringGrid1.Refresh;
  //DrawGrid;
  //boot := false;

end;

procedure TTownEditorWin.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  str: String;
  I,A: Integer;
  txt: Boolean;
begin
  StringGrid1.Canvas.Lock;
  if Showitemsterrain1.Checked then
  str := StringGrid1.Cells[ACol, ARow]
  else str := '$FFF1';
  A := trunc(extended(ACol / 16)) + trunc(extended(ARow / 16))* 5;
  txt := false;

  if str = '$FFF1' then //Empty
  begin
    if Showbackground1.Checked then
    begin
      fc := buildingc;
      StringGrid1.Canvas.Font.Color := fc;
      //bmp := TBitmap.Create;
      if OldB <> Acres[A] then
      begin
        bmp.FreeImage;
        bmp.LoadFromResourceName(hInstance,'A' + IntToStr(Acres[A]));
        OldB := Acres[A];
      end;
      StringGrid1.Canvas.Brush.Color := bmp.Canvas.Pixels[ACol mod 16, ARow mod 16];
      //bmp.Free;
    end
    else begin
      fc := clRed;
      StringGrid1.Canvas.Font.Color := fc;
      StringGrid1.Canvas.Brush.Color := clWhite;
    end;

    if showGrass1.Checked then
    if G[ACol,ARow] < $A0 then
    if StringGrid1.Canvas.Brush.Color <> TColor(RGB($9,$60,$C9)) then
    if StringGrid1.Canvas.Brush.Color <> TColor(RGB($9,$60,$E9)) then
    //if StringGrid1.Canvas.Brush.Color <> RGB($A7,$B7,$AC) then
    begin
      if G[ACol,ARow] <= $40 then
     StringGrid1.Canvas.Brush.Color := RGB($40,$33,0)
     else StringGrid1.Canvas.Brush.Color := RGB(G[ACol,ARow],$33,0);
    end;

  end
  else
  StringGrid1.Canvas.Brush.Color := GetColor(str);

  StringGrid1.Canvas.FillRect(Rect);

  //if boot = false then DrawGrid;

  StringGrid1.Canvas.Font.Color := fc;
  if IsBuried(ACol,ARow,A) then
  begin
    StringGrid1.Canvas.Font.Color := buriedc;
    DrawText(StringGrid1.Canvas.Handle,'X',1,rect,DT_CENTER);
  end;
  for I := 0 to 34 do
  begin
    if B[I,0] = ACol + $10 then
    if B[I,1] = ARow + $10 then
    if BE[I] = true then
    begin
      DrawText(StringGrid1.Canvas.Handle,'B',1,rect,DT_CENTER);
      txt := true;
      break;
    end;
  end;
 if txt = false then
  for I := 0 to 99 do
  begin
    if B2[I,0] = ACol + $10 then
    if B2[I,1] = ARow + $10 then
    if BE2[I] = true then
    begin
      DrawText(StringGrid1.Canvas.Handle,'B',1,rect,DT_CENTER);
      txt := true;
      break;
    end;
  end;
  if txt = false then
  if drawUsed = true then
  for I := 0 to Length(Used) - 1 do
  if Used[I,0] = ACol then
  if Used[I,1] = ARow then
  begin
    DrawText(StringGrid1.Canvas.Handle,'-',1,rect,DT_CENTER);
    break;
  end;
  StringGrid1.Canvas.Unlock;
  //0-15 Col = ACol - (A * 16)
 // for I := 1 to 1 do
  //StringGrid1.Canvas.T
  //PatBlt(StringGrid1.Canvas.Handle, 128 * I + (16 * I), 0, 1,740,BLACKNESS);
end;

procedure TTownEditorWin.DrawGrid;
var
  I,P: Integer;
begin
  if not showAcreGrid1.Checked then
  exit;

  StringGrid1.Canvas.Pen.Color := gridc;
  for I := 1 to 4 do                             //Draw acre border
  begin
    P := ((143 * I) + (I - 1)) - (StringGrid1.LeftCol * 9);
    StringGrid1.Canvas.MoveTo(P,0);
    StringGrid1.Canvas.LineTo(P,719 - (StringGrid1.TopRow * 9));
    P := ((143 * I) + (I - 1)) - (StringGrid1.TopRow * 9);
    StringGrid1.Canvas.MoveTo(0,P);
    StringGrid1.Canvas.LineTo(719 - (StringGrid1.LeftCol * 9),P);
  end;
  StringGrid1.Canvas.Pen.Color := clGray;
end;

procedure TTownEditorWin.Export1Click(Sender: TObject);
var
  SaveDialog: TSaveDialog;
  FS2: TFileStream;
  X,Y: Integer;
  buffer: word;
  bufferB: byte;
begin
  SaveDialog := TSaveDialog.Create(nil);
  SaveDialog.DefaultExt := '*.bin';
  SaveDialog.Filter := 'Town Layout (*.bin)|*.bin';
  SaveDialog.Options := [ofOverwritePrompt,ofPathMustExist,ofHideReadOnly];
  if SaveDialog.Execute(Handle) then
  begin
    try
      FS2 := TFileStream.Create(SaveDialog.FileName, fmCreate);

        FS.Seek($6BCB6,0);

      for Y := 0 to 79 do //Dump the grass
      for X := 0 to 79 do
      begin
        bufferB := G[X,Y];
        FS2.WriteBuffer(bufferB,sizeof(bufferB));
      end;

      for X := 0 to 34 do //Dump the buildings
      for Y := 0 to 1 do
      begin
        bufferB := B[X,Y];
        FS2.WriteBuffer(bufferB,sizeof(bufferB));
      end;
      for X := 0 to 99 do //Dump the signs
      for Y := 0 to 1 do
      begin
        bufferB := B2[X,Y];
        FS2.WriteBuffer(bufferB,sizeof(bufferB));
      end;

      for X := 0 to 399 do //dump the buried map
      begin
        buffer := ReverseW(Buried[X]);
        FS2.WriteBuffer(buffer,sizeof(buffer));
      end;

      for Y := 0 to 79 do //Dump the grid
      for X := 0 to 79 do
      begin
        buffer := ReverseW(StrToInt(StringGrid1.Cells[X,Y]));
        FS2.WriteBuffer(buffer,sizeof(buffer));
      end;

      FS2.Free;
      SaveDialog.Free;
    except
      MessageBox(Handle,'Unable to town layout!','Error',MB_ICONERROR);
    end;
  end;
end;

procedure TTownEditorWin.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Key := 0;
end;

procedure TTownEditorWin.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow:Integer;
  canselect: boolean;
begin
  Application.HideHint;
  oldP.X := -1;
  oldP.Y := -1;
  if button = mbRight then
  begin
    StringGrid1.MouseToCell(X,Y,ACol,ARow);
    StringGrid1SelectCell(nil,ACol,ARow,canselect);
    TreeView1.Selected.getNextSibling.Selected := true;
  end
  else StringGrid1.ShowHint := false;
end;

procedure TTownEditorWin.StringGrid1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  ACol,ARow: Integer;
begin
  if oldP.X = X then
  if oldP.Y = Y then
  Exit;

  try
  if Application.ShowHint = true then
  if StringGrid1.ShowHint = true then
  begin
    oldP.X := X;
    oldP.Y := Y;
    StringGrid1.MouseToCell(X,Y,ACol,ARow);
    if ACol = -1 then
    begin
      StringGrid1.Hint := '';
      Application.HideHint;
      Exit;
    end
    else Application.ShowHint := true;
    StringGrid1.Hint := ItemSearch(StringGrid1.Cells[ACol, ARow]) + ' (' + StringGrid1.Cells[ACol,ARow] + ')';
    Application.ActivateHint(Mouse.CursorPos);
  end;
  except
  end;

end;

procedure TTownEditorWin.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  StringGrid1.ShowHint := true;
end;

procedure TTownEditorWin.StringGrid1MouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TTownEditorWin.StringGrid1MouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TTownEditorWin.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  I,X,A: Integer;
  Safe: Boolean;
begin
  Application.CancelHint;
  safe := true;
  A := trunc(extended(ACol / 16)) + trunc(extended(ARow / 16))* 5;
  if StringGrid1.Cells[ACol, ARow] = '$D000' then
  begin
    for I := 0 to 99 do
    begin
      if B2[I,0] = ACol + $10 then
      if B2[I,1] = ARow + $10 then
      if BE2[I] = true then
      begin
        safe := false;
        break;
      end;
    end;
  end
  else if StringGrid1.Cells[ACol, ARow] = '$7003' then
  begin
    if B[34,0] = ACol + $10 then
    if B[34,1] = ARow + $10 then
    safe := false;
  end;
  if replace.Down then
  if TreeView1.Selected <> nil then
  if TreeView1.Selected.HasChildren = false then
  if safe = true then
  begin
    StringGrid1.Cells[ACol, ARow] := '$' + IntToHex(TreeView1.Selected.SelectedIndex, 4);
    if IsBuried(ACol,ARow,A) then
    ApplyBury(ACol,ARow,A);
  end;

  if delete.Down then
  if safe = true then
  begin
    StringGrid1.Cells[ACol, ARow] := '$FFF1';
    if IsBuried(ACol,ARow,A) then
    ApplyBury(ACol,ARow,A);
  end;

  if buryitem.Down then
  if IsBuried(ACol,ARow,A) then
  ApplyBury(ACol,ARow,A)
  else
  if StrToInt(StringGrid1.Cells[ACol, ARow]) >= $9000 then
  if StrToInt(StringGrid1.Cells[ACol, ARow]) <= $CF57 then
  ApplyBury(ACol,ARow,A);

  if coords.Down then
  begin
   // hexlabel.Caption := 'X: ' + IntToHex(ACol + $10,2) +  ' Y: ' + IntToHex(ARow + $10,2);
    //hexlabel.Caption := hexlabel.Caption + #13#10 + IntToStr(1 shl (ACol mod 16));
  end;

  if check.Down then
  begin
    hexlabel.Caption := hlmsg5 + FindItem(TreeView1,StringGrid1.Cells[ACol, ARow]) + ' (' + StringGrid1.Cells[ACol,ARow] + ')';
    check.Down := true;
  end;
    if speedbutton1.Down then
  begin
    hexlabel.Caption := 'Acre: ' + IntToStr(trunc(extended(ACol / 16)) + trunc(extended(ARow / 16))* 5);
  end;

  if bcheck.Down then
  begin
    bID := $FF;
    for I := 0 to 99 do      //Check if it's a sign.
    if B2[I,0] = ACol + $10 then
    if B2[I,1] = ARow + $10 then
    if BE2[I] = true then
    begin
      bID := 35;
      if B[32,0] = ACol + $10 then  //Ok, it's a sign. Now let's see if it's a UFO (might not be needed).
      if B[32,1] = ARow + $10 then
      if BE[32] = true then
      begin
        bID := 32;
        break; //UFO
      end;
      for X := 0 to 17 do   //Ok, it's a sign. Now let's see if it's a neighbor or player house.
      if B[X,0] = ACol + $10 then
      if B[X,1] = ARow + $10 then
      if BE[X] = true then
      begin
        bID := X;
        Break;    //Player or neighbor house
      end;
      Break;     //Sign
    end;

    if bID = $FF then    //Not a sign, so we need to check other buildings, including neighbor and player houses to be safe.
    for I := 0 to 34 do
    if B[I,0] = ACol + $10 then
    if B[I,1] = ARow + $10 then
    if BE[I] = true then
    begin
      bID := I;
      Break;      //It's a building
    end;
    if bID <> $FF then
    begin
      hexlabel.Caption := hlmsg6 + GetBuilding(bID) + '. You can move it by clicking the "move" button.';
      Old[0,0] := ACol + $10;
      Old[0,1] := ARow + $10;
    end
    else
    hexlabel.Caption := hlmsg3;
  end;

  if bmove.Down then
  begin
    safe := true;
    for I := 0 to 34 do
    begin
      if BE[I] = true then
      if ACol = B[I,0] - $10 then
      if ARow = B[I,1] - $10 then
      begin
        Safe := false;    //Make sure not to "stack" buildings
        Break;
      end;
    end;
    for I := 0 to 99 do
    begin
      if BE2[I] = true then
      if ACol = B2[I,0] - $10 then
      if ARow = B2[I,1] - $10 then
      begin
        Safe := false;    //Make sure not to "stack" buildings on signs
        Break;
      end;
    end;

    if Safe = true then
    if bID < $FF then
    begin
      if bID <> 35 then              //if not sign
      begin
        for I := 0 to 99 do
        if B2[I,0] = B[bID,0] then
        if B2[I,1] = B[bID,1] then
        begin
          B2[I,0] := ACol + $10;           //Update sign coordinates if needed
          B2[I,1] := ARow + $10;
        end;
        B[bID,0] := ACol + $10;           //Update building coordinates
        B[bID,1] := ARow + $10;
      end
      else
      for I := 0 to 99 do  //Update sign
      if B2[I,0] = Old[0,0] then
      if B2[I,1] = Old[0,1] then
      begin
        B2[I,0] := ACol + $10;
        B2[I,1] := ARow + $10;
      end;

      if bID >= 34 then  //Update bus stop or sign item
      begin
        if StringGrid1.Cells[Old[0,0] - $10,Old[0,1] - $10] = '$7003' then
        StringGrid1.Cells[ACol,ARow] := '$7003'
        else if StringGrid1.Cells[Old[0,0] - $10,Old[0,1] - $10] = '$D000' then
        StringGrid1.Cells[ACol,ARow] := '$D000';
        StringGrid1.Cells[Old[0,0] - $10,Old[0,1] - $10] := '$FFF1';
      end;
      Old[0,0] := ACol + $10;
      Old[0,1] := ARow + $10;
      bCheck.Down := true;
      hexlabel.Caption := hlmsg3;
      if bID < 35 then
      UpdateUsed(bID);
      bID := $FF;
    end;

  end;

  if bplace.Down then
  begin
      safe := true;
      for I := 0 to 34 do
      begin
        if B[I,0] = ACol + $10 then
        if B[I,1] = ARow + $10 then
        begin
          safe := false;
          break;
        end;
      end;

      if safe = true then
      for I := 0 to 99 do
      begin
        if B2[I,0] = ACol + $10 then
        if B2[I,1] = ARow + $10 then
        begin
         safe := false;
         break;
        end;
      end;

    if safe = true then
    if pb <> 35 then
    begin

      case pb of
      0..17:
      for I := 0 to 99 do
      if BE2[I] = false then
      begin
        B2[I,0] := ACol + $10;
        B2[I,1] := ARow + $10;
        BE2[I] := true;
        break;
      end
      else if I = 99 then
      begin
        MessageBox(Handle,'No sign post slots left. Unable to place this building.','Error',MB_ICONERROR);
        Exit;
      end;
      end;

      B[pb,0] := ACol + $10;
      B[pb,1] := ARow + $10;
      BE[pb] := true;
      if pb = 34 then
      StringGrid1.Cells[ACol,ARow] := '$7003';
      UpdateUsed(pb);

      bcheck.Down := true;
      hexlabel.Caption := hlmsg3;
    end
    else begin
      for I := 0 to 99 do
      if B2[I,0] = 0 then
      if B2[I,1] = 0 then
      begin
       B2[I,0] := ACol + $10;
       B2[I,1] := ARow + $10;
       BE2[I] := true;
       StringGrid1.Cells[ACol,ARow] := '$D000';
       break;
      end;

      if pb = 35 then
      for I := 0 to 99 do
      if BE2[I] = false then
      begin
        Break;
      end
      else if I = 99 then
      begin
        bcheck.Down := true;
        hexlabel.Caption := hlmsg3;
        break;
      end;

    end;

  end;

  if bdelete.Down then
  begin
    for I := 0 to 34 do
    begin
      if B[I,0] = ACol + $10 then
      if B[I,1] = ARow + $10 then
      begin
        B[I,0] := 0;
        B[I,1] := 0;
        if I = 34 then
        StringGrid1.Cells[ACol,ARow] := '$FFF1';
        UpdateUsed(I);
        BE[I] := false;
      end;

    end;
    for I := 0 to 99 do
    begin
      if B2[I,0] = ACol + $10 then
      if B2[I,1] = ARow + $10 then
      begin
        BE2[I] := false;
        B2[I,0] := 0;
        B2[I,1] := 0;
        if StringGrid1.Cells[ACol,ARow] = '$D000' then
        StringGrid1.Cells[ACol,ARow] := '$FFF1';
      end;
    end;
  end;

  if gCheck.Down then
  gval.Text := IntToStr(G[ACol,ARow]);

  if gSet.Down then
  try
    if StrToInt(gval.Text) > 255  then
    gval.Text := '255';
    G[ACol,ARow] := StrToInt(gVal.Text);
  except
    MessageBox(Handle,'Please use a number between 0 and 255.','Error',MB_ICONERROR);
  end;


end;

procedure TTownEditorWin.Timer1Timer(Sender: TObject);
begin
  LoadItems(TreeView1,true,true,false);
  Treeview1.Items[0].Delete;
  Timer1.Free;
  //DrawGrid;
  //boot := false;
end;

procedure TTownEditorWin.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  if TreeView1.Items.Count > 1 then
  if TreeView1.Selected.HasChildren = false then
  begin
    replace.Down := true;
    replace.Click;
  end
  else if replace.Down then
  hexlabel.Caption := hlmsg2;
end;

procedure TTownEditorWin.TreeView1Enter(Sender: TObject);
begin
  if TreeView1.Selected <> nil then
  if TreeView1.Selected.Parent <> nil then
  begin
    replace.Down := true;
    replace.Click;
  end;
end;

function GetBuilding(bID: byte): String;
begin
  case bID of
    0:
      Result := 'Player House A';
    1:
      Result := 'Player House B';
    2:
      Result := 'Player House C';
    3:
      Result := 'Player House D';
    8:
      Result := 'Neighbor House 1';
    9:
      Result := 'Neighbor House 2';
    10:
      Result := 'Neighbor House 3';
    11:
      Result := 'Neighbor House 4';
    12:
      Result := 'Neighbor House 5';
    13:
      Result := 'Neighbor House 6';
    14:
      Result := 'Neighbor House 7';
    15:
      Result := 'Neighbor House 8';
    16:
      Result := 'Neighbor House 9';
    17:
      Result := 'Neighbor House 10';
    18:
      Result := 'Town Hall';
    19:
      Result := 'Gate';
    20:
      Result := 'Nook''s Store';
    21:
      Result := 'Able Sister''s Store';
    22:
      Result := 'Museum';
    23:
      Result := 'Bulletin Board';
    24:
      Result := 'New Year''s Sign';
    25:
      Result := 'Chip''s Stand';
    26:
      Result := 'Nat''s Stand';
    27:
      Result := 'Lighthouse';  //Lighthouse only?
    28:
      Result := 'Windmill';  //Windmill only?
    29:
      Result := 'Fountain';
    30:
      Result := 'Harvest Festival table 1';
    31:
      Result := 'Harvest Festival table 2';
    32:
      Result := 'Gulliver''s UFO';
    33:
      Result := 'Pavé''s Sign';
    34:
      Result := 'Bus Stop';
    35:
      Result := 'Sign';

  else Result := 'Unknown, dangerous';
  end;

end;

function IsBuried(ACol: Integer; ARow: Integer; Acre: Integer): boolean;
begin
  if 1 shl (ACol mod 16) and Buried[(ARow mod 16) + (Acre*16)] = 1 shl (ACol mod 16) then
  Result := true
  else
  Result := false;
end;

procedure ApplyBury(ACol: Integer; ARow: Integer; Acre: Integer);
begin
  Buried[(ARow mod 16) + (Acre*16)] := Buried[(ARow mod 16) + (Acre*16)] xor 1 shl (ACol mod 16);
end;

end.
