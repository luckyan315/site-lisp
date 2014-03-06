#!/bin/bash

# sample skel script 
# Copyright (C) 2014 guanglin.an (lucky315.an@gmail.com )

#constants
TEMP_FILE='./temp/*'

#hook "ctrl + c"
trap 'echo "hook ctrl + c" && rm -f $TEMP_FILE' INT

#hook "app exit "
trap 'echo "hook exit"' EXIT

#help
help() {
    echo "Usage: `basename $0` <args>"
    echo ""
    echo "<description>"
    echo "arguments:"
    echo "  <options>"
    exit 1
}

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
