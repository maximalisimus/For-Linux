#!/bin/bash
function ord()
{
    echo -e -n "$@" | xxd -p
}
function chr()
{
    echo -e -n "$@" | xxd -r -p
}
function genrnnm()
{
    # echo "ibase=16; 61" | bc
    # 65
    # echo "obase=16; 26" | bc
    # 1A
    # ord "AYZ"
    # ord "ayz"
    # 41 59 5A - A Y Z - HEX
    # 65 89 90 - A Y Z - DEC
    # 61 79 7A - a y z - HEX
    # 97 121 122 - a y z - DEC
    # 65...122 - DEC
    _str=""
    cnt=1
    declare -i count
    count=$1
    while [ $cnt -le $count ]; do
        _vrem=$(echo $((1 + RANDOM % 25 + 97)))
        _hf=$( echo "obase=16; ${_vrem[*]}" | bc )
        # echo $((1 + RANDOM % 25 + 97))
        _str="${_str} ${_hf}"
        let cnt+=1
    done
    unset count
    unset cnt
    _nw_str=$(echo "${_str[*]}" | xargs | tr -d ' ')
    _str_str=$(chr "$_nw_str")
    unset _str
    unset _vrem
    unset _hf
    unset _nw_str
    echo "$_str_str"
}
function genrandname()
{
    _prt_o=$(genrnnm "2")
    _prt_t=$(genrnnm "5")
    echo "_${_prt_o}_${_prt_t}"
}
_prt_f=$(genrandname)
echo "${_prt_f}"
exit 0
