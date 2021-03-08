#!/bin/bash
# useradd1.sh - A simple shell script to display the form dialog on screen
# set field names i.e. shell variables
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
DIALOG=${DIALOG=dialog}
shell=""
groups=""
user=""
home=""
# open fd
exec 3>&1
# Store data to $VALUES variable
VALUES=$(dialog --ok-label "Next" \
	  --backtitle "Linux User Managment" \
	  --title "Useradd" \
	  --form "Create a new user" \
15 50 0 \
	"Username:" 1 1	"$user" 	1 10 10 0 \
	"Shell:"    2 1	"$shell"  	2 10 15 0 \
	"Group:"    3 1	"$groups"  	3 10 8 0 \
	"HOME:"     4 1	"$home" 	4 10 40 0 \
2>&1 1>&3)
# close fd
exec 3>&-
# display values just entered
clear
declare -a array
echo "$VALUES" 2>&1 | while read line
do
	echo "$line" >> form.txt
done
array=( $(cat form.txt) )
rm -rf form.txt
$DIALOG --backtitle "FrameWork" --title "Configuration" --colors --yesno "It's information dialog.\n\Zn\Z5Please enter to Ok!\n\ZnUsername: \Zn\Z2${array[0]} \n\ZnShell: \Zn\Z2${array[1]} \n\ZnGroup: \Zn\Z2${array[2]} \n\ZnHOME: \Zn\Z2${array[3]}" 20 70
sleep 3
unset array
clear
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
echo -e "\nScript is Done ..."
exit 0
