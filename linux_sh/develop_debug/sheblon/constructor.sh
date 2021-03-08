#!/bin/bash
#
function basemenu()
{
	if [[ $_bs_mn_once -eq 0 ]]; then
		ABSOLUT_FILENAME=$(readlink -e "$0")
		filesdir=$(dirname "$ABSOLUT_FILENAME")
		_language=$(cat "$filesdir"/config/lang.conf)
		source "${_language}"
		source "$filesdir"/config/variables.sh
		mkdir -p ./work
		touch $_work_fl
		touch $_hdr_fl
		touch $_bd_fl
		touch $_regular_fl
		if [[ ${_lst_mn_fl[*]} != "" ]]; then
			for i in ${_lst_mn_fl[*]}; do
				_mn_fl="./modules/$i.sh"
				[ -e $_mn_fl ] && source "$_mn_fl"
			done
			unset _mn_fl
		fi
		_bs_mn_once=1
	fi
	dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_bs_mn_ttl" \
    --menu "$_bs_mn_bd" 0 0 10 \
 	"1" "$_fn_menu" \
	"2" "$_bs_mn_1" \
	"3" "$_mn_exit" 2>${ANSWER}	

    case $(cat ${ANSWER}) in
        "1") fn_base
             ;;
        "2") chrchck
			;;
          *) dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --yesno "$_close_bd" 0 0
			if [[ $? -eq 0 ]]; then
				clear
				rm -rf $ANSWER
				exit 0
			else
				basemenu
			fi
             ;;
     esac
     basemenu
}
basemenu
rm -rf $ANSWER
exit 0

