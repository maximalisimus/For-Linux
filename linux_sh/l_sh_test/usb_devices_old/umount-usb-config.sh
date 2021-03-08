#!/bin/bash
system=$(uname -s)
version=$(uname -r)
archi=$(uname -m)
_backtitle="${system} ${version} ${archi}"
ABS_FNAME=`readlink -e "$0"`
filedir=`dirname "$ABS_FNAME"`
cp -f $filedir/options.backup $filedir/options.conf
ANSWER="./inst.stp"
_userpass=""
echo ""  >> $filedir/options.conf
select_language() {
    
    Xdialog --backtitle "$_backtitle" --title " Select Language " --menu "\nLanguage / sprache / taal / språk / lingua / idioma / nyelv / língua" 0 0 12 \
 	"1" $"English		(en)" \
 	"2" $"Italian 		(it)" \
 	"3" $"Russian 		(ru)" \
 	"4" $"Turkish 		(tr)" \
 	"5" $"Dutch 		(nl)" \
 	"6" $"Greek 		(el)" \
 	"7" $"Danish 		(da)" \
 	"8" $"Hungarian 	(hu)" \
 	"9" $"Portuguese 	(pt)" \
   "10" $"German	 	(de)" \
   "11" $"French		(fr)" \
   "12" $"Polish		(pl)" 2>${ANSWER}

	case $(cat ${ANSWER}) in
        "1") echo "_language=\"\$filesdir/language/english.lng\""  >> $filedir/options.conf
			echo "source \$_language"  >> $filedir/options.conf
			source $filedir/language/english.lng
             ;;
        "2") echo "_language=\"\$filesdir/language/italian.lng\""  >> $filedir/options.conf
			echo "source \$_language"  >> $filedir/options.conf
			source $filedir/language/italian.lng
             ;; 
        "3") echo "_language=\"\$filesdir/language/russian.lng\""  >> $filedir/options.conf
			echo "source \$_language"  >> $filedir/options.conf
			source $filedir/language/russian.lng
             ;;
        "4") echo "_language=\"\$filesdir/language/turkish.lng\""  >> $filedir/options.conf
			echo "source \$_language"  >> $filedir/options.conf
			source $filedir/language/turkish.lng
             ;;
        "5") echo "_language=\"\$filesdir/language/dutch.lng\""  >> $filedir/options.conf
			echo "source \$_language"  >> $filedir/options.conf
			source $filedir/language/dutch.lng
             ;;             
        "6") echo "_language=\"\$filesdir/language/greek.lng\""  >> $filedir/options.conf
			echo "source \$_language"  >> $filedir/options.conf
			source $filedir/language/greek.lng
             ;;
        "7") echo "_language=\"\$filesdir/language/danish.lng\""  >> $filedir/options.conf
			echo "source \$_language"  >> $filedir/options.conf
			source $filedir/language/danish.lng
             ;;   
        "8") echo "_language=\"\$filesdir/language/hungarian.lng\""  >> $filedir/options.conf
			echo "source \$_language"  >> $filedir/options.conf
			source $filedir/language/hungarian.lng
             ;;
        "9") echo "_language=\"\$filesdir/language/portuguese.lng\""  >> $filedir/options.conf
			echo "source \$_language"  >> $filedir/options.conf
			source $filedir/language/portuguese.lng
             ;;      
       "10") echo "_language=\"\$filesdir/language/german.lng\""  >> $filedir/options.conf
			echo "source \$_language"  >> $filedir/options.conf
			source $filedir/language/german.lng
             ;;
       "11") echo "_language=\"\$filesdir/language/french.lng\""  >> $filedir/options.conf
			echo "source \$_language"  >> $filedir/options.conf
			source $filedir/language/french.lng
             ;;
       "12") echo "_language=\"\$filesdir/language/polish.lng\""  >> $filedir/options.conf
			echo "source \$_language"  >> $filedir/options.conf
			source $filedir/language/polish.lng
             ;;
    esac
}
inputpass()
{
	Xdialog --backtitle "$_backtitle" --title "$_pass_title" --inputbox "$_pass_body" 0 0 "" 2>${ANSWER}
	qst=$?
	case $qst in
		0) #_the_pass=$(cat ${ANSWER})
			_userpass=$(cat ${ANSWER})
			#_userpass=$_the_pass
			;;
	esac
}
select_type_pass()
{
	Xdialog --default-item 2 --backtitle "$_backtitle" --title "$_select_type_pass_title" \
    --menu "$_select_type_pass_body" 0 0 5 \
 	"1" "$_no_pass_menu" \
	"2" "$_memory_pass_menu" \
	"3" "$_input_pass_menu" 2>${ANSWER}	

    case $(cat ${ANSWER}) in
        "1") echo "_type_mount=\"1\"" >> $filedir/configure.inf
             ;;
        "2") inputpass
			echo "_type_mount=\"2\"" >> $filedir/configure.inf
			[[ ${_userpass[*]} != "" ]] && echo "szPassword=\"$_userpass\"" >> $filedir/configure.inf
             ;;
        "3") echo "_type_mount=\"3\"" >> $filedir/configure.inf
             ;;
     esac
}
select_language
Xdialog --backtitle "$_backtitle" --title "$_info_install_title" --msgbox "$_info_install_body" 0 0
Xdialog --backtitle "$_backtitle" --title "$_info_pass_type_title" --msgbox "$_info_pass_type_body" 0 0
select_type_pass
rm -rf $ANSWER
clear
exit 0
