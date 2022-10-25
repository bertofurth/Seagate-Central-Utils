#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "zstd"

# No configure stage in zstd
#change_into_obj_directory
#configure_it --prefix=$PREFIX \
#	     --bindir=$EXEC_PREFIX/bin \
#	     --sbindir=$EXEC_PREFIX/sbin \
#	     --host=$ARCH

export TARGET_SYSTEM=linux
make_it
install_it
finish_it
