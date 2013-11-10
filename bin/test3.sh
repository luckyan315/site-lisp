#!/bin/bash

print_usage()
{
    cat << _EOF_
USAGE: 
  `basename $0` [-n value] [file_name]
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
state_file=

var_cnt=1
var_file=

while [ -n "$1" ]; do
    case "$1" in
        --help)
            print_usage
            exit
            ;;  
        -n)
            shift 1
	    state_count=1;
	    continue;
            ;;

        *)
	    if [ $# -eq 1 ]; then
		var_file=$1
		echo "File: $1"
		exit 1
	    elif [ "$state_count" ]; then
	    	var_cnt=$1
		shift 1
	    	echo "Count : $var_cnt"
	    	state_count=0
	    else
		echo -e "\x1b[31munknown arg: $1\x1b[m"
		shift 1
	    fi
	    ;;
    esac
done

rm -fr $var_file
for (( i = 0 ; i < $var_cnt ;  i ++ )) ; do 
	printf "%03d t
	
awk 'BEGIN {i = 0; real=0.0; user=0.0; sys=0.0;} 
		{  
			real += $2; 
			user += $3; 
			sys  += $4; 
			i++;
		} 
		END { 
			printf("tot  %.3f  %.3f  %.3f\n", real, user, sys)
			printf("avg  %.3f  %.3f  %.3f\n", real/i, user/i, sys/i)
		}' $var_file
cat $var_file

rm -fr $var_file

# statics it 