#!/bin/sh
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
echo -e "\e[1;30mStart $0\n\e[0m"
ABSOLUT_FILENAME=""
filesdir=""
hal=""
fdi=""
policy=""
keymap=""
realkeymap=""
localeconf=""
reallocaleconf=""
localegen=""
reallocalegen=""
typesystem=""
mirrorlisti686=""
mirrorlistx8664=""
realmirrorlists=""
pacmanconf=""
realpacmanconf=""
vconsoleconf=""
realvconsoleconf=""
starters()
{
	ABSOLUT_FILENAME=`readlink -e "$0"`
	filesdir=`dirname "$ABSOLUT_FILENAME"`
	hal="/etc/hal/"
	fdi="/etc/hal/fdi/"
	policy="/etc/hal/fdi/policy/"
	keymap="$filesdir/arch_custom-config/10-keymap.fdi"
	realkeymap="/etc/hal/fdi/policy/10-keymap.fdi"
	localeconf="$filesdir/arch_custom-config/locale.conf"
	reallocaleconf="/etc/locale.conf"
	localegen="$filesdir/arch_custom-config/locale.gen"
	reallocalegen="/etc/locale.gen"
	realmirrorlists="/etc/pacman.d/mirrorlist"
	mirrorlisti686="$filesdir/arch_custom-config/mirrorlist-i686"
	mirrorlistx8664="$filesdir/arch_custom-config/mirrorlist-x86_64"
	typesystem=( $(uname -m) )
	pacmanconf="$filesdir/arch_custom-config/pacman.conf"
	realpacmanconf="/etc/pacman.conf"
	vconsoleconf="$filesdir/arch_custom-config/vconsole.conf"
	realvconsoleconf="/etc/vconsole.conf"
}
cpftf()
{
	sudo cp -f "$1" "$2"
	sleep 1
	if [ -e "$2" ]; then
		echo -e "\e[1;32mCopy file \e[1;37m$2 \e[1;32mto Ok!\e[0m"
	elif [ ! -e "$2" ]; then
		echo -e "\e[1;31mCopy file \e[1;37m$2 \e[1;31merror!\e[0m"
	fi	
}
scmkd()
{
	sudo mkdir "$1"
	sleep 1
	if [ -e "$1" ]; then
		echo -e "\e[1;32mNew dir create: \e[1;37m$1\e[0m"
	elif [ ! -e "$1" ]; then
		echo -e "\e[1;31mCreate to dir \e[1;37m$1 \e[1;31merror!\e[0m"
	fi
}
finishers()
{
	unset ABSOLUT_FILENAME
	unset filesdir
	unset hal
	unset fdi
	unset policy
	unset keymap
	unset realkeymap
	unset localeconf
	unset reallocaleconf
	unset localegen
	unset reallocalegen
	unset realmirrorlists
	unset mirrorlisti686
	unset mirrorlistx8664
	unset typesystem
	unset mkinitcpioconf
	unset realmkinitcpioconf
	unset pacmanconf
	unset realpacmanconf
	unset vconsoleconf
	unset realvconsoleconf
}
starters
scmkd "$hal"
scmkd "$fdi"
scmkd "$policy"
cpftf "$keymap" "$realkeymap"
cpftf "$localeconf" "$reallocaleconf"
cpftf "$localegen" "$reallocalegen"
if [[ $typesystem =~ ^["x86_64"] ]]; then
	cpftf "$pacmanconf" "$realpacmanconf"
	sed -i '5r arch_custom-config/mirrorlist-x86_64' /etc/pacman.d/mirrorlist
else 
	sed -i '5r arch_custom-config/mirrorlist-i686' /etc/pacman.d/mirrorlist
fi
cpftf "$vconsoleconf" "$realvconsoleconf"
loadkeys ru
setfont cyr-sun16
locale-gen
export Lang=ru_RU.UTF-8
finishers
echo -e "\e[1;30m\n\nDone $0\e[0m"
read -p "Press any key to continue ..."
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
exit 0
