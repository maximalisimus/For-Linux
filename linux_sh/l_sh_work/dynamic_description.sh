#!/bin/bash
#
_us_gr_presystemd=(audio disk optical scanner storage video)
_ugd_audio="audio-description"
_ugd_disk="disk-description"
_ugd_optical="optical-description"
_ugd_scanner="scanner-description"
_ugd_storage="storage-description"
_ugd_video="video-description"
_desc=""
variables=""
counter=0
for i in ${_us_gr_presystemd[*]}; do
    _desc="${_desc} _ugd_$i"
done
for i in ${_desc[*]}; do
    variables="${variables} ${_us_gr_presystemd[$counter]} ${!i}"
    let counter+=1
done
ANSWER="./.asf"
dialog --backtitle "VERSION - SYSTEM (ARCHI)" --title "_dynamic_title" --menu "_dynamic_Body" 0 0 16 ${variables} 2>${ANSWER}
_ch_var=$(cat ${ANSWER})
clear
echo ""
param="_ugd_${_ch_var[*]}"
echo "${_ch_var[*]} - ${!param}"
rm -rf $ANSWER
exit 0
