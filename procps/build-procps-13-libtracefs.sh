#!/bin/bash
source ../build-common
source ../build-functions
check_source_dir "libtracefs"
change_into_obj_directory

# Have to build from the source directory
check_source_dir "libtracefs"

# No configure stage for libtracefs
#configure_it

#
# CFLAGS adjustments needed to avoid compilation
# problems.
#
export CFLAGS="-DF_GETPIPE_SZ=1032 $CFLAGS -I$BUILDHOST_DEST/$PREFIX/include/traceevent"

# Specify the directory to generate objects in
# using the O= flag
make_it prefix=$PREFIX \
	pkgconfig_dir=$PKG_CONFIG_PATH \
	O=$OBJ/$LIB_NAME

# Need to define where pkgconfig files go otherwise
# they end up in the /usr/lib64 directory
install_it pkgconfig_dir=/usr/local/lib/pkgconfig
finish_it
