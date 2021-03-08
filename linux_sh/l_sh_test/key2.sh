#!/bin/bash
# The script is designed to automatically establish a connection to the Internet through the question-answer console
# Script version 1.0. Author by maximalisimus
helper()
{ 
	case "$1" in 
		1) echo "Helper key is -help"
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
		3) echo -e "\t-auto) Automatic configuration of the adapter"
			echo -e "\t-conf) Manual adapter configuration"
		shift;;
		4) echo -e "Help manual config adapter"
		shift;;
	esac
}
if [ -n "$1" ]; then
	while [ -n "$1" ]
	do
		case "$1" in
			-e) config="$2"	
				hlp="$3"
				if [ ! -n "$config" ]; then
					echo "Please select the ethernet option: "
					helper "3"
				elif [ "$config" == "-help" ]; then
					helper "3"
				elif [ "$config" == "-auto" ]; then
					echo "Work auto configuration"
				elif [ "$config" == "-conf" ]; then
					echo "Work manual configuration"
				else echo "This parameter does not exist, please re-enter the request:"
					helper "3"
				fi
				shift;;
			-w) encrypt="$2"
				if [ -z "$encrypt" ]; then
					echo "Please select the encryption type: "
					helper "2"
				elif [ "$encrypt" == "-help" ]; then
					helper "2"
				elif [ "$encrypt" == "-wep" ]; then
					echo "Wireless option $2"
				elif [ "$encrypt" == "-wpa" ]; then
					echo "Wireless option $2"
				elif [ "$encrypt" == "-wpa2" ]; then
					echo "Wireless option $2"
				else echo "This parameter does not exist, please re-enter the request:"
					helper "2"
				fi
				shift;;
			-help) helper "1";;
			-h) helper "1";;
			-v) echo "Script version 1.0";;
			-i) echo "Author by maximalisimus";;
			*) echo "This parameter does not exist!"
				helper "1";;
		esac
		shift
	done
elif [ ! -n "$1" ]; then
	helper "1"
fi
exit 0
