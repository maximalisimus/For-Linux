#!/bin/bash
# The script is designed to automatically establish a connection to the Internet through the question-answer console
# Script version 1.0. Author by maximalisimus
helper()
{ 
	case "$1" in 
		1) echo -e "Please select the required option and run the script again with the selected parameters\n"
			echo "-e) Ethernet network connection"
			echo "-w) Wireless network connection"
			echo "-v) Version info to script"
			echo "-i) Autor script information"
			echo "For help with the options, see the appropriate sections"
		shift;;
		2) echo -e "\twep) Wired Equivalent Privacy"
			echo -e "\twpa) Wi-Fi Protected Access"
			echo -e "\twpa2) WPA/WPA2 PSK, Enterprise"
		shift;;
		3) echo -e "\tauto) Automatic configuration of the adapter"
			echo -e "\tconf) Manual adapter configuration"
		shift;;
	esac
}
while [ -n "$1" ]
do
	case "$1" in
		-e) config="$2"
			if [ -z "$config" ]; then
				echo "Please select the ethernet option: "
				helper "3"
			elif [ "$config" == "-help" ]; then
				helper "3"
			elif [ "$config" == "auto" ]; then
				echo "Ethernet option auto"
			elif [ "$config" == "conf" ]; then
				echo "Ethernet option conf"
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
			elif [ "$encrypt" == "wep" ]; then
				echo "Wireless option $2"
			elif [ "$encrypt" == "wpa" ]; then
				echo "Wireless option $2"
			elif [ "$encrypt" == "wpa2" ]; then
				echo "Wireless option $2"
			else echo "This parameter does not exist, please re-enter the request:"
				helper "2"
			fi
		shift ;;
		-help) helper "1";;
		-v) echo "Script version 1.0";;
		-i) echo "Author by maximalisimus";;
		*) echo "This parameter does not exist!"
			helper "1"
		shift;;
	esac
shift
done
exit 0
