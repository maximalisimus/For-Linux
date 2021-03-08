#!/bin/bash
_booth=$(cat ./pkg-booth.txt)
_list=$(cat ./pkg-list.txt)
touch ./pkg-list-x86-64.txt
_bool=0
for i in ${_list[*]}; do
	_bool=0
	for j in ${_booth[*]}; do
		if [[ $i == $j ]]; then
			_bool=1
			break
		else
			_bool=0
		fi
	done
	if [[ $_bool == "0" ]]; then
		echo "$i" >> ./pkg-list-x86-64.txt
	fi
done
echo "pkg-list.txt count line:"
cat ./pkg-list.txt | wc -l
echo "pkg-list-x86-64.txt count lines:"
cat ./pkg-list-x86-64.txt | wc -l
exit 0
