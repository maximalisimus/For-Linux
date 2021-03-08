#!/bin/bash
ANSWER="./.asf"
_lng_file="${filesdir}/lang/${_language}.lng"
versions="1.1"
SYSTEM=$(uname -s)
VERSION=$(uname -r)
ARCHI=$(uname -m)
usb_name=""							# USB name
usb_size=""							# USB size
usb_info=""							# Full info USB devices
dev_usb=""							# /dev/sdX
menu_usb_dev=""						# Menu USB devices
menu_usb_power=""					# Menu powroff USB
declare -a full_usb_name			# Full devices /dev/sdXX
declare -a full_usb_dev				# Full USB devices /dev/sdX
