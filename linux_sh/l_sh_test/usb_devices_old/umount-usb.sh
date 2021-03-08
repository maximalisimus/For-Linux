#!/bin/bash
ANSWER="./user.usb"
my_usb="./usb.dev"
my_usb_mount="./usb.mount"
my_dev_usb="./usb.dev"
system=$(uname -s)
version=$(uname -r)
archi=$(uname -m)
_backtitle="${system} ${version} ${archi}"
ABS_FILENAME=`readlink -e "$0"`
fs_filedir=`dirname "$ABS_FILENAME"`
source $fs_filedir/options.conf
if [[ $_language == "" ]]; then
	Xdialog --backtitle "$_backtitle" --title "Input Passwords" --inputbox "Please, Enter the user passwords" 0 0 "" 2>${PASSWORD}
	qst=$?
	case $qst in
		0) szPassword=$(cat ${PASSWORD})
			printf "%s\n" "$szPassword" | sudo --stdin sh $fs_filedir/umount-usb-config.sh
			;;
	esac
	exec sh $0
fi
wait
[[ $szPassword != "" ]] && echo "$szPassword" > ${PASSWORD}
wait
sleep 1
input_pass()
{
	Xdialog --backtitle "$_backtitle" --title "$_pass_title" --inputbox "$_pass_body" 0 0 "" 2>${ANSWER}
	qst=$?
	case $qst in
		0) szPassword=$(cat ${ANSWER})
			;;
	esac
}
umount_dev_no_pas()
{
	sudo umount -l /dev/${eject_usb}
	wait
	sudo umount -l ${eject_usb}
}
umount_no_pass()
{
	sudo umount -l ${eject_usb_point}
	umount_dev
}
umount_pass()
{
	szPassword=$(cat ${PASSWORD})
	printf "%s\n" "$szPassword" | sudo --stdin umount -l ${eject_usb_point}
	umount_dev
}
umount_dev_pass()
{
	szPassword=$(cat ${PASSWORD})
	printf "%s\n" "$szPassword" | sudo --stdin umount -l /dev/${eject_usb}
	wait
	szPassword=$(cat ${PASSWORD})
	printf "%s\n" "$szPassword" | sudo --stdin umount -l ${eject_usb}
}
umount_dev()
{
	_dev_point=$(lsblk -o NAME,MODEL,TYPE,FSTYPE,SIZE,MOUNTPOINT | grep -v "loop" | grep -v "room" | grep -v "arch-airootfs" | grep -Ei "vfat|ntfs" | awk '{print $5}' | awk '!/^$/{print $0}')
	_dev_dir_point="/run/media/$_UserName/"
	_col=${#_dev_dir_point}
	for i in ${_dev_point[*]}; do
		_tmp=$(echo ${i:$_col})
		dev_point="${dev_point} $_tmp"
	done
	for i in ${dev_point[*]}; do
		lsblk -o NAME,MODEL,TYPE,FSTYPE,SIZE,MOUNTPOINT | grep -v "loop" | grep -v "room" | grep -v "arch-airootfs" | grep -i "$i" | grep -Ei "vfat|ntfs" | awk '{print $1}' | sed 's/└─//' > $my_dev_usb
	done
	for i in $(cat $my_dev_usb); do
		if [[ $i == $eject_usb ]]; then
			case $_type_mount in
				1) umount_dev_no_pas
					;;
				2) umount_dev_pass
					;;
				3) umount_dev_pass
					;;
			esac
		fi
	done
}
lsblk -o NAME,MODEL,TYPE,FSTYPE,SIZE,MOUNTPOINT | grep -v "loop" | grep -v "room" | grep -v "arch-airootfs" | grep -Ei "vfat|ntfs" | awk '{print $5}' > $my_usb_mount
usb=""
unset usb
szPassword=""
_UserName=$(whoami)
if [[ $(cat $my_usb_mount) != "" ]]; then
	_point=$(lsblk -o NAME,MODEL,TYPE,FSTYPE,SIZE,MOUNTPOINT | grep -v "loop" | grep -v "room" | grep -v "arch-airootfs" | grep -Ei "vfat|ntfs" | awk '{print $5}' | awk '!/^$/{print $0}')
	_dir_point="/run/media/$_UserName/"
	_col=${#_dir_point}
	for i in ${_point[*]}; do
		_tmp=$(echo ${i:$_col})
		point="${point} $_tmp"
	done
	for i in ${point[*]}; do
		lsblk -o NAME,MODEL,TYPE,FSTYPE,SIZE,MOUNTPOINT | grep -v "loop" | grep -v "room" | grep -v "arch-airootfs" | grep -i "$i" | grep -Ei "vfat|ntfs" | awk '{print $1}{print $4}' | sed 's/└─//' >> $my_usb
	done
	if [[ $(cat $my_usb) != "" ]]; then
		for i in $(cat $my_usb); do
			# usb="${usb} $i -"
			usb="${usb} $i"
		done
		Xdialog --backtitle "$_backtitle" --title "$_menu_title" --menu "$_menu_body" 30 70 11 ${usb} 2>${ANSWER}
		question=$?
		case $question in
			0) eject_usb=$(cat ${ANSWER})
				eject_usb_point=$(lsblk -o NAME,MODEL,TYPE,FSTYPE,SIZE,MOUNTPOINT | grep -v "loop" | grep -v "room" | grep -v "arch-airootfs" | grep -i "${eject_usb}" | grep -Ei "vfat|ntfs" | awk '{print $5}')
				case $_type_mount in
					1) umount_no_pass
						;;
					2) umount_pass
						;;
					3) input_pass
						if [[ $szPassword != "" ]]; then
							umount_pass
						fi
						;;
				esac
			;;
		esac
	else
		Xdialog --backtitle "$_backtitle" --title "$_MSG_Title" --msgbox "$_MSG_Body" 10 50
	fi
else
	Xdialog --backtitle "$_backtitle" --title "$_MSG_Title" --msgbox "$_MSG_Body" 10 50
fi
clear
rm -rf ${ANSWER}
rm -rf ${PASSWORD}
unset usb
unset szPassword
rm -rf ${my_usb}
rm -rf ${my_usb_mount}
rm -rf ${my_dev_usb}
exit 0
