unit pockets;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ComCtrls, Buttons, Types, global, CRC32, ExtCtrls,
  find;

type
  TForm4 = class(TForm)
    TreeView1: TTreeView;
    StringGrid1: TStringGrid;
    apply: TButton;
    cancel: TButton;
    replace: TSpeedButton;
    delete: TSpeedButton;
    hexlabel: TLabel;
    check: TSpeedButton;
    Timer1: TTimer;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure cancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure applyClick(Sender: TObject);
    procedure replaceClick(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure Timer1Timer(Sender: TObject);
    procedure TreeView1Enter(Sender: TObject);
    procedure deleteClick(Sender: TObject);
    procedure checkClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

Uses
  Main;

{$R *.dfm}

procedure TForm4.applyClick(Sender: TObject);
var
  X,Y: Integer;
  buffer: word;
begin
  case imode of
    0:begin
      FS.Seek($7F42 + Player_Offset,0);
      for X := 0 to 3 - 1 do
      for Y := 0 to 5 - 1 do
      begin
        buffer := ReverseW(StrToInt(StringGrid1.Cells[Y,X]));
        FS.WriteBuffer(buffer, sizeof(buffer));
      end;
    end;
   1:begin
      FS.Seek($1F3038 + ((Player - 1) * $140),0);
      for X := 0 to 32 - 1 do
      for Y := 0 to 5 - 1 do
      begin
        buffer := ReverseW(StrToInt(StringGrid1.Cells[Y,X]));
        FS.WriteBuffer(buffer, sizeof(buffer));
      end;
   end;
   2:begin
      FS.Seek($72DDA,0);
      for X := 0 to 2 - 1 do
      for Y := 0 to 6 - 1 do
      begin
        buffer := ReverseW(StrToInt(StringGrid1.Cells[Y,X]));
        FS.WriteBuffer(buffer, sizeof(buffer));
      end;
   end;
   3:begin
      FS.Seek($72DF2,0);
      for X := 0 to 2 - 1 do
      for Y := 0 to 6 - 1 do
      begin
        buffer := ReverseW(StrToInt(StringGrid1.Cells[Y,X]));
        FS.WriteBuffer(buffer, sizeof(buffer));
      end;
   end;
   4:begin
      FS.Seek($630C8,0);
      for X := 0 to 6 - 1 do
      for Y := 0 to 6 - 1 do
      begin
        buffer := ReverseW(StrToInt(StringGrid1.Cells[Y,X]));
        FS.WriteBuffer(buffer, sizeof(buffer));
        FS.Position := FS.Position + 2;
      end;
   end;
  end;
  cm := true;
  Close;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  TreeView1.FullCollapse;
  TreeView1.Items[0].Selected := true;
  Check.Down := true;
  hexlabel.Caption := hlmsg1;
end;

procedure TForm4.Button2Click(Sender: TObject);
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

procedure TForm4.cancelClick(Sender: TObject);
begin
  Close;
end;

procedure TForm4.checkClick(Sender: TObject);
begin
  hexlabel.Caption := hlmsg1;
end;

procedure TForm4.deleteClick(Sender: TObject);
begin
  hexlabel.Caption := hlmsg4;
end;

procedure TForm4.FormCreate(Sender: TObject);
var
  X,Y: Integer;
  buffer: word;
begin
  hexlabel.Caption := hlmsg1;
  case imode of
    0:begin
      FS.Seek($7F42 + Player_Offset,0);
      for X := 0 to 3 - 1 do
      for Y := 0 to 5 - 1 do
      begin
        FS.ReadBuffer(buffer, sizeof(buffer));
        StringGrid1.Cells[Y,X] := '$' + IntToHex(ReverseW(buffer),4);
      end;
    end;

    1:begin
      Caption := 'Drawer Editor';
      StringGrid1.ScrollBars := ssVertical;
      StringGrid1.ColCount := 5;
      StringGrid1.RowCount := 32;
      StringGrid1.Height := TreeView1.Height;
      StringGrid1.Width := 276;

      FS.Seek($1F3038 + ((Player - 1) * $140),0);
      for X := 0 to 32 - 1 do
      for Y := 0 to 5 - 1 do
      begin
        FS.ReadBuffer(buffer, sizeof(buffer));
        StringGrid1.Cells[Y,X] := '$' + IntToHex(ReverseW(buffer),4);
      end;
    end;

    2:begin
      Caption := 'Lost & Found Editor';
      StringGrid1.ColCount := 6;
      StringGrid1.RowCount := 2;
      StringGrid1.Height := 37;
      StringGrid1.Width := 309;

      FS.Seek($72DDA,0);
      for X := 0 to 2 - 1 do
      for Y := 0 to 6 - 1 do
      begin
        FS.ReadBuffer(buffer, sizeof(buffer));
        StringGrid1.Cells[Y,X] := '$' + IntToHex(ReverseW(buffer),4);
      end;
    end;
    3:begin
      Caption := 'Recycle Bin Editor';
      StringGrid1.ColCount := 6;
      StringGrid1.RowCount := 2;
      StringGrid1.Height := 37;
      StringGrid1.Width := 309;

      FS.Seek($72DF2,0);
      for X := 0 to 2 - 1 do
      for Y := 0 to 6 - 1 do
      begin
        FS.ReadBuffer(buffer, sizeof(buffer));
        StringGrid1.Cells[Y,X] := '$' + IntToHex(ReverseW(buffer),4);
      end;
    end;

    4:begin
      Caption := 'Nook''s Store Editor';
      StringGrid1.ColCount := 6;
      StringGrid1.RowCount := 6;
      StringGrid1.Height := 105;
      StringGrid1.Width := 309;

      FS.Seek($630C8,0);
      for X := 0 to 6 - 1 do
      for Y := 0 to 6 - 1 do
      begin
        FS.ReadBuffer(buffer, sizeof(buffer));
        StringGrid1.Cells[Y,X] := '$' + IntToHex(ReverseW(buffer),4);
        FS.Position := FS.Position + 2;
      end;
    end;

  end;

end;

procedure TForm4.replaceClick(Sender: TObject);
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


procedure TForm4.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  str: String;
begin
  str := StringGrid1.Cells[ACol, ARow];
StringGrid1.Canvas.Font.Color := clGray;
  StringGrid1.Canvas.Font.Style := [fsBold];
   StringGrid1.Canvas.Font.Size := 8;
  if str <> '$FFF1' then
  StringGrid1.Canvas.Brush.Color := GetColor(str)
  else
  StringGrid1.Canvas.Brush.Color := clWhite;
  StringGrid1.Canvas.FillRect(Rect);
  DrawText(StringGrid1.Canvas.Handle, str, Length(str),rect,DT_CENTER);
end;

procedure TForm4.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  key := 0;
end;

procedure TForm4.StringGrid1MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm4.StringGrid1MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm4.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if replace.Down then
  if TreeView1.Selected <> nil then
  if TreeView1.Selected.HasChildren = false then
  StringGrid1.Cells[ACol, ARow] := '$' + IntToHex(TreeView1.Selected.SelectedIndex, 4);

  if delete.Down then
  StringGrid1.Cells[ACol, ARow] := '$FFF1';

  if check.Down then
  begin
    hexlabel.Caption := hlmsg5 + FindItem(TreeView1,StringGrid1.Cells[ACol, ARow]) + ' (' + StringGrid1.Cells[ACol,ARow] + ')';
    check.Down := true;
  end;
end;

procedure TForm4.Timer1Timer(Sender: TObject);
begin
  LoadItems(TreeView1,true,false,false);
  Treeview1.Items[0].Delete;
  Timer1.Free;
end;

procedure TForm4.TreeView1Change(Sender: TObject; Node: TTreeNode);
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

procedure TForm4.TreeView1Enter(Sender: TObject);
begin
  if TreeView1.Selected <> nil then
  if TreeView1.Selected.Parent <> nil then
  begin
    replace.Down := true;
    replace.Click;
  end;
end;

end.
