#!/bin/bash

#
# Make sure you have "tclsh" installed
#

source ../build-common
source ../build-functions
check_source_dir "libxml2"
# Generate configuration files but do not automatically
# run "configure"
NOCONFIGURE=1 ./autogen.sh
change_into_obj_directory
configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --without-python \
	     --with-readline=$BUILDHOST_DEST/$PREFIX/lib \
	     --with-zlib=$BUILDHOST_DEST/$PREFIX/lib
	     
make_it
install_it
finish_it
