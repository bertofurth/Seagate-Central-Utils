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

cp src/pEmacs/search.c src/pEmacs/search.c.orig
patch src/pEmacs/search.c ./0001-pEmacs-Optional-Arrow-exit-search.patch
checkerr

cp src/pEmacs/main.c src/pEmacs/main.c.orig
patch src/pEmacs/main.c ./0002-pEmacs-Optional-Save-on-exit.patch
checkerr


