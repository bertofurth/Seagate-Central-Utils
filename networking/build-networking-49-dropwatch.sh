#!/bin/bash

# libnml is needed by ethtool

source ../common/build-common
source ../common/build-functions
check_source_dir "dropwatch"
# Generate configure script (dropwatch needs this)
./autogen.sh
change_into_obj_directory
export READLINE_CFLAGS="$CFLAGS"
export READLINE_LIBS="$LDFLAGS -lreadline -lncurses"
export LIBNLG3_CFLAGS="$CFLAGS -I$BUILDHOST_DEST/$PREFIX/include/libnl3"


# Libtool files aren't accurate when they're on the
# building host so let's temporarily move them

mkdir $OBJ/$LIB_NAME/la
mv -f $BUILDHOST_DEST/$PREFIX/lib/*.la $OBJ/$LIB_NAME/la/

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --without-bfd \
	     --host=$ARCH 
make_it
install_it

# Move the libtool files back
mv -f $OBJ/$LIB_NAME/la/*.la $BUILDHOST_DEST/$PREFIX/lib/

finish_it

