
block_toggle(key) {

toggle := true

Hotkey, %key%, toggle_block

toggle_block:

toggle:=!toggle 		; toggles on and off
if toggle { ;off
    BlockInput, MouseMoveOff
    return
} else { ;on
	BlockInput, MouseMove
    
    while true {
    Input,v,,{%key%}
	If InStr(ErrorLevel,"EndKey")
		Send % "{" SubStr(ErrorLevel,8) "}"
    }

    return
}
}