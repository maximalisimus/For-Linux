#!/bin/bash
#
_mem_head=""
_memory=""
_mem_2=""
_mem_head=$(free -h | awk 'NR==1{printf "\t%s\t%s\t%s\t%s\t\n", $1,$3,$2,$2}')
_memory=$(free -h | awk 'NR==2{printf "%s\t%s\t%s\t%s\t%.2f%%\n", $1,$2,$4,$3,$3*100/$2}')
_mem_2=$(free -h | awk 'NR==3{printf "%s\t%s\t%s\t%s\t%.2f%%\n", $1,$2,$4,$3,$3*100/$2}')
echo ""
echo "$_mem_head"
echo "$_memory"
echo "$_mem_2"
echo ""
unset _mem_head
unset _memory
unset _mem_2

