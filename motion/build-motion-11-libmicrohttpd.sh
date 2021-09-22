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

# Seagate Central doesn't properly support accept4().
# I can only guess the old version of libc installed
# on the Seagate Central doesn't implement it properly.
#
# If you don't manually disable libmicrohttpd from
# using accept4() then the server will not accept
# any connections.
#
sed -i "/HAVE_ACCEPT4/c #undef HAVE_ACCEPT4" $OBJ/$LIB_NAME/MHD_config.h

make_it
install_it
# Put libgnutls.la back
mv $BUILDHOST_DEST/$PREFIX/lib/libgnutls.la.orig $BUILDHOST_DEST/$PREFIX/lib/libgnutls.la
finish_it
