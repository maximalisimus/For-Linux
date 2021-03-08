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
	arch-chroot $MOUNTPOINT /bin/bash -c "pacman -Q" >/tmp/pkg 2>/dev/null
	cat /tmp/pkg | awk '{print $1}' >/tmp/lists
	rm -rf /tmp/pkg
	st_pkg=$(cat /tmp/lists)
	rm -rf /tmp/lists
	for i in ${temp_pkg[*]}; do
		cntr=$(echo "${st_pkg[*]}" | grep "$i" | wc -l)
		[[ $cntr == "0" ]] && new_pkg=("${new_pkg[@]}" "$i")
	done
	#for letter in ${temp_pkg[*]}; do
	#	setup_pkg=$(ls $MOUNTPOINT/var/lib/pacman/local/ | grep "$letter" | wc -l)
	#	if [[ $setup_pkg == "0" ]]; then
	#		new_pkg=("${new_pkg[@]}" "$letter")
	#	fi
	#done
	echo ${new_pkg[*]}
}
list=("cmake" "button" "batton" "python2-xdg" "hrenj" "xdg-user-dirs" "mama" "xdg-utils" "kicad" "archiso" "ntp" "abiword")
dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "_search_pkg_title" --infobox "_search_pkg_body" 0 0
#sleep 1
lst=$(check_s_lst_pkg "${list[*]}")
sleep 1
clear
echo ""
echo "${list[*]}"
echo ""
#unset list
echo "${lst[*]}"
echo ""
#sleep 1
_list=($(check_q_lst_pkg "${lst[*]}"))
echo "${_list[*]}"
echo ""
unset list
unset _list
unset list_packages
rm -rf ./pkg_inst.info
rm -rf ./pkg
exit 0
