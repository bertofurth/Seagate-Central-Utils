#!/bin/bash
source ../common/build-common
source ../common/build-functions

check_source_dir "sysstat"

# sysstat doesn't seem to like building out of tree
#
# change_into_obj_directory

# Stops systat from creating a "lib64" directory
export sa_lib_dir=/usr/local/lib
configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --disable-documentation \
	     --disable-nls 
make_it
install_it
finish_it
