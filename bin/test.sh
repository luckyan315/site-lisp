#!/bin/bash

#TODO:  add getopt 
# usage :
#		./perf.sh -n 10  main
#		main : 
#				avg    real   ...   use ... sys ...
#				10 times   
#				1. real ... use ...  sys ...
#				2. real ... use ...  sys ...
#				3. real ... use ...  sys ...
#				4. real ... use ...  sys ...
#				5. real ... use ...  sys ...
#				6. real ... use ...  sys ...
#				7. real ... use ...  sys ...

cmd=ls
cnt=10
if [ "$1" ] ; then 
	cmd=$1
fi
FILE=log

rm -fr $FILE
for (( i = 0 ; i < $cnt ;  i ++ )) ; do 
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
		}' $FILE
cat $FILE

rm -fr $FILE

# statics it 