#!/bin/bash

# binutils headers are needed by dropwatch

# TODO. I think we only need "libiberty" and
# "libbfs" so can we just build and install them?
# Note the "--enable-install-libiberty" flag

source ../build-common
source ../build-functions
check_source_dir "binutils"
change_into_obj_directory
configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH --enable-install-libiberty
make_it
install_it
finish_it

