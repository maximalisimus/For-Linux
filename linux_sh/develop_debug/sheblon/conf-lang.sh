#!/bin/bash
VERSION=$(uname -r)
SYSTEM=$(uname -s)
ARCHI=$(uname -m)
ANSWER="./.asf"
ABSOLUT_FILENAME=$(readlink -e "$0")
filesdir=$(dirname "$ABSOLUT_FILENAME")
_config_files="$filesdir/config/lang.conf"
select_language() {
	
	dialog --backtitle "$VERSION - $SYSTEM ($ARCHI)" --title " Select Language " --menu "\nLanguage / sprache / taal / språk / lingua / idioma / nyelv / língua" 0 0 11 \
	"1" $"English       (en)" \
	"2" $"Italian       (it)" \
	"3" $"Russian       (ru)" \
	"4" $"Turkish       (tr)" \
	"5" $"Dutch         (nl)" \
	"6" $"Greek         (el)" \
	"7" $"Danish        (da)" \
	"8" $"Hungarian     (hu)" \
	"9" $"Portuguese    (pt)" \
   "10" $"German        (de)" \
   "11" $"French        (fr)" 2>${ANSWER}

	case $(cat "${ANSWER}") in
		"1") echo "./lang/english.trans" > $_config_files
			 ;;
		"2") echo "./lang/italian.trans" > $_config_files
			 ;; 
		"3") echo "./lang/russian.trans" > $_config_files
			 ;;
		"4") echo "./lang/turkish.trans" > $_config_files
			 ;;
		"5") echo "./lang/dutch.trans" > $_config_files
			 ;;             
		"6") echo "./lang/greek.trans" > $_config_files
			 ;;
		"7") echo "./lang/danish.trans" > $_config_files
			 ;;   
		"8") echo "./lang/hungarian.trans" > $_config_files
			 ;;
		"9") echo "./lang/portuguese.trans" > $_config_files
			 ;;
	   "10") echo "./lang/german.trans" > $_config_files
			 ;;
	   "11") echo "./lang/french.trans" > $_config_files
			 ;;
		  *) exit 0
			 ;;
	esac
}
select_language
clear
rm -rf $ANSWER
