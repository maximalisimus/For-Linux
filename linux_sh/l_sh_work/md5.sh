#!/bin/bash
ABSOLUT_FILENAME=`readlink -e "$0"`
filesdir=`dirname "$ABSOLUT_FILENAME"`
_folder=""
_error_folder=""
_md5=""
_error_md5=""
_error_test_md5=""
_md5sum_check=""
while [ -n "$1" ]; do
	case "$1" in
		-a) [[ $2 != "" ]] && _folder="$2" || _folder="$filesdir"
			shift
			;;
		-b) [[ $2 != "" ]] && _error_folder="$2" || _error_folder="$_folder"
			shift
			;;
		-c) [[ $2 != "" ]] && _md5sum_check="$2"
			shift
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
if [[ $_md5sum_check != "" ]]; then 
	_files=$(find $_folder -type f | grep -v "$0" | grep -v "$_md5" | grep -v "$_error_md5" | grep -v "$_error_test_md5" | grep -v "$_md5sum_check")
else
	_files=$(find $_folder -type f | grep -v "$0" | grep -v "$_md5" | grep -v "$_error_md5" | grep -v "$_error_test_md5")
fi
for i in ${_files[*]}; do
	md5sum $i 1>>$_md5 2>>$_error_md5
	wait
done
wait
md5sum -c $_md5 1>/dev/null 2>$_error_test_md5
[[ $(cat $_error_test_md5) == "" ]] && echo "Good" || cat $_error_test_md5
rm -rf $_error_test_md5
echo "------------"
if [[ $(cat $_error_md5) == "" ]]; then 
	echo "Good"
	rm -rf $_error_md5
else	
	cat $_error_md5
	rm -rf $_error_md5
fi
echo "------------"
if [[ $_md5sum_check != "" ]]; then
	_out_md5=$(cat $_md5 | awk '{print $1}')
	_out_ch_md5=$(cat $_md5sum_check | awk '{print $1}')
	_err=0
	_err2=0
	echo "Check the file $_md5 and $_md5sum_check"
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
			cat $_md5 | grep "$i"
			_err2=1
		fi
	done
	([[ $_err == "0" ]] && [[ $_err2 == "0" ]]) && echo "Good"
	echo "------------"
	echo ""
else
	cat $_md5
	echo "------------"
	echo ""
fi
rm -rf $_md5
exit 0
