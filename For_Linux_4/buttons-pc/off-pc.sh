#!/bin/bash
DIALOG=${DIALOG=Xdialog}
 
$DIALOG --backtitle "Выключение компьютера" --title "Пожалуйста выберите действие" --clear \
        --yesno "Выключить компьютер ?\n" 10 100
 
case $? in
    0) shutdown -P now ;;
esac

