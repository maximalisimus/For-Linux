#!/bin/bash
# trap "echo -e '\e[1;30mScript $0 is exit\e[0m'" EXIT
# trap "echo -e '\e[1;31mScript $0 is stoped \e[1;34m(Ctrl+C)\e[0m'" SIGINT
# trap "echo -e '\e[1;35mScript $0 is cenceled \e[1;32m(Ctrl+Z)\e[0m'" SIGTSTP
# trap "echo Script $0 is start" SIGCONT
tempfile=`mktemp 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
DIALOG=${DIALOG=dialog}
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
sfilename=`readlink -e "$0"`
sfiledir=`dirname "$script_filename"`
usrpackage="$sfiledir/arch_custom-config/userpackage.txt"
declare -a dpmn
declare -a dkmn
delcare -a listxinitkde
dpmn=("gdm" "lightdm" "lxdm" "sddm" "xdm")
dkmn=("cinnamon" "gnome" "kde" "lxde" "mate" "xfce4")
listxinitkde=("KDE" "PLASMA")
userpackage=( $(cat "$usrpackage") )
unset usrpackage
selecttofile()
{
	FILE=`$DIALOG --stdout --title "Please select to xz packages" --fselect ~/ 10 60`
	case $? in
		0) sudo pacman -U $FILE;;
		1) echo "Click to Cancel";;
		255) echo "Click to ESC.";;
	esac
	unset FILE
}
setinputbox=""
inputdiaolog()
{
	$DIALOG --backtitle "FrameWork v1.1" --title "Input dialog" --clear \
			--inputbox "Please input $1:" 19 51 2> $tempfile
	clear
	echo ""
	retval=$?
	case $retval in
		0) setinputbox=`cat $tempfile`;;
		1) echo -e "\e[1;31mCancel to input!\e[0m";;
		255) echo -e "\e[1;37mClick enter to \e[1;33mESC\e[0m";;
	esac
}
declare -a spisok
declare -a OPTIONS
issetup=""
setspisok()
{
	case "$1" in
		1) spisok=( $(pacman -Ss | grep -w "$2" | awk '{print $1}' | cut -d/ -f2 | grep -v "xf86") );;
		2) spisok=( $(pacman -Ss | grep -w "$2" | awk '{print $1}' | cut -d/ -f2) );;
		3) case "$3" in
				1) cnt=0
					for ltr in "${dpmn[@]}"; do
						spisok[$cnt]=$ltr
						let cnt+=1
					done
					unset cnt
					unset dpmn;;
				2) cnt=0
					for ltr in "${dkmn[@]}"; do
						spisok[$cnt]=$ltr
						let cnt+=1
					done
					unset cnt
					unset dkmn;;
				3) cnt=0
					for ltr in "${listxinitkde[@]}"; do
						spisok[$cnt]=$ltr
						let cnt+=1
					done
					unset cnt
					unset listxinitkde;;
				4) cnt=0
					for ltr in "${userpackage[@]}"; do
						spisok[$cnt]=$ltr
						let cnt+=1
					done
					unset cnt
					unset userpackage;;
				*) break;;
			esac;;
		*) break;;
	esac
}
unsetspisok()
{
	unset spisok
}
outpackages()
{
	setspisok "$1" "$2" "$3"
	count=0
	counter=0
	for letter in "${spisok[@]}"; do
		OPTIONS[$count]=$counter
		let count+=1
		OPTIONS[$count]="$letter"
		let count+=1
		let counter+=1
	done
	unset count
	unset counter
}
selectpackages()
{
	outpackages "$1" "$2" "$3"
	HEIGHT=19
	WIDTH=51
	CHOICE_HEIGHT=15
	BACKTITLE="FrameWork v1.1"
	TITLE="Select menu"
	MENU="Please to select packets on setup:"
	CHOICE=$(dialog --clear \
					--backtitle "$BACKTITLE" \
					--title "$TITLE" \
					--menu "$MENU" \
					$HEIGHT $WIDTH $CHOICE_HEIGHT \
					"${OPTIONS[@]}" \
					2>&1 >/dev/tty)
	clear
	echo ""
	if [ -n "$CHOICE" ]; then
		selectpkcg=""
		selectpkcg="${spisok[$CHOICE]}"
		unset CHOICE
		unset spisok
		unset OPTIONS
		unset HEIGHT
		unset WIDTH
		unset CHOICE_HEIGHT
		unset BACKTITLE
		unset TITLE
		unset MENU
		unsetspisok
	elif [ -z "$CHOICE" ]; then
		echo ""
		echo -e "\e[1;31mCancel to select menu!\e[0m"
	fi
}
outpckgs()
{
	setspisok "$1" "$2" "$3"
	count=0
	counter=0
	for letter in "${spisok[@]}"; do
		if [ "$count" == "0" ]; then
			OPTIONS[$count]="$letter"
			let count+=1
			OPTIONS[$count]=""
			let count+=1
			OPTIONS[$count]="ON"
			let count+=1
			let counter+=1
		else
			OPTIONS[$count]="$letter"
			let count+=1
			OPTIONS[$count]=""
			let count+=1
			OPTIONS[$count]="off"
			let count+=1
			let counter+=1
		fi
	done
	unset count
	unset counter
}
checktpckgs()
{
	outpckgs "$1" "$2" "$3"
	HEIGHT=19
	WIDTH=51
	CHOICE_HEIGHT=15
	BACKTITLE="FrameWork v1.1"
	TITLE="Select packages"
	MENU="Please to select setup packages:"
	$DIALOG --clear \
			--backtitle "$BACKTITLE" \
			--title "$TITLE" \
			--checklist "$MENU" \
			$HEIGHT $WIDTH $CHOICE_HEIGHT \
			"${OPTIONS[@]}" \
			2> $tempfile
	retval=$?
	clear
	echo ""
	choice=`cat $tempfile`
	case $retval in
		  0) sudo pacman -S $choice --noconfirm;;
		  1) echo -e "\e[1;31mCancel to setup Desktop!\e[0m";;
		  255) echo -e "\e[1;37mClick enter to \e[1;33mESC\e[0m";;
	esac
	unset CHOICE
	unset spisok
	unset OPTIONS
	unset HEIGHT
	unset WIDTH
	unset CHOICE_HEIGHT
	unset BACKTITLE
	unset TITLE
	unset MENU
	unset selectpkcg
	unset retval
	unsetspisok
}
declare -a lstdisks
declare -a lstdisk
declare -a lstdiskinf
thedisk=""
isdisk()
{
	lstdisk=( $(cat disk.txt) )
	# lsblk | grep -w "disk" | awk '{print $1}'
	lstdiskinf=( $(cat disk2.txt) )
	# lsblk | grep -w "disk" | awk '{print $4}'
	count=0
	counter=0
	for letter in "${lstdisk[@]}"; do
		if [ "$count" == "0" ]; then
			lstdisks[$count]="$letter"
			let count+=1
			lstdisks[$count]="${lstdiskinf[$counter]}"
			let count+=1
			let counter+=1
		else
			lstdisks[$count]="$letter"
			let count+=1
			lstdisks[$count]="${lstdiskinf[$counter]}"
			let count+=1
			let counter+=1
		fi
	done
	unset count
	unset counter
	unset lstdisk
	unset lstdiskinf
}
listdisk()
{
	isdisk
	HEIGHT=19
	WIDTH=51
	CHOICE_HEIGHT=15
	BACKTITLE="FrameWork v1.1"
	TITLE="Select devices"
	MENU="Please to select disk grub-setup:"
	$DIALOG --clear \
			--backtitle "$BACKTITLE" \
			--title "$TITLE" \
			--menu "$MENU" \
			$HEIGHT $WIDTH $CHOICE_HEIGHT \
			"${lstdisks[@]}" \
			2> $tempfile
	retval=$?
	clear
	echo ""
	choice=`cat $tempfile`
	case $retval in
		  0) thedisk="/dev/$choice";;
		  1) echo -e "\e[1;31mCancel to setup Desktop!\e[0m";;
		  255) echo -e "\e[1;37mClick enter to \e[1;33mESC\e[0m";;
	esac
	unset CHOICE
	unset lstdisks
	unset HEIGHT
	unset WIDTH
	unset CHOICE_HEIGHT
	unset BACKTITLE
	unset TITLE
	unset MENU
	unset retval
}
pleasewait()
{
	COUNT=10
	(
		while test $COUNT != 110
		do
			echo $COUNT
			echo "XXX"
			echo "Please wait to 10 seconds: $COUNT%"
			echo "XXX"
			COUNT=`expr $COUNT + 10`
			sleep 1
		done
	) |
	$DIALOG --backtitle "Framework v1.1" --title "Configuration" --gauge "Please wait to 10 sec." 10 51 0
}
echo -e "\e[1;30mStart $0\n\e[0m"
pacman-key --init
pacman-key --refresh-keys
pacman -Syy
pacman -S grub --noconfirm
listdisk
grub-install $thedisk
loadkeys ru
setfont cyr-sun16
locale-gen
export Lang=ru_RU.UTF-8
timedatectl set-timezone Europe/Moscow
hwclock --systohc
myusername=""
inputdiaolog "Username"
if [ -n "$setinputbox" ]; then
	echo -e "\e[1;37mUsername: \e[1;33m$setinputbox\e[0m"
	myusername=$setinputbox
	unset setinputbox
elif [ -z "$setinputbox" ]; then
	echo -e "\e[1;31mCancel to input!\e[0m"
fi
useradd -m -g users -G audio,games,lp,optical,power,scanner,storage,video,wheel -s /bin/bash $myusername
passwd root
passwd $myusername
mkinicpio -p linux
grub-mkconfig -o /boot/grub/grub.cfg
clear
sudo pacman -S sudo gksu dconf dconf-editor gconf gconf-editor grub-customizer ttf-liberation ttf-dejavu opendesktop-fonts ttf-bitstream-vera ttf-arphic-ukai ttf-arphic-uming ttf-hanazono terminus-font --noconfirm
echo ""
echo "$myusername ALL=(ALL) ALL" >> /etc/sudoers
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
sed "s/'# root ALL=(ALL) ALL'/'root ALL=(ALL) ALL'/"
clear
echo ""
pacman -S ninja make cmake autoconf automake python fish bash-completion curl git wget gcc --noconfirm
pacman -Scc
clear
echo ""
chsh -s /usr/bin/fish $myusername
chsh -s /usr/bin/fish root
login $myusername
sudo gconftool-2 --set --type boolean /apps/gksu/sudo-mode true
git clone https://aur.archlinux.org/package-query.git
git clone https://aur.archlinux.org/yaourt.git
git clone https://aur.archlinux.org/pamac-aur.git
sudo chown -R $myusername package-query/*
sudo chmod -R 777 package-query/*
sudo chown -R $myusername yaourt/*
sudo chmod -R 777 yaourt/*
sudo chown -R $myusername pamac-aur/*
sudo chmod -R 777 pamac-aur/*
cd package-query/
makepkg -si
selecttofile
cd ../
clear
echo ""
cd yaourt/
makepkg -si
selecttofile
cd ../
clear
echo ""
cd pamac-aur/
makepkg -si
selecttofile
cd ../
clear
echo ""
sudo pacman -S netctl dialog wpa_supplicant net-tools network-manager-applet libgtop networkmanager networkmanager-openconnect networkmanager-openvpn networkmanager-pptp networkmanager-vpnc networkmanager-l2tp iw wireless_tools wicd --noconfirm
sudo pacman -S samba libwbclient smb4k smbclient smbnetfs --noconfirm
sudo systemctl stop dhcpcd
sudo systemctl disable dhcpcd
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
clear
echo ""
pleasewait
ping -c 3 ya.ru
echo ""
pacman -S xterm lxterminal gnome-terminal leafpad nano vi vim gedit geany --noconfirm
checktpckgs "1" "xorg"
# selectpackages "1" "xorg"
# checktpckgs "2" "$selectpkcg"
unset selectpkcg
selectpackages "2" "xf86-video"
checktpckgs "2" "$selectpkcg"
unset selectpkcg
selectpackages "2" "xf86-input"
checktpckgs "2" "$selectpkcg"
unset selectpkcg
selectpackages "3" "$selectpkcg" "1"
checktpckgs "2" "$selectpkcg"
mydm="$selectpkcg"
unset selectpkcg
selectpackages "3" "$selectpkcg" "2"
andpacket="$selectpkcg"
checktpckgs "2" "$selectpkcg"
unset selectpkcg
if [ "andpacket" == "kde" ]; then
	checktpckgs "2" "plasma"
fi
pacman -S breeze breeze-grub breeze-icons --noconfirm
sudo pacman -Scc
Xorg :0 -configure
Xorg -configure
sudo cp "/root/xorg.conf.new" "/etc/X11/xorg.conf"
sudo systemctl enable $mydm
if [ -e "/etc/$mydm.conf" ]; then
	sudo echo "login_cmd exec /bin/sh - ~/.xinitrc %session" >> "/etc/$mydm.conf"
elif [ ! -e "/etc/$mydm.conf" ]; then
	touch "/etc/$mydm.conf"
	sudo echo "login_cmd exec /bin/sh - ~/.xinitrc %session" >> "/etc/$mydm.conf"
fi
if [ ! -e "/home/$myusername/.xinitrc" ]; then
	touch "/home/$myusername/.xinitrc"
fi
case "$mydm" in
	cinnamon) echo "exec cinnamon-session" >> "/home/$myusername/.xinitrc";;
	gnome) echo "export GDK_BACKEND=x11" >> "/home/$myusername/.xinitrc"
			echo "exec gnome-session" >> "/home/$myusername/.xinitrc";;
	kde) selectpackages "3" "kde" "3"
		if [ "$selectpkcg" == "KDE" ]; then
			echo "exec startkde" >> "/home/$myusername/.xinitrc"
			unset selectpkcg
		else 
			echo "export XDG_SESSION_TYPE=wayland && export $(dbus-launch) && startplasmacompositor" >> "/home/$myusername/.xinitrc"
			unset selectpkcg
		fi;;
	lxde) echo "exec startlxde" >> "/home/$myusername/.xinitrc";;
	mate) echo "exec mate-session" >> "/home/$myusername/.xinitrc";;
	xfce4) echo "exec startxfce4" >> "/home/$myusername/.xinitrc";;
esac
checktpckgs "2" "pulseaudio"
sudo pacman -S ttf-dejavu artwiz-fonts hunspell hyphen mythes --confirm
checktpckgs "2" "libreoffice-fresh"
echo "Xft.lcdfilter: lcddefault" | xrdb -merge
checktpckgs "3" "temp" "4"
sudo pacman -Scc
curl -o strap.sh https://blackarch.org/strap.sh
`exit`
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
