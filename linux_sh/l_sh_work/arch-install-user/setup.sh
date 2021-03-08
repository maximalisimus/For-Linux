#!/bin/sh
# trap "echo -e '\e[1;30mScript $0 is exit\e[0m'" EXIT
# trap "echo -e '\e[1;31mScript $0 is stoped \e[1;34m(Ctrl+C)\e[0m'" SIGINT
# trap "echo -e '\e[1;35mScript $0 is cenceled \e[1;32m(Ctrl+Z)\e[0m'" SIGTSTP
# trap "echo Script $0 is start" SIGCONT
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
echo -e "\e[1;30mStart $0\n\e[0m"
script_filename=""
script_filedir=""
manualconfnet=""
network_rules=""
custom_conf=""
swap_conf=""
post_installation_conf=""
wifi_conf=""
mirrorlist_conf=""
myerrorcode=""
setmyerrorcode()
{
	myerrorcode="$1"
}
unsetmyerrorcode()
{
	unset myerrorcode
}
startim()
{
	script_filename=`readlink -e "$0"`
	script_filedir=`dirname "$script_filename"`
	manualconfnet="$script_filedir/manconfnet.sh"
	network_rules="$script_filedir/net-rules.sh"
	custom_conf="$script_filedir/custom.sh"
	post_installation_conf="$script_filedir/postinstall.sh"
	swap_conf="$script_filedir/swappiness.sh"
	wifi_conf="$script_filedir/wifi.sh"
	mirrorlist_conf="$script_filedir/mirrorlist.sh"
}
internetconfig()
{
	echo -e "What type of connection do you use: \n\t1) \e[1;32mEthernet\e[0m \t2) \e[1;34mWiFi\e[0m"
	t=""
	read t
	while [[ "$t" =~ [^"1"|^"2"] ]]; do
		clear
		echo "Unknow argument for option!"
		echo ""
		echo "What type of connection do you use:"
		echo -e "\t1) \e[1;32mEthernet\e[0m \t2) \e[1;34mWiFi\e[0m"
		read t
	done
	echo ""
	case "$t" in
		1) sh $wifi_conf "1"
			setmyerrorcode "$?";;
		2) sh $wifi_conf "2"
			setmyerrorcode "$?";;
	esac
}
finishim()
{
	unset script_filename
	unset script_filedir
	unset network_rules
	unset custom_conf
	unset post_installation_conf
	unset swap_conf
	unset wifi_conf
	unset mirrorlist_conf
	unset manualconfnet
	unsetmyerrorcode
}
startim
sh $swap_conf
clear
sh $network_rules
clear
sh $custom_conf
clear
if [ -n "$1" ]; then
	case "$1" in
		-n) setmyerrorcode "0";;
		*) internetconfig;;
	esac
	clear
elif [ -z "$1" ]; then
	internetconfig
fi
if [ "$myerrorcode" == "7" ]; then
	clear
	echo -e "\e[1;31mSorry, error connecting to the Internet.\e[0m"
	echo -e "\e[1;30mPlease configure the Internet connection (Ethernet and Wifi) manually or using a script \e[1;37m\"wifi.sh\".\e[0m"
	echo -e "\e[1;30mWhen you run the script for a wired connection, specify 1 in quotation marks. For example: \e[1;37msh wifi.sh \"1\".\e[0m"
	echo -e "\e[1;30mFor wireless connection, specify 2 in quotation marks. For example: \e[1;37msh wifi.sh \"2\".\e[0m"
	echo -e "\n\e[1;30mTo continue the installation without configuring the Internet connection, restart the script with the \e[1;37m\"-n\" \e[1;30mparameters.\e[0m"
	finishim
	exit 17
elif [ "$myerrorcode" == "9" ]; then
	clear
	echo -e "\e[1;31mSorry, error connecting to the Internet.\e[0m"
	echo -e "\e[1;30mPlease configure the Internet connection (Ethernet and Wifi) manually or using a script \e[1;37m\"wifi.sh\".\e[0m"
	echo -e "\e[1;30mWhen you run the script for a wired connection, specify 1 in quotation marks. For example: \e[1;37msh wifi.sh \"1\".\e[0m"
	echo -e "\e[1;30mFor wireless connection, specify 2 in quotation marks. For example: \e[1;37msh wifi.sh \"2\".\e[0m"
	echo -e "\n\e[1;30mTo continue the installation without configuring the Internet connection, restart the script with the \e[1;37m\"-n\" \e[1;30mparameters.\e[0m"
	finishim
	exit 19
fi
pacman -Syy
pacstrap /mnt base base-devel
# genfstab -p /mnt >> /mnt/etc/fstab
genfstab -U -p /mnt >> /mnt/etc/fstab
clear
sleep 5
sudo sh $post_installation_conf
arch-chroot /mnt
cd /root/arch-script/arch-install-user/
finishim
echo -e "\e[1;30m\n\nDone $0\e[0m"
if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi
echo -n "${reset}"
# trap - SIGINT
# trap - SIGTSTP
# trap - SIGCONT
# trap - EXIT
exit 0
