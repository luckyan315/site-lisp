#!/bin/bash

print_usage()
{
    cat << _EOF_
USAGE: 
  `basename $0` [-n value] [app_name]
_EOF_
}

###############################################################################
# main
###############################################################################
if [ $# -lt 1 ]; then
    print_usage
    exit
fi

state_count=
state_app=

while [ -n "$1" ]; do
    case "$1" in
        --help)
            print_usage
            exit
            ;;  
        -n)
	    state_count=1
	    echo "access -n"
            shift; continue
            ;;

        *)
	    if [ -n $state_count ]; then
		echo "state_count access!"
	    fi
		echo "access -*"
            exit 1
            ;;
    esac
done