#!/bin/bash

# Node service controller skel script
# Copyright (C) 2014 guanglin.an (lucky315.an@gmail.com )

NODE_PID="$!"
SERVER_FILE=

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

# start() {

# }

# stop() {
    
# }

# restart() {
    
# }

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
	    echo "service start....$SERVER_FILE"
	    ;;
	e)
	    echo "service stop...."
	    ;;
	r)
	    echo "service restart..."
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
