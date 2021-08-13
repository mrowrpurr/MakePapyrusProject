scriptName MOD_NAME_PlayerScript
{Represents the player}

; Runs the first time this mod is installed
event OnInit()
    Debug.MessageBox("MOD_NAME installed")
endEvent

; Runs when the player loads the game
; (if the mod was installed when the game was saved)
event OnPlayerLoadGame()
endEvent
