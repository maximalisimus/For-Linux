#!/bin/bash
echo "Start ..."
declare -a net
declare -a mac
declare -a stat
ABSOLUTE_FILENAME=""
filedir=""
filename=""
realfile=""
customconfig=""
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
startim()
{
	setnet
	setmac
	setstat
	ABSOLUTE_FILENAME=`readlink -e "$0"`
	filedir=`dirname "$ABSOLUTE_FILENAME"`
	filename="$filedir/10-network.rules"
	realfile="/etc/udev/rules.d/10-network.rules"
	customconfig="$filedir/arch_custom-config/10-network.rules"
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
		echo "Add is MAC-Address $2"
		let lcount+=1
	elif [[ "$1" =~ ^[e] ]]; then
		echo "SYBSYSTEM==\"net\", ACTION==\"add\", ATTR{address}==\"$2\", NAME=\"enet$ecount\"" >> $filename
		echo "Add is MAC-Address $2"
		let ecount+=1
	elif [[ "$1" =~ ^[w] ]]; then
		echo "SYBSYSTEM==\"net\", ACTION==\"add\", ATTR{address}==\"$2\", NAME=\"wnet$wcount\"" >> $filename
		echo "Add is MAC-Address $2"
		let wcount+=1
	fi
}
finishim()
{
	unset net
	unset mac
	unset stat
	unset ABSOLUTE_FILENAME
	unset filedir
	unset filename
	unset realfile
	unset customconfig
	unset outm
}
startim
count=0
for letter in "${stat[@]}"; do
	if [ "${net[$count]}" != "lo" ]; then
		if [ "$letter" != "UP" ]; then
		`ip link set ${net[$count]} up`
		echo "${net[$count]} is UP"
		fi
	fi
let count+=1
done
`dhcpcd`
lcount=0
ecount=0
wcount=0
count=0
subcount=0
if [ -e $filename ]; then
	echo "FileName is $filename"
else
	`touch $filename`
	echo "New filename is $filename"
fi
for letter in "${mac[@]}"; do
	subcount=$( settemplate $letter $filename )
	if [ "$subcount" != 1 ]; then
		outtemplatetofile "${net[$count]}" "$letter"
	fi
	if [ "$subcount" == 1 ]; then
		outtemplate "$letter" "$filename"
		echo "$outm"
	fi
	let count+=1
done
`cp -f $filename $customconfig`
`cp -f $filename $realfile`
finishim
echo "Done ..."
exit 0
