@echo off

if not "%1"=="" (
	set BFSIZE=%1
) else (
	set BFSIZE=24
)

if not "%2"=="" (
	set _IS_USR=%2
	if not "%3"=="" (
		set _IS_IP=%3
	)  else (
		set _IS_IP=192.168.0.100
	)
) else (
	set _IS_USR=u0_a387
	set _IS_IP=192.168.0.100
)

echo cd /data/data/com.termux/files/home/downloads/ > ssh-apps\command.txt

echo ./sshtips.sh %BFSIZE% >> ssh-apps\command.txt

echo exit >> ssh-apps\command.txt

start /wait ssh-apps\pscp.exe -pw mikl -P 8022 tips.txt %_IS_USR%@%_IS_IP%:/data/data/com.termux/files/home/downloads/

start /wait ssh-apps\putty.exe -ssh %_IS_USR%@%_IS_IP%  -pw mikl  -P 8022 -m ssh-apps\command.txt

start /wait ssh-apps\pscp.exe -pw mikl -P 8022 %_IS_USR%@%_IS_IP%:/data/data/com.termux/files/home/downloads/vk.png %CD%\

start /wait ssh-apps\putty.exe -ssh %_IS_USR%@%_IS_IP%  -pw mikl  -P 8022 -m ssh-apps\command2.txt

