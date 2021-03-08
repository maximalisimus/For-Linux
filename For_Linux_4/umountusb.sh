#!/bin/bash
for usb_dev in /dev/disk/by-id/usb-*; do
    dev=$(readlink -f $usb_dev)
    grep -q ^$dev /proc/mounts && umount $dev 2>>/dev/null
done
exit 0
