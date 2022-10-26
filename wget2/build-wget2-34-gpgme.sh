#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "gpgme"
change_into_obj_directory
# Libtool files aren't accurate when they're on the
# building host so let's temporarily move them

mkdir $OBJ/$LIB_NAME/la
mv -f $DESTDIR/$PREFIX/lib/*.la $OBJ/$LIB_NAME/la/

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --disable-glibtest \
	     --disable-gpgconf-test \
	     --disable-gpg-test \
	     --disable-gpgsm-test \
	     --disable-g13-test
make_it
install_it

# Move the libtool files back
mv -f $OBJ/$LIB_NAME/la/*.la $DESTDIR/$PREFIX/lib/

finish_it

