#!/bin/bash
setcolor()
{
	SETCOLOR_SUCCESS="echo -en \\033[1;32m"
	SETCOLOR_FAILURE="echo -en \\033[1;31m"
	SETCOLOR_NORMAL="echo -en \\033[0;39m"
}
outin_success()
{
	$SETCOLOR_SUCCESS
	echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
	$SETCOLOR_NORMAL
	echo
}
outin_failure()
{
	$SETCOLOR_FAILURE
	echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
	$SETCOLOR_NORMAL
	echo
}
script_question()
{
	echo -e -n "\e[1;37mДля работы скрипта требуется пакет «\e[1;34m$1\e[1;37m».\e[1;33m Установить? (\e[1;32my\e[1;33m/\e[1;31mn\e[1;33m)? \e[0m\n"
	echo -e -n "\e[1;37mThe «\e[1;34m$1\e[1;37m» package is required for operation.\e[1;33m To install? (\e[1;32my\e[1;33m/\e[1;31mn\e[1;33m)? \e[0m\n"
}
script_result()
{
	read item
	case "$item" in
	y|Y) echo -e -n "\e[1;32mПроизводится установка пакета «$1»...\e[0m"
		outin_success
		echo -e -n "\e[1;32mThe «$1» package is installed...\e[0m"
		outin_success
		echo ""
		pacman -S $1 --noconfirm
		
	;;
	n|N) echo -e -n "\e[1;31mРабота скрипта будет прекращена!\e[0m"
		outin_failure
		echo -e -n "\e[1;31mThe script will be terminated!\e[0m"
		outin_failure
		echo ""
		exit 0
	;;
	*) echo -e -n "\e[1;37mВыполняется действие по умолчанию...\e[0m"
		outin_success
		echo -e -n "\e[1;32mThe default action is executed...\e[0m" 
		outin_success
		echo ""
		pacman -S $1 --noconfirm
		;;
	esac
}
setcolor
if ! dialog --version
then
	script_question "dialog"
	script_result "dialog"
fi
if ! convert -version
then
	script_question "imagemagick"
	script_result "imagemagick"
fi
script_question "openssh"
script_result "openssh"
wait
ssh-keygen
system=$(uname -s)
version=$(uname -r)
archi=$(uname -m)
_is_user=""
_is_ip=""
_backtitle="${system} ${version} ${archi}"
if [ "$1" == "" ]; then
    dialog --backtitle "$_backtitle" --title "Ввод имени" --inputbox "Введите имя пользователя ssh" 0 0 "u0_a387" 2>./info.tmp
    if [ "$?" -ne "-1" ]; then
        _is_user=$(cat ./info.tmp)
    else
        _is_user="u0_a387"
    fi
    dialog --backtitle "$_backtitle" --title "Ввод ip адреса" --inputbox "Введите ip адресс ssh соединения" 0 0 "192.168.0.100" 2>./info.tmp
    if [ "$?" -ne "-1" ]; then
        _is_ip=$(cat ./info.tmp)
    else
        _is_ip="192.168.0.100"
    fi
    rm -rf ./info.tmp
else
    _is_user="$1"
    if [ "$2" == "" ]; then
        dialog --backtitle "$_backtitle" --title "Ввод ip адреса" --inputbox "Введите ip адресс ssh соединения" 0 0 "192.168.0.100" 2>./info.tmp
        if [ "$?" -ne "-1" ]; then
            _is_ip=$(cat ./info.tmp)
        else
            _is_ip="192.168.0.100"
        fi
        rm -rf ./info.tmp
    else
        _is_ip="$2"
    fi
fi    
scp -P 8022 ~/.ssh/id_rsa.pub ${_is_user[*]}@${_is_ip[*]}:/data/data/com.termux/files/home/downloads/
ssh -p 8022 ${_is_user[*]}@${_is_ip[*]} "mkdir -p /data/data/com.termux/files/home/.ssh/"
ssh -p 8022 ${_is_user[*]}@${_is_ip[*]} "cp -f ./downloads/id_rsa.pub ./.ssh/id_rsa.pub"
ssh -p 8022 ${_is_user[*]}@${_is_ip[*]} "cat ./.ssh/id_rsa.pub >> ./.ssh/authorized_keys"
ssh -p 8022 ${_is_user[*]}@${_is_ip[*]} "chmod 700 .ssh; chmod 600 .ssh/authorized_keys"
sed -i "s/u0_a387/$_is_user/g" ./ssh.sh
sed -i "s/192.168.0.100/$_is_ip/g" ./ssh.sh
exit 0
