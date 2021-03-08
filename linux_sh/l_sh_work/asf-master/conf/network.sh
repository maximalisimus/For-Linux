#!/bin/bash
echo -e "\e[1;30m\n\nStart $0\e[0m"
source ./init.conf
# Create a temporary file to store menu selections
ANSWER="./.asf"
# Save retyping
VERSION="Architect Installation Framework"
# Installation
SYSTEM="Unknown"     		# Display whether system is BIOS or UEFI. Default is "unknown"
# Architecture
ARCHI=`uname -m`     		# Display whether 32 or 64 bit system
#stat=""
#tmplt()
#{
#	case "$1" in
#		1) if [[ $2 =~ ^([0-9]{1,3}[\.]){3}[0-9]{1,3}[\/][0-9]{1,2} ]]; then
#			# ^([0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9][\/][0-9][0-9])
#				echo "1"
#			else
#				echo "0"
#			fi;;
#		2) if [[ $2 =~ ^([0-9]{1,3}[\.]){3}[0-9]{1,3} ]]; then
#			# ^([0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9])
#				echo "1"
#			else
#				echo "0"
#			fi;;
#	esac
#}
#setstat()
#{
#	stat=( $(ip -o link show | gawk '{print $9}' | tr -d ':') )
#}
ethernet_menu()
{
	dialog --colors --default-item 1 --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "\Z0Ethernet config" --menu "Configuration adapter" 0 0 3 \
	"1" "\Z4Auto configuration" \
	"2" "\Z2Manual configuration" \
	"3" "\Z0< Back" \
	2>${ANSWER}
	case $(cat ${ANSWER}) in
	    "1") echo "Auto configuration"
			sleep 3
			;;
		"2") echo "Manual configuration"
			sleep 3
			;;
		"3") network_menu
			;;				
	esac
	ethernet_menu
}
wifi_menu()
{
	dialog --colors --default-item 1 --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "\Z0WiFi config" --menu "Configuration adapter" 0 0 7 \
	"1" "nput SSID" \
	"2" "Input password" \
	"3" "Encryption" \
	"4" "Type Encryption" \
	"5" "Fine WiFi configuration" \
	"6" "Manual address configuration" \
	"7" "\Z0< Back" \
	2>${ANSWER}
	case $(cat ${ANSWER}) in
	    "1") echo "nput SSID"
			sleep 3
			;;
		"2") echo "Input password"
			sleep 3
			;;
		"3") echo "Encryption"
			sleep 3
			;;
		"4") echo "Type Encryption"
			sleep 3
			;;
		"5") echo "Fine WiFi configuration"
			sleep 3
			;;
		"6") echo "Manual address configuration"
			sleep 3
			;;
		"7") network_menu
			;;				
	esac
	wifi_menu
}
network_menu()
{
	dialog --colors --default-item 1 --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "\Z0Select network" --menu "Please to select the type on network connection" 0 0 3 \
		"1" "\Z2Ethernet" \
		"2" "\Z4WiFi" \
		"3" "\Z0Exit" \
		2>${ANSWER}
		case $(cat ${ANSWER}) in
	    	"1") ethernet_menu
				;;
			"2") wifi_menu
				;;
			"3") dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --yesno "Do you want to exit?" 0 0
				if [[ $? -eq 0 ]]; then
					 clear
					exit 0
				else
					network_menu
				fi
				;;				
		esac
	network_menu
}
# setstat
# for letter in "${stat[@]}"; do
#	if [ "${net[$count]}" != "lo" ]; then
#		echo -e -n "${net[$count]} \e[0m"
#		if [ "$letter" != "UP" ]; then
#			`ip link set ${net[$count]} up`
#			checkprocess
#		else
#			echo -e -n "\e[1;31mUP\e[0m\n"
#			checkprocess
#		fi		
#	fi
#	let count+=1
# done
while true; do
	network_menu
done
echo -e "\e[1;30m\n\nDone $0\e[0m"
exit 0
