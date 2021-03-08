#!/bin/bash
if [ -z $DISPLAY ]; then
	dialog --version 2> /dev/null 1> /dev/null
	errcode=$?
	if [ "$errcode" == "0" ]; then
		DIALOG=${DIALOG=dialog}
	elif [ "$errcode" != "0" ]; then
		echo -e "\e[1;31mError to run Script! \e[1;30mPlease setup at pacman to \e[1;37mdialog \e[1;30mor \e[1;37mxdialog\e[1;30m!\e[0m"
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
exit 0
