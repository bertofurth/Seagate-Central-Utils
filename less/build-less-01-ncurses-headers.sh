#!/bin/bash
source ../build-common
source ../build-functions

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
    echo installed on this system.
    exit -1
fi
popd
make_it
install_it
finish_it
