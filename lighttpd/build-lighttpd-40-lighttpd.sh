#!/bin/bash

# readline is needed by dropwatch

source ../build-common
source ../build-functions
check_source_dir "lighttpd"
change_into_obj_directory
export LUA_CFLAGS="${CFLAGS}"
export LUA_LIBS="${LDFLAGS}"
export XML_CFLAGS="${CFLAGS} -I$BUILDHOST_DEST/$PREFIX/include/libxml2"
# libtool has problems so we temporarily
# move the .la files in the cross directory
mkdir $OBJ/$LIB_NAME/la
mv -f $BUILDHOST_DEST/$PREFIX/lib/*.la $OBJ/$LIB_NAME/la/

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --with-gnutls \
	     --with-nettle \
	     --with-lua \
	     --with-pam \
	     --with-zstd \
	     --with-webdav-props

make_it

# Move the libtool files back
mv -f $OBJ/$LIB_NAME/la/*.la $BUILDHOST_DEST/$PREFIX/lib/
install_it
finish_it

