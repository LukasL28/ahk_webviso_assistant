#Include ./lib/Chrome.ahk
FileCreateDir, ChromeProfile
ChromeInst := new Chrome("ChromeProfile")

PageInst := ChromeInst.GetPage()
PageInst.Call("Page.navigate", {"url": "https://google.de/"})
PageInst.WaitForLoad()

Sleep 1000

if WinExist("Google - Google Chrome") {
    WinActivate 
	IfWinActive, Google - Google Chrome
{
	MsgBox "ok"
    Send, {F11}

}
}

InternetCheck:

PingFileName = %a_Sec%%a_MSec%

run, cmd /c ipconfig /flushdns && ping 192.168.100.53 && Type Nul > "%a_workingdir%\%PingFileName%", , hide UseErrorLevel, PingPid

if ErrorLevel
{
msgbox, Fail! "cmd.exe" or "ping.exe" files not found! 
exitapp
}

settimer, CheckPingFileName, -10000	
return

	CheckPingFileName:

	IfExist, %A_WorkingDir%\%PingFileName%	
	{
	FileDelete, %A_WorkingDir%\%PingFileName%
	settimer, InternetCheck, -10000	
	}
	else
	{
    FileDelete, %A_WorkingDir%\%PingFileName%
    PageInst.Call("Browser.close")
	PageInst.Disconnect()
	PageInst := ChromeInst.GetPage()
	PageInst.Call("Page.navigate", {"url": "https://google.de/"})
	PageInst.WaitForLoad()
	settimer, InternetCheck, -10000	
	}

	return