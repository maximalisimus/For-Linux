#!/bin/bash
ABSOLUT_FILENAME=$(readlink -e "$0")
filesdir=$(dirname "$ABSOLUT_FILENAME")
_sh_files=$(find "$filesdir/modules/" -maxdepth 1 -type f -iname "*.sh" | xargs)
_files=( $_sh_files )
unset _sh_files
source "${filesdir}/options.conf"
for i in ${_files[*]}; do
	source $i
done
source "${_lng_file}"
unset _files
wait
usb_init
while [ -n "$1" ]; do
	case "$1" in
		-u) usb_to_umount "$_mn_usbumount_ttl" "$_mn_usbumount_bd"
			;;
		-p) usb_poweroff "$_mn_usbpoweroff_ttl" "$_mn_usbpoweroff_bd"
			;;
		-o) usb_umountpoweroff "$_mn_usbumount_ttl" "$_mn_usbumount_bd"
			;;
		-f) full_usb_umount
			;;
		-d) full_usb_poweroff
			;;
		-r) full_usb_umount 
			wait
			full_usb_poweroff
			wait
			;;
		-c) select_language
			;;
		-v) out_version
			;;
		-[h?] | --help) _help;;
		*) $SETCOLOR_ERROR
			echo -e -n "\nUnkonwn parameter(s)\n"
			$SETCOLOR_NORMAL
			_help
			;;
	esac
	shift
done
rm -rf "${ANSWER}"
exit 0
