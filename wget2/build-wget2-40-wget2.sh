#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "wget2"
change_into_obj_directory


mkdir $OBJ/$LIB_NAME/la
mv -f $BUILDHOST_DEST/$PREFIX/lib/*.la $OBJ/$LIB_NAME/la/

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --disable-nls \
	     --disable-doc
make_it
install_it

# Move the libtool files back
mv -f $OBJ/$LIB_NAME/la/*.la $BUILDHOST_DEST/$PREFIX/lib/

# Optional. Link wget to wget2. Why not??
ln wget2 $BUILDHOST_DEST/$PREFIX/bin/wget
finish_it

