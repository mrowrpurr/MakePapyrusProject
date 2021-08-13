@ECHO OFF

SET PROJECT_TEMPLATE_DIR="C:\Users\mrowr\Dropbox\Games\Skyrim SE\Papyrus Project Setup\NewSkyrimMod\ProjectTemplate"

SET args=%*
IF NOT DEFINED args GOTO END

powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('Enter New Project Name:', 'NewPapyrusProject')}" > %TEMP%\newPapyrusProjectName.tmp
set /p PROJECT_NAME=<%TEMP%\newPapyrusProjectName.tmp

CD "%1"
MKDIR %PROJECT_NAME%
CD %PROJECT_NAME%
XCOPY /e %PROJECT_TEMPLATE_DIR% .
timeout /t 1
powershell -Command "(Get-Content Scripts\Source\PLAYER_SCRIPT.psc) -replace 'MOD_NAME', '%PROJECT_NAME%' | Out-File -encoding ASCII Scripts\Source\PLAYER_SCRIPT.psc"
MOVE Scripts\Source\PLAYER_SCRIPT.psc Scripts\Source\%PROJECT_NAME%_PlayerScript.psc
powershell -Command "(Get-Content skyrimse.ppj) -replace 'MOD_NAME', '%PROJECT_NAME%' | Out-File -encoding ASCII skyrimse.ppj"

powershell -Command "(Get-Content PLUGIN.esx) -replace 'MOD_NAME', '%PROJECT_NAME%' | Out-File -encoding ASCII PLUGIN.esx"
bethkit convert PLUGIN.esx %PROJECT_NAME%.esp
DEL PLUGIN.esx

build.bat