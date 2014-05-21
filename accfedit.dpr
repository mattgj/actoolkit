program accfedit;





{$R 'acrebmp.res' 'acrebmp.rc'}

uses
  Forms,
  Windows,
  SysUtils,
  main in 'main.pas' {Form1},
  towneditor in 'towneditor.pas' {TownEditorWin},
  about in 'about.pas' {AboutWin},
  pockets in 'pockets.pas' {Form4},
  global in 'global.pas',
  CRC32 in 'CRC32.pas',
  emotions in 'emotions.pas' {Form3},
  face in 'face.pas' {Form5},
  acres in 'acres.pas' {Form2},
  map in 'map.pas' {Form6},
  settings in 'settings.pas' {Form10},
  house in 'house.pas' {Form11},
  find in 'find.pas' {Form12},
  items in 'items.pas',
  wait in 'wait.pas' {Form14},
  building in 'building.pas' {Form15};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReadSettings;
  filepath := '';
  Application.hinthidepause := 60000;
  Application.HintPause := 0;
  if OpenFile then
  begin
    Application.Title := 'ACToolkit';
    Application.CreateForm(TForm1, Form1);
  if CheckTheSums = false then
    begin
      if MessageBox(GetDesktopWindow, chkerror, 'Warning', MB_ICONWARNING or MB_YESNO) = idNo then
      Cleanup(false)
      else
      Application.Run;
    end
    else
    if FileExists(Filepath) then
    Application.Run;
  end;
end.
