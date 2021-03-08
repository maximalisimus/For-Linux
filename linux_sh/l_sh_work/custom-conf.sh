#!/bin/sh
echo "Start ..."
ABSOLUTE_FILENAME=""
filedir=""
keymap=""
realkeymap=""
ipv=""
realipv=""
localeconf=""
reallocaleconf=""
localegen=""
reallocalegen=""
mirrorlists=""
realmirrorlists=""
mkinitcpioconf=""
realmkinitcpioconf=""
pacmanconf=""
realpacmanconf=""
vconsoleconf=""
realvconsoleconf=""
startim()
{
	ABSOLUTE_FILENAME=`readlink -e "$0"`
	filedir=`dirname "$ABSOLUTE_FILENAME"`
	keymap="$filedir/arch_custom-config/10-keymap.fdi"
	realkeymap="/etc/hal/fdi/policy/10-keymap.fdi"
	ipv="$filedir/arch_custom-config/40-ipv6.conf"
	realipv="/etc/sysctl.d/40-ipv6.conf"
	localeconf="$filedir/arch_custom-config/locale.conf"
	reallocaleconf="/etc/locale.conf"
	localegen="$filedir/arch_custom-config/locale.gen"
	reallocalegen="/etc/locale.gen"
	mirrorlists="$filedir/arch_custom-config/mirrorlist"
	realmirrorlists="/etc/pacman.d/mirrorlist"
	mkinitcpioconf="$filedir/arch_custom-config/mkinitcpio.conf"
	realmkinitcpioconf="/etc/mkinitcpio.conf"
	pacmanconf="$filedir/arch_custom-config/pacman.conf"
	realpacmanconf="/etc/pacman.conf"
	vconsoleconf="$filedir/arch_custom-config/vconsole.conf"
	realvconsoleconf="/etc/vconsole.conf"
}
cpftf()
{
	`cp -f $1 $2`
}
finishim()
{
	unset ABSOLUTE_FILENAME
	unset filedir
	unset keymap
	unset realkeymap
	unset ipv
	unset realipv
	unset localeconf
	unset reallocaleconf
	unset localegen
	unset reallocalegen
	unset mirrorlists
	unset realmirrorlists
	unset mkinitcpioconf
	unset realmkinitcpioconf
	unset pacmanconf
	unset realpacmanconf
	unset vconsoleconf
	unset realvconsoleconf
}
startim
cpftf "$keymap" "$realkeymap"
mkdir /etc/hal/
mkdir /etc/hal/fdi/
mkdir /etc/hal/fdi/policy/
cpftf "$ipv" "$realipv"
cpftf "$localeconf" "$reallocaleconf"
cpftf "$localegen" "$reallocalegen"
cpftf "$mirrorlists" "$realmirrorlists"
cpftf "$mkinitcpioconf" "$realmkinitcpioconf"
cpftf "$pacmanconf" "$realpacmanconf"
cpftf "$vconsoleconf" "$realvconsoleconf"
loadkeys ru
setfont cyr-sun16
locale-gen
export Lang=ru_RU.UTF-8
pacman -Syy
finishim
echo "Done ..."
exit 0
