#!/bin/sh
tmplt()
{
	case "$1" in
		1) if [[ $2 =~ ^([0-9]{1,3}[\.]){3}[0-9]{1,3}[\/][0-9]{1,2} ]]; then
			# ^([0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9][\/][0-9][0-9])
				echo "1"
			else
				echo "0"
			fi;;
		2) if [[ $2 =~ ^([0-9]{1,3}[\.]){3}[0-9]{1,3} ]]; then
			# ^([0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9])
				echo "1"
			else
				echo "0"
			fi;;
	esac
}
echo -e "\e[1;30mPlease enter the \e[1;37mhostname \e[1;30mnetwork\e[0m"
netname=""
read netname
echo -e "\n\e[1;30mPlease enter your network \e[1;37mip \e[1;30maddress and \e[1;37mnet mask.\e[0m"
echo -e "\e[1;30mTemplate address: \e[1;37m192.168.000.001/24\e[0m"
the_ip=""
read the_ip
thecount="0"
while [ "$thecount" == "0" ]; do
	thecount=$( tmplt "1" $the_ip)
	if [ "$thecount" == "0" ]; then
		echo -e "\e[1;31mThe entered ip address does not match the pattern: \e[1;37m***.***.***.***/**\e[0m"
		echo -e "\e[1;30mPlease enter your network \e[1;37mip \e[1;30maddress and \e[1;37mnet mask.\e[0m"
		echo -e "\e[1;30mTemplate address: \e[1;37m192.168.0.1/24\e[0m"
		thecount="0"
		read the_ip
	elif [ "$thecount" == "1" ]; then
		echo -e "\e[1;30mThe IP address of the network: \e[1;37m$the_ip\e[0m"
		thecount="1"
		break
	fi
done
echo -e "\n\e[1;30mPlease enter the \e[1;37mdefault gateway \e[1;30maddress of the network\e[0m"
echo -e "\e[1;30mTemplate address: \e[1;37m192.168.1.1\e[0m"
echo -e "\e[1;30m(Please enter if not gateway address)\e[0m"
the_gtw=""
read the_gtw
if [ -n "$the_gtw" ]; then
	thecount="0"
	while [ "$thecount" == "0" ]; do
		thecount=$( tmplt "2" $the_gtw)
		if [ "$thecount" == "0" ]; then
			echo -e "\e[1;31mThe entered default gateway address does not match the pattern: \e[1;37m***.***.***.***\e[0m"
			echo -e "\e[1;30mPlease enter the \e[1;37mdefault gateway \e[1;30maddress of the network\e[0m"
			echo -e "\e[1;30mTemplate address: \e[1;37m192.168.1.1\e[0m"
			thecount="0"
			read the_gtw
		elif [ "$thecount" == "1" ]; then
			echo -e "\e[1;30mThe default gateway address of the network: \e[1;37m$the_gtw\e[0m"
			thecount="1"
			break
		fi
	done
elif [ -z "$the_gtw" ]; then
	echo ""
fi
echo -e "\n\e[1;30mPlease enter the \e[1;37mbroadcast \e[1;30maddress of the network\e[0m"
echo -e "\e[1;30mTemplate address: \e[1;37m192.168.001.255\e[0m"
the_brdc=""
read the_brdc
thecount="0"
while [ "$thecount" == "0" ]; do
	thecount=$( tmplt "2" $the_brdc)
	if [ "$thecount" == "0" ]; then
		echo -e "\e[1;31mThe entered broadcast address does not match the pattern: \e[1;37m***.***.***.***\e[0m"
		echo -e "\e[1;30mPlease enter the \e[1;37mbroadcast \e[1;30maddress of the network\e[0m"
		echo -e "\e[1;30mTemplate address: \e[1;37m192.168.001.255\e[0m"
		thecount="0"
		read the_brdc
	elif [ "$thecount" == "1" ]; then
		echo -e "\e[1;30mThe broadcast address of the network: \e[1;37m$the_brdc\e[0m"
		thecount="1"
		break
	fi
done
sudo hostnamectl set-hostname $netname
# ip addr add IP-адрес/маска_подсети broadcast широковещательный_адрес dev интерфейс
sudo ip address add $the_ip broadcast $the_brdc dev $1
# ip route add default via шлюз_по_умолчанию
if [ -n "$the_gtw" ]; then
	sudo ip route add default via $the_gtw
fi
sudo ip link set $1 down
sudo ip link set $1 up
unset netname
unset the_ip
unset the_brdc
unset the_gtw
read -p "Press any key to continue ..."
exit 0
