unit emotions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Global;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Label3: TLabel;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label4: TLabel;
    apply: TButton;
    cancel: TButton;
    ComboBox1: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure applyClick(Sender: TObject);
    procedure cancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.applyClick(Sender: TObject);
var
  buffer: byte;
  I: Integer;
begin
  FS.Seek($8634 + Player_Offset, 0);

  for I := 0 to 3 do
  begin
    case I of
      0:
        buffer := ComboBox1.ItemIndex;
      1:
        buffer := ComboBox2.ItemIndex;
      2:
        buffer := ComboBox3.ItemIndex;
      3:
        buffer := ComboBox4.ItemIndex;
    end;
    if buffer = 0 then
    buffer := $FF
    else
    buffer := buffer - 1;
    FS.WriteBuffer(buffer,sizeof(buffer));
  end;
  cm := true;
  Close;
end;

procedure TForm3.cancelClick(Sender: TObject);
begin
  Close;
end;

procedure TForm3.FormCreate(Sender: TObject);
var
  buffer: byte;
  I: Integer;
begin
 ComboBox2.Items := ComboBox1.Items;
 ComboBox3.Items := ComboBox1.Items;
 ComboBox4.Items := ComboBox1.Items;
 FS.Seek($8634 + Player_Offset, 0);

 for I := 0 to 3 do
 begin
   FS.ReadBuffer(buffer, sizeof(buffer));
   if buffer = $FF then
   buffer := 0
   else
   if buffer > $1D then
   buffer  := 0
   else
   buffer := buffer + 1;

   case I of
     0:
       ComboBox1.ItemIndex := buffer;
     1:
       ComboBox2.ItemIndex := buffer;
     2:
       ComboBox3.ItemIndex := buffer;
     3:
       ComboBox4.ItemIndex := buffer;
   end;

 end;



end;

end.
