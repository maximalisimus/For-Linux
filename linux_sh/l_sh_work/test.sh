#!/bin/sh
read -p "Please, enter the ip address: " myip
if [[ "$myip" =~ ^([0-9]{1,3}[\.]){3}[0-9]{1,3} ]]; then
	echo "It's Ok!"
else echo "Error!"
fi
exit 0
