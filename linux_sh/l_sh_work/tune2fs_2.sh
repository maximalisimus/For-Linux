#!/bin/bash
VERSION=$(uname -r)
SYSTEM=$(uname -s)
ARCHI=$(uname -m)
ANSWER="./.asf"
_sh_dev_title="Select devices"
_sh_dev_body="\nPlease, to select on devices\n"
_rsvd_nfo1="Device "
_rsvd_nfo2=" to size "
_rsvd_nfo3="Reserved block count percentage:"
_reserved_info_title="Reserved block information"
declare -a _devices
declare -a _device_menu
_once_device_menu=0
MOUNTPOINT="/"
DEVICES=""
select_mountpoint()
{
    devices_list=$(lsblk -l | sed '/SWAP/d' | grep -Ei "$1" | awk 'BEGIN{OFS=" "} {print $1,$4}')
    dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_sh_dev_title" --menu "$_sh_dev_body" 0 0 4 ${devices_list} 2>${ANSWER} || prep_menu
    DEVICES=$(cat ${ANSWER})
}
function reserved_block()
{
	_block_count=$(tune2fs -l $1 | grep -Ei "^(Block count:)" | sed 's/Block count://' | tr -d ' ')
	_reserved_block_count=$(tune2fs -l $1 | grep -Ei "^(Reserved block count:)" | sed 's/Reserved block count://' | tr -d ' ')
	bc=${_block_count[*]}
	unset _block_count
	rbc=${_reserved_block_count[*]}
	unset _reserved_block_count
	_reserv_procent=$(awk 'BEGIN{print ('"$rbc"'*100/'"$bc"')}' | sed 's/\./,/')
	unset bc
	unset rbc
	# round
	_rnd_reserv_procent=$(printf "%.0f" $_reserv_procent)
	unset _reserv_procent
	echo "${_rnd_reserv_procent[*]}"
}

deviceslist=$(lsblk -l | sed '/SWAP/d' | sed '/run/d' | grep -Ei "${MOUNTPOINT}" | awk '{print $1}')
echo "" > ./rsrvd.nfo
counter=0
for i in ${deviceslist[*]}; do
	devicessize=$(lsblk -l | sed '/SWAP/d' | sed '/run/d' | grep -Ei "$i" | awk '{print $4}')
	_reserved_size=$(reserved_block "/dev/$i")
	echo -e -n "\n$_rsvd_nfo1 $i $_rsvd_nfo2 ${devicessize[*]} \n" >> ./rsrvd.nfo
	echo -e -n "$_rsvd_nfo3 $_reserved_size\n" >> ./rsrvd.nfo
	counter=$(($counter+1))
done

dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_reserved_info_title" --textbox ./rsrvd.nfo 0 0
clear
rm -rf ./rsrvd.nfo
rm -rf ${ANSWER}
exit 0
