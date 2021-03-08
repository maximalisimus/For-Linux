#!/bin/bash
temp="./new.conf"
_next=0
pc_conf_prcss()
{
    echo "#" > "$2"
    while read line; do
        if [[ $line == "#[multilib]" ]]; then
            _next=1
            echo "[multilib]" >> "$2"
            echo "Include = /etc/pacman.d/mirrorlist" >> "$2"
        else
            if [[ $_next == "1" ]]; then
                _next=0
                continue
            else
                echo "$line" >> "$2"
            fi
        fi
    done < "./$1"
    cp -f "$2" "$1"
}
pc_conf_prcss "./pacman.conf" "$temp"
exit 0
