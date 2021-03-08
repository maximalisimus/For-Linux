#!/bin/bash
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_ERROR="echo -en \\033[1;33m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
ABSOLUT_FILENAME=`readlink -e "$0"`
filesdir=`dirname "$ABSOLUT_FILENAME"`
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
	echo -e -n "\nHelp $0\n"
	echo -e -n "\nThe command is:\n"
	echo -e -n "\n-a\tDirectory with md5sum check files.\n\tOptional parameter.\n\tBy default, the current directory will be searched.\n"
	echo -e -n "\n-b\tDirectory for errors.\n\tOptional parameter.\n\tBy default, either the same directory as the '-a' option is set, \n\tor the current directory is set.\n"
	echo -e -n "\n-c\tA custom text file with md5 amounts that you want to verify.\n\tOptional parameter.\n\tBy default, all md5 amounts received will be displayed.\n"
	echo -e -n "\n-d\tDo not output md5 sums.\n\tOptional parameter.\n\tNot used by default.\n"
	echo -e -n "\n-m\tMaximum depth of subdirectories search.\n\tTo search only the current directory, set 1.\n\tOptional parameter.\n\tBy default, all subdirectories will be searched.\n"
	echo -e -n "\n-r\tStart calculating md5 sums.\n"
	echo -e -n "\n--h\tHelp.\n"
	echo -e -n "\n--help\tHelp.\n"
}
_folder=""
_error_folder=""
_md5=""
_error_md5=""
_error_test_md5=""
_md5sum_check=""
_no_out_md5sum=0
md5_program()
{
	[[ $_folder == "" ]] && _folder="$filesdir"
	[[ $_error_folder == "" ]] && _error_folder="$_folder"
	_md5="$_folder/MD5"
	_error_md5="$_error_folder/error-md5"
	_error_test_md5="$_error_folder/error-test-md5"
	echo ""
	echo "------------"
	echo -e -n "\e[0;37mCalculate md5sum\e[0m\n"
	if [[ $_md5sum_check != "" ]]; then 
		if [[ $_maxdepth = "" ]]; then
			find $_folder -type f -exec md5sum {} + | grep -v "$0" | grep -v "$_md5" | grep -v "$_error_md5" | grep -v "$_error_test_md5" | grep -v "$_md5sum_check" 1>>$_md5 2>>$_error_md5
		else
			find $_folder -maxdepth "$_maxdepth" -type f -exec md5sum {} + | grep -v "$0" | grep -v "$_md5" | grep -v "$_error_md5" | grep -v "$_error_test_md5" | grep -v "$_md5sum_check" 1>>$_md5 2>>$_error_md5
		fi
	else
		if [[ $_maxdepth = "" ]]; then
			find $_folder -type f -exec md5sum {} + | grep -v "$0" | grep -v "$_md5" | grep -v "$_error_md5" | grep -v "$_error_test_md5" 1>>$_md5 2>>$_error_md5
		else
			find $_folder -maxdepth "$_maxdepth" -type f -exec md5sum {} + | grep -v "$0" | grep -v "$_md5" | grep -v "$_error_md5" | grep -v "$_error_test_md5" 1>>$_md5 2>>$_error_md5
		fi
	fi
	wait
	if [[ $(cat $_error_md5) == "" ]]; then
		sms "1"
		checkprocess "0"
		rm -rf $_error_md5
	else
		sms "2"
		checkprocess "1"
		echo -e -n "\n"
		echo -e -n "$_error_md5\n"
		cat $_error_md5
		# rm -rf $_error_md5
	fi
	echo "------------"
	md5sum -c $_md5 1>/dev/null 2>$_error_test_md5
	if [[ $(cat $_error_test_md5) == "" ]]; then
		echo -e -n "\e[0;32mCheck the calculated md5sum\e[0m"
		checkprocess "0"
		rm -rf $_error_test_md5
	else
		echo -e -n "\n\e[0;31mError the calculated md5sum\e[0m"
		checkprocess "1"
		echo -e -n "\n"
		echo -e -n "$_error_test_md5\n"
		cat $_error_test_md5
		# rm -rf $_error_test_md5
	fi
	echo "------------"
	if [[ $_md5sum_check != "" ]]; then
		_out_md5=$(cat $_md5 | awk '{print $1}')
		_out_ch_md5=$(cat $_md5sum_check | awk '{print $1}')
		_err=0
		_err2=0
		echo -e -n "\e[0;37mCheck the calculate md5sum with file: $_md5sum_check\e[0m\n"
		for i in ${_out_md5[*]}; do
			for j in ${_out_ch_md5[*]}; do
				if [[ $i == $j ]]; then
					_err=0
					break
				else
					_err="$j"
				fi
			done
			if [[ $_err != "0" ]]; then
				$SETCOLOR_ERROR
				if [[ $_no_out_md5sum == 0 ]]; then	
					cat $_md5 | grep "$i"
				fi
				_err2=1
				$SETCOLOR_NORMAL
			fi
		done
		if [[ $_err2 == "0" ]]; then
			sms "1"
			checkprocess "0"
		else
			sms "2"
			checkprocess "1"
		fi
		echo "------------"
		echo ""
	else
		if [[ $_no_out_md5sum == 0 ]]; then
			cat $_md5
			echo "------------"
			echo ""
		fi
	fi
	rm -rf $_md5
}
_maxdepth=""
while [ -n "$1" ]; do
	case "$1" in
		-a) [[ $2 != "" ]] && _folder="$2" || _folder="$filesdir"
			[[ $2 != "" ]] && shift
			;;
		-b) [[ $2 != "" ]] && _error_folder="$2" || _error_folder="$_folder"
			[[ $2 != "" ]] && shift
			;;
		-c) [[ $2 != "" ]] && _md5sum_check="$2"
			[[ $2 != "" ]] && shift
			;;
		-d) _no_out_md5sum=1;;
		-m) [[ $2 != "" ]] && _maxdepth="$2"
			shift;;
		-[h?] | --help) _help;;
		-r) md5_program;;
		*) $SETCOLOR_ERROR
			echo -e -n "\nUnkonwn parameter\n"
			$SETCOLOR_NORMAL
			_help
			;;
	esac
	shift
done
exit 0
