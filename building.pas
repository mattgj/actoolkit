unit building;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm15 = class(TForm)
    ComboBox1: TComboBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form15: TForm15;
  index: Array[0..35] of Byte;

implementation

uses
  TownEditor;

{$R *.dfm}

procedure TForm15.Button1Click(Sender: TObject);
begin
  if comboBox1.Items.Strings[0] <> '(none)' then
  pb := index[ComboBox1.ItemIndex]
  else pb := $FF;
  Close;
end;

procedure TForm15.FormCreate(Sender: TObject);
var
  I,S: Integer;
begin
  KeyPreview := true;
  S := 0;
  for I := 0 to 34 do
  begin
    if BE[I] = false then
    if GetBuilding(I) <> GetBuilding(4) then
    begin
      ComboBox1.Items.Add(GetBuilding(I));
      index[ComboBox1.Items.Count - 1] := I;
    end;
  end;

  for I := 0 to 99 do
  begin
    if BE2[I] = false then
    S := S + 1;
  end;

  if S > 0 then
  begin
    ComboBox1.Items.Add(GetBuilding(35) + ' (' + IntToStr(S) + ' left)');
    index[ComboBox1.Items.Count - 1] := 35;
  end;

  if ComboBox1.Items.Count = 0 then
  ComboBox1.Items.Add('(none)');

  ComboBox1.ItemIndex := 0;
end;

procedure TForm15.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F4) and (ssAlt in Shift) then
  Key := 0;
end;

end.
