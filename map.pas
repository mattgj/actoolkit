unit map;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, global, Menus, Jpeg;

type
  TForm6 = class(TForm)
    StringGrid1: TStringGrid;
    PopupMenu1: TPopupMenu;
    Close1: TMenuItem;
    Refresh1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1MouseEnter(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Refresh1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure RefreshAcres;
  end;

var
  Form6: TForm6;
  A: Array[0..6] of Array[0..6] of Word;

implementation

{$R *.dfm}

procedure TForm6.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm6.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Free;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  RefreshAcres;
  Width := StringGrid1.Width - 10;
  Height := StringGrid1.Height - 10;
end;

procedure TForm6.Refresh1Click(Sender: TObject);
begin
  RefreshAcres;
end;

procedure TForm6.RefreshAcres;
var
  X,Y: Integer;
  buffer: word;
begin
  FS.Seek($68414,0);
  for Y := 0 to 6 do
  for X := 0 to 6 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    buffer := ReverseW(buffer);
    if buffer > 367 then
    buffer := buffer and $FF;
    StringGrid1.Cells[X,Y] := IntToStr(buffer)
  end;
end;

procedure TForm6.Save1Click(Sender: TObject);
var
  jpg: TJpegImage;
  bmp: TBitmap;
begin
  try
    jpg := TJpegImage.Create;
    bmp := TBitmap.Create;
    bmp.SetSize(StringGrid1.Width - 10,StringGrid1.Height - 10);
    BitBlt(bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height, StringGrid1.Canvas.Handle, 0, 0, SRCCOPY);
    jpg.Assign(bmp);
    jpg.SaveToFile(ExtractFilePath(ParamStr(0)) + 'map.jpg');
    jpg.Free;
    bmp.Free;
    MessageBox(Handle,'Saved to map.jpg','Saved',MB_ICONINFORMATION);
  except
    MessageBox(Handle,'Error saving map!','Error',MB_ICONERROR);
  end;
end;

procedure TForm6.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  bmp: TBitmap;
begin
  try
    StringGrid1.Canvas.Lock;
    bmp := TBitmap.Create;
    bmp.LoadFromResourceName(hInstance,'A' + StringGrid1.Cells[ACol,ARow]);
    StringGrid1.Canvas.StretchDraw(rect,bmp);
    bmp.Free;
    StringGrid1.Canvas.Unlock;
  except
  end;
end;

procedure TForm6.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if button = mbLeft then
  begin
    AlphaBlendValue := 100;
    ReleaseCapture;
    SendMessage(Handle, WM_SYSCOMMAND, 61458, 0);
  end
  else
  PopupMenu1.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TForm6.StringGrid1MouseEnter(Sender: TObject);
begin
  AlphaBlendValue := 255;
end;

end.
