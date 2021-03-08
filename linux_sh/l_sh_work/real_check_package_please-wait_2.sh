#!/bin/bash
MOUNTPOINT="/mnt"
function check_s_lst_pkg {
	local temp_pkg
	temp_pkg=("$@")
	declare -a new_pkg
	temp=""
	for i in ${temp_pkg[*]}; do
		pacman -Ss $i 1>/dev/null 2>/dev/null
		err=$?
		if [[ $err -eq 0 ]]; then 
			new_pkg=("${new_pkg[*]}" "$i")
		fi
	done
	echo ${new_pkg[*]}
}
function check_q_lst_pkg {
	local temp_pkg
	temp_pkg=("$@")
	declare -a new_pkg
	temp=""
	for i in ${temp_pkg[*]}; do
		pacman --root ${MOUNTPOINT} --dbpath ${MOUNTPOINT}/var/lib/pacman -Qs $i 1>/dev/null 2>/dev/null
		err=$?
		[[ $err != "0" ]] && new_pkg=("${new_pkg[@]}" "$i")
	done
	echo ${new_pkg[*]}
}
list=("cmake" "button" "batton" "python2-xdg" "hrenj" "xdg-user-dirs" "mama" "xdg-utils" "kicad" "archiso" "ntp" "abiword")
dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "_search_pkg_title" --infobox "_search_pkg_body" 0 0
lst=$(check_s_lst_pkg "${list[*]}")
sleep 1
clear
echo ""
echo "${list[*]}"
echo ""
echo "${lst[*]}"
echo ""
_list=($(check_q_lst_pkg "${lst[*]}"))
echo "${_list[*]}"
echo ""
unset list
unset _list
unset list_packages
exit 0
