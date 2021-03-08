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
_folder=""
_error_folder=""
_md5=""
_error_md5=""
_error_test_md5=""
_md5sum_check=""
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
		*) shift
			;;
	esac
	shift
done
[[ $_folder == "" ]] && _folder="$filesdir"
[[ $_error_folder == "" ]] && _error_folder="$_folder"
_md5="$_folder/MD5"
_error_md5="$_error_folder/error-md5"
_error_test_md5="$_error_folder/error-test-md5"
echo ""
echo "------------"
echo -e -n "\e[0;37mCalculate md5sum\e[0m\n"
if [[ $_md5sum_check != "" ]]; then 
	find $_folder -type f -exec md5sum {} + | grep -v "$0" | grep -v "$_md5" | grep -v "$_error_md5" | grep -v "$_error_test_md5" | grep -v "$_md5sum_check" 1>>$_md5 2>>$_error_md5
else
	find $_folder -type f -exec md5sum {} + | grep -v "$0" | grep -v "$_md5" | grep -v "$_error_md5" | grep -v "$_error_test_md5" 1>>$_md5 2>>$_error_md5
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
	cat $_error_md5
	rm -rf $_error_md5
fi
echo "------------"
md5sum -c $_md5 1>/dev/null 2>$_error_test_md5
if [[ $(cat $_error_test_md5) == "" ]]; then
	echo -e -n "\e[0;32mCheck the calculated md5sum\e[0m"
	checkprocess "0"
	rm -rf $_error_test_md5
else
	echo "\n\e[0;31mError the calculated md5sum\e[0m"
	checkprocess "1"
	echo -e -n "\n"
	cat $_error_test_md5
	rm -rf $_error_test_md5
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
			cat $_md5 | grep "$i"
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
	cat $_md5
	echo "------------"
	echo ""
fi
rm -rf $_md5
exit 0
