#!/bin/bash
function inschr_smpl()
{
	if [ -e $_regular_fl ]; then
		if [[ $(cat $_regular_fl) != "" ]]; then
			_result=$(cat $_regular_fl | xargs)
			echo "arch_chroot \"${_result}\" 2>/tmp/.errlog" >> $_work_fl
		else
			dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_chrch_in_ttl" --inputbox "$_chrch_in_bd" 0 0 "" 2>${ANSWER}
			_result=$(cat ${ANSWER} | xargs)
			echo "arch_chroot \"${_result}\" 2>/tmp/.errlog" >> $_work_fl
		fi
	fi
}
function inschr_smpl_null()
{
	echo "arch_chroot \"\" 2>/tmp/.errlog" >> $_work_fl
}
function inschr_hrd()
{
	if [ -e $_regular_fl ]; then
		if [[ $(cat $_regular_fl) != "" ]]; then
			_result=$(cat $_regular_fl | xargs)
			echo "arch_chroot \"${_result}\" >/dev/null 2>/tmp/.errlog" >> $_work_fl
		else
			dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_chrch_in_ttl" --inputbox "$_chrch_in_bd" 0 0 "" 2>${ANSWER}
			_result=$(cat ${ANSWER} | xargs)
			echo "arch_chroot \"${_result}\" >/dev/null 2>/tmp/.errlog" >> $_work_fl
		fi
	fi
}
function inschr_hrd_null()
{
	echo "arch_chroot \"\" >/dev/null 2>/tmp/.errlog" >> $_work_fl
}
function inschck()
{
	echo "check_for_error" >> $_work_fl
}
function chrchck()
{
	dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_chrch_ttl" \
    --menu "$_chrch_bd" 0 0 7 \
 	"1" "$_chrch_mn_1" \
	"2" "$_chrch_mn_2" \
	"3" "$_chrch_mn_3" \
	"4" "$_chrch_mn_4" \
	"5" "$_chrch_mn_5" \
	"6" "$_mn_back" 2>${ANSWER}	

    case $(cat ${ANSWER}) in
        "1") inschr_smpl
             ;;
        "2") inschr_hrd
             ;;
        "3") inschr_smpl_null
			;;
		"4") inschr_hrd_null
			;;
        "5") inschck
             ;;     
          *) basemenu
             ;;
     esac
     chrchck	
}
