#!/bin/bash
nvsearch=($(pacman -Ss | grep -E 'nvidia-[0-9]{3}' | grep extra | sed 's/extra\///' | awk '{print $1}'))
# old_lngth=${#nvsearch[0]}
lngth=0
counter=0
nvidia_name=${nvsearch[0]}
for letter in ${nvsearch[*]}
do
	# echo "$letter"
	# echo "${#nvsearch[$counter]}"
	lngth=${#nvsearch[$counter]}
	#echo "$lngth"
	# if [[ $old_lngth -gt $lngth ]]; then
	if [[ $lngth -eq 12 ]]; then
		# old_lngth=$lngth
		nvidia_name=$letter
		# echo "$old_lngth"
		# echo "namepkg"
	fi
	counter=$(($counter+1))
done
echo "$namepkg"
unset nvsearch
unset old_lngth
unset lngth
unset counter
unset namepkg
exit 0
