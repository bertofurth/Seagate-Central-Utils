#!/bin/bash

# readline is needed by dropwatch

source ../build-common
source ../build-functions
check_source_dir "lighttpd"
change_into_obj_directory
configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH
# --with-nettle

make_it
install_it
finish_it
