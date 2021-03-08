#!/bin/bash
VERSION=$(uname -r)
SYSTEM=$(uname -o)
ARCHI=$(uname -m)
ANSWER="./.asf"
function select_user()
{
	_usr_list=$(ls /home/ | sed "s/lost+found//")
        _usr_lst_menu=""
        for i in ${_usr_list[*]}; do
            _usr_lst_menu="${_usr_lst_menu} $i - on"
        done
        _usr_lst_menu="${_usr_lst_menu} root - off"
	Xdialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "Select User" --checklist "\nPlease to select user on change password\n" \
	0 0 5 ${_usr_lst_menu} 2>${ANSWER}
	variables=$(cat ${ANSWER})
	_users=( $variables )
	unset variables
	for j in ${_users[*]}; do
		set_root_password "$j"
	done
}
function set_root_password() {
	Xdialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "Enter Password for user $1" --clear --insecure --passwordbox \
	"\nPlease, enter the password\n" 0 0 2> ${ANSWER}
	PASSWD=$(cat ${ANSWER})
	Xdialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "Repeat Password for user $1" --clear --insecure --passwordbox \
	"\nPlease, repeat the password\n" 0 0 2> ${ANSWER}
	PASSWD2=$(cat ${ANSWER})
	while [[ $PASSWD != $PASSWD2 ]]; do
		Xdialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "Enter Password for user $1" --clear --insecure --passwordbox \
		"\nPlease, enter the password\n" 0 0 2> ${ANSWER}
		PASSWD=$(cat ${ANSWER})
		Xdialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title "Repeat Password for user $1" --clear --insecure --passwordbox \
		"\nPlease, repeat the password\n" 0 0 2> ${ANSWER}
		PASSWD2=$(cat ${ANSWER})
	done
	clear
	echo -e "${PASSWD}\n${PASSWD}" > /tmp/.passwd
	passwd $1 < /tmp/.passwd
	rm -rf /tmp/.passwd
}
select_user
rm -rf $ANSWER
exit 0
