#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "wget2"
change_into_obj_directory


mkdir $OBJ/$LIB_NAME/la
mv -f $DESTDIR/$PREFIX/lib/*.la $OBJ/$LIB_NAME/la/

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --disable-nls \
	     --disable-doc
make_it
install_it

# Move the libtool files back
mv -f $OBJ/$LIB_NAME/la/*.la $DESTDIR/$PREFIX/lib/

# Optional. Link wget to wget2. The native version
# on the Seagate Central is pretty useless because
# it doesn't do https.
ln -s wget2 $DESTDIR/$PREFIX/bin/wget
finish_it

