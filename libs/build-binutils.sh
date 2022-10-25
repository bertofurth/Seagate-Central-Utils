#!/bin/bash

# TODO. Can we just build the headers and not install the
# libraries and binaries? I don't think we need the
# binaries.

source ../common/build-common
source ../common/build-functions
check_source_dir "binutils"
change_into_obj_directory
configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH 
make_it
install_it
finish_it

