#!/bin/bash
ABSOLUT_FILENAME=$(readlink -e "$0")
filesdir=$(dirname "$ABSOLUT_FILENAME")
scp -P 8022 "$filesdir"/tips.txt u0_a387@192.168.0.100:/data/data/com.termux/files/home/downloads/
ssh -p 8022 u0_a387@192.168.0.100 "./sshtips.sh $1"
scp -P 8022 u0_a387@192.168.0.100:/data/data/com.termux/files/home/downloads/vk.png "$filesdir"/
ssh -p 8022 u0_a387@192.168.0.100 "rm -rf ./downloads/vk.png; rm -rf ./downloads/tips.txt"
exit 0
