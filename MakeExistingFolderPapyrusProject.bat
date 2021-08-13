@ECHO OFF

SET PROJECT_TEMPLATE_DIR="C:\Users\mrowr\Dropbox\Games\Skyrim SE\Papyrus Project Setup\MakePapyrusProject\ProjectTemplate"

For %%A in (%1) do (
    SET PROJECT_NAME=%%~nxA
)

CD "%1"
XCOPY /e %PROJECT_TEMPLATE_DIR% .
powershell -Command "(Get-Content Scripts\Source\PLAYER_SCRIPT.psc) -replace 'PLAYER_SCRIPT', '%PROJECT_NAME%_PlayerScript' | Out-File -encoding ASCII Scripts\Source\PLAYER_SCRIPT.psc"
MOVE Scripts\Source\PLAYER_SCRIPT.psc Scripts\Source\%PROJECT_NAME%_PlayerScript.psc
powershell -Command "(Get-Content skyrimse.ppj) -replace 'NAME_OF_YOUR_MOD', '%PROJECT_NAME%' | Out-File -encoding ASCII skyrimse.ppj"
