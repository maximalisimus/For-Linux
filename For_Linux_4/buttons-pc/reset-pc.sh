#!/bin/bash
DIALOG=${DIALOG=Xdialog}
 
$DIALOG --backtitle "Перезагрузка компьютера" --title "Пожалуйста выберите действие" --clear \
        --yesno "Перезагрузить компьютер ?\n" 10 100
 
case $? in
    0) shutdown -r now ;;
esac

