#!/bin/bash
pleasewait=1
x=0
for x in {1..20}; do
	if [[ $pleasewait -le 5 ]]; then
		echo -n  -e "\e[1;31mPlease wait: $x ...\e[0m"\\r
		sleep 1
		pleasewait=$(($pleasewait+1))
	elif [[ $pleasewait -eq 10 ]]; then
		echo -n  -e "\e[1;31mPlease wait: $x ...\e[0m"\\r
		sleep 1
		pleasewait=$((1))
	elif [[ $pleasewait -gt 5 ]]; then
		echo -n  -e "\e[1;34mPlease wait: $x ...\e[0m"\\r
		sleep 1
		pleasewait=$(($pleasewait+1))
	fi
done
exit 0
