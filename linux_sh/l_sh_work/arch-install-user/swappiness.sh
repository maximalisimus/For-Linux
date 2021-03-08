#!/bin/sh
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
echo -e "\e[1;30mStart $0\n\e[0m"
# trap "echo -e '\e[1;31mScript $0 is stoped \e[1;34m(Ctrl+C)\e[0m'" SIGINT
# trap "echo -e '\e[1;35mScript $0 is cenceled \e[1;32m(Ctrl+Z)\e[0m'" SIGTSTP
scr_filename=""
scr_filedir=""
sysctlconf=""
real_sysctlconf=""
declare -a freefile
freefile=""
r_sw=""
setswappiness()
{
	codes=""
	xcode=""
	cat /sys/fs/cgroup/memory/memory.swappiness 2> /dev/null 1> /dev/null
	codes=$?
	if [[ $codes == "0" ]]; then
		real_swappiness=( $(cat /sys/fs/cgroup/memory/memory.swappiness) )
		r_sw=$((100-$real_swappiness))
	elif [[ $codes != "0" ]]; then
		cat /proc/sys/vm/swappiness 2> /dev/null 1> /dev/null
		xcode=$?
		if [[ $xcode == "0" ]]; then
			real_swappiness=( $(cat /proc/sys/vm/swappiness) )
			r_sw=$((100-$real_swappiness))
		elif [[ $xcode != "0" ]]; then
			r_sw="40"
		fi
	fi
	unset codes
	unset xcode
}
unsetswappiness()
{
	unset real_swappiness
	unset r_sw
}
startes()
{
	scr_filename=`readlink -e "$0"`
	scr_filedir=`dirname "$scr_filename"`
	sysctlconf="$scr_filedir/arch_custom-config/swappiness.conf"
	freefile=( $(free -h) )
	IFS=$' '
	setswappiness
}
finishes()
{
	unset freefile
	unset IFS
	unsetswappiness
	unset sw
	unset sw_user
	unset scr_filename
	unset scr_filedir
	unset sysctlconf
}
startes
count=0
for letter in "${freefile[@]}"; do
	if [ "$count" -le 5 ]; then
		echo -e -n "\e[1;33m\t$letter\e[0m"
	elif [ "$count" -eq 6 ]; then
		echo -e -n "\e[1;32m\n$letter\e[0m"
	elif [ "$count" -eq 10 ]; then
		echo -e -n "\e[1;32m\t  $letter\e[0m"
	elif [ "$count" -eq 11 ]; then
		echo -e -n "\e[1;32m\t     $letter\e[0m"
	elif [ "$count" -eq 12 ]; then
		echo -e -n "\e[1;32m\t    $letter\e[0m"
	elif [ "$count" -le 12 ]; then
		echo -e -n "\e[1;32m\t$letter\e[0m"
	elif [ "$count" -eq 13 ]; then
		echo -e -n "\e[1;30m\t\n$letter\e[0m"
	elif [ "$count" -le 19 ]; then
		echo -e -n "\e[1;30m\t$letter\e[0m"
	fi
	let count+=1
done
echo ""
echo -e "The size of the \e[1;34mRAM \e[1;37mfill (for swappiness) is: \e[1;33m$r_sw\e[0m"
echo -e "Please enter the size of the \e[1;34mRAM \e[1;37mfill (for swappiness) or none to default conf:\e[0m"
read sw_user
if [ -n "$sw_user" ]; then
	if [[ $sw_user =~ ^([0-9]{1,2})$ ]]; then
		sw=$((100-$sw_user))
		sysctl vm.swappiness=$sw
		unsetswappiness
		setswappiness
		echo "vm.swappiness=10" > $sysctlconf
		echo -e "\e[1;34mSwappiness \e[1;37msize is set: \e[1;33m$sw\e[0m"
	else 
		clear
		echo -e "\e[1;31mUnknow argument for option!\e[0m"
		echo ""
		echo -e "Please reenter the size of the \e[1;34mRAM \e[1;37mfill (for swappiness) or none to default conf:\e[0m"
		read sw_user
		sw=$((100-$sw_user))
		sysctl vm.swappiness=$sw
		unsetswappiness
		setswappiness
		echo "vm.swappiness=10" > $sysctlconf
		echo -e "\e[1;34mSwappiness \e[1;37msize is set: \e[1;33m$sw\e[0m"
	fi
elif [ -z "$sw_user" ]; then
	sw=10
	sysctl vm.swappiness=$sw
	unsetswappiness
	setswappiness
	echo "vm.swappiness=10" > $sysctlconf
	echo -e "\e[1;34mSwappiness \e[1;37msize is set of the default: \e[1;33m$sw\e[0m"
fi
finishes
echo -e "\e[1;30m\n\nDone $0\e[0m"
read -p "Press any key to condinue ..."
if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi
echo -n "${reset}"
# trap - SIGINT
# trap - SIGTSTP
exit 0
