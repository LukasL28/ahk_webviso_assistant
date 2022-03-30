create_config() {

file_name = %A_WorkingDir%\webviso_assistant_config.ini

; Create config file

;config
IniWrite,https://github.com/LukasL28/ahk_webviso_assistant,%file_name%,config,url ; url of web-viso
IniWrite,true,%file_name%,config,enable_ping 

FileAppend `n, %file_name%

IniWrite,1.1.1.1,%file_name%,ping,ping_url
IniWrite,10000,%file_name%,ping,ping_interval 

FileAppend `n, %file_name%

IniWrite,false,%file_name%,behaviour,disabel_keyborad
IniWrite,false,%file_name%,behaviour,disabel_mouse
IniWrite,{F12},%file_name%,behaviour,disable_overwrite_key
}

read_config(Section, Key){
file_name = %A_WorkingDir%\webviso_assistant_config.ini

IniRead, var,%file_name%,%Section%,%Key%
Return var
}