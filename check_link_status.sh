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
#insert task nuber in error message
LINK1=ens9
LINK2=ens10
MESSAGE_ERROR="WARNING:task${task_num}"
MESSAGE_OK="OK:task${task_num}"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

ip a > "/root/links_task${task_num}_status"

function check_link_state {
        LINK=$1
        read -n 1 LINK_state < "/root/state_${LINK}_task${task_num}"
        #if LINK = 0, then link is ok, should check for fails
        if [ "$LINK_state" -eq "0" ]; then
                        grep $LINK "/root/links_task${task_num}_status"
                        #if grep fails, then it is not wordpress page, $? contains errorcode
                        if [ "$?" -ne "0" ]; then
                                        echo "1" > "/root/state_${LINK}_task${task_num}"
                                        curl -s -X POST $URL -d chat_id=$CHAT_ID_GEORGE -d text="$MESSAGE_ERROR $LINK down"
                        fi
        #if LINK_state=1, then LINK is absent, should check for recover
        else
                        grep $LINK "/root/links_task${task_num}_status"
                        #if grep success, then link has recovered, $? contains zero
                        if [ "$?" -eq "0" ]; then
                                        echo "0" > "/root/state_${LINK}_task${task_num}"
                                        curl -s -X POST $URL -d chat_id=$CHAT_ID_GEORGE -d text="$MESSAGE_OK $LINK up"
                        fi
        fi
}

check_link_state $LINK1
check_link_state $LINK2
