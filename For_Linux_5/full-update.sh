#!/bin/bash
error_list=$(pacman -Qdt | cut -d " " -f1)
for i in ${error_list[*]}; do
	pacman -Rns $i --noconfirm
done
for i in ${error_list[*]}; do
	pacman -Rdd $i --noconfirm
done
sudo pacman -Syyuu --noconfirm && sudo mkinitcpio -P && sudo grub-mkconfig -o /boot/grub/grub.cfg && sudo pacman -Scc --noconfirm && sudo grub-customizer
exit 0
