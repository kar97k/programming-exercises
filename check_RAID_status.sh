#!/bin/bash

#it is local script, it must be putted on machine, which state must be checked
#run as script in /etc/crontab:
#* * * * * root /dir/check_wp_state.sh 192.168.56.111
#or any other ip, will be checked last symbol

ip=$1
#get last symbol from string of 15 chars:
task_num=${ip:13:2}
TOKEN=795659365:AAEZ4TyKiAXA85rR_9ACv2EgtcLRgVVHm4U
CHAT_ID_GEORGE=212275278
CHAT_ID_NASTYA=668590491
#insert task nuber in error message
MESSAGE_ERROR_RAID="WARNING:task${task_num} RAID degraded"
MESSAGE_OK_RAID="OK:task${task_num} RAID degraded"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

cat "/proc/mdstat" > "/root/RAID_task${task_num}_mdstat"

read -n 1 RAID_state < "/root/state_RAID_task${task_num}"
#if RAID_state = 0, then RAID is ok, should check for fails
if [ "$RAID_state" -eq "0" ]; then
        grep UU "/root/RAID_task${task_num}_mdstat"
        #if grep fails, then it is not wordpress page, $? contains errorcode
        if [ "$?" -ne "0" ]; then
                echo "1" > "/root/state_RAID_task${task_num}"
                curl -s -X POST $URL -d chat_id=$CHAT_ID_GEORGE -d text="$MESSAGE_ERROR_RAID"
                curl -s -X POST $URL -d chat_id=$CHAT_ID_NASTYA-d text="$MESSAGE_ERROR_RAID"
        fi
#if RAID_state=1, then RAID is degraded, should check for recover
else
        grep UU "/root/RAID_task${task_num}_mdstat"
        #if grep success, then site has recovered, $? contains zero
        if [ "$?" -eq "0" ]; then
                echo "0" > "/root/state_RAID_task${task_num}"
                curl -s -X POST $URL -d chat_id=$CHAT_ID_GEORGE -d text="$MESSAGE_OK_RAID"
                curl -s -X POST $URL -d chat_id=$CHAT_ID_NASTYA -d text="$MESSAGE_OK_RAID"
        fi
fi
