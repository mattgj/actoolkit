{

  *********************************************
  * Acre Editor code by Virus                 *
  * Background images provided by DsPet       *
  * Copyright (C) 2008-2009 Game-Hackers.com  *
  * All rights reserved.                      *
  *********************************************

}

unit acres;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ComCtrls, Buttons, StdCtrls, ExtCtrls, global;

type
  TForm2 = class(TForm)
    apply: TButton;
    cancel: TButton;
    Timer1: TTimer;
    hexlabel: TLabel;
    Label3: TLabel;
    replace: TSpeedButton;
    check: TSpeedButton;
    TreeView1: TTreeView;
    StringGrid1: TStringGrid;
    collapse: TButton;
    StringGrid2: TStringGrid;
    Label1: TLabel;
    export: TButton;
    import: TButton;
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure applyClick(Sender: TObject);
    procedure cancelClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure replaceClick(Sender: TObject);
    procedure checkClick(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure collapseClick(Sender: TObject);
    procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure exportClick(Sender: TObject);
    procedure importClick(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.applyClick(Sender: TObject);
var
  X,Y: Integer;
  buffer: word;
begin
  hexlabel.Caption := hlmsg8;
  FS.Seek($68414,0);
  for Y := 0 to 6 do
  for X := 0 to 6 do
  begin
    buffer := ReverseW(StrToInt(StringGrid1.Cells[X,Y]));
    FS.WriteBuffer(buffer,sizeof(buffer));
  end;
  cm := true;
  Close;
end;

procedure TForm2.importClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  FS2: TFileStream;
  X,Y: Integer;
  buffer: word;
begin
  OpenDialog := TOpenDialog.Create(nil);
  OpenDialog.DefaultExt := '*.bin';
  OpenDialog.Filter := 'Acre Layout (*.bin)|*.bin';
  OpenDialog.Options := [ofPathMustExist, ofFileMustExist, ofHideReadOnly];
  if OpenDialog.Execute(Handle) then
  begin
    try
      FS2 := TFileStream.Create(OpenDialog.FileName, fmOpenRead);
      if FS2.Size = 98 then
      begin
        for Y := 0 to 6 do
        for X := 0 to 6 do
        begin
          FS2.ReadBuffer(buffer,sizeof(buffer));
          buffer := ReverseW(buffer);
          if buffer > 367 then       //Just to be safe
          buffer := buffer and $FF;
          StringGrid1.Cells[X,Y] := IntToStr(buffer);
        end;
      end
      else
      MessageBox(Handle,'Invalid file!','Error',MB_ICONERROR);
      FS2.Free;
      OpenDialog.Free;
    except
      MessageBox(Handle,'Unable to import layout!','Error',MB_ICONERROR);
    end;
  end;

end;

procedure TForm2.exportClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
  FS2: TFileStream;
  X,Y: Integer;
  buffer: word;
begin
  SaveDialog := TSaveDialog.Create(nil);
  SaveDialog.DefaultExt := '*.bin';
  SaveDialog.Filter := 'Acre Layout (*.bin)|*.bin';
  SaveDialog.Options := [ofOverwritePrompt,ofPathMustExist,ofHideReadOnly];
  if SaveDialog.Execute(Handle) then
  begin
    try
      FS2 := TFileStream.Create(SaveDialog.FileName, fmCreate);
      for Y := 0 to 6 do
      for X := 0 to 6 do
      begin
        buffer := ReverseW(StrToInt(StringGrid1.Cells[X,Y]));
        FS2.WriteBuffer(buffer,sizeof(buffer));
      end;
      FS2.Free;
      SaveDialog.Free;
    except
      MessageBox(Handle,'Unable to export layout!','Error',MB_ICONERROR);
    end;
  end;
end;

procedure TForm2.cancelClick(Sender: TObject);
begin
  Close;
end;

procedure TForm2.checkClick(Sender: TObject);
begin
  hexlabel.Caption := hlmsg1;
end;

procedure TForm2.collapseClick(Sender: TObject);
begin
  TreeView1.FullCollapse;
  TreeView1.Items[0].Selected := true;
  Check.Down := true;
  hexlabel.Caption := hlmsg8;
  StringGrid2.Cells[0,0] := '';
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  X,Y: Integer;
  buffer: word;
begin
  hexlabel.Caption := hlmsg8;
  FS.Seek($68414,0);
  for Y := 0 to 6 do
  for X := 0 to 6 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    buffer := ReverseW(buffer);
    if buffer > 367 then       //Just to be safe
    buffer := buffer and $FF;
    StringGrid1.Cells[X,Y] := IntToStr(buffer);
  end;
end;

procedure TForm2.replaceClick(Sender: TObject);
begin
 if TreeView1.Selected <> nil then
  begin
    if TreeView1.Selected.HasChildren = false then
    hexlabel.Caption := hlmsg7 + TreeView1.Selected.Parent.Text + ' ' + TreeView1.Selected.Text
    else
    hexlabel.Caption := hlmsg2;
  end
  else
  hexlabel.Caption := hlmsg2;
end;

procedure TForm2.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  bmp: TBitmap;
begin
  StringGrid1.Canvas.Lock;
  bmp := TBitmap.Create;
  bmp.LoadFromResourceName(hInstance,'A' + StringGrid1.Cells[ACol,ARow]);
  StringGrid1.Canvas.StretchDraw(rect,bmp);
  bmp.Free;
  StringGrid1.Canvas.Unlock;
end;

procedure TForm2.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  key := 0;
end;

procedure TForm2.StringGrid1MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm2.StringGrid1MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm2.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  name: String;
begin
  if check.Down then
  begin
    name := FindItem(TreeView1,'$' + IntToHex(StrToInt(Stringgrid1.Cells[ACol,ARow]),4)) + ' (' + '$' + IntToHex(StrToInt(Stringgrid1.Cells[ACol,ARow]),4) + ')';
    hexlabel.Caption := hlmsg9 + TreeView1.Selected.Parent.Text + ' ' + name;
    check.Down := true;
  end;
  if replace.Down then
  if TreeView1.Selected <> nil then
  if TreeView1.Selected.HasChildren = false then
  begin
    StringGrid1.Cells[ACol, ARow] := IntToStr(TreeView1.Selected.SelectedIndex);
    //check.Down := true;
    //hexlabel.Caption := hlmsg8;
  end;
end;

procedure TForm2.StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  bmp: TBitmap;
begin
  StringGrid2.Canvas.Lock;
  if StringGrid2.Cells[ACol,ARow] <> '' then
  begin
    bmp := TBitmap.Create;
    bmp.LoadFromResourceName(hInstance,'A' + StringGrid2.Cells[ACol,ARow]);
    StringGrid2.Canvas.StretchDraw(rect,bmp);
    bmp.Free;
  end
  else
  StringGrid2.Canvas.FillRect(Rect);
  StringGrid2.Canvas.Unlock;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  LoadItems(TreeView1,false,false,true);
  TreeView1.Items[0].Delete;
  Timer1.Free;
end;

procedure TForm2.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  if TreeView1.Items.Count > 1 then
  if TreeView1.Selected.HasChildren = false then
  begin
    StringGrid2.Cells[0,0] := IntToStr(TreeView1.Selected.SelectedIndex);
    replace.Down := true;
    replace.Click;
  end
  else if replace.Down then
  begin
    StringGrid2.Cells[0,0] := '';
    hexlabel.Caption := hlmsg2;
  end;
end;

end.
