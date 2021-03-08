#!/bin/bash
### Translit Full Menu ###
_sh_dev_title="Выбор устройства"
_sh_dev_body="\nПожалуйста, выберите необходимое устройство\n"
_rsvd_nfo1="Устройство "
_rsvd_nfo2=" размером "
_rsvd_nfo3="Зарезервированное место раздела в процентах:"
_reserved_info_title="Зарезервинное место для суперпользователя"
_rsrvd_menu_title="Настройки файловой системы"
_rsrvd_menu_body="\nНастройка параметров файловой системы. Настройка tmpfs для SSD накопителей\n"
_rsrvd_menu1="Информация о зарезервированном объеме"
_rsrvd_menu2="Установка зарезервированного объема"
_rsrvd_menu3="Информация о папке tmp в FSTAB"
_rsrvd_menu4="Настройка tmpfs"
_yesno_tmpfs_body="\nЖелаете настроить папку tmp для SSD накопителей?\n"
_input_reserved_title="Ввод объема зарезервированного пространства"
_input_reserved_body="\nПожалуйста, введите желаемый объем зарезервированного пространства раздела в процентах от 1 до 10%\n"
_info_tmpfs_title="Информация о tmpfs"
_info_tmpfs_bd1="Данная опция ускорит работу SSD накопителя."
_info_tmpfs_bd2="Монтирование папки tmp в оперативную память."
_info_tmpfs_bd3="Далее укажите желаемый объем папки в пределах от 1 до 10 Гб"
_info_tmpfs_bd4="Но вдвое меньше оперативной памяти."
_info_tmpfs_bd5="Например: 1G"
_info_tmpfs_body="\n$_info_tmpfs_bd1\n$_info_tmpfs_bd2\n$_info_tmpfs_bd3\n$_info_tmpfs_bd4\n$_info_tmpfs_bd5\n"
_input_size_tmpfs_title="Ввод объема папки tmp"
_input_size_tmpfs_body="\nПожалуйста введите желаемый объем. Например: 1G\n"
### Translit Full Menu ###
declare -a _devices							# Array scan mnt mount devices variables declare
declare -a _device_menu						# Array menu form on scan mnt mount devices variables declare
DEVICES=""									# Array devices to clear
_isreserved=""								# Percentage to setup reserved block count on root
_rsrvd_file="./rsrvd.nfo"					# File information to reserved block count
_tmp_fstab="./tmp.fstab"					# File information on tmp folder to FSTAB
_once_shwram=0								# Once form memory information to mem file
select_mountpoint()
{
    devices_list=$(lsblk -l | sed '/SWAP/d' | grep -Ei "$1" | awk 'BEGIN{OFS=" "} {print $1,$4}')
    dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_sh_dev_title" --menu "$_sh_dev_body" 0 0 4 ${devices_list} 2>${ANSWER}
    DEVICES=$(cat ${ANSWER})
}
showmemory()
{
	if [[ $_once_shwram == "0" ]]; then
		rm -rf ${_mem_file}
		_freefile=( $(free -h) )
		IFS=$' '
		show_memory
		_once_shwram=1
	fi
	dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_free_info" --textbox ${_mem_file} 15 100
	clear
}
function reserved_block()
{
	_block_count=$(tune2fs -l $1 | grep -Ei "^(Block count:)" | sed 's/Block count://' | tr -d ' ')
	_reserved_block_count=$(tune2fs -l $1 | grep -Ei "^(Reserved block count:)" | sed 's/Reserved block count://' | tr -d ' ')
	bc=${_block_count[*]}
	unset _block_count
	rbc=${_reserved_block_count[*]}
	unset _reserved_block_count
	_reserv_procent=$(awk 'BEGIN{print ('"$rbc"'*100/'"$bc"')}' | sed 's/\./,/')
	unset bc
	unset rbc
	# round
	_rnd_reserv_procent=$(printf "%.0f" $_reserv_procent)
	unset _reserv_procent
	echo "${_rnd_reserv_procent[*]}"
}
show_block_info()
{
	deviceslist=$(lsblk -l | sed '/SWAP/d' | grep -Ei "${MOUNTPOINT}" | awk '{print $1}')
	echo "" > ${_rsrvd_file}
	for i in ${deviceslist[*]}; do
		devicessize=$(lsblk -l | sed '/SWAP/d' | grep -Ei "$i" | awk '{print $4}')
		_reserved_size=$(reserved_block "/dev/$i")
		echo -e -n "\n$_rsvd_nfo1 $i $_rsvd_nfo2 ${devicessize[*]} \n" >> ${_rsrvd_file}
		echo -e -n "$_rsvd_nfo3 $_reserved_size\n" >> ${_rsrvd_file}
	done
	dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_reserved_info_title" --textbox ${_rsrvd_file} 0 0
	clear
}
input_reserved_percentage()
{
	dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_input_reserved_title" --inputbox "$_input_reserved_body" 0 0 "" 2>${ANSWER}
	qst=$?
	case $qst in
		0) _isreserved=$(cat ${ANSWER})
			;;
	esac
}
fine_rsrvd_menu()
{
	rm -rf ${_rsrvd_file}
	rm -rf ${_mem_file}
	rm -rf ${_tmp_fstab}
	unset IFS
	unset freefile
}
rsrvd_menu()
{
	if [[ $SUB_MENU != "rsrvd_menu" ]]; then
	   SUB_MENU="rsrvd_menu"
	   HIGHLIGHT_SUB=1
	else
	   if [[ $HIGHLIGHT_SUB != 5 ]]; then
	      HIGHLIGHT_SUB=$(( HIGHLIGHT_SUB + 1 ))
	   fi
	fi
	dialog --default-item ${HIGHLIGHT_SUB} --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_rsrvd_menu_title" --menu "$_rsrvd_menu_body" 0 0 5 \
 	"1" "$_rsrvd_menu1" \
	"2" "$_rsrvd_menu2" \
	"3" "$_rsrvd_menu3" \
	"4" "$_rsrvd_menu4" \
	"5" "$_Back" 2>${ANSWER} # $_Back
	
	HIGHLIGHT_SUB=$(cat ${ANSWER})
    case $(cat ${ANSWER}) in
    "1") show_block_info
		clear
         ;;
    "2") clear
		select_mountpoint "${MOUNTPOINT}"
		input_reserved_percentage
		if [[ ${_isreserved[*]} -le 10 ]]; then
			if [[ ${_isreserved[*]} -ge 1 ]]; then
				sudo tune2fs -m ${_isreserved[*]} /dev/$DEVICES 2>/tmp/.errlog
				clear
			else echo "Error size paramter at 1 to 10" > /tmp/.errlog
			fi
		else echo "Error size paramter at 1 to 10" > /tmp/.errlog
		fi
         ;;		
	"3") cat /etc/fstab | grep -i "tmpfs" > ${_tmp_fstab}
		dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_rsrvd_menu3" --textbox ${_tmp_fstab} 0 0
		;;
	"4") clear
		dialog --defaultno --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_rsrvd_menu3" --yesno "$_yesno_tmpfs_body" 0 0
		if [[ $? -eq 0 ]]; then
			dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_info_tmpfs_title" --msgbox "$_info_tmpfs_body" 0 0
			showmemory
			dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_input_size_tmpfs_title" --inputbox "$_input_size_tmpfs_body" 0 0 "" 2>${ANSWER}
			qst=$?
			case $qst in
				0) _size_tmpfs=$(cat ${ANSWER})
					sudo sed -i '/tmpfs/d' ${MOUNTPOINT}/etc/fstab 2>/tmp/.errlog
					echo "tmpfs   /tmp         tmpfs   nodev,nosuid,size=${_size_tmpfs[*]}          0  0" >> ${MOUNTPOINT}/etc/fstab 2>/tmp/.errlog
				;;
			esac
		fi
		clear
		;;
      *) # Back to NAME Menu
		fine_rsrvd_menu
		clear
		main_menu_online
         ;;
    esac
	check_for_error
    rsrvd_menu
}
rsrvd_menu
rm -rf ${ANSWER}
exit 0
