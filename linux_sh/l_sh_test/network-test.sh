#!/bin/bash
echo "Start ..."
net=( $(ip -o link show | gawk '{print $2}' | tr -d ':') )
mac=( $(ip -o link show | gawk '{print $17}') )
stat=( $(ip -o link show | gawk '{print $9}' | tr -d ':') )
count=0
for letter in "${stat[@]}"; do
	if [ "${net[$count]}" != "lo" ]; then
		if [ "$letter" != "UP" ]; then
		`ip link set ${net[$count]} up`
		`dhcpcd`
		echo "${net[$count]} is UP"
		fi
	fi
let count+=1
done
filedir=$HOME
filename="$filedir/10-network.rules"
if [ -e $filedir ]; then
	echo "DIR is $filedir"
	if [ -e $filename ]; then
	echo "FileName is $filename"
	else
	`touch $filename`
	echo "New filename is $filename"
	fi
else
`mkdir $filedir`
echo "New dir is $fiedir"
`touch $filename`
echo "New filename $filename"
fi
count=0
if [ -s $filename ]; then
echo "10-network.rules to have is MAC-Address"
else
	for macer in "${mac[@]}"; do
		echo "SYBSYSTEM==\"net\", ACTION==\"add\", ATTR{address}==\"$macer\", NAME=\"net$count\"" >> $filename
		echo "Add is MAC-Address $macer"
		let count+=1
	done
fi
echo "Done ..."
