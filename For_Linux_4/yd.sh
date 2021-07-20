#!/bin/bash
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_ERROR="echo -en \\033[1;33m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
sms()
{
	case "$1" in
		1) $SETCOLOR_SUCCESS
			echo -e -n "Process to Complete"
			$SETCOLOR_NORMAL;; 
		2) $SETCOLOR_FAILURE
			echo -e -n "Process to Failure"
			$SETCOLOR_NORMAL;;
	esac
}
checkprocess()
{
	if [ $1 -eq 0 ]; then
		$SETCOLOR_SUCCESS
		# echo -e -n "\n"
		echo -e -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
		$SETCOLOR_NORMAL
		 echo -e -n "\n"
	else
		$SETCOLOR_FAILURE
		# echo -e -n "\n"
		echo -e -n "$(tput hpa $(tput cols))$(tput cub 6)[Fail]"
		$SETCOLOR_NORMAL
		 echo -e -n "\n"
	fi
}
_help()
{
	echo -e -n "\t$0 -[i,d,s,e] [-h,-help,--h,--help] [URL require]\n"
	echo -e -n "Help $0\n"
	echo -e -n "The command is:\n"
	echo -e -n "\t-i\tInformation of count videos to best formats.\n"
	echo -e -n "\t-d\tDownload to best format.\n"
	echo -e -n "\t-s\tStart position to download.\n"
	echo -e -n "\t-e\tEnd position to download.\n"
	echo -e -n "\t-h\t|\n\t-help\t|\n\t--h\t|\n\t--help\tHelp.\n"
}
_information()
{
	youtube-dl --yes-playlist -iF "${1}" | grep -Ei "^[0-9].*" | grep -Evi "audio" | awk '{print "count -",$1,$2,$3,$4,$11}' | grep -Ei "best" | uniq -cid | sed 's/^[ \t]*//'
	sms "1"
	checkprocess "0"
}
_downloads()
{
	if [[ $sp_flag -eq 0 ]]; then
		youtube-dl -o '%(title)s.%(ext)s' --yes-playlist -if best "$1"
		sms "1"
		checkprocess "0"
	elif [[ $ep_flag -eq 0 ]]; then
		youtube-dl -o '%(title)s.%(ext)s' --yes-playlist -if best --playlist-start "${sp}" "$1"
		sms "1"
		checkprocess "0"
	else
		if [[ $ep -ne 0 ]]; then
			youtube-dl -o '%(title)s.%(ext)s' --yes-playlist -if best --playlist-start "${sp}" --playlist-end "${ep}" "$1"
			sms "1"
			checkprocess "0"
		else
			youtube-dl -o '%(title)s.%(ext)s' --yes-playlist -if best --playlist-start "${sp}" "$1"
			sms "1"
			checkprocess "0"
		fi
	fi
}
sp_flag=0
ep_flag=0
sp=0
ep=0
while [ -n "$1" ]; do
	case "$1" in
		-i) if [[ $2 != "" ]]; then
				_information "${2}"
				wait
				shift
			fi
			;;
		-d) if [[ $2 != "" ]]; then
				_downloads "$2"
				wait
				shift
			fi
			;;
		-s) if [[ $2 != "" ]]; then
				sp_flag=1
				sp=${2}
				wait
				shift
			fi
			;;
		-e) if [[ $2 != "" ]]; then
				ep_flag=1
				ep=${2}
				wait
				shift
			fi
			;;
		-[h?] | --help) _help;;
		*) $SETCOLOR_ERROR
			echo -e -n "Unkonwn parameter\n"
			$SETCOLOR_NORMAL
			_help
			sms "2"
			checkprocess "1"
			;;
	esac
	shift
done
exit 0
