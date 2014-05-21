unit grasseditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons, global, wait;

type
  TForm9 = class(TForm)
    StringGrid1: TStringGrid;
    check: TSpeedButton;
    replace: TSpeedButton;
    gval: TEdit;
    Label1: TLabel;
    apply: TButton;
    cancel: TButton;
    backdrop: TCheckBox;
    acregrid: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure backdropClick(Sender: TObject);
    procedure acregridClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cancelClick(Sender: TObject);
    procedure applyClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function GetGrassColor(code: byte): TColor;

var
  Form9: TForm9;
  Acres: Array[0..24] of Word;
  //G: Array[0..6399] of Byte;

implementation

{$R *.dfm}

procedure TForm9.acregridClick(Sender: TObject);
begin
  StringGrid1.Refresh;
end;

procedure TForm9.applyClick(Sender: TObject);
var
  A,X,X2,Y,Y2: Integer;
  buffer: byte;
begin
  FS.Seek($6BCB6,0);
  for A := 0 to 25 - 1 do
  for Y2 := 0 to 3 do
  for X2 := 0 to 1 do
  for Y := 0 to 4 - 1 do
  for X := 0 to 8 - 1 do
  begin
    buffer := StrToInt(stringGrid1.Cells[(X+(X2*8)) + ((A mod 5) * 16),(Y+(Y2*4)) + ((A div 5) * 16)]);
    FS.WriteBuffer(buffer,sizeof(buffer));
  end;
  cm := true;
  Close;
end;

procedure TForm9.backdropClick(Sender: TObject);
begin
  StringGrid1.Refresh;
end;

procedure TForm9.Button1Click(Sender: TObject);
var
  X,Y: Integer;
  dialog: TForm14;
begin
  dialog := TForm14.Create(self);
  dialog.Show;
  dialog.Refresh;
  for Y := 0 to 79 do
  for X := 0 to 79 do
  if StringGrid1.Cells[X,Y] <> '255' then
  StringGrid1.Cells[X,Y] := '255';
  dialog.Free;
end;

procedure TForm9.Button2Click(Sender: TObject);
var
  X,Y: Integer;
  dialog: TForm14;
begin
  dialog := TForm14.Create(self);
  dialog.Show;
  dialog.Refresh;
  for Y := 0 to 799 do
  for X := 0 to 799 do
  if StringGrid1.Cells[X,Y] <> '0' then
  StringGrid1.Cells[X,Y] := '0';
  dialog.Free;
end;

procedure TForm9.cancelClick(Sender: TObject);
begin
  Close;
end;

procedure TForm9.FormCreate(Sender: TObject);
var
  A,X,X2,Y2,Y: Integer;
  buffer: word;
  bufferB: byte;
begin

  FS.Seek($6BCB6,0);

  for A := 0 to 25 - 1 do
  for Y2 := 0 to 3 do
  for X2 := 0 to 1 do
  for Y := 0 to 4 - 1 do
  for X := 0 to 8 - 1 do
  begin
    FS.ReadBuffer(bufferB,sizeof(bufferB));
    stringGrid1.Cells[(X+(X2*8)) + ((A mod 5) * 16),(Y+(Y2*4)) + ((A div 5) * 16)] := IntToStr(bufferB);
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

end;

procedure TForm9.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  A,I,P: Integer;
  bmp: TBitmap;
begin
  A := trunc(extended(ACol / 16)) + trunc(extended(ARow / 16))* 5;
  if backdrop.Checked = true then
  begin
    bmp := TBitmap.Create;
    bmp.LoadFromResourceName(hInstance,'A' + IntToStr(Acres[A]));
    StringGrid1.Canvas.Brush.Color := bmp.Canvas.Pixels[ACol mod 16, ARow mod 16];
    bmp.Free;
  end
  else StringGrid1.Canvas.Brush.Color := clWhite;
  if StrToInt(StringGrid1.Cells[ACol,ARow]) < $A0 then
  begin
    if StrToInt(StringGrid1.Cells[ACol,ARow]) < $80 then
    StringGrid1.Canvas.Brush.Color := RGB($66,$33,0)
    else
    StringGrid1.Canvas.Brush.Color := RGB($99,$33,0);
  end;

  StringGrid1.Canvas.FillRect(Rect);
 // StringGrid1.Canvas.Brush.Color := GetGrassColor(StrToInt(StringGrid1.Cells[ACol,ARow]));
 // else StringGrid1.Canvas.Brush.Color := RGB($0,$FF,$0);
  //StringGrid1.Canvas.Brush.Color := ReverseW(StrToInt(StringGrid1.Cells[ACol,ARow]));

  if acreGrid.Checked = true then
  begin
    StringGrid1.Canvas.Pen.Color := gridc;
    for I := 1 to 4 do                             //Draw acre border
    begin
      P := ((143 * I) + (I - 1)) - (StringGrid1.LeftCol * 9);
      StringGrid1.Canvas.MoveTo(P,0);
      StringGrid1.Canvas.LineTo(P,740);
      P := ((143 * I) + (I - 1)) - (StringGrid1.TopRow * 9);
      StringGrid1.Canvas.MoveTo(0,P);
      StringGrid1.Canvas.LineTo(740,P);
    end;
    StringGrid1.Canvas.Pen.Color := clGray;
  end;

end;

procedure TForm9.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if check.Down then
  gval.Text := IntToStr(StrToInt(StringGrid1.Cells[ACol,ARow]));

  if replace.Down then
  try
    if StrToInt(gval.Text) > 255  then
    gval.Text := '255';
    StringGrid1.Cells[ACol,ARow] := gval.Text;
  except
    MessageBox(Handle,'Please use a number between 0 and 255.','Error',MB_ICONERROR);
  end;

end;

function GetGrassColor(code: byte): TColor;
begin
  Result := 0;

  if code > 50 then
  if code < 150 then
  begin
    Result := RGB(0,$50,0);
    exit;
  end;

  if code > 150 then
  begin
    Result := RGB(0,$FF,0);
    exit;
  end;

end;

end.
