#!/bin/bash
#
hrn=$(pacman -Qdt | cut -d " " -f1)
for i in ${hrn[*]}; do
	pacman -Rns $i --noconfirm
done
pacman -Rdd libdmx --noconfirm
pacman -Rdd libxxf86dga --noconfirm
pacman -Rdd libxxf86misc --noconfirm
pacman -Rdd xorgproto --noconfirm
pacman -Syyu --noconfirm
mkinitcpio -P
grub-mkconfig -o /boot/grub/grub.cfg
exit 0
