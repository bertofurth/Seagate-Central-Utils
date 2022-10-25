#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "libwebp"
change_into_obj_directory
export LIBPNG_CONFIG=$BUILDHOST_DEST/$EXEC_PREFIX/bin
configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH 
make_it
install_it
finish_it
