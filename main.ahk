

Run http://192.168.100.53/?group=P1

gui, add, text, x65 y20, Status:
gui, add, text, x+5 vStatus, Please Wait! Checking for Internet Connection!
gui, add, text, x65 y+20, Last Check:
gui, add, text, x+5 w150 vLastCheck, Wait ...!

gui, show, w400 h150, Internet Connection Checker!

InternetCheck:

guicontrol, , Status, Please Wait! Checking for Internet Connection!

PingFileName = %a_Sec%%a_MSec%	;%a_Sec% current windows os seconds
				;%a_MSec% current windows os milliseconds

				;for every internet check, the file name will be diferrent (randomized)

run, cmd /c ipconfig /flushdns && ping 192.168.100.53 && Type Nul > "%a_workingdir%\%PingFileName%", , hide UseErrorLevel, PingPid


if ErrorLevel	;if "cmd.exe" or "ping.exe" files are not found
{
msgbox, Fail! "cmd.exe" or "ping.exe" files not found!
exitapp
}

settimer, CheckPingFileName, -10000	;"-10.000" check once after 10 seconds
return

	CheckPingFileName:

	IfExist, %A_WorkingDir%\%PingFileName%		;if %PingFileName% exist in script "working dir"
	{
	FileDelete, %A_WorkingDir%\%PingFileName%
	guicontrol, , Status, Wait 10 seconds ...!
	guicontrol, , LastCheck, Success - Connected!
	settimer, InternetCheck, -10000			;"-10000"after 10 seconds, "InternetCheck" lable will be executed only once
	}
	else
	{
    FileDelete, %A_WorkingDir%\%PingFileName%
	guicontrol, , Status, Wait 10 seconds ...!	
	guicontrol, , LastCheck, Fail - Not Connected!
    Run http://192.168.100.53/?group=P1
	settimer, InternetCheck, -10000			;"-10000"after 10 seconds, "InternetCheck" lable will be executed only once
	}

	return


guiclose:
process, close, %PingPid%			;close "cmd.exe" executed by autohotkey through its unique process id (pid) if process still exist
process, close, ping.exe			;close "ping.exe" executed by %PingPid% if process still exist
FileDelete, %A_WorkingDir%\%PingFileName%
exitapp



