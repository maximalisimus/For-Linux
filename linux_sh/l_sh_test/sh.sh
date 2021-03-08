#!/bin/bash
echo "Start ..."
ABSOLUTE_FILENAME=`readlink -e "$0"`
filedir=`dirname "$ABSOLUTE_FILENAME"`
filename="$filedir/10-network.rules"
declare -a mac
setmac()
{
mac=( $(ip -o link show | gawk '{print $17}') )
}
settemplate()
{
sttm=`grep -i -w $1 $2 | wc -l`
echo $sttm
}
outm=""
outtemplate()
{
outm=`grep -i -w $1 $2`
}
setmac
count=0
subcount=0
for letter in "${mac[@]}"; do
	subcount=$( settemplate $letter $filename )
	if [ "$subcount" != 1 ]; then
		echo "$filename is null to MAC: $letter"
	fi
	if [ "$subcount" == 1 ]; then
		outtemplate $letter $filename
		echo $outm
	fi
done
echo "Done ..."
exit 0
