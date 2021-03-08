#!/bin/bash
MOUNTPOINT="/mnt"
check_s_pkg_pacman()
{
	err=""
	pacman -Ss $1 1>/dev/null 2>/dev/null
	err=$?
	[[ $err -eq 0 ]] && echo 0 || echo 1
}
check_q_pkg_pacman()
{
	err=""
	# pacman -Qs $1 1>/dev/null 2>/dev/null
	pacman --root ${MOUNTPOINT} --dbpath ${MOUNTPOINT}/var/lib/pacman -Qs $1 1>/dev/null 2>/dev/null
	err=$?
	[[ $err -eq 0 ]] && echo 0 || echo 1
}
function check_s_lst_pkg {
	local temp_pkg
	temp_pkg=("$@")
	declare -a new_pkg
	temp=""
	for letter in ${temp_pkg[*]}; do
		temp=$(check_s_pkg_pacman "$letter")
		[[ $temp -eq 0 ]] && new_pkg=("${new_pkg[@]}" "$letter")
	done
	echo ${new_pkg[*]}
}
function check_q_lst_pkg {
	local temp_pkg
	temp_pkg=("$@")
	declare -a new_pkg
	temp=""
	for letter in ${temp_pkg[*]}; do
		temp=$(check_q_pkg_pacman "$letter")
		[[ $temp -eq 1 ]] && new_pkg=("${new_pkg[@]}" "$letter")
	done
	echo ${new_pkg[*]}
}
list1=("cmake" "button" "batton" "python2-xdg" "hrenj" "xdg-user-dirs" "mama" "xdg-utils" "kicad" "archiso")
dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "_search_pkg_title" --infobox "_search_pkg_body" 0 0
sleep 1
list_packages=$(check_s_lst_pkg "${list1[*]}")
clear
echo ""
echo ${list1[*]}
echo ""
unset list1
echo ${list_packages[*]}
echo ""
list1=$(check_q_lst_pkg "${list_packages[*]}")
echo ${list1[*]}
echo ""
unset list1
unset list_packages
exit 0
