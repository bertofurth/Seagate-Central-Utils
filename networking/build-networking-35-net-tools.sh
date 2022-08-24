#!/bin/bash

source ../build-common
source ../build-functions

# Is there a pre-existing "net-tools-config.h" file for
# net-tools that can be used as the config.h?
#
# If not then the user will be prompted for information

CONFIG_H=net-tools-config.h

check_source_dir "net-tools"

if [  -r $TOP/$CONFIG_H ]; then
    echo "Copying $CONFIG_H to net-tools source directory"
    cp $TOP/$CONFIG_H $SRC/$LIB_NAME/config.h
else
    echo "***********************************************"
    echo "**************** WARNING **********************"
    echo "***********************************************"
    echo
    echo "No $CONFIG_H preconfigured config file found."
    echo "You may be prompted for information by the net-tools"
    echo "make process."
    echo
fi

# net tools doesn't build "out of tree" very well.
# change_into_obj_directory

# N.B There's no "configure" program for net-tools

export BASEDIR=$BUILDHOST_DEST/$PREFIX
#export BINDIR=$EXEC_PREFIX/bin
#export SBINDIR=$EXEC_PREFIX/sbin

make_it

# FYI net-tools puts the "man" pages in a weird place
# At usr/local/usr/share/man. It should get cleaned
# up by the trim script.
install_it
finish_it

