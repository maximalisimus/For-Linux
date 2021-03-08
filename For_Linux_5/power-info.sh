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
Title="Информация о найденых батареях компьютера"
dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "$Title" --textbox ./pwr.nfo 0 0
rm -rf ./pwr.nfo
clear
exit 0
