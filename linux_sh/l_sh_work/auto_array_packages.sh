#!/bin/bash
ABS_FILENAME=`readlink -e "$0"`
filedir=`dirname "$ABS_FILENAME"`
declare -a pkg_add
pkg_add=""
# declare -a pkg_once
pkg_once=""
# declare -a pkg_eml
# pkg_eml=""
pkg_menu=""
find_pkg()
{
	pkg_add=$(ls $1 | grep -vi "windows" | grep -vi "emulators" | rev | cut -d '-' -f4-11 | rev)
	for i in ${pkg_add[*]}; do
		pkg_once+=(0)
		pkg_menu="${pkg_menu} $i - off"
	done
}
#find_eml_pkg()
#{
#	pkg_eml=$(ls $1 | rev | cut -d '-' -f4-11 | rev)
#}
find_pkg "${filedir}/packages"
# find_eml_pkg "${filedir}/packages/emulators"
ANSWER="./.asf"
sleep 3
dialog --backtitle "VERSION - SYSTEM (ARCHI)" --title "Title" --checklist "Body" 0 0 16 ${pkg_menu} 2>${ANSWER}
clear
# echo ""
temp=$(cat ${ANSWER})
count=0
for i in ${temp[*]}; do
	ls ${filedir}/packages/ | grep -i "$i"
	count=0
	for j in ${pkg_add[*]}; do
		if [[ $j == $i ]]; then
			pkg_once[$count]=1
			break
		fi
		let count+=1
	done
done
sleep 3
clear
dialog --backtitle "VERSION - SYSTEM (ARCHI)" --title "Title" --checklist "Body" 0 0 16 ${pkg_menu} 2>${ANSWER}
temp=$(cat ${ANSWER})
clear
for i in ${temp[*]}; do
	count=0
	for j in ${pkg_add[*]}; do
		if [[ $j == $i ]]; then
			if [[ ${pkg_once[$count]} == 0 ]]; then
				ls ${filedir}/packages | grep -i "$i"
				pkg_once[$count]=1
				break
			else
				echo "Sory, package to installed: $i"
				break
			fi
		fi
		let count+=1
	done
done
unset pkg_add
# unset pkg_eml
rm -rf $ANSWER
exit 0
