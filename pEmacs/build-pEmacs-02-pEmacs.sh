#!/bin/bash
source ../build-common
source ../build-functions
check_source_dir "pEmacs"

# pEmacs doesn't support "out of tree" builds.
#change_into_obj_directory

# The makefile needs to be modified somewhat
# to work with this build system.

sed -i "/^CFLAGS=/c CFLAGS=\${CPPFLAGS} -Wall -O2" $SRC/$LIB_NAME/Makefile
sed -i "/^LFLAGS=/c LFLAGS=\${LDFLAGS} -lncurses" $SRC/$LIB_NAME/Makefile

# Account for weird location of ncurses
# export CFLAGS="$CFLAGS -I$BUILDHOST_DEST/$PREFIX/include/ncurses"

# No configure script for pEmacs
#configure_it --prefix=$PREFIX \
#	     --bindir=$EXEC_PREFIX/bin \
#	     --sbindir=$EXEC_PREFIX/sbin \
#	     --host=$ARCH

make_it

# pEmacs "make install" tries to install on the local host
# so we don't run that.
#install_it

# Copy the newly built binary "pe" to the destination dir

mkdir -p $BUILDHOST_DEST/$EXEC_PREFIX/bin
cp ./pe $BUILDHOST_DEST/$EXEC_PREFIX/bin
if [ $? -ne 0 ]; then
    echo
    echo Couldn\'t copy \"pe\" from $(pwd). Check build!
    echo Exiting \($SECONDS seconds\)
    exit -1
fi
finish_it

