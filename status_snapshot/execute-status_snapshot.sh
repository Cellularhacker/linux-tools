#!/bin/bash

######
#
# Modified at 2023-06-02 13:00:00 KST ~ 2023-06-02 14:20:00 KST
# by Cellularhacker (wva3cdae@gmail.com)
# Github @Cellularhacker
#
# Check Updates at : https://github.com/Cellularhacker/linux-tools/blob/main/status_snapshot/execute-status_snapshot.sh
#
######

ALIAS='status_snapshot'
SHORT_HOSTNAME=$(hostname -s)
DATE_Y=$(date +20%y)
DATE_M=$(date +%m)
DATE_D=$(date +%d)
TIME_H=$(date +%H)
TIME_M=$(date +%M)
TIME_S=$(date +%S)
DIR_NAME="${DATE_Y}/${DATE_M}/${DATE_D}/${TIME_H}"
DATESTR=$(date +20%y%m%d-%H%M%S)
FILENAME="${ALIAS}_${DATESTR}.${SHORT_HOSTNAME}.log"

LOG_DIR="/home/cellularhacker/${ALIAS}_logs/${DIR_NAME}"

mkdir "/home/cellularhacker/${ALIAS}_logs" 2>/dev/null
mkdir -p "${LOG_DIR}" 2>/dev/null

/bin/bash "/usr/exports/${ALIAS}.sh" > "${LOG_DIR}/${FILENAME}"
