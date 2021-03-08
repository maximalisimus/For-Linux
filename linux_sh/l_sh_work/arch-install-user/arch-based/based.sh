#!/bin/bash
clear
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
question()
{
	errcode=$?
	if [ $errcode -eq 0 ]; then
		$SETCOLOR_SUCCESS
		if [ -n "$1" ]; then
			echo -e -n "$1"
		else
			echo -e -n "Operations complete!"
		fi
		echo -e -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]\n"
		$SETCOLOR_NORMAL
		echo
	else
		$SETCOLOR_FAILURE
		if [ -n "$1" ]; then
			echo -e -n "$1"
		else
			echo -e -n "Operations is errors!"
		fi
		echo -e -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]\n"
		$SETCOLOR_NORMAL
		echo
	fi
}
echo -e "\e[1;30m\n\nStart $0\e[0m"
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
loadkeys ru
question "loadkeys ru"
setfont cyr-sun16
question "setfont cyr-sun16"
locale-gen
export Lang=ru_RU.UTF-8
question "export Lang=ru_RU.UTF-8"
hwclock --systohc
question "hwclock --systohc"
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	mikl.localdomain	mikl" >> /etc/hosts
question "/etc/hosts is edit to 127.0.0.1..."
myusername=""
echo ""
read -p "Please etner the username: " myusername
useradd -m -g users -G audio,games,lp,optical,power,scanner,storage,video,wheel -s /bin/bash $myusername
if [ -e "/home/$myusername" ]; then
	question "useradd is $myusername"
else
	question "Error useradd is $myusername !"
fi
echo "$myusername" > /etc/hostname
question "hostname setup is $myusername"
echo "Please enter the password root"
passwd root
echo "Please enter the password $myusername"
passwd $myusername
clear
mkinicpio -P
grub-mkconfig -o /boot/grub/grub.cfg
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
question "echo wheel ALL=(ALL) ALL >> /etc/sudoers"
sudo pacman -S dconf dconf-editor gconf gconf-editor grub-customizer ttf-liberation ttf-dejavu opendesktop-fonts ttf-bitstream-vera ttf-arphic-ukai ttf-arphic-uming ttf-hanazono terminus-font cmake fish bash-completion curl git wget gwget breeze breeze-grub breeze-icons --noconfirm
question
sudo pacman -S netctl dialog xdialog net-tools network-manager-applet networkmanager libgtop --noconfirm
question
sudo pacman -S wpa_supplicant iw wireless_tools wicd --noconfirm
question
sudo pacman -S networkmanager-openconnect networkmanager-openvpn networkmanager-pptp networkmanager-vpnc networkmanager-l2tp --noconfirm
question
sudo pacman -S samba libwbclient smb4k smbclient smbnetfs --noconfirm
question
sudo pacman -S xterm lxterminal gnome-terminal leafpad gedit geany gvfs polkit xdg-user-dirs --noconfirm
question
sudo pacman -S ark audacious audacity chromium gimp gimp-help-ru gparted okular opera parcellite xarchiver vlc --noconfirm
question
sudo pacman -S archiso blender inkscape kicad kicad-library kicad-library-3d pragha qt5ct telegram-qt transmission-gtk wine-mono wine_gecko winetricks firefox unzip zip unrar p7zip smplayer keepassx truecrypt rhythmbox virtualbox --noconfirm
question 
sudo pacman -S libreoffice-fresh libreoffice-fresh-ru --noconfirm
question
sudo pacman -U packages/package-query-1.9-3-x86_64.pkg.tar.xz --noconfirm
question
sudo pacman -U packages/yaourt-1.9-1-any.pkg.tar.xz --noconfirm
question
sudo pacman -U packages/pamac-aur-7.3.3-1-x86_64.pkg.tar.xz --noconfirm
question
sudo pacman -U packages/timeshift-19.01-2-x86_64.pkg.tar.xz --noconfirm
question
sudo systemctl stop dhcpcd
question "systemctl stop dhcpcd"
sudo systemctl disable dhcpcd
question "systemctl disable dhcpcd"
sudo systemctl enable NetworkManager
question "systemctl enable NetworkManager"
sudo systemctl start NetworkManager
question "systemctl start NetworkManager"
curl -o strap.sh https://blackarch.org/strap.sh
sudo sh strap.sh
clear
sudo pacman -S linux-lts linux-lts-headers linux-lts-docs --noconfirm
mkinitcpio -P
grub-mkconfig -o /boot/grub/grub.cfg
clear
sudo pacman -S xorg --noconfirm
sudo pacman -S sddm sddm-kcm --noconfirm
sudo pacman -S mate mate-extra --noconfirm
sudo pacman -S mate-menu mate-backgrounds mate-common mate-polkit mate-user-guide --noconfirm
clear
Xorg :0 -configure
question "Xorg :0 -configure"
Xorg -configure
question "Xorg -configure"
sudo cp /root/xorg.conf.new /etc/X11/xorg.conf
question "File is /etc/X11/xorg.conf"
touch "/home/$myusername/.xinitrc"
echo "exec mate-session" >> /home/$myusername/.xinitrc
#cp `find /usr/share/xsession -iname "*.desktop"` /home/$myusername/
#sudo chown $myusername `find /home/$myusername/ -iname "*.desktop"`
#sudo chmod ugo+x `find /home/$myusername/ -iname "*.desktop"`
sudo cp -R /usr/share/xsession/* /home/$myusername/
sudo chown -R $myusername /home/$myusername/*
sudo chmod -R ugo+x /home/$myusername/*
question "File is /home/$myusername/.xinitrc"
sudo systemctl enable sddm
question "systemctl enable lxdm"
mkinitcpio -P
grub-mkconfig -o /boot/grub/grub.cfg
clear
# pacman -Qqet | grep -v "$(pacman -Qqg base base-devel)" # List packets to cut of base and base-devel packets
echo -e -n "\e[1;30m\n\nDone $0\e[0m"
unset errcode
echo -n "${reset}"
echo ""
read -p "Press any key to continue ..."
echo ""
exit 0
