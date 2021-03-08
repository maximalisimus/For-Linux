#!/bin/bash
upower -e | grep -vi "line_power" | grep -vi "displaydevice" >> ./pwr.nfo
pwr_info=$(cat ./pwr.nfo)
echo "" > ./pwr.nfo
for i in ${pwr_info[*]}; do
    upower -i $i >> ./pwr.nfo
done
VERSION=$(uname -r)
SYSTEM=$(uname -s)
ARCHI=$(uname -m)
_DevShowTitle=""
dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$_DevShowTitle" --textbox ./pwr.nfo 0 0
rm -rf ./pwr.nfo
clear
exit 0
