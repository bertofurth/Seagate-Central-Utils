#!/bin/bash
#
# ncurses on the Seagate Central is a little bit problematic
# in that it only supports a few terminal types. I'm sure this
# build script could be improved but it seems to work well
# for now.
#
source ../common/build-common
source ../common/build-functions

#If using ncurses 5.x
#export CXXFLAGS=$CXXFLAGS" -std=gnu++11"

# https://stackoverflow.com/questions/37475222/ncurses-6-0-compilation-error-error-expected-before-int
export CPPFLAGS=$CPPFLAGS" -P"

check_source_dir "ncurses"
change_into_obj_directory
configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --disable-database \
	     --with-fallbacks \
	     --without-cxx-binding \
	     --with-shared \
	     --with-normal \
	     --with-debug \
	     --without-manpages \
	     --enable-overwrite

# Generate embedded terminal definitions for
# the most basic of terminals.
# We've included the most common types here
# but you may wish to add others if you're
# getting "terminals database is inaccessible"
# messages when connecting to the target unit
# from your client and you don't wish to
# reconfigure your client to use one of the
# listed terminal types.
#
mkdir -p $OBJ/$LIB_NAME/ncurses/
pushd $SRC/$LIB_NAME/ncurses
tinfo/MKfallback.sh /usr/share/terminfo \
		    ../misc/terminfo.src \
		    `which tic` \
		    `which infocmp` \
		    linux vt100 vt102 xterm xterm-256color screen \
                    xterm-xfree86 ansi vt220 rxvt dumb \
		    > $OBJ/$LIB_NAME/ncurses/fallback.c
if [ $? -ne 0 ]; then
    echo
    echo Failed to generate $OBJ/$LIB_NAME/ncurses/fallback.c
    echo Check that ncurses utilities \"tic\" and \"infocmp\" are
    echo installed on this build system.
    exit -1
fi
popd
make_it
install_it

# This is a bit of a nasty hack. To stop subsequent builds
# from complaining about not being able to find libtinfo
# (which they don't need on the Seagate Central) we just
# link libtinfo to libncurses.
#
# The error message this addresses is
#
# ld: cannot find -ltinfo: No such file or directory
#
ln -s libncurses.so $BUILDHOST_DEST/$PREFIX/lib/libtinfo.so

finish_it
