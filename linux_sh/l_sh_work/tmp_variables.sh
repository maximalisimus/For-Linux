#!/bin/bash
sudo echo 'TTTESTTT=_TEST_' > /tmp/variables
shopt -s lastpipe ; sudo find /tmp -name 'variables' -print0 | while read -d $'\0' -r ; do source "$REPLY" ; done ; echo $TTTESTTT
exit 0
