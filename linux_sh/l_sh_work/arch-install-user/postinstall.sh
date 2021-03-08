#!/bin/sh
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
echo -e "\e[1;30mStart $0\n\e[0m"
ABS_FILENAME=""
onfiledir=""
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
sysctlconf=""
real_sysctlconf=""
startim()
{
	ABS_FILENAME=`readlink -e "$0"`
	onfiledir=`dirname "$ABS_FILENAME"`
	hal="/mnt/etc/hal/"
	fdi="/mnt/etc/hal/fdi/"
	policy="/mnt/etc/hal/fdi/policy/"
	keymap="$onfiledir/arch_custom-config/10-keymap.fdi"
	realkeymap="/mnt/etc/hal/fdi/policy/10-keymap.fdi"
	localeconf="$onfiledir/arch_custom-config/locale.conf"
	reallocaleconf="/mnt/etc/locale.conf"
	localegen="$onfiledir/arch_custom-config/locale.gen"
	reallocalegen="/mnt/etc/locale.gen"
	realmirrorlists="/mnt/etc/pacman.d/mirrorlist"
	mirrorlisti686="$filesdir/arch_custom-config/mirrorlist-i686"
	mirrorlistx8664="$filesdir/arch_custom-config/mirrorlist-x86_64"
	typesystem=( $(uname -m) )
	pacmanconf="$onfiledir/arch_custom-config/pacman.conf"
	realpacmanconf="/mnt/etc/pacman.conf"
	vconsoleconf="$onfiledir/arch_custom-config/vconsole.conf"
	realvconsoleconf="/mnt/etc/vconsole.conf"
	sysctlconf="$onfiledir/arch_custom-config/swappiness.conf"
	real_sysctlconf="/mnt/etc/sysctl.d/swappiness.conf"
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
finishim()
{
	unset ABS_FILENAME
	unset onfiledir
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
	unset pacmanconf
	unset realpacmanconf
	unset vconsoleconf
	unset realvconsoleconf
	unset sysctlconf
	unset real_sysctlconf
}
startim
scmkd "$hal"
scmkd "$fdi"
scmkd "$policy"
cpftf "$keymap" "$realkeymap"
cpftf "$localeconf" "$reallocaleconf"
cpftf "$localegen" "$reallocalegen"
if [[ $typesystem =~ ^["x86_64"] ]]; then
	cpftf "$pacmanconf" "$realpacmanconf"
	sed -i '5r arch_custom-config/mirrorlist-x86_64' /mnt/etc/pacman.d/mirrorlist
else 
	sed -i '5r arch_custom-config/mirrorlist-i686' /mnt/etc/pacman.d/mirrorlist
fi
cpftf "$vconsoleconf" "$realvconsoleconf"
cpftf "$sysctlconf" "$real_sysctlconf"
sed -i '83r arch_custom-config/sudooers-x86-64-i686' /mnt/etc/sudoers
finishim
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
