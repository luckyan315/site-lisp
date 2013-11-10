#!/bin/bash

# kill the moniter script 

pid=`ps -ef | grep $USER | grep -v "grep" | grep moniter.sh  | awk '{print $2}'`
echo " kill the moniter.sh ($pid)"
kill -9 $pid 


pid=`ps -ef | grep $USER | grep -v "grep" | grep svr  | awk '{print $2}'`
echo "kill all process with *svr*:($pid)"
kill -9 $pid 
