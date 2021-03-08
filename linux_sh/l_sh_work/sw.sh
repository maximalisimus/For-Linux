#!/bin/sh
echo -e "\e[1;30mStart $0\e[0m"
declare -a headers
declare -a mems
declare -a swaps
headers=""
mems=""
swaps=""
startes()
{
	headers=( $(cat free.txt | grep -v "Mem" | grep -v "Swap") )
	mems=( $(cat free.txt | grep Mem) )
	swaps=( $(cat free.txt | grep Swap) )
}
finishes()
{
	unset headers
	unset mems
	unset swaps
}
startes
echo -e "\e[1;31m${headers[*]}\e[0m"
echo -e "\e[1;32m${mems[*]}\e[0m"
echo -e "\e[1;34m${swaps[*]}\e[0m"
finishes
echo -e "\e[1;30mDone $0\e[0m"
exit 0
