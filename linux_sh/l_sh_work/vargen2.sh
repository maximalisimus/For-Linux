#!/bin/bash

# _lst_engns=(aspell google bing spell hunspell apertium yandex)
# _lst=$(trans -list-engine | tr -d '*' | sed 's/[ \t]//g' | xargs)
_lst_engns=(yandex google)
# _lst_engns=( $_lst )

_lng=(da nl en fr de el hu it pt tr)
_lng_files=(danish dutch english french german greek hungarian italian portuguese turkish)

_header_file="./header.txt"
_lang_file="./language.txt"
_tmpout_file="./tmp.txt"
_src_file="./russian.txt"
_out_rus="./lng/russian.txt"
_error_file="./err.log"
_fl_err="./error.log"
_tempest="./temper.txt"

_plwt=1
_plwts=1

setcolor()
{
	SETCOLOR_SUCCESS="echo -en \\033[1;32m"
	SETCOLOR_FAILURE="echo -en \\033[1;31m"
	SETCOLOR_NORMAL="echo -en \\033[0;39m"
}
outin_success()
{
	$SETCOLOR_SUCCESS
	echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
	$SETCOLOR_NORMAL
	echo
}
outin_failure()
{
	$SETCOLOR_FAILURE
	echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
	$SETCOLOR_NORMAL
	echo
}
function flashline()
{
	if [[ $_plwt -eq 1 ]]; then
		echo -n  -e "\e[1;31mPlease wait: $x ...\e[0m"\\r
		let _plwt+=1
		_plwts=1
	elif [[ $_plwt -eq 2 ]]; then
		echo -n  -e "\e[1;32mPlease wait: $x ...\e[0m"\\r
		if [[ $_plwts = 1 ]]; then
			let _plwt+=1
		else
			let _plwt-=1
		fi
		
	elif [[ $_plwt -eq 3 ]]; then
		echo -n  -e "\e[1;33mPlease wait: $x ...\e[0m"\\r
		if [[ $_plwts = 1 ]]; then
			let _plwt+=1
		else
			let _plwt-=1
		fi
	elif [[ $_plwt -eq 4 ]]; then
		echo -n  -e "\e[1;34mPlease wait: $x ...\e[0m"\\r
		if [[ $_plwts = 1 ]]; then
			let _plwt+=1
		else
			let _plwt-=1
		fi
	elif [[ $_plwt -eq 5 ]]; then
		echo -n  -e "\e[1;35mPlease wait: $x ...\e[0m"\\r
		let _plwt-=1
		_plwts=2
	fi
}
function checkinoutfile()
{
	declare -i _ch_f_src
	declare -i _out_f_ch
	declare -i _tr_ch_fs
	declare -i _out_f_tr
	_ch_f_src=$(cat $1 | cut -d '"' -f1 | grep -vi "#" | sed 's/.*\(=\S*\).*/\1/' | wc -l)
	_out_f_ch=$(cat $2 | cut -d '"' -f1 | grep -vi "#" | sed 's/.*\(=\S*\).*/\1/' | wc -l)
	_tr_ch_fs=$(cat $1 | cut -d '"' -f2 | grep -vi "#" | awk '!/^$/{print $0}' | wc -l)
	_out_f_tr=$(cat $2 | cut -d '"' -f2 | grep -vi "#" | awk '!/^$/{print $0}' | wc -l)
	if [[ $_ch_f_src -ne $_out_f_ch ]]; then
		echo -e -n "\e[1;31mError out of string!\e[0m"
		outin_failure
	else
		if [[ $_tr_ch_fs -ne $_out_f_tr ]]; then
			echo "\e[1;31mError! Not the text on variables!\e[0m"
			outin_failure
		fi
	fi
	unset _ch_f_src
	unset _out_f_ch
	unset _tr_ch_fs
	unset _out_f_tr
}
function cutinfile()
{
	if [ -e $_src_file ]; then
		flashline
		cutntr "$_src_file" "$_tempest"
	else
		echo -e -n "\e[1;31mError! File $_src_file not found!\e[0m"
		outin_failure
		exit 2
	fi
	[ -e $_header_file ] && rm -rf $_header_file
	[ -e $_lang_file ] && rm -rf $_lang_file
	while read line; do
		if [[ $line =~ ^[#] ]]; then
			echo "$line" >> $_header_file
			echo "" >> $_lang_file
		else
			echo "$line" | cut -d '"' -f1 >> $_header_file
			echo "$line" | cut -d '"' -f2 >> $_lang_file
		fi
	done < $_src_file
	mkdir -p lng
}
function cuttrfile()
{
	for i in ${_lng_files[*]}; do
		_cut_tr_f="./lng/$i.txt"
		_src_tr_f="./lng/$i.src"
		if [ -e $_cut_tr_f ]; then
			flashline
			[ -e $_header_file ] && rm -rf $_header_file
			wait
			cutntr "$_cut_tr_f" "$_tempest"
			while read line; do
				flashline
				if [[ $line =~ ^[#] ]]; then
					echo "$line" >> $_header_file
					echo "" >> $_src_tr_f
				else
					echo "$line" | cut -d '"' -f1 >> $_header_file
					echo "$line" | cut -d '"' -f2 >> $_src_tr_f
				fi
			done < $_cut_tr_f
			flashline
		else
			echo -e -n "\e[1;31mError! File $_cut_tr_f not found!\e[0m"
			outin_failure
		fi
	done
	unset _cut_tr_f
	unset _src_tr_f
}
function toconcatfile()
{
	counter=0
	count=0
	_tmp=""
	[ -e $_tmpout_file ] && rm -rf $_tmpout_file
	wait
	(tr -d '\r' | while read line; do
		if [[ $line =~ ^[#] ]]; then
			echo "$line" >> $_tmpout_file
		else
			count=0
			while read lines; do
				if [[ $count -eq $counter ]]; then
					_tmp=$(echo "$lines");
					break;
				fi
				let count+=1
			done < "$1"
			if [[ ${_tmp[*]} != "" ]]; then
				echo "$line${_tmp}" | sed 's/=/="/' >> $_tmpout_file
			else
				echo "$line" | sed 's/=/="/' >> $_tmpout_file
			fi	
		fi
		let counter+=1
	done) < $_header_file
	unset counter
	unset count
	unset _tmp
	[ -e $2 ] && rm -rf $2
	(tr -d '\r' | while read line; do
		if [[ $line =~ ^[#] ]]; then
			echo "$line" >> $2
		else
			echo "$line\"" >> $2
		fi
	done) < $_tmpout_file
	[ -e $_tmpout_file ] && rm -rf $_tmpout_file
}
function pastentr()
{
	rm -rf $2
	cat $1 | rev | sed '/db/s/^"/"n-/g' | sed '/db/s/"=/n-"=/g' | tr '-' '\\' | rev >> $2
	cp -f $2 $1
	rm -rf $2
}
function cutntr()
{
	rm -rf $2
	cat $1 | rev | tr '\\' '-' | sed 's/n-//g' | rev >> $2
	cp -f $2 $1
	rm -rf $2
}
function translatetext()
{
	trans -b -e "$1" -t "$2" -i "$3" -o "$4"
}
function convertout()
{
	rm -rf ./lng/*.txt
	for i in ${_lng_files[*]}; do
		_in_file="./lng/$i.src"
		_out_file="./lng/$i.txt"
		toconcatfile "$_in_file" "$_out_file"
		wait
		checkinoutfile "$_src_file" "$_out_file"
		[ -e $_in_file ] && rm -rf $_in_file
		pastentr "$_out_file" "$_tempest"
		wait
	done
	pastentr "$_src_file" "$_tempest"
	cp -f $_src_file $_out_rus
}
function trnsltlng()
{
	[ -e $_lang_file ] || cutinfile
	wait
	_sever="google"
	count=0
	cnt=1
	_out_file=""
	for i in ${_lng[*]}; do
		if [[ $cnt -eq 1 ]]; then
			cnt=0
			_sever="google"
		else
			cnt=1
			_sever="yandex"
		fi
		_out_file="./lng/${_lng_files[$count]}.src"
		translatetext "$_sever" "$i" "$_lang_file" "$_out_file"
		wait
		echo "Translate ${_lng_files[$count]} = $i is OK ???"
		read  x
		case $x in
			"y") echo -e -n "\e[1;32mGood translate ${_lng_files[$count]} = $i ...\e[0m"
				outin_success
				;;
			"n") echo -e -n "\e[1;31mError translate ${_lng_files[$count]} = $i !\e[0m"
				outin_failure
				flashline
				sleep 1m
				wait
				if [[ $cnt -eq 1 ]]; then
					cnt=0
					_sever="google"
				else
					cnt=1
					_sever="yandex"
				fi
				wait
				translatetext "$_sever" "$i" "$_lang_file" "$_out_file"
				;;
			*) echo -e -n "\e[1;32mGood translate ${_lng_files[$count]} = $i ...\e[0m"
				outin_success
				;;
		esac
		let count+=1
		flashline
		sleep 1m
		wait
	done
}
function addtrfnfldr()
{
	for i in ${_lng_files[*]}; do
		_in_file="./lng/$i.txt"
		_out_file="$1/$i.trans"
		if [ -e $_in_file ]; then
			if [ -e $_out_file ]; then
				cat $_out_file $_in_file >> $_tempest
				cp -f $_tempest $_out_file
				[ -e $_tempest ] && rm -rf $_tempest
			else
				echo -e -n "\e[1;31mError! File $_out_file not found!\e[0m"
				outin_failure
			fi
		else
			echo -e -n "\e[1;31mError! File $_in_file not found!\e[0m"
			outin_failure
		fi
	done
	_out_file="$1/russian.trans"
	_out_rus="./lng/russian.txt"
	if [ -e $_out_file ]; then
		if [ -e $_out_rus ]; then
			cat $_out_file $_out_rus >> $_tempest
			cp -f $_tempest $_out_file
			[ -e $_tempest ] && rm -rf $_tempest
		else
			echo -e -n "\e[1;31mError! File $_out_rus not found!\e[0m"
			outin_failure
		fi
	else
		echo -e -n "\e[1;31mError! File $_in_file not found!\e[0m"
		outin_failure
	fi		
	unset _in_file
	unset _out_file
}
function clearheader()
{
	# [ -e $_src_file ] && rm -rf $_src_file
	[ -e $_header_file ] && rm -rf $_header_file
	[ -e $_lang_file ] && rm -rf $_lang_file
	[ -e $_error_file ] && rm -rf $_error_file
	[ -e $_process_file ] && rm -rf $_process_file
	[ -e $_tempest ] && rm -rf $_tempest
}
function cleartrsrc()
{
	rm -rf ./lng/*.src
}
function cleartrtxt()
{
	rm -rf ./lng/*.txt
}
function allclear()
{
	clearheader
	[ -e ./lng ] && rm -rf ./lng
}
function cherrlg()
{
	_ch_the_err_log=$(cat $_fl_err | awk '!/^$/{print $0}' | sed 's/[ \t]//g')
	if [[ $_ch_the_err_log != "" ]]; then
		echo -e -n "\e[1;31mError! The process \e[1;35m$1 \e[1;31mis failed!\e[0m"
		outin_failure
	else
		echo -e -n "\e[1;32mThe process \e[1;35m$1 \e[1;32mis completed ...\e[0m"
		outin_success
	fi
	unset _ch_the_err_log
}
_help()
{
	echo -e -n "\nHelp $0"
	echo -e -n "\nThe command key is:"
	echo -e -n "\e[1;33m\n-c\t\t\e[1;30mCut the file to header variables and language text.\n\t\tPlease input the default to file of ./russian.txt\n\t\tor point this in the parameter\e[0m"
	echo -e -n "\e[1;33m\n-v\t\t\e[1;30mCut the translation file to header variables and language text. \n\t\t(./lng/*.txt on ./lng/*.src)\e[0m"
	echo -e -n "\e[1;33m\n-t\t\t\e[1;30mTranslate the text\e[0m"
	echo -e -n "\e[1;33m\n-p\t\t\e[1;30mInsert on translation text to the variables \n\t\t./header.txt on finish folder to ./lng/*.txt\e[0m"
	echo -e -n "\e[1;33m\n-a\t\t\e[1;30mAdd the translation variables on the your folder in parameter.\n\t\t(./lng/*.txt on user-folder)\e[0m"
	echo -e -n "\e[1;33m\n-d\t\t\e[1;30mClear the headers file \n\t\t(./header.txt and ./language.txt)\e[0m"
	echo -e -n "\e[1;33m\n-r\t\t\e[1;30mClear the translattion variable files file \n\t\t(./lng/*.txt)\e[0m"
	echo -e -n "\e[1;33m\n-s\t\t\e[1;30mClear the translattion files file \n\t\t(./lng/*.src)\e[0m"
	echo -e -n "\e[1;33m\n-o\t\t\e[1;30mAll Clear \n\t\t(Clear the headers and \n\t\tdelete finish folder ./lng)\e[0m"
	echo -e -n "\e[1;33m\n-h \e[1;30m(--h --help)\t\e[1;37mHelp.\n\e[0m"
	echo ""
}
setcolor
echo "" > $_fl_err
while [ -n "$1" ]; do
	case "$1" in
		-c) if [[ $2 != "" ]]; then
				if [[ $2 =~ ^[^-] ]]; then
					_src_file="$2"
				fi
			fi
			cutinfile 2>$_fl_err
			cherrlg "-c"
			if [[ $2 != "" ]]; then
				if [[ $2 =~ ^[^-] ]]; then
					shift
				fi
			fi
			;;
		-v) cuttrfile 2>$_fl_err
			cherrlg "-v"
			;;	
		-t) trnsltlng 2>$_fl_err
			cherrlg "-t"
			;;
		-p) convertout 2>$_fl_err
			cherrlg "-p"
			;;
		-a) if [[ $2 != "" ]]; then
				if [[ $2 =~ ^[^-] ]]; then
					addtrfnfldr "$2" 2>$_fl_err
					cherrlg "-a"
				fi
			fi
			if [[ $2 != "" ]]; then
				if [[ $2 =~ ^[^-] ]]; then
					shift
				fi
			fi
			;;
		-d) clearheader 2>$_fl_err
			cherrlg "-d"
			;;
		-r) cleartrtxt 2>$_fl_err
			cherrlg "-r"
			;;
		-s) cleartrsrc 2>$_fl_err
			cherrlg "-s"
			;;
		-o) allclear 2>$_fl_err
			cherrlg "-o"
			;;
		-[h?] | --help) _help
				;;
		*) _help
			;;
	esac
	shift
done
[ -e $_fl_err ] && rm -rf $_fl_err
exit 0
