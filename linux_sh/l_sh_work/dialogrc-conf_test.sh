#!/bin/bash
#
dialog --backtitle "Version System (Archi)" --title " My one dialog" --clear \
        --yesno "Hello! It's one programm,\nuses dialog" 10 40
 
case $? in
    0)
	echo "It is the 'Yes'.";;
    1)
	echo "Select 'No'.";;
    255)
	echo "Click the ESC.";;
esac
clear
ABSOLUT_FILENAME=$(readlink -e "$0")
filesdir=$(dirname "$ABSOLUT_FILENAME")
source "$filesdir/dialogrc-conf.sh"
us_dlgrc_conf
dialog --backtitle "Version System (Archi)" --title " My one dialog" --clear \
        --yesno "Hello! It's one programm,\nuses dialog" 10 40
 
case $? in
    0)
	echo "It is the 'Yes'.";;
    1)
	echo "Select 'No'.";;
    255)
	echo "Click the ESC.";;
esac
clear
un_us_dlgrc_conf
dialog --backtitle "Version System (Archi)" --title " My one dialog" --clear \
        --yesno "Hello! It's one programm,\nuses dialog" 10 40
 
case $? in
    0)
	echo "It is the 'Yes'.";;
    1)
	echo "Select 'No'.";;
    255)
	echo "Click the ESC.";;
esac
clear
echo ""
sudo ls -A $HOME/ | grep ".dialogrc"
sudo ls -A /root/ | grep ".dialogrc"
sudo ls /etc/ | grep "dialogrc"
exit 0

