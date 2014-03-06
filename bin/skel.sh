#!/bin/bash

# sample skel script 
# Copyright (C) 2014 guanglin.an (lucky315.an@gmail.com )

#constants
TEMP_FILE='./temp/*'

#hook "ctrl + c"
#trap 'echo "hook ctrl + c" && rm -f $TEMP_FILE' INT

#hook "app exit "
#trap 'echo "hook exit"' EXIT

#help
help() {
    
    echo "Usage: `basename $0` <args>"
    echo ""
    echo "<description>"
    echo "arguments:"
    echo "  <options>"
    exit 1
}

getReturn() {
    echo -n "Press return "
    read ans
    return 0
}

getConfirm() {
    echo -n "Are you sure?"
    while 1 ; do
	read ans
	case "$ans" in
	    y | yes | Y | YES )
		return 0
		;;
	    n | no | N | NO )
		return 1
		;;
	    *)
		echo "Please Enter yes(y) or no(n)!"
		;;
	esac
    done
}

###############################################################################
# main
###############################################################################

if [ $# -lt 1 ]; then
    help
    exit 1
fi

#parse args
while getopts ":ht:" opt; do
    case $opt in
	h) help
	    ;;
	\?)
	    echo -e "\x1b[31mInvalid option: -$OPTARG\x1b[m" >&2
	    exit 1
	    ;;
	t)
	    arg="$OPTARG"
	    echo "Option -$opt: $OPTARG"
	    ;;
	    
    esac
done
