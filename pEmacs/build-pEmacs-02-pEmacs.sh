#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "pEmacs"

# pEmacs doesn't support "out of tree" builds.
#change_into_obj_directory

# The makefile needs to be modified somewhat
# to work with this build system.

cp $SRC/$LIB_NAME/Makefile $SRC/$LIB_NAME/Makefile.orig
sed -i "/^CFLAGS=/c CFLAGS=\${CPPFLAGS} -Wall -O2" $SRC/$LIB_NAME/Makefile
sed -i "/^LFLAGS=/c LFLAGS=\${LDFLAGS} -lncurses" $SRC/$LIB_NAME/Makefile

# No configure script for pEmacs
#configure_it

make_it

# pEmacs "make install" tries to install on the local host
# so we don't run that.
#install_it

# Copy the newly built binary "pe" to the destination dir

mkdir -p $DESTDIR/$EXEC_PREFIX/bin
cp ./pe $DESTDIR/$EXEC_PREFIX/bin/
if [ $? -ne 0 ]; then
    echo
    echo Couldn\'t copy \"pe\" from $(pwd). Check build!
    echo Exiting \($SECONDS seconds\)
    exit -1
fi

# Link "emacs" to "pe". Why not?? I would be stunned if
# anyone actually put *real* emacs on a Seagate Central
ln -s pe $DESTDIR/$EXEC_PREFIX/bin/emacs

finish_it

