﻿; Script generated by the Inno Setup Script Wizard.

// ISSI inicializálása
// ÜDVÖZLÖ KÉP deklarálása:
#define ISSI_Splash "inno-fajlok\art\splash-screen-image.bmp"
#define ISSI_Splash_T 3
#define ISSI_Splash_X 960
#define ISSI_Splash_Y 540
#define ISSI_Splash_CORNER 48
// HÁTTÉRSZÍN deklarálása:
#define ISSI_BackgroundImage_BGColor "$000000"
// HÁTTÉRKÉP deklarálása:
#define ISSI_BackgroundImage "inno-fajlok\art\background-image.bmp"
#define ISSI_IncludePath "C:\ISSI"
#include ISSI_IncludePath+"\_issi.isi"  
// APPID deklarálása:
#define MyAppID "{ABCDEFGH-IJKL-MNOP-QRST-UVWXYZ123456}"
// APP VERZIÓ megadása:
#define MyAppVersion "0.00.000"

[Setup]
; MEGJEGYZÉS: Az AppID az egyes telepítők egyedi azonosítója.
; Ne használd ugyanazt az AppID-t a különböző telepítőkhöz!
; Az AppID-t fentebb add meg, és a kapcsos zárójelek maradjanak!
; Új AppID generálása: (a minta kijelölése után!) Ctrl+Shift+G 
; Az App verziószámát is fentebb add meg (az alábbiak változók!).
AppId={{#MyAppID}
AppVersion={#MyAppVersion}
; Telepítő neve és készítője/kiadója:
AppName=Játék Neve - magyarítás
AppPublisher=KészítöKiadóNeve
; Telepítési útvonalak kapcsolói:
AppendDefaultDirName=no
DefaultDirName="{code:GetInstallationPath}"
DirExistsWarning=no
UsePreviousAppDir=no
; Start menü programmappa neve:
DefaultGroupName=KészítöKiadóNeve
; Telepítési útmutató leírás plusz esetleges jogi infók (csak ANSI-kódolású TXT-k lehetnek!):
InfoBeforeFile=C:\INNO\inno-fajlok\info\olvassel-1.txt
InfoAfterFile=C:\INNO\inno-fajlok\info\olvassel-2.txt
; Kimeneti mappa, fájlnév és ikon megadása:
OutputDir=C:\INNO\kimenet
OutputBaseFilename=JatekNeve-magyaritas-v1
SetupIconFile=C:\INNO\inno-fajlok\art\installer.ico
; Tömörítési ráta:
Compression=lzma2/max
SolidCompression=no
; Telepítő kinézet és szükséges jogosultságok:
WizardStyle=modern
PrivilegesRequired=lowest

[Languages]
// MAGYAR NYELVI FÁJL deklarálása a magyar nyelvű telepítőhöz
Name: "hungarian"; MessagesFile: "compiler:Languages\Hungarian.isl"

[Icons]
// PARANCSIKON létrehozása a Start menübe az eltávolításhoz
Name: "{group}\Játék magyarításának eltávolítása"; Filename: "{app}\unins001.exe"

[InstallDelete]
// KORÁBBI telepítésből megmaradt mappa és fájlok eltávolítása az új fájlok bemásolása előtt
Type: files; Name: "{app}\_segédletek\olvassel.txt"
Type: filesandordirs; Name: "{app}\_segédletek\"

[Files]
// ZENELEJÁTSZÓ és ZENE a telepítő alá (csak memóriába kerül kicsomagolásra)
Source: "C:\INNO\inno-fajlok\app\MediaPlayer.dll"; Flags: dontcopy
Source: "C:\INNO\inno-fajlok\app\music.mp3"; Flags: dontcopy
// SEGÉDPROGRAM és SZKRIPT bemásolása a célkönyvtárba
Source: "C:\INNO\inno-fajlok\app\UnityEX.exe"; DestDir: "{app}\JatekNeve_Data\"; Flags: ignoreversion
Source: "C:\INNO\inno-fajlok\app\export.bat"; DestDir: "{app}\JatekNeve_Data\"; Flags: ignoreversion
// BIZTONSÁGI MENTÉS az eredeti fájlokról (átnevezéssel, de csak ha még nem létezik róluk)
Source: "{app}\JatekNeve_Data\StreamingAssets\resources.assets"; DestDir: "{app}\JatekNeve_Data\StreamingAssets\"; DestName: "resources.assets.original"; Flags: external skipifsourcedoesntexist onlyifdoesntexist uninsneveruninstall
// BEMÁSOLÁSA új fájloknak (például segédleteknek)
Source: "C:\INNO\bemenet\_segédletek\*.*"; DestDir: "{app}\_segédletek\"; Flags: ignoreversion
// FELÜLÍRÁSA az eredeti fájloknak
Source: "C:\INNO\bemenet\resources.assets"; DestDir: "{app}\JatekNeve_Data\"; Flags: ignoreversion

[Run]
// FUTTATÁS "csendben" a telepítés közben
Filename: "{app}\JatekNeve_Data\export.bat"; Description: "Bundle-ök kicsomagolása"; StatusMsg: "Bundle-ök kicsomagolása folyamatban (ez eltarthat egy darabig)..."; Flags: runhidden
// FUTTATÁS a telepítés vége előtt
Filename: "{app}\JatekNeve_Data\EMIP-installer.exe"; Description: "Magyarítás injektálása"; StatusMsg: "Injektor-telepítés folyamatban...";
// FUTTATÁS a telepítő bezárását követően, web-böngésző szoftver segítségével (check-box-szal választható)
Filename: "https://www.domainnev.hu/JatekNeve/jatekszabaly.html"; Description: "Játékszabály elolvasása (WEB)"; Flags: postinstall shellexec skipifsilent unchecked
// FUTTATÁS a telepítő bezárását követően, PDF-olvasó szoftver segítségével (check-box-szal választható)
Filename: "{app}\_segédletek\Játékszabály.pdf"; Description: "Játékszabály elolvasása (PDF)"; Flags: postinstall shellexec skipifsilent unchecked
// FUTTATÁS a telepítő bezárását követően (check-box-szal választható)
Filename: "{app}\JatekNeve.exe"; Description: "Játék futtatása"; Flags: postinstall skipifsilent unchecked

[UninstallDelete]
// ELTÁVOLÍTÁS során eltávolítandók
Type: filesandordirs; Name: "{app}\_segédletek\"
Type: files; Name: "{app}\JatekNeve_Data\UnityEX.exe"
Type: files; Name: "{app}\JatekNeve_Data\export.bat"
Type: files; Name: "{app}\unins001.exe"


[Code]


//=
// REGISTRY alapján a Játék Neve telepítési útvonalának megkeresése &
// ALAPÉRTELMEZETT ÚTVONAL deklarálása, ha nem található a telepítési útvonal
//=
var
  InstallationPath: string;

function GetInstallationPath(Param: string): string;
begin
  if InstallationPath = '' then
  begin
    if RegQueryStringValue(
      HKLM64, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 123456',
      'InstallLocation', InstallationPath) then
        begin
          MsgBox('Siker! Megvan a játék Steam-könyvtára itt:' #13#13 '' + InstallationPath + #13#13 'Amennyiben mégsem ide szeretnéd telepíteni, úgy lesz még a későbbiekben lehetőséged az útvonal módosítására!', mbError, MB_OK);
        end
      else
    if RegQueryStringValue(
      HKLM32, 'SOFTWARE\WOW6432Node\GOG.com\Games\123456789',
      'path', InstallationPath) then
        begin
          MsgBox('Siker! Megvan a játék GOG-könyvtára itt:' #13#13 '' + InstallationPath + #13#13 'Amennyiben mégsem ide szeretnéd telepíteni, úgy lesz még a későbbiekben lehetőséged az útvonal módosítására!', mbError, MB_OK);
        end
      else
    begin
      InstallationPath := 'C:\Program Files\JatekNeve';
      MsgBox('Nem található a játék könyvtára. Manuálisan kell betallóznod a JatekNeve.exe fájlt tartalmazó mappát, különben az alapértelmezett könyvtár ez lesz: '#13#13 + InstallationPath, mbError, MB_OK);
    end;
  end;
  Result := InstallationPath;
end;


//=
// A JatekNeve.exe meglétének vizsgálata az adott könyvtárban
//=
function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Log('NextButtonClick(' + IntToStr(CurPageID) + ') called');
  case CurPageID of
    wpSelectDir:
    if not FileExists(ExpandConstant('{app}\JatekNeve.exe')) then begin
      if MsgBox('Úgy látszik, nem ez lesz a megfelelő könyvtár (ebben a könyvtárban nem található a JatekNeve.exe fájl).' #13#13 'Próbáld manuálisan betallózni a Játék Neve könyvtárát!', mbError, MB_OK) = IDOK then
        begin
          WizardForm.BackButton.OnClick(WizardForm.BackButton);
          Result := False;
        end;
      end;
    wpReady:
  end;
  Result := True;
end;


//=
// PROCEDURE DECLARATION
// DirectoryCopy procedúra deklarálása egy komplett mappa BACKUP-jához
//=
procedure DirectoryCopy(SourcePath, DestPath: string);
var
  FindRec: TFindRec;
  SourceFilePath: string;
  DestFilePath: string;
begin
  if FindFirst(SourcePath + '\*', FindRec) then
  begin
    try
      repeat
        if (FindRec.Name <> '.') and (FindRec.Name <> '..') then
        begin
          SourceFilePath := SourcePath + '\' + FindRec.Name;
          DestFilePath := DestPath + '\' + FindRec.Name;
          if FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0 then
          begin
            if FileCopy(SourceFilePath, DestFilePath, False) then
            begin
              Log(Format('Copied %s to %s', [SourceFilePath, DestFilePath]));
            end
              else
            begin
              Log(Format('Failed to copy %s to %s', [SourceFilePath, DestFilePath]));
            end;
          end
            else
          begin
            if DirExists(DestFilePath) or CreateDir(DestFilePath) then
            begin
              Log(Format('Created %s', [DestFilePath]));
              DirectoryCopy(SourceFilePath, DestFilePath);
            end
              else
            begin
              Log(Format('Failed to create %s', [DestFilePath]));
            end;
          end;
        end;
      until not FindNext(FindRec);
    finally
      FindClose(FindRec);
    end;
  end
    else
  begin
    Log(Format('Failed to list %s', [SourcePath]));
  end;
end;


//=
// INSTALL BACKUP
// komplett mappa biztonsági mentés-eljárása
//=
procedure CurStepChanged(CurStep: TSetupStep);
var
  SourcePath1: string;
  DestPath1: string;
begin
  if CurStep = ssInstall then
  begin
    SourcePath1 := ExpandConstant('{app}\JatekNeve_Data\StreamingAssets\localization');
    DestPath1 := ExpandConstant('{app}\JatekNeve_Data\StreamingAssets\localization_original');
    Log(Format('A %s mappa biztonsági mentése ezen a néven: %s', [SourcePath1, DestPath1]));
    if DirExists(DestPath1) then
        begin
          Log(Format('Nem sikerült létrehozni a %s biztonsági mentését ide: ', [DestPath1]));
        end
          else
        begin
          if not ForceDirectories(DestPath1) then
            begin
              Log(Format('Nem sikerült létrehozni a %s biztonsági mentését ide: ', [DestPath1]));
            end
              else
            begin
              MsgBox('Bár az elkövetkezőkben úgy tűnhet, hogy a telepítő lefagyott, ám csak biztonsági másolatot készít a játék eredeti nyelvi fájljairól.' #13#13 'Ahhoz, hogy rendben lefuthasson, most nyomj ''OK''-ét, és várd meg a sikert jelző párbeszédablak megjelenését!', mbError, MB_OK);
              DirectoryCopy(SourcePath1, DestPath1);
            end  
        end;
  end;
end;


//=
// UNINSTALL RESTORE
// komplett mappa visszaállítás + visszanevezgetések & feleslegek eltávolítása
//=
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  SourcePath2: string;
  DestPath2: string;
  OldFile1: string;
begin
  case CurUninstallStep of usPostUninstall:
  begin
    SourcePath2 := ExpandConstant('{app}\JatekNeve_Data\StreamingAssets\localization_original');
    DestPath2 := ExpandConstant('{app}\JatekNeve_Data\StreamingAssets\localization');
    OldFile1 := ExpandConstant('{app}\JatekNeve_Data\resources.assets.original');
    Log(Format('A %s mappa visszaállítása ezen a néven: %s', [SourcePath2, DestPath2]));
    if not ForceDirectories(DestPath2) then
      begin
        Log(Format('Nem sikerült visszaállítani a %s biztonsági mentést ide: ', [DestPath2]));
      end
      else
      begin
        MsgBox('Bár az elkövetkezők során úgy tűnhet, hogy az eltávolító lefagyott, de csak visszaállítja a játék eredeti fájljait.' #13#13 'Ahhoz, hogy rendben lefuthasson, most nyomj ''OK''-ét, és várd meg a sikert jelző párbeszédablak megjelenését!', mbError, MB_OK);
        DirectoryCopy(SourcePath2, DestPath2);
      end;
    if FileExists(OldFile1) then
          RenameFile(OldFile1, ExpandConstant('{app}\JatekNeve_Data\resources.assets'));
    if DirExists(SourcePath2) then
          DelTree(ExpandConstant('{app}\JatekNeve_Data\StreamingAssets\localization_original'), True, True, True);
    end;
  end;
end;


//=
// ZENE lejátszása a telepítő futása során
//=
const
  EC_COMPLETE = $01;
type
  TDirectShowEventProc = procedure(EventCode, Param1, Param2: Integer);

function DSGetLastError(var ErrorText: WideString): HRESULT;
  external 'DSGetLastError@files:mediaplayer.dll stdcall';
function DSPlayMediaFile: Boolean;
  external 'DSPlayMediaFile@files:mediaplayer.dll stdcall';
function DSStopMediaPlay: Boolean;
  external 'DSStopMediaPlay@files:mediaplayer.dll stdcall';
function DSSetVolume(Value: LongInt): Boolean;
  external 'DSSetVolume@files:mediaplayer.dll stdcall';
function DSInitializeAudioFile(FileName: WideString; 
  CallbackProc: TDirectShowEventProc): Boolean; 
  external 'DSInitializeAudioFile@files:mediaplayer.dll stdcall';

procedure OnMediaPlayerEvent(EventCode, Param1, Param2: Integer); 
begin
  if EventCode = EC_COMPLETE then
  begin
    { ... }
  end;
end;

<event('InitializeWizard')>
procedure InitializeWizard2;
var
  ErrorCode: HRESULT;
  ErrorText: WideString;
begin
  ExtractTemporaryFile('music.mp3');
  if DSInitializeAudioFile(ExpandConstant('{tmp}\music.mp3'), 
    @OnMediaPlayerEvent) then
  begin
    DSSetVolume(-2500);
    DSPlayMediaFile;
  end
  else
  begin
    ErrorCode := DSGetLastError(ErrorText);
    MsgBox('TDirectShowPlayer error: ' + IntToStr(ErrorCode) + '; ' + 
      ErrorText, mbError, MB_OK);
  end;
end;

procedure DeinitializeSetup;
begin
  DSStopMediaPlay;
end;

#define ISSI_InitializeSetup