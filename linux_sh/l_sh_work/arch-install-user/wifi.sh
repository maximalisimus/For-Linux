#!/bin/sh
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
echo -e "\e[1;30mStart $0\n\e[0m"
scripts_filename=`readlink -e "$0"`
scripts_filedir=`dirname "$scripts_filename"`
manual_confnet="$scripts_filedir/manconfnet.sh"
declare -a wnet
declare -a wname
myssid=""
adaptername=""
mypass=""
wnet_count=""
my_ip=""
ping_net=""
typewencrypt=""
typewnet=""
errorcode=""
dhcpstat=""
question=""
setmyip()
{
	my_ip=( $(ip -o address show | grep -v "::1/128" | awk '{print $4}') )
}
unsetmyip()
{
	unset my_ip
}
setmyping()
{
	ping -c 3 ya.ru 2> /dev/null 1> /dev/null
	ping_net="$?"
	# ( $(ping -c 3 ya.ru | sed '1,6d' | sed '2,1d' | awk '{print $6}' | tr -d '%') )
}
unsetmyping()
{
	unset ping_net
}
setwnet()
{
	case "$1" in
		1) wnet=( $(ip -o link show | gawk '{print $2}' | tr -d ':' | grep w) );;
		2) wnet=( $(ip -o link show | gawk '{print $2}' | tr -d ':' | grep e) );;
	esac
}
unsetwnet()
{
	unset wnet
}
setwnetcount()
{	
	case "$1" in
		1) wnet_count=( $(ip -o link show | gawk '{print $2}' | tr -d ':' | grep w | wc -l) );;
		2) wnet_count=( $(ip -o link show | gawk '{print $2}' | tr -d ':' | grep e | wc -l) );;
	esac
}
unsetwnetcount()
{
	unset wnet_count
}
setwname()
{
	wname=( $(iw dev $1 scan | grep SSID | awk '{print $2}') )
}
unsetwname()
{
	unset wname
}
outadaptername()
{
	wcount=1
		for wletter in "${wnet[@]}"; do
			echo -e "\t\e[1;37m$wcount) \e[1;33m$wletter\e[0m"
			let wcount+=1
		done
}
outwnetname()
{
	for wifinetname in "${wname[@]}"; do
			echo -e -n "\t\e[1;30mSSID: \e[1;37m$wifinetname\e[0m\n"
	done
}
# pingcheck()
# {
#	if [ "$ping_net" == "0" ]; then
#		echo "0"
#	elif [ "$ping_net" != "0" ]; then
#		echo "1"
#	fi
# }
setdhcp()
{
	dhcpstat=( $(sudo systemctl is-active dhcpcd) )
	if [ "$dhcpstat" == "inactive" ]; then
		`sudo systemctl start dhcpcd`
		unset dhcpstat
		dhcpstat=( $(sudo systemctl is-active dhcpcd) )
		if [ "$dhcpstat" == "active" ]; then
			`sudo systemctl stop dhcpcd`
		elif [ "$dhcpstat" == "inactive" ]; then
			`sudo systemctl start dhcpcd`
			`sudo systemctl stop dhcpcd`
		fi
		`sudo dhcpcd`
	elif [ "$dhcpstat" == "inactive" ]; then
		`sudo systemctl start dhcpcd`
		unset dhcpstat
		dhcpstat=( $(sudo systemctl is-active dhcpcd) )
		if [ "$dhcpstat" == "active" ]; then
			`sudo systemctl stop dhcpcd`
		elif [ "$dhcpstat" == "inactive" ]; then
			`sudo systemctl start dhcpcd`
			`sudo systemctl stop dhcpcd`
		fi
		`sudo dhcpcd`
	fi
}
wifi()
{
	if [ "$wnet_count" == "0" ]; then
		echo -e "\e[1;31mSorry, wifi adapter is not detected!\e[0m"
		errorcode="11"
	elif [ "$wnet_count" == "1" ]; then
		setwname "${wnet[0]}"
		adaptername="${wnet[0]}"
		echo ""
		echo -e "\e[1;37mWifi name (SSID) is scanned:\e[0m\n"
		outwnetname
		echo -e "Please enter the name (\e[1;34mSSID\e[0m) of your network:"
		read myssid
		echo -e "Please enter your network to \e[1;33mpassword\e[0m:"
		echo -e "\e[1;30m(Please enter if not to password)\e[0m"
		read mypass
		echo -e "\n\e[1;30mPlease to select \e[1;37mnumber \e[1;30mthe ecnryption to \e[1;37mWiFi net:\e[0m"
		echo -e "\t\e[1;37m1)\e[1;30mWEP \t\e[1;37m2)\e[1;34mWPA/WPA2\e[0m"
		echo -e "\e[1;30m(2 - Enter encryption to default)\e[0m"
		read typewencrypt
		if [ -z "$typewencrypt" ]; then 
			typewencrypt=2
		fi			
		echo -e "\n\e[1;30mPlease to select \e[1;37mnumber \e[1;30mtype \e[1;37mWiFi net:\e[0m"
		echo -e "\t\e[1;37m1)\e[1;32mOpen \t\e[1;37m2)\e[1;33mEncrypt\e[0m"
		echo -e "\e[1;30m(2 - Enter type connection to default)\e[0m"
		read typewnet
		if [ -z "$typewnet" ]; then 
			typewnet=2
		fi
		errorcode="0"
	elif [ "$wnet_count" -gt "1" ]; then
		clear
		echo ""
		echo -e "\e[1;37mPlease to select the WiFi adapter:\e[0m"
		outadaptername
		echo -e "\e[1;30m(1 - Enter adapter to default)\e[0m"
		read adaptername
		if [ -z "$adaptername" ]; then
			adaptername="${wnet[0]}"
		fi
		cnt="0"
		while [[ "$cnt" == "0" ]]; do
			for wlt in "${wnet[@]}"; do
				if [ "$wlt" == "$adaptername" ]; then
					cnt="1"
					adaptername="$wlt"
					break
				elif [ "$wlt" != "$adaptername" ]; then
					cnt="0"
					continue
				fi
			done
			if [ "$cnt" == "0" ]; then
				clear
				echo ""
				echo -e "\e[1;31mThe wifi adapter name is not valid\e[0m"
				echo ""
				echo -e "\e[1;37mPlease to select the WiFi adapter:\e[0m"
				outadaptername
				echo -e "\e[1;30m(1 - Enter adapter to default)\e[0m"
				read adaptername
				if [ -z "$adaptername" ]; then
					adaptername="${wnet[0]}"
				fi
			elif [ "$cnt" == "1" ]; then
				break
			fi
		done
		echo -e "\e[1;37mWifi name (SSID) is scanned:\e[0m\n"
		outwnetname
		echo -e "Please enter the name (\e[1;34mSSID\e[0m) of your network:"
		read myssid
		echo -e "Please enter your network \e[1;33mpassword\e[0m:"
		echo -e "\e[1;30m(Please enter if not to password)\e[0m"
		read mypass
		echo -e "\n\e[1;30mPlease to select \e[1;37mnumber \e[1;30mthe ecnryption to \e[1;37mWiFi net:\e[0m"
		echo -e "\t\e[1;37m1)\e[1;30mWEP \t\e[1;37m2)\e[1;34mWPA/WPA2\e[0m"
		echo -e "\e[1;30m(2 - Enter encryption to default)\e[0m"
		read typewencrypt
		if [ -z "$typewencrypt" ]; then 
			typewencrypt=2
		fi
		echo -e "\n\e[1;30mPlease to select \e[1;37mnumber \e[1;30mtype \e[1;37mWiFi net:\e[0m"
		echo -e "\t\e[1;37m1)\e[1;32mOpen \t\e[1;37m2)\e[1;33mEncrypt\e[0m"
		echo -e "\e[1;30m(2 - Enter type connection to default)\e[0m"
		read typewnet
		if [ -z "$typewnet" ]; then 
			typewnet=2
		fi
		errorcode="0"
	fi
}
wifiwep()
{
	case "$1" in
		1) iw dev $adaptername connect $2;;
		2) iw dev $adaptername connect $2 key 0:$3;;
	esac
}
wifiwpa()
{
	case "$1" in
		1) wpa_passphrase $2 > $scripts_filedir/arch_custom-config/example.conf
			# /etc/wpa_supplicant/example.conf
			wpa_supplicant -B -i $adaptername -c $scripts_filedir/arch_custom-config/example.conf;; 
				# /etc/wpa_supplicant/example.conf;;
		2) wpa_passphrase $2 $3 > $scripts_filedir/example.conf
			# /etc/wpa_supplicant/example.conf
			wpa_supplicant -B -i $adaptername -c $scripts_filedir/arch_custom-config/example.conf;; 
				# /etc/wpa_supplicant/example.conf;;
	esac
}
wificheck()
{
	if [ "$errorcode" == "11" ]; then
		break
	fi
	case "$typewencrypt" in
		1) case "$typewnet" in
				1) wifiwep "1" "$myssid";;
				2) wifiwep "2" "$myssid" "$mypass";;
			esac;;
		2) case "$typewnet" in
				1) wifiwpa "1" "$myssid";;
				2) wifiwpa "2" "$myssid" "$mypass";;
			esac;;
		*) break;;
	esac
}
adaptercheck()
{
	echo ""
	echo -e "\e[1;37mPlease to select the ethernet adapter:\e[0m"
	outadaptername
	echo -e "\e[1;30m(1 - Enter adapter to default)\e[0m"
	read adaptername
	if [ -z "$adaptername" ]; then
		adaptername="${wnet[0]}"
	fi
	cnt="0"
	while [[ "$cnt" == "0" ]]; do
		for wlt in "${wnet[@]}"; do
			if [ "$wlt" == "$adaptername" ]; then
				cnt="1"
				adaptername="$wlt"
				break
			elif [ "$wlt" != "$adaptername" ]; then
				cnt="0"
				continue
			fi
		done
		if [ "$cnt" == "0" ]; then
			clear
			echo ""
			echo -e "\e[1;31mThe ethernet adapter name is not valid\e[0m"
			echo ""			
			echo -e "\e[1;37mPlease to select the ethernet adapter:\e[0m"
			outadaptername
			echo -e "\e[1;30m(1 - Enter adapter to default)\e[0m"
			read adaptername
			if [ -z "$adaptername" ]; then
				adaptername="${wnet[0]}"
			fi
		elif [ "$cnt" == "1" ]; then
			break
		fi
	done
}
ethernet()
{
	if [ "$wnet_count" == "0" ]; then
		echo -e "\e[1;31mSorry, ethernet adapter is not detected!\e[0m"
		if [ "$errorcode" != "11" ]; then
			errorcode="9"
		fi
	elif [ "$wnet_count" == "1" ]; then
		if [ -z "$adaptername" ]; then
			adaptername="${wnet[0]}"
		fi
		setdhcp
		unsetmyip
		unsetmyping
		sleep 10
		setmyip
		setmyping
		if [ "$ping_net" == "0" ]; then
			echo -e "\e[1;32mInternet to connection!\e[0m"
			errorcode="0"
		elif [ "$ping_net" != "0" ]; then
			ping -c 3 ya.ru
			echo -e "\n\e[1;30mDo you want number to \e[1;37mmanual config \e[1;30mto \e[1;37methernet \e[1;30madapter&\e[0m"
			echo -e "\t\e[1;33m1) \e[1;37myes \e[1;30mor \e[1;33m2) \e[1;37mno\e[0m"
			echo -e "\e[1;30m(2 - Please enter to default question)\e[0m"
			read question
			if [ -n "$question" ]; then
				if [ "$question" == "1" ]; then
					echo -e "\n\e[1;31mThe Internet is not connected! \e[1;36mPlease manual configure ethernet adapter.\e[0m"
					sh $manual_confnet "$adaptername"
					unsetmyip
					unsetmyping
					sleep 10
					setmyip
					setmyping
					if [ "$ping_net" == "0" ]; then
						echo -e "\e[1;32mInternet to connected!\e[0m"
						errorcode="0"
					elif [ "$ping_net" != "0" ]; then
						echo -e "\e[1;31mSory, the Internet is not connected!\e[0m"
						errorcode="7"
					fi
				elif [ "$question" == "2" ]; then
					question="1"
				fi
			elif [ -z "$question" ]; then
				question="1"
			fi
		fi	
	elif [ "$wnet_count" -gt "1" ]; then
		if [ -z "$adaptername" ]; then
			adaptercheck
		fi
		setdhcp
		unsetmyip
		unsetmyping
		sleep 10
		setmyip
		setmyping
		if [ "$ping_net" == "0" ]; then
			echo -e "\e[1;32mInternet to connection!\e[0m"
			errorcode="0"
		elif [ "$ping_net" != "0" ]; then
			ping -c 3 ya.ru
			echo -e "\n\e[1;30mDo you want number to \e[1;37mmanual config \e[1;30mto \e[1;37methernet \e[1;30madapter&\e[0m"
			echo -e "\t\e[1;33m1) \e[1;37myes \e[1;30mor \e[1;33m2) \e[1;37mno\e[0m"
			echo -e "\e[1;30m(2 - Please enter to default question)\e[0m"
			read question
			if [ -n "$question" ]; then
				if [ "$question" == "1" ]; then
					echo -e "\n\e[1;31mThe Internet is not connected! \e[1;36mPlease manual configure ethernet adapter.\e[0m"
					sh $manual_confnet "$adaptername"
					unsetmyip
					unsetmyping
					sleep 10
					setmyip
					setmyping
					if [ "$ping_net" == "0" ]; then
						echo -e "\e[1;32mInternet to connected!\e[0m"
						errorcode="0"
					elif [ "$ping_net" != "0" ]; then
						echo -e "\e[1;31mSory, the Internet is not connected!\e[0m"
						errorcode="7"
					fi
				elif [ "$question" == "2" ]; then
					question="1"
				fi
			elif [ -z "$question" ]; then
				question="1"
			fi
		fi	
	fi
}
startscript()
{
	case "$1" in
		1) setwnetcount "1"
			setwnet "1";;
		2) setwnetcount "2"
			setwnet "2";;
	esac
}
finishscript()
{
	unsetmyip
	unsetmyping
	unsetwnet
	unsetwnetcount
	unsetwname
	unset typewencrypt
	unset typewnet
	unset errorcode
	unset adaptername
	unset scripts_filename
	unset scripts_filedir
	unset manual_confnet
	unset dhcpstat
	unset question
}
case "$1" in
	1) startscript "2"
		ethernet;;
	2) startscript "1"
		wifi
		wificheck
		ethernet;;
	*) break;;
esac
case "$errorcode" in
	0) break;;
	7) break
		exit 7;;
	9) break 
		exit 9;;
	11) finishscript
		startscript "2"
		ethernet;;
	*) break;;
esac
finishscript
echo -e "\e[1;30m\n\nDone $0\e[0m"
read -p "Press any key to continue ..."
if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi
echo -n "${reset}"
exit 0
