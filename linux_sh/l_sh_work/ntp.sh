#!/bin/bash
_zones=(africa antarctica asia europe north-america oceania south-america)
URL="https://www.ntppool.org/zone/${_zones[3]}"
_ntp_files="./ntp.txt"
# curl -s "${URL}" | sed -e 's/<[^>]*>//g' | awk '!/^$/{print $0}' | sed 's/^[ \t]*//' | grep -Ei " [a-z]{2}.pool.ntp.org" | grep -Ei "\([0-9]{1,4}\)" | grep -Evi "\+|\!|-|\([a-z]" | sed -E 's/ \&#[0-9]{1,4};//g' | sed -E 's/ \([0-9]{1,4}\)//g' | tr ' ' '_' >> $_ntp_files
curl -s "${URL}" | sed -e 's/<[^>]*>//g' | awk '!/^$/{print $0}' | sed 's/^[ \t]*//' | grep -Ei " [a-z]{2}.pool.ntp.org" | grep -Evi "\+|\!|-|\([a-z]" | sed -E 's/ \&#[0-9]{1,4};//g' | sed -E 's/ \([0-9]{1,4}\)//g' | tr ' ' '_' >> $_ntp_files
exit 0

