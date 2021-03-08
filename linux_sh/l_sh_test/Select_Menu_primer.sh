#!/bin/sh
temp=""
PS3='Please, to select menu: '
echo
choice_of()
{
select menu
do
  temp=$menu
  break
done
}
choice_of Ethernet WiFi
echo -e "\nMyMenu1 is $temp\n"
unset temp
choice_of Wep Wpa/Wpa2
echo -e "\nMyMenu2 is $temp\n"
exit 0
