#!/bin/bash
_title="Title selection"
_body="\nPlease to enter selection.\n"
_column_1="Boolean"
_column_2="Select"
_network_menu=(netctl connman networkmanager wicd-gtk)
_menu=""
for i in ${_network_menu[*]}; do
	_menu="${_menu} FALSE $i"
done
unset _network_menu
declare -a __menu
declare -a choise
__menu=( $_menu )
_opt=$(zenity --list --checklist --multiple --title="$_title" --text="$_body" --width=256 --height=256 --column="$_column_1" --column="$_column_2" "${__menu[@]}" | tr "|" " " | xargs)
unset _menu
unset __menu
choise=( $_opt )
unset _opt
echo "option 0 = ${choise[0]}"
echo ""
echo "${choise[*]}"
sleep 3
wait
unset choise
### Data Column ###
_Back="Back"
_Exit="Exit"
_column="Options"
_gl_ttl="Global menu title"
_gl_bd="\nBody global menu\n"
_global_menu=("Menu-1" "Menu-2" "Menu-3" "$_Exit") # Global menu
_mno_ttl="One menu title"
_mno_bd="\nOne menu body\n"
_one_menu=("Selection-1" "Selection-2" "PodMenu-1" "$_Back") # One menu
_omo_ttl="PodMenu 1"
_omo_bd="PodMenu body"
_onemone_menu=("PodMenu-1" "PodMenu-2" "$_Back") # One podMenu
_mnt_ttl="Two menu title"
_mnt_bd="\nTwo menu body\n"
_two_menu=("Two-selection-1" "Two-selection-2" "$_Back") # Two menu
_mn_th_ttl="Three menu title"
_mn_th_bd="\nThree menu body\n"
### Data Column ###
function global()
{
	while global_menu=$(zenity --title="$_gl_ttl" --text="$_gl_bd" --width=256 --height=256 --list --column="$_column"  "${_global_menu[@]}"); do
		case "$global_menu" in
			"${_global_menu[0]}" ) menu_one ;;
			"${_global_menu[1]}" ) menu_two ;;
			"${_global_menu[2]}" ) menu_three ;;
		esac
		if  [[ "$global_menu" == "$_Exit" ]]; then
			if zenity --question --text="Do you want to exit now ?" ; then
				break ;
			fi			
		fi
	done
}
function menu_one()
{
	one_menu=$(zenity --title="$_mno_ttl" --text="$_mno_bd" --width=256 --height=256 --list --column="$_column"  "${_one_menu[@]}") 
		case "$one_menu" in
			"${_one_menu[0]}" ) echo "$one_menu" && sleep 3 && wait && global ;;
			"${_one_menu[1]}" ) echo "$one_menu" && sleep 3 && wait && global ;;
			"${_one_menu[2]}" ) menu_one_menu ;;
			"${_one_menu[3]}" ) global ;;
		esac
}
function menu_one_menu()
{
		one_one_menu=$(zenity --title="$_omo_ttl" --text="$_omo_bd" --width=256 --height=256 --list --column="$_column"  "${_onemone_menu[@]}")
		case "$one_one_menu" in
			"${_onemone_menu[0]}" ) echo "$one_one_menu" && sleep 3 && wait && menu_one ;;
			"${_onemone_menu[1]}" ) echo "$one_one_menu" && sleep 3 && wait && menu_one ;;
			"${_onemone_menu[2]}" ) menu_one ;;
		esac
}
function menu_two()
{
	two_menu=$(zenity --title="$_mnt_ttl" --text="$_mnt_bd" --width=256 --height=256 --list --column="$_column"  "${_two_menu[@]}")
		case "$two_menu" in
			"${_two_menu[0]}" ) echo "$one_menu" && sleep 3 && wait && global ;;
			"${_two_menu[1]}" ) echo "$one_menu" && sleep 3 && wait && global ;;
			"${_two_menu[2]}" ) global ;;
		esac
}
function menu_three()
{
	echo "Three menu selection"
	sleep 5
	wait
	global
}
global
exit 0
