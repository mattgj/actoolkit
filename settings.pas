unit settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, global;

type
  TForm10 = class(TForm)
    ColorDialog1: TColorDialog;
    treebox: TEdit;
    Label1: TLabel;
    flowerbox: TEdit;
    Label2: TLabel;
    flower2box: TEdit;
    Label3: TLabel;
    itembox: TEdit;
    Label4: TLabel;
    item2box: TEdit;
    Label5: TLabel;
    rockbox: TEdit;
    Label6: TLabel;
    patternbox: TEdit;
    Label7: TLabel;
    weedbox: TEdit;
    Label8: TLabel;
    otherbox: TEdit;
    Label9: TLabel;
    gridbox: TEdit;
    Label10: TLabel;
    Apply: TButton;
    Cancel: TButton;
    buriedbox: TEdit;
    Label11: TLabel;
    buildingbox: TEdit;
    Label12: TLabel;
    procedure CancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure treeboxChange(Sender: TObject);
    procedure flowerboxChange(Sender: TObject);
    procedure flower2boxChange(Sender: TObject);
    procedure weedboxChange(Sender: TObject);
    procedure rockboxChange(Sender: TObject);
    procedure patternboxChange(Sender: TObject);
    procedure itemboxChange(Sender: TObject);
    procedure item2boxChange(Sender: TObject);
    procedure otherboxChange(Sender: TObject);
    procedure gridboxChange(Sender: TObject);
    procedure buildingboxChange(Sender: TObject);
    procedure buriedboxChange(Sender: TObject);
    procedure ApplyClick(Sender: TObject);
    procedure treeboxDblClick(Sender: TObject);
    procedure flowerboxDblClick(Sender: TObject);
    procedure flower2boxDblClick(Sender: TObject);
    procedure weedboxDblClick(Sender: TObject);
    procedure rockboxDblClick(Sender: TObject);
    procedure patternboxDblClick(Sender: TObject);
    procedure itemboxDblClick(Sender: TObject);
    procedure item2boxDblClick(Sender: TObject);
    procedure otherboxDblClick(Sender: TObject);
    procedure gridboxDblClick(Sender: TObject);
    procedure buildingboxDblClick(Sender: TObject);
    procedure buriedboxDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure changeColor(editbox: TEdit);
  function ColorToString(color: TColor): String;
  function StringToColor(rgbstr: String): TColor;

var
  Form10: TForm10;

implementation

{$R *.dfm}

procedure TForm10.ApplyClick(Sender: TObject);
begin
  try
    treec := StringToColor(treebox.Text);
    flowerc := StringToColor(flowerbox.Text);
    flower2c := StringToColor(flower2box.Text);
    weedc := StringToColor(weedbox.Text);
    rockc := StringToColor(rockbox.Text);
    patternc := StringToColor(patternbox.Text);
    itemc := StringToColor(itembox.Text);
    item2c := StringToColor(item2box.Text);
    otherc := StringToColor(otherbox.Text);
    gridc := StringToColor(gridbox.Text);
    buildingc := StringToColor(buildingbox.Text);
    buriedc := StringToColor(buriedbox.Text);
  except
  end;
  WriteSettings;
  Close;
end;

procedure TForm10.buildingboxChange(Sender: TObject);
begin
  changeColor(buildingbox);
end;

procedure TForm10.buildingboxDblClick(Sender: TObject);
begin
  if ColorDialog1.Execute(Handle) then
  begin
    buildingbox.Text := ColorToString(ColorDialog1.Color);
  end;
end;

procedure TForm10.buriedboxChange(Sender: TObject);
begin
  changeColor(buriedbox);
end;

procedure TForm10.buriedboxDblClick(Sender: TObject);
begin
  if ColorDialog1.Execute(Handle) then
  begin
    buriedbox.Text := ColorToString(ColorDialog1.Color);
  end;
end;

procedure TForm10.CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TForm10.flower2boxChange(Sender: TObject);
begin
  changeColor(flower2box);
end;

procedure TForm10.flower2boxDblClick(Sender: TObject);
begin
  if ColorDialog1.Execute(Handle) then
  begin
    flower2box.Text := ColorToString(ColorDialog1.Color);
  end;
end;

procedure TForm10.flowerboxChange(Sender: TObject);
begin
  changeColor(flowerbox);
end;

procedure TForm10.flowerboxDblClick(Sender: TObject);
begin
  if ColorDialog1.Execute(Handle) then
  begin
    flowerbox.Text := ColorToString(ColorDialog1.Color);
  end;
end;

procedure TForm10.FormCreate(Sender: TObject);
begin
  treebox.Text := ColorToString(treec);
  flowerbox.Text := ColorToString(flowerc);
  flower2box.Text := ColorToString(flower2c);
  weedbox.Text := ColorToString(weedc);
  rockbox.Text := ColorToString(rockc);
  patternbox.Text := ColorToString(patternc);
  itembox.Text := ColorToString(itemc);
  item2box.Text := ColorToString(item2c);
  otherbox.Text := ColorToString(otherc);
  gridbox.Text := ColorToString(gridc);
  buildingbox.Text := ColorToString(buildingc);
  buriedbox.Text := ColorToString(buriedc);
end;

procedure TForm10.gridboxChange(Sender: TObject);
begin
  changeColor(gridbox);
end;

procedure TForm10.gridboxDblClick(Sender: TObject);
begin
  if ColorDialog1.Execute(Handle) then
  begin
    gridbox.Text := ColorToString(ColorDialog1.Color);
  end;
end;

procedure TForm10.item2boxChange(Sender: TObject);
begin
  changeColor(item2box);
end;

procedure TForm10.item2boxDblClick(Sender: TObject);
begin
  if ColorDialog1.Execute(Handle) then
  begin
    item2box.Text := ColorToString(ColorDialog1.Color);
  end;
end;

procedure TForm10.itemboxChange(Sender: TObject);
begin
  changeColor(itembox);
end;

procedure TForm10.itemboxDblClick(Sender: TObject);
begin
  if ColorDialog1.Execute(Handle) then
  begin
    itembox.Text := ColorToString(ColorDialog1.Color);
  end;
end;

procedure TForm10.otherboxChange(Sender: TObject);
begin
  changeColor(otherbox);
end;

procedure TForm10.otherboxDblClick(Sender: TObject);
begin
  if ColorDialog1.Execute(Handle) then
  begin
    otherbox.Text := ColorToString(ColorDialog1.Color);
  end;
end;

procedure TForm10.patternboxChange(Sender: TObject);
begin
  changeColor(patternbox);
end;

procedure TForm10.patternboxDblClick(Sender: TObject);
begin
  if ColorDialog1.Execute(Handle) then
  begin
    patternbox.Text := ColorToString(ColorDialog1.Color);
  end;
end;

procedure TForm10.rockboxChange(Sender: TObject);
begin
  changeColor(rockbox);
end;

procedure TForm10.rockboxDblClick(Sender: TObject);
begin
  if ColorDialog1.Execute(Handle) then
  begin
    rockbox.Text := ColorToString(ColorDialog1.Color);
  end;
end;

procedure TForm10.treeboxChange(Sender: TObject);
begin
  changeColor(treebox);
end;

procedure TForm10.treeboxDblClick(Sender: TObject);
begin
  if ColorDialog1.Execute(Handle) then
  begin
    treebox.Text := ColorToString(ColorDialog1.Color);
  end;
end;

procedure TForm10.weedboxChange(Sender: TObject);
begin
  changeColor(weedbox);
end;

procedure TForm10.weedboxDblClick(Sender: TObject);
begin
  if ColorDialog1.Execute(Handle) then
  begin
    weedbox.Text := ColorToString(ColorDialog1.Color);
  end;
end;

procedure changeColor(editbox: TEdit);
begin
  try
    editbox.Brush.Color := Reverse(StrToInt('$' + editbox.Text + '00'));
    editbox.Font.Color :=  $FFFFFF xor editbox.Brush.Color;
  except
  end;
end;

function ColorToString(color: TColor): String;
begin
  Result := IntToHex(color and $FF,2) + IntToHex((color and $FF00) shr 8,2)
  + IntToHex((color and $FF0000) shr 16,2);
end;

function StringToColor(rgbstr: String): TColor;
begin
  Result := Reverse(StrToInt('$' + rgbstr + '00'));
end;

end.
