
block_toggle(key, mouse) {

toggle := true

Hotkey, %key%, toggle_block

toggle_block:

toggle:=!toggle 		; toggles on and off
if toggle { ;off
    BlockInput, MouseMoveOff
    return
} else { ;on

    If (mouse == "true") {
	BlockInput, MouseMove
    }    
    ; ;Block Keypoard input ... 
    ; while true {
    ; Input,v,,{%key%}
	; If InStr(ErrorLevel,"EndKey")
	; 	Send % "{" SubStr(ErrorLevel,8) "}"
    ; }

    return
}
}