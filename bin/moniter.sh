#!/bin/sh

SERVERS="firmsvr firmcli"

while true ;  do 
	for  svr in     $SERVERS          ; do 
		pid=`ps -ef | grep $USER | grep -v "grep" | grep $svr  | awk '{print $2}'`
		if [ -z $pid  ] ; then 
			./bin/$svr -f conf/$svr.conf
			echo "Alarm: restarting this svr:[$svr]"
		else
			echo "$svr -- $pid"
		fi 
	done 
	sleep 1
done
# 0. while true
# 1. for all svr 
# 2. find the svr 
# 3. if svr not existing then start it end
# 4. repeat all 
# 5. sleep 1 second
# 6. repeat 

