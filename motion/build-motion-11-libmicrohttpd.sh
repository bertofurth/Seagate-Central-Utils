#!/bin/bash
source ../build-common
source ../build-functions
check_source_dir "libmicrohttpd"
change_into_obj_directory
#
# libgnutls.la seems to cause problems. Temporarily
# make it invisible.
mv $BUILDHOST_DEST/$PREFIX/lib/libgnutls.la $BUILDHOST_DEST/$PREFIX/lib/libgnutls.la.orig
configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH
make_it
install_it
# Put libgnutls.la back
mv $BUILDHOST_DEST/$PREFIX/lib/libgnutls.la.orig $BUILDHOST_DEST/$PREFIX/lib/libgnutls.la
finish_it
