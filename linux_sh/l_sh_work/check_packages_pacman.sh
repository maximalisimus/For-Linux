#!/bin/bash
check_pkg_pacman()
{
	err=""
	pacman -Ss $1 1>/dev/null 2>/dev/null
	err=$?
	if [ $err -eq 0 ]; then
		echo 0
	else
		echo 1
	fi
	unset err
}
function check_lst_pkg {
	local temp_pkg
	temp_pkg=("$@")
	declare -a new_pkg
	for letter in ${temp_pkg[*]}; do
		if [ $(check_pkg_pacman "$letter") -eq 0 ]; then
			 new_pkg=( "${new_pkg[@]}" "$letter" )
		fi
	done
	echo ${new_pkg[*]}
	unset new_pkg
	unset temp_pkg
}
list1=(cmake button batton python2-xdg hrenj xdg-user-dirs mama xdg-utils)
list_packages=$(check_lst_pkg ${list1[*]})
for letter in ${list_packages[*]}; do
	echo $letter
done
exit 0
