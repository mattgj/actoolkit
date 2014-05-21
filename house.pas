unit house;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, global, ComCtrls, StdCtrls, Buttons, ExtCtrls, find;

type
  TForm11 = class(TForm)
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    delete: TSpeedButton;
    replace: TSpeedButton;
    check: TSpeedButton;
    hexlabel: TLabel;
    Label1: TLabel;
    Button1: TButton;
    cancel: TButton;
    apply: TButton;
    TreeView1: TTreeView;
    StringGrid2: TStringGrid;
    Label2: TLabel;
    StringGrid4: TStringGrid;
    StringGrid3: TStringGrid;
    Label3: TLabel;
    StringGrid6: TStringGrid;
    StringGrid5: TStringGrid;
    Label4: TLabel;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Timer1Timer(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Enter(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid2SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid3SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid4DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid4SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid5SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid5DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid6DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid6SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure cancelClick(Sender: TObject);
    procedure applyClick(Sender: TObject);
    procedure checkClick(Sender: TObject);
    procedure replaceClick(Sender: TObject);
    procedure deleteClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid2MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid2MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid3MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid3MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid4MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid4MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid5MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid5MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid6MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid6MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGrid2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SelectCell(Grid: TStringGrid; ACol: Integer; ARow: Integer);
    procedure DrawCell(Grid: TStringGrid; ACol: Integer; ARow: Integer; Rect: TRect; max: boolean);
  end;
  

var
  Form11: TForm11;

implementation

{$R *.dfm}

procedure TForm11.FormCreate(Sender: TObject);
var
  X,Y: Integer;
  buffer: word;
begin
  hexlabel.Caption := hlmsg1;
  FS.Seek($6DE6C + ($15C0 * imode),0);
  for Y := 0 to 15 do
  for X := 0 to 15 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    StringGrid1.Cells[X,Y] := '$' + IntToHex(ReverseW(buffer),4);
  end;
  for Y := 0 to 15 do
  for X := 0 to 15 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    StringGrid2.Cells[X,Y] := '$' + IntToHex(ReverseW(buffer),4);
  end;

  FS.Seek($6DE6C + $458 + ($15C0 * imode),0);
  for Y := 0 to 15 do
  for X := 0 to 15 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    StringGrid3.Cells[X,Y] := '$' + IntToHex(ReverseW(buffer),4);
  end;
  for Y := 0 to 15 do
  for X := 0 to 15 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    StringGrid4.Cells[X,Y] := '$' + IntToHex(ReverseW(buffer),4);
  end;

  FS.Seek($6DE6C + ($458 * 2) + ($15C0 * imode),0);
  for Y := 0 to 15 do
  for X := 0 to 15 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    StringGrid5.Cells[X,Y] := '$' + IntToHex(ReverseW(buffer),4);
  end;
  for Y := 0 to 15 do
  for X := 0 to 15 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    StringGrid6.Cells[X,Y] := '$' + IntToHex(ReverseW(buffer),4);
  end;

end;

procedure TForm11.replaceClick(Sender: TObject);
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

procedure TForm11.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  DrawCell(StringGrid1,ACol,ARow,Rect,true);
end;

procedure TForm11.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Key := 0;
end;

procedure TForm11.StringGrid1MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm11.StringGrid1MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm11.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  SelectCell(StringGrid1,ACol,ARow);
end;

procedure TForm11.StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  DrawCell(StringGrid2,ACol,ARow,Rect,true);
end;

procedure TForm11.StringGrid2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Key := 0;
end;

procedure TForm11.StringGrid2MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm11.StringGrid2MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm11.StringGrid2SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  SelectCell(StringGrid2,ACol,ARow);
end;

procedure TForm11.StringGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  DrawCell(StringGrid3,ACol,ARow,Rect,false);
end;

procedure TForm11.StringGrid3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Key := 0;
end;

procedure TForm11.StringGrid3MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm11.StringGrid3MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm11.StringGrid3SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  SelectCell(StringGrid3,ACol,ARow);
end;

procedure TForm11.StringGrid4DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  DrawCell(StringGrid4,ACol,ARow,Rect,false);
end;

procedure TForm11.StringGrid4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Key := 0;
end;

procedure TForm11.StringGrid4MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm11.StringGrid4MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm11.StringGrid4SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  SelectCell(StringGrid4,ACol,ARow);
end;

procedure TForm11.StringGrid5DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  DrawCell(StringGrid5,ACol,ARow,Rect,true);
end;

procedure TForm11.StringGrid5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Key := 0;
end;

procedure TForm11.StringGrid5MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm11.StringGrid5MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm11.StringGrid5SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  SelectCell(StringGrid5,ACol,ARow);
end;

procedure TForm11.StringGrid6DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  DrawCell(StringGrid6,ACol,ARow,Rect,true);
end;

procedure TForm11.StringGrid6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Key := 0;
end;

procedure TForm11.StringGrid6MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm11.StringGrid6MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TForm11.StringGrid6SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  SelectCell(StringGrid6,ACol,ARow);
end;

procedure TForm11.Timer1Timer(Sender: TObject);
begin
  LoadItems(TreeView1,true,false,false);
  Treeview1.Items[0].Delete;
  Timer1.Free;
end;

procedure TForm11.TreeView1Change(Sender: TObject; Node: TTreeNode);
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

procedure TForm11.TreeView1Enter(Sender: TObject);
begin
  if TreeView1.Selected <> nil then
  if TreeView1.Selected.Parent <> nil then
  begin
    replace.Down := true;
    replace.Click;
  end;
end;

procedure TForm11.applyClick(Sender: TObject);
var
  X,Y: Integer;
  buffer: word;
begin
  FS.Seek($6DE6C + ($15C0 * imode),0);
  for Y := 0 to 15 do
  for X := 0 to 15 do
  begin
    buffer := ReverseW(StrToInt(StringGrid1.Cells[X,Y]));
    FS.WriteBuffer(buffer,sizeof(buffer));
  end;
  for Y := 0 to 15 do
  for X := 0 to 15 do
  begin
    buffer := ReverseW(StrToInt(StringGrid2.Cells[X,Y]));
    FS.WriteBuffer(buffer,sizeof(buffer));
  end;

  FS.Seek($6DE6C + $458 + ($15C0 * imode),0);
  for Y := 0 to 15 do
  for X := 0 to 15 do
  begin
    buffer := ReverseW(StrToInt(StringGrid3.Cells[X,Y]));
    FS.WriteBuffer(buffer,sizeof(buffer));
  end;
  for Y := 0 to 15 do
  for X := 0 to 15 do
  begin
    buffer := ReverseW(StrToInt(StringGrid4.Cells[X,Y]));
    FS.WriteBuffer(buffer,sizeof(buffer));
  end;

  FS.Seek($6DE6C + ($458 * 2) + ($15C0 * imode),0);
  for Y := 0 to 15 do
  for X := 0 to 15 do
  begin
    buffer := ReverseW(StrToInt(StringGrid5.Cells[X,Y]));
    FS.WriteBuffer(buffer,sizeof(buffer));
  end;
  for Y := 0 to 15 do
  for X := 0 to 15 do
  begin
    buffer := ReverseW(StrToInt(StringGrid6.Cells[X,Y]));
    FS.WriteBuffer(buffer,sizeof(buffer));
  end;
  cm := true;
  Close;
end;

procedure TForm11.Button1Click(Sender: TObject);
begin
  TreeView1.FullCollapse;
  TreeView1.Items[0].Selected := true;
  Check.Down := true;
  hexlabel.Caption := hlmsg1;
end;

procedure TForm11.Button2Click(Sender: TObject);
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

procedure TForm11.cancelClick(Sender: TObject);
begin
  Close;
end;

procedure TForm11.checkClick(Sender: TObject);
begin
  hexlabel.Caption := hlmsg1;
end;

procedure TForm11.deleteClick(Sender: TObject);
begin
  hexlabel.Caption := hlmsg4;
end;

procedure TForm11.DrawCell(Grid: TStringGrid; ACol: Integer; ARow: Integer; Rect: TRect; max: boolean);
var
  str: String;
begin
  str := Grid.Cells[ACol, ARow];
  if str <> '$FFF1' then
  Grid.Canvas.Brush.Color := GetColor(str)
  else
  Grid.Canvas.Brush.Color := clWhite;
  Grid.Canvas.FillRect(Rect);
  Grid.Canvas.Pen.Color := clBlack;
  if max = true then
  begin
    Grid.Canvas.MoveTo(43,65);
    Grid.Canvas.LineTo(131,65);
    Grid.Canvas.LineTo(131,153);
    Grid.Canvas.LineTo(43,153);
    Grid.Canvas.LineTo(43,65);
  end
  else begin
    Grid.Canvas.MoveTo(54,87);
    Grid.Canvas.LineTo(54,153);
    Grid.Canvas.LineTo(120,153);
    Grid.Canvas.LineTo(120,87);
    Grid.Canvas.LineTo(54,87);
  end;
  Grid.Canvas.Pen.Color := clGray;
end;

procedure TForm11.SelectCell(Grid: TStringGrid; ACol: Integer; ARow: Integer);
begin
  if replace.Down then
  if TreeView1.Selected <> nil then
  if TreeView1.Selected.HasChildren = false then
  Grid.Cells[ACol, ARow] := '$' + IntToHex(TreeView1.Selected.SelectedIndex, 4);

  if delete.Down then
  Grid.Cells[ACol, ARow] := '$FFF1';

  if check.Down then
  begin
    hexlabel.Caption := hlmsg5 + FindItem(TreeView1,Grid.Cells[ACol, ARow]) + ' (' + Grid.Cells[ACol,ARow] + ')';
    check.Down := true;
  end;
end;

end.
