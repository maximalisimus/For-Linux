#!/bin/bash
function ping_ya() 
{
	clear
	echo ""
	echo "ping -c 3 ya.ru"
}
function  ifconfig()
{
	clear
	echo ""
	echo "/sbin/ifconfig"
}
function meminfo()
{
	clear
	echo ""
	echo "/bin/cat /proc/meminfo"
}
function menu()
{
	clear
	echo ""
	echo -e "\t\t\tМеню скрипта\n"
	echo -e "\t1. Пинговать ya.ru"
	echo -e "\t2. Информация об интерфейсах"
	echo -e "\t3. Информация о памяти"
	echo -e "\t0. Выход"
	echo -en "\t\tВведите номер раздела: "
	read -n 1 option
}
while [ $? -ne 1 ]
do
        menu
        case $option in
			0) break;;
			1) ping_ya;;
			2) ifconfig;;
			3) meminfo;;
			*) clear
				echo "Нужно выбрать раздел";;
		esac
		echo -en "\n\n\t\t\tНажмите любую клавишу для продолжения"
		read -n 1 line
done
clear
exit 0
