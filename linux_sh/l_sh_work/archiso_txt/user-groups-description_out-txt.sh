#!/bin/bash
_us_gr_users=(adm ftp games http log rfkill sys systemd-journal users uucp wheel)
_us_gr_system=(dbus kmem locate lp mail nobody proc smmsp tty utmp)
_us_gr_presystemd=(audio disk floppy input kvm optical scanner storage video)
echo "#" >> ./ugd.txt
echo "# User groups" >> ./ugd.txt
echo "_ug_select_ttl=\"\"" >> ./ugd.txt
echo "ug_select_bd=\"\n\n\"" >> ./ugd.txt
echo "#" >> ./ugd.txt
echo "# User Groups for user" >> ./ugd.txt
echo "#" >> ./ugd.txt
for i in ${_us_gr_users[*]}; do
    echo "_ugd_$i=\"\"" >> ./ugd.txt
done
echo "#" >> ./ugd.txt
echo "# User Groups for system" >> ./ugd.txt
echo "#" >> ./ugd.txt
for i in ${_us_gr_system[*]}; do
    echo "_ugd_$i=\"\"" >> ./ugd.txt
done
echo "#" >> ./ugd.txt
echo "# User Groups for Pre-Systemd" >> ./ugd.txt
echo "#" >> ./ugd.txt
for i in ${_us_gr_presystemd[*]}; do
    echo "_ugd_$i=\"\"" >> ./ugd.txt
done
exit 0
