#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "trace-cmd"
change_into_obj_directory

# Have to build from the source directory
check_source_dir "trace-cmd"

# No configure stage for trace-cmd
#configure_it

# CFLAGS adjustments needed to avoid compilation
# problems. I should probably look further into
# the -D ones. I suspect they are needed because
# we are using glibc 2.11 (as used on the Central)
# which is ancient.
#
export CFLAGS="$CFLAGS -I$BUILDHOST_DEST/$PREFIX/include/traceevent \
       	       -I$BUILDHOST_DEST/$PREFIX/include/tracefs \
	       -DXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \
	       -DCLOCK_MONOTONIC_RAW=4 \
	       -DAF_VSOCK=40"

# Specify the directory to generate objects in
# using the O= flag
make_it prefix=$PREFIX \
	pkgconfig_dir=$PKG_CONFIG_PATH \
	O=$OBJ/$LIB_NAME

install_it
finish_it
