#!/bin/sh
# The script is designed to automatically establish a connection to the Internet through the question-answer console
# Script version 1.0. Author by maximalisimus
count="0"
declare -a param
checkargs() 
{
	if [[ $1 =~ ^-[e|w|c|a|"wep"|"wpa"|"wpa2"|"ip"|"mask"|"gw"|"ssid"|"pass"] ]]; then
		echo "1"
	elif [[ $1 =~ ^-[h/\?/"help"] ]]; then
		echo "2"
	elif [[ $1 =~ ^([a-z]|[A-Z]|[0-9]) ]]; then 
		echo "0"
	else echo "3"
	fi
}
helper()
{ 
	case "$1" in 
		1) echo "Helper key is --help | --h | -help | -h"
			echo "Please select the required option and run the script again with the selected parameters"
			echo "-e) Ethernet network connection"
			echo "-w) Wireless network connection"
			echo "-v) Version info to script"
			echo "-i) Autor script information"
			echo "For help with the options, see the appropriate sections"
			shift;;
		2) echo -e "\t-wep) Wired Equivalent Privacy"
			echo -e "\t-wpa) Wi-Fi Protected Access"
			echo -e "\t-wpa2) WPA/WPA2 PSK, Enterprise"
			shift;;
		3) echo -e "\t-a) Automatic configuration of the adapter"
			echo -e "\t-c) Manual adapter configuration"
			shift;;
		4) echo "Script version 1.0"
			shift;;
		5) echo "Author by maximalisimus"
			shift;;
		6) echo "This parameter does not exist!"
			shift;;
		7) echo "This parameter does not exist, please re-enter the request:"
			shift;;
		8) echo "Unknow argument for option!"
			shift;;
	esac
}
if [ -n "$1" ]; then
	while [ -n "$1" ]
	do
		case "$1" in
			-e) paramin="$2"
				if [ -n "$paramin" ]; then 
					check=$( checkargs "$paramin" )
					if [ "$check" == "0" ]; then
						param+="$paramin"
						count="0"
						shift
					elif [ "$check" == "1" ]; then
						count="10"
					elif [ "$check" == "2" ]; then
						helper "3"
					elif [ "$check" == "3" ]; then
						helper "7"
						helper "3"
					fi
				elif [ ! -n "$paramin" ]; then
					count="4"
					helper "6"
					helper "2"
				fi	
				shift;;
			-w) paramin="$2"
				if [ -n "$paramin" ]; then 
					check=$( checkargs "$paramin" )
					if [ "$check" == "0" ]; then
						helper "8"
						helper "2"
					elif [ "$check" == "1" ]; then
						count="5"
					elif [ "$check" == "2" ]; then
						helper "2"
					elif [ "$check" == "3" ]; then
						helper "7"
						helper "2"
					fi
				elif [ ! -n "$paramin" ]; then
					helper "6"
					helper "2"
				fi
				shift;;
			-c) echo ""
				shift;;
			-a) echo ""
				shift;;
			-ip) echo ""
				shift;;
			-mask) echo ""
				shift;;
			-gw) echo ""
				shift;;
			-ssid) paramin="$2"
					if [ "$count" == "5" ]; then
						if [ -n "$paramin" ]; then 
							check=$( checkargs "$paramin" )
							if [ "$check" == "0" ]; then
								param+="$paramin"
								count="6"
							elif [ "$check" == "1" ]; then
								helper "7"
								helper "2"
							elif [ "$check" == "2" ]; then
								helper "2"
							elif [ "$check" == "3" ]; then
								helper "7"
								helper "2"
							fi
						elif [ ! -n "$paramin" ]; then
							helper "6"
							helper "2"
						fi
					else 
						helper "7"
						helper "1"
					fi
				shift;;
			-pass) paramin="$2"
					if [ "$count" == "6" ]; then
						if [ -n "$paramin" ]; then 
							check=$( checkargs "$paramin" )
							if [ "$check" == "0" ]; then
								param+="$paramin"
								count="7"
							elif [ "$check" == "1" ]; then
								helper "7"
								helper "2"
							elif [ "$check" == "2" ]; then
								helper "2"
							elif [ "$check" == "3" ]; then
								helper "7"
								helper "2"
							fi
						elif [ ! -n "$paramin" ]; then
							helper "6"
							helper "2"
						fi
					else 
						helper "7"
						helper "1"
					fi
				shift;;
			 *) echo "Process param is $count ${param[@]}"
				shift;;
		esac	
	done
elif [ ! -n "$1" ]; then
	helper "1"
fi
exit 0
