#!/bin/bash
_dm=(lxdm gdm sddm lightdm slim)
_dm_manager=""
for i in ${_dm[*]}; do
	sudo pacman -Qs $i 1>/dev/null 2>/dev/null
	if [[ $? == "0" ]]; then
		case $i in
			"${_dm[0]}") _dm_manager="${_dm[0]}"
				break;;
			"${_dm[1]}") _dm_manager="${_dm[1]}"
				break;;
			"${_dm[2]}") _dm_manager="${_dm[2]}"
				break;;
			"${_dm[3]}") _dm_manager="${_dm[3]}"
				break;;
			"${_dm[4]}") _dm_manager="${_dm[4]}"
				break;;
		esac
	fi
done
echo "$_dm_manager"
exit 0
