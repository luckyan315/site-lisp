#!/bin/sh
find . -name "*.[chCHp]*" -print | etags -L - 
exit 0