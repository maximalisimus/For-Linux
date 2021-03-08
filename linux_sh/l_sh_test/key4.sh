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
		
	done
elif [ ! -n "$1" ]; then
	echo "Help message !"
fi
exit 0
