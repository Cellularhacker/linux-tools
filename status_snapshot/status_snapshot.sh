#!/bin/bash

######
#
# Modified at 2023-06-02 13:00:00 KST ~ 2023-06-02 14:20:00 KST
# by Cellularhacker (wva3cdae@gmail.com)
# Github @Cellularhacker
#
# Check Updates at : https://github.com/Cellularhacker/linux-tools/blob/main/status_snapshot/status_snapshot.sh
#
######

echo '' && echo 'hostname' && hostname && echo '' && echo '' && echo 'kernel' && echo '' && uname -a && echo '' && echo '' && echo 'release' && echo '' && cat /etc/*-release && echo '' && echo '' && echo 'memory' && echo '' && free -m && echo '' && echo 'process' && echo '' && top -n 1 -b && echo '' && echo '' && echo 'io' && echo '' && iotop -n 1 -b && echo '' && echo '' && echo 'storage' && echo '' && df -hT
