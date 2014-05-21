unit face;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, global;

type
  TForm5 = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    ComboBox2: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox3: TComboBox;
    apply: TButton;
    cancel: TButton;
    ComboBox4: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    ComboBox5: TComboBox;
    procedure applyClick(Sender: TObject);
    procedure cancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.applyClick(Sender: TObject);
var
  I: Integer;
  buffer: byte;
begin
  FS.Seek($840A + Player_Offset,0);
  FS.ReadBuffer(buffer,sizeof(buffer));
  buffer := buffer and $F0;
  FS.Seek($840A + Player_Offset,0);
  for I := 0 to 3 do
  begin
    case I of
      0:
        buffer := buffer + ComboBox1.ItemIndex;
      1:
        buffer := ComboBox2.ItemIndex;
      2:
        buffer := ComboBox3.ItemIndex;
      3:begin
        FS.Seek($8416 + Player_Offset,0);
        buffer := ComboBox4.ItemIndex;
      end;
    end;
    FS.WriteBuffer(buffer,sizeof(buffer));
  end;

  FS.Seek($8418 + Player_Offset,0);
  buffer := ComboBox5.ItemIndex shl 1;
  FS.WriteBuffer(buffer,sizeof(buffer));

  cm := true;
  Close;
end;

procedure TForm5.cancelClick(Sender: TObject);
begin
  Close;
end;

procedure TForm5.FormCreate(Sender: TObject);
var
  I: Integer;
  buffer: byte;
begin
  FS.Seek($840A + Player_Offset,0);
  for I := 0 to 3 do
  begin
    FS.ReadBuffer(buffer,sizeof(buffer));
    case I of
      0:
        ComboBox1.ItemIndex := buffer and $F;
      1: begin
        if buffer > $19 then
        buffer := $19;
        ComboBox2.ItemIndex := buffer;
      end;
      2: begin
        if buffer > 7  then
        buffer := 7;
        ComboBox3.ItemIndex := buffer;
      end;
      3:begin
        FS.Seek($8416 + Player_Offset,0);
        FS.ReadBuffer(buffer,sizeof(buffer));
        ComboBox4.ItemIndex := buffer;
      end;
    end;
  end;

  FS.Seek($8418 + Player_Offset,0);
  FS.ReadBuffer(buffer,sizeof(buffer));
  buffer := buffer shr 1;
  if buffer > 7 then
  ComboBox5.ItemIndex := 0
  else ComboBox5.ItemIndex := buffer;

end;

end.
