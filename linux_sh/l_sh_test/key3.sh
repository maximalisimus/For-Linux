#!/bin/bash
# The script is designed to automatically establish a connection to the Internet through the question-answer console
# Script version 1.0. Author by maximalisimus
# checkargs () {
# if [[ $OPTARG =~ ^-[a/b]$ ]]
# then
# echo "Unknow argument $OPTARG for option $opt!"
# exit 1
# fi
# }
# if [ $# -lt 1 ]
# then
# echo "No options found!"
# exit 1
# fi 
if [ -n "$1" ]; then
	while [ -n "$1" ]
	do
		case "$1" in
			-e) config="$2"
				if [ ! -n "$config" ]; then
					echo "No options found! Please select the ethernet option: "
					echo "Help message !"
				elif [ -n "$config" ]; then
					case "$config" in
						-h|--help|-help) echo "Help message !";;
						-a|-auto) echo "Auto connect";;
						*) echo "This parameter does not exist!"
							echo "Help message !";;
					esac
				else echo "This parameter does not exist, please re-enter the request:"
					echo "Help message !"
				fi
			shift;;
			-w) encrypt="$2"
				if [ ! -n "$encrypt" ]; then
					echo "No options found! Please select the encryption type: "
					echo "Help message !"
				elif [ -n "$encrypt" ]; then
					case "$encrypt" in
						-h|--help|-help) echo "Help message !";;
						-wep) echo "WEP encrypt";;
						-wpa|-wpa2) echo "WPA / WPA2 encrypt";;
						*) echo "This parameter does not exist!"
							echo "Help message !";;
					esac
				else echo "This parameter does not exist, please re-enter the request:"
					echo "Help message !"
				fi
			shift ;;
			-help|-h|--help ) echo "Help message !";;
			-v|-version|--version ) echo "Script version 1.0";;
			-i|-information|-info ) echo "Author by maximalisimus";;
			*) echo "This parameter does not exist!"
				echo "Help message !"
			shift;;
		esac
		shift
	done
elif [ ! -n "$1" ]; then
	echo "Help message !"
fi
exit 0
