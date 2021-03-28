

Commands:
sudo adduser pi ssh
sudo apt-get update
sudo apt-get upgrade
wget -O - https://raw.githubusercontent.com/OpenMediaVault-Plugin-Developers/installScript/master/install​ | sudo bash

Commands:
sudo fdisk -l - Check the disk
sudo mdadm --create --verbose /dev/md0 --level=stripe --raid-devices=2 /dev/sda1 /dev/sdb1 - Create RAID0
sudo mdadm --create --verbose /dev/md0 --level=mirror --raid-devices=2 /dev/sda1 /dev/sdb1 - Create RAID1
cat /proc/mdstat - Information on the RAID
sudo reboot — Reboot Raspberry Pi
sudo shutdown -h now — Power Off Raspberry Pi

