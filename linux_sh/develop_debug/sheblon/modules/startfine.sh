#!/bin/bash
_result=""
function fn_open()
{
	_result=""
	dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_stfn_ttl" --inputbox "$_stfn_bd" 0 0 "myFunc" 2>${ANSWER}
	_result=$(cat ${ANSWER})
	echo "function ${_result}()" >> $_work_fl
	echo "{" >> $_work_fl
}
function fn_close()
{
	echo "}" >> $_work_fl
}
function fn_base()
{
	dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_fn_menu" \
    --menu "$_fn_menu_bd" 0 0 4 \
 	"1" "$_fn_mn_1" \
	"2" "$_fn_mn_2" \
	"3" "$_mn_back" 2>${ANSWER}	

    case $(cat ${ANSWER}) in
        "1") fn_open
             ;;
        "2") fn_close
             ;;  
          *) basemenu
             ;;
     esac
     fn_base
}
