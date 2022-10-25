#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "coreutils"
change_into_obj_directory

# Account for weird location of ncurses
# export CFLAGS="$CFLAGS -I$BUILDHOST_DEST/$PREFIX/include/ncurses"

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH
make_it
install_it
finish_it
