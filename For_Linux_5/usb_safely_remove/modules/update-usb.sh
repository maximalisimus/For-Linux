#!/bin/bash
sms()
{
    case "$1" in
        1) $SETCOLOR_SUCCESS
            echo -e -n "Process to Complete"
            $SETCOLOR_NORMAL;; 
        0) $SETCOLOR_FAILURE
            echo -e -n "Process to Failure"
            $SETCOLOR_NORMAL;;
    esac
}
checkprocess()
{
    if [ $1 -eq 1 ]; then
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
function out_console_ok()
{
	clear
	wait
	sms "1"
	checkprocess "1"
	wait
	sleep 1
	wait
}
function out_console_error()
{
	clear
	wait
	sms "0"
	checkprocess "0"
	wait
	sleep 1
	wait
}
_help()
{
    echo -e -n "${_help_str_14}\n"
    echo -e -n "${_help_str_1} $0 V${versions}\n"
    echo -e -n "${_help_str_2}\n"
    echo -e -n "\t-u\t${_help_str_3}\n" 
    echo -e -n "\t-p\t${_help_str_4}\n"
    echo -e -n "\t-o\t${_help_str_5}\n" 
    echo -e -n "\t-f\t${_help_str_6}\n"
    echo -e -n "\t-d\t${_help_str_7}\n"
    echo -e -n "\t-r\t${_help_str_8}\n"
    echo -e -n "\t-c\t${_help_str_9}\n"
    echo -e -n "\t-v\t${_help_str_10}\n"
    echo -e -n "\t-h\t${_help_str_11} (-h, --h, -help, --help)\n" # Help
}
function out_info()
{
    echo -e -n "${_help_str_12}\n${_help_str_13}\n"
}
function out_version()
{
    echo "$0 ${versions}"
}
function out_notify()
{
	if [[ "$3" == "" ]]; then
		_timeout=10000
	else
		_timeout="$3"
	fi
	notify-send -u normal --expire-time="${_timeout}" --icon=drive-harddisk "${1}" "${2}"
}
function usb_init()
{
    SETCOLOR_SUCCESS="echo -en \\033[1;32m"
    SETCOLOR_FAILURE="echo -en \\033[1;31m"
    SETCOLOR_ERROR="echo -en \\033[1;33m"
    SETCOLOR_NORMAL="echo -en \\033[0;39m"
    unset usb_name
    for i in /dev/disk/by-path/*usb* ; do
        if [[ $i != *part* ]]; then
            devpoint=$(readlink -f $i | cut -d '/' -f3-9)
            usb_name="${usb_name} $devpoint"
        fi
    done
    name_usb=( $usb_name )
    unset usb_name
    unset full_usb_name
    unset full_usb_dev
    unset menu_usb_power
    unset menu_usb_dev
    for i in ${name_usb[*]}; do
        m_point=$(lsblk -o NAME,MOUNTPOINT | grep -Ei "$i" | grep -Ei "run|media|mnt" | grep -Ei "/" | awk '{print $2,$3,$4,$5}' | sed -r 's/^ *| *$//g' | tr ' ' '_')
        if [[ ${m_point[*]} != "" ]]; then
            usb_size=$(lsblk -o NAME,SIZE | grep -Ei "^$i" | awk '{print $2}' | tr ' ' '_')
            usb_name=$(lsblk -o NAME,MOUNTPOINT | grep -Ei "$i" | grep -Ei "run|media|mnt" | rev | cut -d '/' -f1 | rev | tr ' ' '_')
            usb_info="${usb_size}_${usb_name}"
            dev_usb=$(lsblk -ro  NAME,MOUNTPOINT | grep -Ei "$i" | grep -Ei "run|media|mnt" | awk '{print $1}' | sed -r 's/^ *| *$//g')
            menu_usb_dev="${menu_usb_dev} ${dev_usb[*]} $usb_info"
        else
            usb_size=$(lsblk -o NAME,SIZE | grep -Ei "^$i" | awk '{print $2}' | tr ' ' '_')
            usb_name=$(lsblk -o NAME,MODEL | grep -Ei "^$i" | awk '{print $2}' | awk '!/^$/{print $0}' | tr ' ' '_' | sed 's/^[ \t]*//')
            usb_info="${usb_size}_${usb_name}"
            dev_usb=$(echo "${i}" | tr -td '[:digit:]')
            menu_usb_power="${menu_usb_power} ${dev_usb[*]} $usb_info"
        fi
        _temp=$(lsblk -ro  NAME,MOUNTPOINT | grep -Ei "$i" | grep -Ei "run|media|mnt" | awk '{print $1}' | sed -r 's/^ *| *$//g')
        full_usb_name+=( "${_temp}" )
        unset _temp
        full_usb_dev+=( "${dev_usb[*]}" )
    done
}
function usb_to_umount()
{
    if [[ ${menu_usb_dev} != "" ]]; then
        Xdialog --backtitle "$SYSTEM $VERSION $ARCHI" --title "${1}" --menu "${2}" 0 0 10 ${menu_usb_dev} 2>${ANSWER} 
        variables=$(cat ${ANSWER})
        rm -rf "${ANSWER}"
        clear
        umount /dev/${variables}
        wait
        out_notify "${_mn_usbumount_ttl}" "${_usb_sms_ttl} /dev/${variables} ${_usb_sms_bd}"
    fi
}
function usb_poweroff()
{
    if [[ ${menu_usb_power} != "" ]]; then
        Xdialog --backtitle "$SYSTEM $VERSION $ARCHI" --title "${1}" --menu "${2}" 0 0 10 ${menu_usb_power} 2>${ANSWER} 
        variables=$(cat ${ANSWER})
        clear
        udisksctl power-off -b /dev/${variables}
        wait
        out_notify "${_mn_usbpoweroff_ttl}" "${_usb_sms_ttl} /dev/${variables} ${_poweroff_sms_bd}"
    fi
}
function usb_umountpoweroff()
{
    if [[ ${menu_usb_dev} != "" ]]; then
        Xdialog --backtitle "$SYSTEM $VERSION $ARCHI" --title "${1}" --menu "${2}" 0 0 10 ${menu_usb_dev} 2>${ANSWER} 
        variables=$(cat ${ANSWER})
        rm -rf "${ANSWER}"
        clear
        umount /dev/${variables}
        wait
        udisksctl power-off -b /dev/${variables}
        wait
        out_notify "${_mn_usbumount_ttl}" "${_usb_sms_ttl} /dev/${variables} ${_usb_sms_bd}"
        out_notify "${_mn_usbpoweroff_ttl}" "${_usb_sms_ttl} /dev/${variables} ${_poweroff_sms_bd}"
    else
        wait
        usb_init
        wait
        usb_poweroff
    fi
}
function full_usb_umount()
{
    for i in ${full_usb_name[*]}; do
        umount /dev/${i}
        wait
    done
    wait
    out_notify "${_mn_usbumount_ttl}" "${_usb_sms_full_ttl}"
}
function full_usb_poweroff()
{
    for j in ${full_usb_dev[*]}; do
        udisksctl power-off -b /dev/${j}
        wait
    done
    wait
    out_notify "${_mn_usbpoweroff_ttl}" "${_poweroff_sms_full_bd}"
}
function select_language()
{
    Xdialog --default-item 3 --backtitle "$SYSTEM $VERSION $ARCHI" --title " Select Language " --menu "\nLanguage / sprache / taal / språk / lingua / idioma / nyelv / língua" 0 0 11 \
    "1" $"English       (en)" \
    "2" $"Italian       (it)" \
    "3" $"Russian       (ru)" \
    "4" $"Turkish       (tr)" \
    "5" $"Dutch         (nl)" \
    "6" $"Greek         (el)" \
    "7" $"Danish        (da)" \
    "8" $"Hungarian     (hu)" \
    "9" $"Portuguese    (pt)" \
   "10" $"German        (de)" \
   "11" $"French        (fr)" 2>${ANSWER}
   
    case $(cat "${ANSWER}") in
        "1") sed -i "/_language=/c _language=\"English\"" "${filesdir}/options.conf"
             ;;
        "2") sed -i "/_language=/c _language=\"Italian\"" "${filesdir}/options.conf"
             ;; 
        "3") sed -i "/_language=/c _language=\"Russian\"" "${filesdir}/options.conf"
             ;;
        "4") sed -i "/_language=/c _language=\"Turkish\"" "${filesdir}/options.conf"
             ;;
        "5") sed -i "/_language=/c _language=\"Dutch\"" "${filesdir}/options.conf"
             ;;             
        "6") sed -i "/_language=/c _language=\"Greek\"" "${filesdir}/options.conf"
             ;;
        "7") sed -i "/_language=/c _language=\"Danish\"" "${filesdir}/options.conf"
             ;;   
        "8") sed -i "/_language=/c _language=\"Hungarian\"" "${filesdir}/options.conf"
             ;;
        "9") sed -i "/_language=/c _language=\"Portuguese\"" "${filesdir}/options.conf"
             ;;      
       "10") sed -i "/_language=/c _language=\"German\"" "${filesdir}/options.conf"
             ;;
       "11") sed -i "/_language=/c _language=\"French\"" "${filesdir}/options.conf"
             ;;
          *) exit 0
             ;;
    esac
    rm -rf "${ANSWER}"
}
