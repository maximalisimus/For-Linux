#!/bin/bash
# include this boilerplate
function jumpto
{
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}
start=${1:-"start"}
jumpto $start
start:
# your script goes here...
x=100
jumpto foo
mid:
x=101
echo "This is not printed!"
foo:
x=${x:-10}
echo x is $x
exit 0
