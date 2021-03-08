#!/bin/bash
# trap "echo -e '\e[1;31mScript $0 is stoped \e[1;34m(Ctrl+C)\e[0m'" SIGINT
# trap "echo -e '\e[1;35mScript $0 is cenceled \e[1;32m(Ctrl+Z)\e[0m'" SIGTSTP
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
echo -e "\e[1;30mStart $0\n\e[0m"
declare -a net
declare -a mac
declare -a stat
ABSOLUTE_FILENAME=""
filedir=""
filename=""
realfile=""
outm=""
setmac()
{
	mac=( $(ip -o link show | gawk '{print $17}') )
}
setnet()
{
	net=( $(ip -o link show | gawk '{print $2}' | tr -d ':') )
}
setstat()
{
	stat=( $(ip -o link show | gawk '{print $9}' | tr -d ':') )
}
starter()
{
	setnet
	setmac
	setstat
	ABSOLUTE_FILENAME=`readlink -e "$0"`
	filedir=`dirname "$ABSOLUTE_FILENAME"`
	filename="$filedir/arch_custom-config/10-network.rules"
	realfile="/etc/udev/rules.d/10-network.rules"
}
settemplate()
{
	sttm=`grep -i -w $1 $2 | wc -l`
	echo $sttm
}
outtemplate()
{
	outm=`grep -i -w $1 $2`
}
outtemplatetofile()
{
	if [[ "$1" =~ ^["lo"] ]]; then
		echo "SYBSYSTEM==\"net\", ACTION==\"add\", ATTR{address}==\"$2\", NAME=\"lo$lcount\"" >> $filename
		echo -e "Add is MAC-Address \e[1;33m$2\e[0m"
		let lcount+=1
	elif [[ "$1" =~ ^[e] ]]; then
		echo "SYBSYSTEM==\"net\", ACTION==\"add\", ATTR{address}==\"$2\", NAME=\"enet$ecount\"" >> $filename
		echo -e "Add is MAC-Address \e[1;33m$2\e[0m"
		let ecount+=1
	elif [[ "$1" =~ ^[w] ]]; then
		echo "SYBSYSTEM==\"net\", ACTION==\"add\", ATTR{address}==\"$2\", NAME=\"wnet$wcount\"" >> $filename
		echo -e "Add is MAC-Address \e[1;33m$2\e[0m"
		let wcount+=1
	fi
}
finisher()
{
	unset net
	unset mac
	unset stat
	unset ABSOLUTE_FILENAME
	unset filedir
	unset filename
	unset realfile
	unset outm
}
starter
count=0
for letter in "${stat[@]}"; do
	if [ "${net[$count]}" != "lo" ]; then
		if [ "$letter" != "UP" ]; then
		`ip link set ${net[$count]} up`
		echo -e "${net[$count]} is \e[1;31mUP\e[0m"
		fi
	fi
let count+=1
done
lcount=0
ecount=0
wcount=0
count=0
subcount=0
if [ -e $filename ]; then
	echo -e "FileName is \e[1;33m$filename\e[0m"
else
	`touch $filename`
	echo -e "\e[1;32mNew filename \e[1;37mis \e[1;33m$filename\e[0m"
fi
for letter in "${mac[@]}"; do
	subcount=$( settemplate $letter $filename )
	if [ "$subcount" != 1 ]; then
		outtemplatetofile "${net[$count]}" "$letter"
	elif [ "$subcount" == 1 ]; then
		outtemplate "$letter" "$filename"
		echo -e "\e[1;36m\n$outm\e[0m"
	fi
	let count+=1
done
cp -f $filename $realfile
finisher
echo -e "\e[1;30m\n\nDone $0\e[0m"
read -p "Press any key to continue ..."
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
