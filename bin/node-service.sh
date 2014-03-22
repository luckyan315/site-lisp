#!/bin/bash

# Node service controller skel script
# Copyright (C) 2014 guanglin.an (lucky315.an@gmail.com )

#cur dir path
DIR_NAME="$(cd "$(dirname "$0")" && pwd)"

NODE_PID="$!"
SERVER_FILE=
PID_FILE="app.pid"

quit() {
    trap - TERM QUIT INT EXIT

    if [ -n "$NODE_PID" ]; then
	echo "Terminating node service pid:$NODE_PID ..."
	kill $NODE_PID
    fi
}

#hook "service exit ..."
trap "quit" TERM QUIT INT EXIT

#help
help() {
    
    echo "Usage: `basename $0` {-b(start) | -e(stop) | -r(restart)}"
    echo ""
    echo "   -b      node service start"
    echo "   -e      node service stop"
    echo "   -r      node service restart"
    exit 1
}

get_pid() {
    pid_file_path="${DIR_NAME}/$PID_FILE"
    if [ -f "$pid_file_path" ]; then
	echo `cat $pid_file_path`
    fi
}

start() {
    pid=`get_pid`
    if [ ! -z $pid ]; then
	echo "server is already running.."
    else
	node $SERVER_FILE 2>&1 &
	echo "Node Service is started..."	
    fi

}

stop() {
    pid=`get_pid`
    if [ -z $pid ]; then
	echo 'Node Service not running'
    else
	kill -15 $pid
	echo 'Node Service stopped!'
    fi
}

restart() {
    stop
    sleep 0.5
    echo restarting....
    start
}

if [ $# -lt 1 ]; then
    help
    exit 1
fi

#parse args
while getopts "hb:ert:" opt; do
    case $opt in
	h) help
	    ;;
	b)
	    SERVER_FILE="$OPTARG"
	    start
	    ;;
	e)
	    stop
	    ;;
	r)
	    restart
	    ;;
	t)
	    arg="$OPTARG"
	    echo "Option -$opt: $OPTARG"
	    ;;
	*)
	    echo -e "\x1b[31mInvalid option: -$opt\x1b[m" >&2
	    exit 1
	    ;;
    esac
done
