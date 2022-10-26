#!/bin/bash
# libpcap is needed by dropwatch
source ../common/build-common
source ../common/build-functions
check_source_dir "libpcap"
change_into_obj_directory

# libnl headers needs to be included in this way
export CFLAGS="$CFLAGS -I$DESTDIR/$PREFIX/include/libnl3"

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH 
make_it
install_it
finish_it

