#Include ./lib/Chrome.ahk

SetTitleMatchMode 2

test_fail = 0

FileCreateDir, ChromeProfile
FileCreateDir, tmp

init:
if WinExist("Google Chrome") {
	PageInst.Call("Browser.close")
	PageInst.Disconnect()
}

ChromeInst := new Chrome("ChromeProfile")

PageInst := ChromeInst.GetPage()
PageInst.Call("Page.navigate", {"url": "http://192.168.100.53/?group=P1"})
PageInst.WaitForLoad()

Sleep 1000


if WinExist("Google Chrome") {
    WinActivate 
    Send, {F11}


}

InternetCheck:

if WinExist  ("Google Chrome") {
} else {
	settimer, init, -1000
}

PingFileName = %a_Sec%%a_MSec%

run, cmd /c ipconfig /flushdns && ping 192.168.100.53 && Type Nul > "%a_workingdir%\tmp\%PingFileName%", , hide UseErrorLevel, PingPid

if ErrorLevel
{
msgbox, Fail! "cmd.exe" or "ping.exe" files not found! 
exitapp
}

settimer, CheckPingFileName, -10000	
return

	CheckPingFileName:

	IfExist, %A_WorkingDir%\tmp\%PingFileName%	
	{
	FileDelete, %A_WorkingDir%\tmp\%PingFileName%
	if (test_fail == 1) {
		test_fail = 0
		settimer, init, -1000	
	} else {
		settimer, InternetCheck, -10000
	}

	}
	else
	{
    FileDelete, %A_WorkingDir%\tmp\%PingFileName%
	test_fail = 1
	if WinExist("Google Chrome") {
		PageInst.Call("Browser.close")
		PageInst.Disconnect()
	} 
	settimer, InternetCheck, -10000	
	}

	return