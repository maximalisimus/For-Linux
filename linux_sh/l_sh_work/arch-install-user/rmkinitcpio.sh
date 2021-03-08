#!/bin/bash
clear
counters="0"
if [ ! -e "arch_custom-config/mkinitcpio.conf" ]; then
	touch "arch_custom-config/mkinitcpio.conf"
elif [ -e "arch_custom-config/mkinitcpio.conf" ]; then
	cat "/dev/null" > "arch_custom-config/mkinitcpio.conf"
fi
cat "/mnt/etc/mkinitcpio.conf" 2>&1 | while read line
do
	if [[ $line =~ ^["HOOKS="] ]]; then
		continue
	elif [[ $line =~ ^[^"HOOKS="] ]]; then
		echo "$line" >> "arch_custom-config/mkinitcpio.conf"
	fi
done
sleep 1
echo "HOOKS=(base udev autodetect modconf block keyboard keymap consolefont sd-vconsole filesystems fsck)" >> "arch_custom-config/mkinitcpio.conf"
sudo cp -f "arch_custom-config/mkinitcpio.conf" "/mnt/etc/mkinitcpio.conf"
sleep 1
exit 0
