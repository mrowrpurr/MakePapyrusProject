@ECHO OFF

SET PROJECT_TEMPLATE_DIR="C:\Users\mrowr\Dropbox\Games\Skyrim SE\Papyrus Project Setup\NewPapyrusProject\ProjectTemplate"

SET args=%*
IF NOT DEFINED args GOTO END

powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('Enter New Project Name:', 'NewPapyrusProject')}" > %TEMP%\newPapyrusProjectName.tmp
set /p PROJECT_NAME=<%TEMP%\newPapyrusProjectName.tmp

CD "%1"
MKDIR %PROJECT_NAME%
CD %PROJECT_NAME%
XCOPY /e %PROJECT_TEMPLATE_DIR% .
timeout /t 1
powershell -Command "(Get-Content Scripts\Source\PLAYER_SCRIPT.psc) -replace 'PLAYER_SCRIPT', '%PROJECT_NAME%_PlayerScript' | Out-File -encoding ASCII Scripts\Source\PLAYER_SCRIPT.psc"
MOVE Scripts\Source\PLAYER_SCRIPT.psc Scripts\Source\%PROJECT_NAME%_PlayerScript.psc
powershell -Command "(Get-Content skyrimse.ppj) -replace 'NAME_OF_YOUR_MOD', '%PROJECT_NAME%' | Out-File -encoding ASCII skyrimse.ppj"

bethkit convert PLUGIN.esx %PROJECT_NAME%.esp
DEL PLUGIN.esx