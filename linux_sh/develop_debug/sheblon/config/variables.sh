#!/bin/bash
VERSION=$(uname -r)
SYSTEM=$(uname -s)
ARCHI=$(uname -m)
ANSWER="./.asf"
_lst_mn_fl=(startfine chrootcheck)
_bs_mn_once=0
_work_fl="./work/output.txt"
_hdr_fl="./work/header.txt"
_bd_fl="./work/process.txt"
_regular_fl="./work/regular.txt"
