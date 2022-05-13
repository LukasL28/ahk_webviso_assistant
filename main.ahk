#Include ./lib/Chrome.ahk
#Include ./scripts/config.ahk
#Include ./scripts/blockinput.ahk

SetTitleMatchMode 2

test_fail = 0

FileCreateDir, ChromeProfile
FileCreateDir, tmp

IfnotExist, %A_WorkingDir%\webviso_assistant_config.ini 
{
create_config() ;webviso_assistant_config.ini
}

;read config
url := read_config("config", "url")
ping_interval := read_config("ping", "ping_interval")

;disable keyboard / mouse input
block_toggle(read_config("behavior", "disable_overwrite_key"), read_config("behavior", "disabel_mouse"))

if WinExist("Google Chrome") {
	PageInst.Call("Browser.close")
	PageInst.Disconnect()
}

init:

ChromeInst := new Chrome("ChromeProfile")

PageInst := ChromeInst.GetPage()
PageInst.Call("Page.navigate", {"url":url})
PageInst.WaitForLoad()

Sleep 1000


if WinExist("Google Chrome") {
    WinActivate 
    Send, {F11}


}


InternetCheck:

	if (test_fail == 0) {
		if WinExist("Google Chrome") {
		} else {
			settimer, init, -1000
		}
	}

PingFileName = %a_Sec%%a_MSec%

run, cmd /c ipconfig /flushdns && ping 192.168.100.53 && Type Nul > "%a_workingdir%\tmp\%PingFileName%", , hide UseErrorLevel, PingPid

if ErrorLevel
{
msgbox, Fail! "cmd.exe" or "ping.exe" files not found! 
exitapp
}

settimer, CheckPingFileName, -%ping_interval%
return

	CheckPingFileName:

	IfExist, %A_WorkingDir%\tmp\%PingFileName%	
	{
	FileDelete, %A_WorkingDir%\tmp\*
	if (test_fail == 1) {
		test_fail = 0
		settimer, init, -1000	
	} else {
		settimer, InternetCheck, -%ping_interval%
	}

	}
	else
	{
    FileDelete, %A_WorkingDir%\tmp\*
	test_fail = 1
	if WinExist("Google Chrome") {
		PageInst.Call("Browser.close")
		PageInst.Disconnect()
	} 
	settimer, InternetCheck, -%ping_interval%
	}

	return