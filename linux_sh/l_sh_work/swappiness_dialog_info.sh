#!/bin/bash
_freefile=""
_swappiness=""
_mem_file="/tmp/mem.conf"
_mem_msg_file="/tmp/msginfo.nfo"
_File_of_Config="/tmp/00-sysctl.conf"
_real_dir_swpns="${MOUNTPOINT}/etc/sysctl.d/"
_real_swappiness="${MOUNTPOINT}/etc/sysctl.d/00-sysctl.conf"
VERSION=$(uname -r)
SYSTEM=$(uname -s)
ARCHI=$(uname -m)
# Swap - swappiness
_swap_menu_title="Настройка 'swappiness'"
_swap_menu_body="\nНастройка частоты использования пространства подкачки.\n"
_sw_menu_info="Просмотр оперативной памяти"
_sw_menu_temp_swpns="Установить swappiness временно"
_sw_menu_swpns="Установить swappiness постоянно"
_free_info="Просмотр оперативной памяти компьютера"
_msg_swps_title="Частота использования раздела подкачки"
_swap_frequency_info="Частота использования файла подкачки 'swap'"
_sw_nfo1="Swappiness sysctl параметр представляющий частоту\n использования пространства подкачки."
_sw_nfo2="Swappiness может иметь значение от 0 до 100."
_sw_nfo3="Значение по умолчанию = 60."
_sw_nfo4="Это значит, что при достижении расхода RAM в 40%,\n ядро Linux активирует применение swap."
_sw_nfo5="При значении swappiness = 10 -\n расход RAM будет достигать 90%."
_sw_nfo6="А при swappiness = 90 -\n расход RAM будет не более 10%."
_sw_nfo7="Низкое значение заставляет ядро избегать подкачки,\n высокое значение позволяет ядру использовать подкачку наперёд."
_sw_nfo8="Использование низкого значения на достаточном количестве памяти,\n улучшает отзывчивость на многих системах."
setswappiness()
{
	codes=""
	xcode=""
	cat /sys/fs/cgroup/memory/memory.swappiness 2> /dev/null 1> /dev/null
	codes=$?
	if [[ $codes == "0" ]]; then
		_swappiness=( $(cat /sys/fs/cgroup/memory/memory.swappiness) )
	elif [[ $codes != "0" ]]; then
		cat /proc/sys/vm/swappiness 2> /dev/null 1> /dev/null
		xcode=$?
		if [[ $xcode == "0" ]]; then
			_swappiness=( $(cat /proc/sys/vm/swappiness) )
		elif [[ $xcode != "0" ]]; then
			_swappiness="40"
		fi
	fi
	unset codes
	unset xcode
}
show_memory()
{
	echo -e -n "\n" > $_mem_file
	count=0
	for letter in "${_freefile[@]}"; do
		if [ "$count" -le 5 ]; then
			echo -e -n "\t$letter" >> $_mem_file
		elif [ "$count" -eq 6 ]; then
			echo -e -n "\n$letter" >> $_mem_file
		elif [ "$count" -eq 10 ]; then
			echo -e -n "\t  $letter" >> $_mem_file
		elif [ "$count" -eq 11 ]; then
			echo -e -n "\t     $letter" >> $_mem_file
		elif [ "$count" -eq 12 ]; then
			echo -e -n "\t    $letter" >> $_mem_file
		elif [ "$count" -le 12 ]; then
			echo -e -n "\t$letter" >> $_mem_file
		elif [ "$count" -eq 13 ]; then
			echo -e -n "\t\n$letter" >> $_mem_file
		elif [ "$count" -le 19 ]; then
			echo -e -n "\t$letter" >> $_mem_file
		fi
		let count+=1
	done
}
swappiness_info()
{
	echo -e -n "\n$_sw_nfo1\n" > $_mem_msg_file
	echo -e -n "$_sw_nfo2\n" >> $_mem_msg_file
	echo -e -n "$_sw_nfo3\n" >> $_mem_msg_file
	echo -e -n "$_sw_nfo4\n" >> $_mem_msg_file
	echo -e -n "$_sw_nfo5\n" >> $_mem_msg_file
	echo -e -n "$_sw_nfo6\n" >> $_mem_msg_file
	echo -e -n "\n$_sw_nfo7\n" >> $_mem_msg_file
	echo -e -n "\n$_sw_nfo8\n" >> $_mem_msg_file
}
show_mem()
{
	_freefile=( $(free -h) )
	IFS=$' '
	show_memory
	setswappiness
	echo -e -n "\n\n$_swap_frequency_info\n" >> $_mem_file
	echo -e -n "swappiness: $_swappiness\n" >> $_mem_file
	swappiness_info
	dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_msg_swps_title" --textbox $_mem_msg_file 0 0
	dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_free_info" --textbox $_mem_file 15 100
}
free_mem()
{
	rm -rf $_mem_file
	rm -rf $_mem_msg_file
	rm -rf $_File_of_Config
	unset freefile
	unset IFS
}
set_temp_swpns()
{
	dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_input_swappiness_title" --inputbox "$_input_swappiness_body" 0 0 "" 2>${ANSWER}

	qst=$?
	case $qst in
		0) _swappiness=$(cat ${ANSWER})
			sysctl vm.swappiness=$_swappiness
			;;
	esac
}
set_swpns()
{
	dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_input_swappiness_title" --inputbox "$_input_swappiness_body" 0 0 "" 2>${ANSWER}

	qst=$?
	case $qst in
		0) _swappiness=$(cat ${ANSWER})
			echo "vm.swappiness=$_swappiness" > $_File_of_Config
			[ -f $_real_dir_swpns ] || mkdir $_real_dir_swpns
			cp -f $_File_of_Config $_real_swappiness
			;;
	esac
}
swap_menu() {
	
   dialog --backtitle "VERSION - SYSTEM (ARCHI)" --title "$_swap_menu_title" \
    --menu "$_swap_menu_body" 0 0 4 \
 	"1" "$_sw_menu_info" \
	"2" "$_sw_menu_temp_swpns" \
	"3" "$_sw_menu_swpns" \
	"4" "$_Back"	2>${ANSWER}	
	variable=($(cat ${ANSWER}))
    case $variable in
        "1") show_mem
             ;;
        "2") set_temp_swpns
             ;;
		"3") set_swpns
			;;
        "4") free_mem
			exit 0
             ;;
     esac	
     
    swap_menu
}
swap_menu
clear
exit 0
