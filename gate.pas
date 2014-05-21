unit gate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, global;

type
  TForm7 = class(TForm)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    apply: TButton;
    cancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure applyClick(Sender: TObject);
    procedure cancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.applyClick(Sender: TObject);
var
  buffer: byte;
begin
  FS.Seek($5EAE0,0);
  if radiobutton1.Checked = true then
  buffer := 0
  else
  if radiobutton2.Checked = true then
  buffer := 1
  else
  buffer := 2;

  FS.WriteBuffer(buffer,sizeof(buffer));
  cm := true;
  Close;
end;

procedure TForm7.cancelClick(Sender: TObject);
begin
  Close;
end;

procedure TForm7.FormCreate(Sender: TObject);
var
  buffer: byte;
begin
  FS.Seek($5EAE0,0);
  FS.ReadBuffer(buffer,sizeof(buffer));
  if buffer > 2 then
  buffer := 0;

  case buffer of
    0:
      RadioButton1.Checked := true;
    1:
      RadioButton2.Checked := true;
    2:
      RadioButton3.Checked := true;
  end;
end;

end.
