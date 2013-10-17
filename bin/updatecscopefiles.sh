#!/bin/sh
find . -name "*.h" -o -name "*.hpp" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.cxx" > cscope.files
cscope -bkq -i cscope.files
exit 0