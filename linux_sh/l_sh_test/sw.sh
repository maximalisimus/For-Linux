#!/bin/sh
echo -e "\e[1;30mStart $0\n\e[0m"
declare -a freefile
freefile=""
startes()
{
	freefile=( $(free -h) )
	IFS=$' '
}
finishes()
{
	unset freefile
}
startes
# echo -e "\e[1;31m${headers[@]}\e[0m"
# echo -e "\e[1;32m${mems[@]}\e[0m"
# echo -e "\e[1;34m${swaps[@]}\e[0m"
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
finishes
echo -e "\e[1;30m\n\nDone $0\e[0m"
exit 0
