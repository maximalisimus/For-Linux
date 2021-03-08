#!/bin/bash
pacman -Si git | grep "Description" | sed "s/Description//" | tr -d ':' | tr -d "\n" | sed -e "s/      //" | grep -E -o ".{0,50}" | sed "2d"
exit 0
