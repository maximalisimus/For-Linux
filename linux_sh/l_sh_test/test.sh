#!/bin/bash
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
sms()
{
	case "$1" in
		1) case "$2" in
				1) ;; 
				2) ;;
			esac;;
	esac
}
question()
{
	if [ $? -eq 0 ]; then
		$SETCOLOR_SUCCESS
		if [ -n "$1" ]; then
			sms "$1" "1"
		fi
		echo -e -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
		$SETCOLOR_NORMAL
	else
		$SETCOLOR_FAILURE
		if [ -n "$1" ]; then
			sms "$1" "2"
		fi
		echo -e -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
		$SETCOLOR_NORMAL
	fi
}
ABSOLUT_FILENAME=`readlink -e "$0"`
filesdir=`dirname "$ABSOLUT_FILENAME"`
if [ -z $DISPLAY ]; then
	dialog --version 2> /dev/null 1> /dev/null
	errcode=$?
	if [ "$errcode" == "0" ]; then
		DIALOG=${DIALOG=dialog}
	elif [ "$errcode" != "0" ]; then
		echo -e "\e[1;31mError to run Script! \e[1;30mPlease setup at pacman to \e[1;37mdialog\e[1;30m!\e[0m"
	fi
else
    Xdialog --version 2> /dev/null 1> /dev/null
    errcode=$?
    if [ "$errcode" == "0" ]; then
        DIALOG=${DIALOG=Xdialog}
		unset errcode
    elif [ "$errcode" != "0" ]; then
		unset errcode
        dialog --version 2> /dev/null 1> /dev/null
        errcode=$?
        if [ "$errcode" == "0" ]; then
            DIALOG=${DIALOG=dialog}
        elif [ "$errcode" != "0" ]; then
			echo -e "\e[1;31mError to run Script! \e[1;30mPlease setup at pacman to \e[1;37mdialog \e[1;30mor \e[1;37mxdialog\e[1;30m!\e[0m"
        fi
    fi
fi
clear
echo -e "\e[1;30m\n\nStart $0\e[0m" && question

echo -e -n "\e[1;30m\n\nDone $0\e[0m" && question
echo -n "${reset}"
echo ""
exit 0
