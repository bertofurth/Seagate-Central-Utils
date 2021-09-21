#!/bin/bash
source ../build-common
source ../build-functions
export CXXFLAGS=$CXXFLAGS" -std=gnu++11"

# Check to see if libncurses.so has been downloaded
# from the Seagate Central.

# If you don't want to do this then read the instructions
# further below in this script for information about
# building your own version of ncurses.

if [ ! -f $SEAGATE_LIBS_BASE/usr/lib/libncurses.so ]; then
    echo
    echo "*************************"
    echo "*************************"
    echo "**       WARNING       **"
    echo "*************************"
    echo "*************************"
    echo
    echo "libncurses.so not found!!"
    echo
    echo "Did you download it from the Seagate Central as "
    echo "per the instructions in the README-screen.md file?? "
    echo
    echo "Read this script ($0) for more details."
    echo
    echo "Sleeping for 30 seconds before continuing."
    echo "Press Ctrl-c to interrupt and fix this problem."
    echo
    sleep 30
fi

# https://stackoverflow.com/questions/37475222/ncurses-6-0-compilation-error-error-expected-before-int
export CPPFLAGS=$CPPFLAGS" -P"

check_source_dir "ncurses"
change_into_obj_directory

# This works for ncurses v6 and above
configure_it --prefix=$PREFIX \
	     --host=$ARCH

#If using ncurses v5.x
#configure_it --prefix=$BUILDHOST_DEST/$PREFIX \
#	     --host=$ARCH

popd
#
# Install the headers only
#
make DESTDIR=$BUILDHOST_DEST install.includes
finish_it
exit 0


# If you want to actually build new ncurses
# libraries and utilities then remove the
# exit statement above and continue as follows...

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
# I've included the most common types here
mkdir -p $OBJ/$LIB_NAME/ncurses/
pushd $SRC/$LIB_NAME/ncurses
tinfo/MKfallback.sh /usr/share/terminfo \
		    ../misc/terminfo.src \
		    `which tic` \
		    `which infocmp` \
		    linux vt100 xterm xterm-256color screen dumb \
		    > $OBJ/$LIB_NAME/ncurses/fallback.c
popd
make_it
install_it
finish_it
