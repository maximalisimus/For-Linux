#!/bin/bash
ANSWER="./.asf"
SYSTEM=$(uname -s)
VERSION=$(uname -r)
ARCHI=$(uname -m)
usb_dev=$(readlink -f /dev/disk/by-id/usb-* | grep -Ei "*.[0-9]")
menu_usb_dev=""
for i in ${usb_dev[*]}; do
	dev_usb=$(echo "$i" | rev | cut -d '/' -f1 | rev)
	m_point=$(lsblk -o NAME,MOUNTPOINT | grep -Ei "${dev_usb}" | cut -d ' ' -f2-9)
	if [[ ${m_point[*]} != "" ]]; then
		usb_size=$(lsblk -o NAME,SIZE | grep -Ei "${dev_usb}" | awk '{print $2}' | tr ' ' '_')
		usb_name=$(lsblk -o NAME,MOUNTPOINT | grep -Ei "${dev_usb}" | rev | cut -d '/' -f1 | rev | tr ' ' '_')
		usb_info="${usb_size}_${usb_name}"
		menu_usb_dev="${menu_usb_dev} $i $usb_info"
	fi	
done
if [[ ${menu_usb_dev} != "" ]]; then
	Xdialog --backtitle "$SYSTEM $VERSION $ARCHI" --title "Извлечение флешек" --menu "\nМеню выбора флешки для извлечения\n" 0 0 10 ${menu_usb_dev} 2>${ANSWER} 
	variables=$(cat ${ANSWER})
	umount ${variables}
fi
rm -rf $ANSWER
exit 0
