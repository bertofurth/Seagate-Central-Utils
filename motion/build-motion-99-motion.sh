#!/bin/bash
source ../build-common
source ../build-functions
check_source_dir "motion"

#
# Needs to run autoreconf to generate a configure
# script.
#
autoreconf -fiv
if [ $? -ne 0 ]; then
    echo
    echo autoreconf failed for $SRC/$LIB_NAME
    echo
    exit -1
fi
change_into_obj_directory
configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --with-webp
make_it
install_it

# Copy sample "motion" configuration files included in
# this project to the default configuration directory.
mkdir -p $BUILDHOST_DEST/$PREFIX/etc/motion
cp $TOP/*.conf.sample $BUILDHOST_DEST/$PREFIX/etc/motion/

finish_it
