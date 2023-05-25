#!/bin/bash
# This script is used to pull the newest code from codeup.aliyun.com and update the local files.

# Every 5 minutes, pull from origin
while true
do
    git pull origin master
    sleep 300
done