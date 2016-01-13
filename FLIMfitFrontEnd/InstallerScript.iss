 ; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "FLIMfit"
#define MyAppPublisher "Sean Warren"
#define MyAppCopyright "(c) Imperial College London"


; These options need to be set on the commandline, eg. > iscc \dMyAppVersion=x.x.x \dMyAppSystem=64 \dRepositoryRoot="...\Imperial-FLIMfit" "InstallerScript.iss"
;#define MyAppVersion "x.x.x"
;#define RepositoryRoot "...\Imperial-FLIMfit"

; Define Ghostscript download urls and required version
#define GhostscriptUrl "http://downloads.ghostscript.com/public/gs916w64.exe"
#define GhostscriptVersionRequired "9.16"

#include "it_download.iss"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
ArchitecturesAllowed=x64

AppId={{5B6988D3-4B10-4DC8-AE28-E29DF8D99C39}}
AppName={#MyAppName}
AppVersion={#AppVersion}
AppPublisher={#MyAppPublisher}
UsePreviousAppDir=no
DefaultDirName={pf}\{#MyAppName}\{#MyAppName} {#AppVersion}
DefaultGroupName={#MyAppName}
OutputDir={#RepositoryRoot}\FLIMfitStandalone\Installer
OutputBaseFilename=FLIMFit {#AppVersion} Setup x64
SetupIconFile={#RepositoryRoot}\FLIMfitFrontEnd\DeployFiles\microscope.ico
Compression=lzma
SolidCompression=yes


ShowLanguageDialog=no
AppCopyright={#MyAppCopyright}
LicenseFile={#RepositoryRoot}\FLIMfitFrontEnd\LicenseFiles\GPL Licence.txt
AllowUNCPath=False
VersionInfoVersion={#InnoAppVersion}
MinVersion=0,5.01sp3

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "{#RepositoryRoot}\InstallerSupport\unzip.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall
Source: "{#VSRedist}"; DestDir: "{tmp}"; Flags: deleteafterinstall
Source: "{#RepositoryRoot}\FLIMfitStandalone\FLIMfit_{#AppVersion}\Start_FLIMfit.bat"; DestDir: "{app}"; Flags: ignoreversion 64bit
Source: "{#RepositoryRoot}\FLIMfitStandalone\FLIMfit_{#AppVersion}\FLIMGlobalAnalysis_64.dll"; DestDir: "{app}"; Flags: ignoreversion 64bit
Source: "{#RepositoryRoot}\FLIMfitStandalone\FLIMfit_{#AppVersion}\FLIMfit.exe"; DestDir: "{app}"; Flags: ignoreversion 64bit
Source: "C:\Program Files\MATLAB\R{#MatlabVer}\bin\win64\tbb.dll"; DestDir: "{app}"; Flags: ignoreversion 64bit
Source: "{#RepositoryRoot}\InstallerSupport\microscope.ico"; DestDir: "{app}"
Source: "{#RepositoryRoot}\FLIMfitFrontEnd\java.opts"; DestDir: "{app}";
[Icons]
Name: "{group}\{#MyAppName} {#AppVersion}"; Filename: "{app}\Start_FLIMfit.bat"; IconFilename: "{app}\microscope.ico"
Name: "{commondesktop}\{#MyAppName} {#AppVersion}"; Filename: "{app}\Start_FLIMfit.bat"; Tasks: desktopicon; IconFilename: "{app}\microscope.ico"
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName} {#AppVersion}"; Filename: "{app}\Start_FLIMfit.bat"; Tasks: quicklaunchicon;  IconFilename: "{app}\microscope.ico"

;[Run]
;Filename: "{app}\Start_FLIMfit_.bat"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent


[Messages]
WinVersionTooHighError=This will install [name/ver] on your computer.%n%nIt is recommended that you close all other applications before continuing.%n%nIf they are not already installed, it will also download and install the Matlab 2012b Compiler Runtime, Visual C++ Redistributable and Ghostscript 9.16 which are required to run [name]. An internet connection will be required.

[Code]
procedure InitializeWizard();
begin
 itd_init;
 itd_setoption('UI_AllowContinue', '1'); // allow downloads to fail
 //Start the download after the "Ready to install" screen is shown
 itd_downloadafter(wpReady);
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode : Integer;
begin
 if CurStep=ssPostInstall then begin //Lets install those files that were downloaded for us
  // Unzip and install Matlab MCR if downloaded
  Exec(expandconstant('{tmp}\unzip.exe'), expandconstant('{tmp}\MatlabMCR.zip'), expandconstant('{tmp}'), SW_SHOW, ewWaitUntilTerminated, ResultCode)
  Exec(expandconstant('{tmp}\bin\win64\setup.exe'), '-mode automated', expandconstant('{tmp}'), SW_SHOW, ewWaitUntilTerminated, ResultCode)
  
  // Install Visual Studio Redist
  Exec(expandconstant('{tmp}\vcredist_64.exe'), '/passive /norestart', expandconstant('{tmp}'), SW_SHOW, ewWaitUntilTerminated, ResultCode)
  
  // Install Ghostscript if downloaded
  Exec(expandconstant('{tmp}\unzip.exe'), expandconstant('{tmp}\Ghostscript.exe'), expandconstant('{tmp}'), SW_SHOW, ewWaitUntilTerminated, ResultCode)
  Exec(expandconstant('{tmp}\setupgs.exe'), expandconstant('"{pf}\gs"'), expandconstant('{tmp}'), SW_SHOW, ewWaitUntilTerminated, ResultCode)
 end;
end;


function InitializeSetup(): Boolean;
var
  // Declare variables
  MatlabMcrInstalled : Boolean;
  GhostscriptInstalled : Boolean;
  url : String;
  
begin

  // Check if mcr is installed
  MatlabMcrInstalled := RegKeyExists(HKLM64,'SOFTWARE\MathWorks\MATLAB Runtime\{#McrVer}\') or RegKeyExists(HKLM64,'SOFTWARE\MathWorks\MATLAB Compiler Runtime\{#McrVer}\');
  GhostscriptInstalled := RegKeyExists(HKLM64,'SOFTWARE\GPL Ghostscript\{#GhostscriptVersionRequired}\');

  if MatlabMcrInstalled = true then
      Log('Required MCR version already installed')
  else
   begin
      Log('Required MCR version not installed')
      url := 'http://www.mathworks.co.uk/supportfiles/downloads/R{#MatlabVer}/deployment_files/R{#MatlabVer}/installers/win64/MCR_R{#MatlabVer}_win64_installer.exe'
      Log('Adding MCR Download: ' + url);
      itd_addfile(url,expandconstant('{tmp}\MatlabMCR.zip'));  
    end;  
    
  if GhostscriptInstalled = true then
      Log('Required Ghostscript version already installed')
  else
    begin
      url := '{#GhostscriptUrl}'
      Log('Adding Ghostscript Download: ' + url);
      itd_addfile(url,expandconstant('{tmp}\Ghostscript.exe'));    
    end;

  Result := true;
end;


