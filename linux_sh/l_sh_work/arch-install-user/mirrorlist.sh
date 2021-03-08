#!/bin/sh
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
echo -e "\e[1;30mStart $0\n\e[0m"
temp=""
PS3='Please, to select menu: '
echo
choice_of()
{
select menu
do
  temp=$menu
  break
done
}
reflectormanual()
{
	rfsrv="/etc/systemd/system/reflector.service"
	touch "$rfsrv"
	echo "[Unit]" >> $rfsrv
	echo "Description=Pacman mirrorlist update" >> $rfsrv
	echo "" >> $rfsrv
	echo "[Service]" >> $rfsrv
	echo "Type=oneshot" >> $rfsrv
	echo "ExecStart=/usr/bin/reflector --protocol http --latest 30 --number 20 --sort rate --save /etc/pacman.d/mirrorlist" >> $rfsrv
	unset rfsrv
	touch /root/pacman-mirrorlist-update.sh
	chmod ugo+x /root/pacman-mirrorlist-update.sh
	echo "sudo systemctl start reflector" >> /root/pacman-mirrorlist-update.sh
	echo -e "\e[1;30mOne update to mirrorlist to command: sh /root/pacman-mirrorlist-update.sh\e[0m"
}
reflectorauto()
{
	rfsrv="/etc/systemd/system/reflector.timer"
	touch "$rfsrv"
	echo "[Unit]" >> $rfsrv
	echo "Description=Run reflector weekly" >> $rfsrv
	echo "" >> $rfsrv
	echo "[Timer]" >> $rfsrv
	echo "OnCalendar=weekly" >> $rfsrv
	echo "AccuracySec=12h" >> $rfsrv
	echo "Persistent=true" >> $rfsrv
	echo "" >> $rfsrv
	echo "[Install]" >> $rfsrv
	echo "WantedBy=timers.target" >> $rfsrv
	systemctl enable reflector.timer
	unset rfsrv
}
reflectorsystem()
{
	case "$1" in
		1) reflectormanual;;
		2) reflectorauto;;
	esac
}
startinitscript()
{
	unset temp
	pacman -Syy
	pacman -S reflector --noconfirm
	echo ""
	echo -e "\e[1;37mPlease to select number menu on one generating mirrorlist for pacman\e[0m"
	echo ""
	choice_of Random Country
	case "$temp" in
		Random) reflector --verbose -l 11 --sort rate --save /etc/pacman.d/mirrorlist;;
		Country) reflector --verbose --country 'Russia' -l 11 --sort rate --save /etc/pacman.d/mirrorlist;;
	esac
	echo ""
	echo "##" >> /etc/pacman.d/mirrorlist
	echo "##" >> /etc/pacman.d/mirrorlist
	echo "## Russia custom" >> /etc/pacman.d/mirrorlist
	echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
	echo "Server = https://mirror.yandex.ru/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
	echo "Server = http://mirror.rol.ru/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
	echo "Server = https://mirror.rol.ru/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
	echo "Server = http://archlinux.zepto.cloud/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
	echo "Server = http://mirror.truenetwork.ru/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
	echo "Server = http://mirror.aur.rocks/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
	echo "Server = https://mirror.aur.rocks/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
	pacman Syy
}
reflectorservices()
{
	unset temp
	echo ""
	echo -e "\e[1;30mDo you want to install reflector service?\e[0m"
	echo ""
	choice_of yes no
	case "$temp" in
		yes) unset temp
			echo -e "\e[1;30mHow service to \e[1;37mreflector\e[1;30m?\e[0m"
			echo -e "\e[1;30m(Reflector - regular update actual mirrorlist to pacman)\e[0m"
			echo -e "\e[1;30m(Update to weakly or manual)\e[0m"
			echo ""
			choice_of manual auto
			case "$temp" in
				manual) reflectorsystem "1";;
				auto) reflectorsystem "2";;
			esac;;
		no) break;;
}
finishdestroyscript()
{
	unset temp
}
echo -e "\e[1;30mDo you want to install \e[1;37mReflector\e[1;30m?\e[0m"
choice_of yes no
case "$temp" in
	yes) startinitscript
		reflectorservices;;
	no) break;;
esac
finishdestroyscript
echo -e "\e[1;30m\n\nDone $0\e[0m"
if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi
echo -n "${reset}"
exit 0
