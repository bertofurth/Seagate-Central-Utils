#!/bin/bash

# libnml is needed by ethtool

### I CANT GET THIS TO WORK

exit 0

source ../build-common
source ../build-functions
check_source_dir "dropwatch"
# Generate configure script (dropwatch needs this)
./autogen.sh
change_into_obj_directory
export READLINE_CFLAGS=$CFLAGS
export READLINE_LIBS=$LDFLAGS
export LIBNLG3_CFLAGS="$CFLAGS -I$BUILDHOST_DEST/$PREFIX/include/libnl3"

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH 
make_it
install_it
finish_it

