#!/bin/bash

#put this script on machine, that will check state (ping and wp state) of other machines
#must be run as script in /etc/crontab:
#* * * * * root /dir/check_wp_state.sh 192.168.56.111
#or any other ip, will be checked last symbol

ip=$1
#get last symbol from string of 15 chars:
task_num=${ip:14:1}
TOKEN=795659365:AAEZ4TyKiAXA85rR_9ACv2EgtcLRgVVHm4U
CHAT_ID_DUTY=-1001160850716
CHAT_ID_GEORGE=212275278
#insert task nuber in error message
MESSAGE_ERROR_PING="PROBLEM:task${task_num} NOPING"
MESSAGE_OK_PING="OK:task${task_num} NOPING"
MESSAGE_ERROR_WP="PROBLEM:task${task_num} WP is down"
MESSAGE_OK_WP="OK:task${task_num} WP is down"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

#if file /root/state_PING_tasknum contain 0 - service online, ping to check if it is unreachable
#if file /root/state_PING_tasknum contain 1 - service offline, ping to check if it is restored
read -n 1 task_state < "/root/state_PING_task${task_num}"
if [ "$task_state" -eq "0" ]; then
        ping -c1 $ip
        if [ "$?" -ne "0" ]; then
                echo '1' > "/root/state_PING_task${task_num}"
                curl -s -X POST $URL -d chat_id=$CHAT_ID_GEORGE -d text="$MESSAGE_ERROR_PING"
                curl -s -X POST $URL -d chat_id=$CHAT_ID_DUTY -d text="$MESSAGE_ERROR_PING"
        fi
else
        ping -c1 $ip
        if [ "$?" -eq "0" ]; then
                echo '0' > "/root/state_PING_task${task_num}"
                curl -s -X POST $URL -d chat_id=$CHAT_ID_GEORGE -d text="$MESSAGE_OK_PING"
                curl -s -X POST $URL -d chat_id=$CHAT_ID_DUTY -d text="$MESSAGE_OK_PING"
        fi
fi

#download main page of site and grep word "wordpress" bad solution to verify site is working, but it was enough for educational purposes
curl $ip > "/root/task${task_num}_main_page"

read -n 1 WP_state < "/root/state_WP_task${task_num}"
#if WP_state = 0, then site is ok, should check for fails
if [ "$WP_state" -eq "0" ]; then
        grep wordpress "/root/task${task_num}_main_page"
        #if grep fails, then it is not wordpress page, $? contains errorcode
	if [ "$?" -ne "0" ]; then
                echo "1" > "/root/state_WP_task${task_num}"
                curl -s -X POST $URL -d chat_id=$CHAT_ID_GEORGE -d text="$MESSAGE_ERROR_WP"
                curl -s -X POST $URL -d chat_id=$CHAT_ID_DUTY -d text="$MESSAGE_ERROR_WP"
        fi
#if WP_state=1, then site is down, should check for recover
else
        grep wordpress "/root/task${task_num}_main_page"
        #if grep success, then site has recovered, $? contains zero
        if [ "$?" -eq "0" ]; then
                echo "0" > "/root/state_WP_task${task_num}"
                curl -s -X POST $URL -d chat_id=$CHAT_ID_GEORGE -d text="$MESSAGE_OK_WP"
                curl -s -X POST $URL -d chat_id=$CHAT_ID_DUTY -d text="$MESSAGE_OK_WP"
        fi
fi
