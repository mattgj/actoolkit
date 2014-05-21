unit language;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, global, StdCtrls;

type
  TForm13 = class(TForm)
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13: TForm13;

implementation

{$R *.dfm}

procedure TForm13.Button1Click(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    2: lang := 1;
    3: lang := 2;
    1: lang := 3;
    else lang := ComboBox1.ItemIndex;
  end;
  WriteSettings;
  Close;
end;

procedure TForm13.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm13.FormCreate(Sender: TObject);
begin
  case lang of
    1: ComboBox1.ItemIndex := 2;
    2: ComboBox1.ItemIndex := 3;
    3: ComboBox1.ItemIndex := 1;
    else ComboBox1.ItemIndex := lang;
  end;
end;

end.
