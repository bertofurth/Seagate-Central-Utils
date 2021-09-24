#!/bin/bash
#
# Apply patches
checkerr()
{
    if [ $? -ne 0 ]; then
	echo " Failure to appy patch! Halting"
	exit 1
    fi
}

patch src/pEmacs/search.c ./0001-pEmacs-Optional-Arrow-exit-search.patch
checkerr
patch src/pEmacs/main.c ./0002-pEmacs-Optional-Save-on-exit.patch
checkerr


