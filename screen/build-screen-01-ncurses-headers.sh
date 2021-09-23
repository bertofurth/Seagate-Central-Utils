#!/bin/bash
source ../build-common
source ../build-functions

#export CXXFLAGS=$CXXFLAGS" -std=gnu++11"

# Check to see if libncurses.so has been downloaded
# from the Seagate Central.

# It's better if it is, but if you really don't want
# to then we'll build a version locally.

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
    echo "per the instructions in the README-myutil.md file?? "
    echo
    echo "Copy /usr/lib/libncurses.so.5.0.7 on the Seagate Central to"
    echo "$SC-LIBS/usr/lb/libncurses.so on the build host."
    echo
    echo "If you don't want to download it then this script will "
    echo "automatically build a new version....so no big deal I guess."
    echo
    echo "Sleeping for 10 seconds before continuing."
    echo 
    echo "Press Ctrl-c to interrupt."
    echo
    sleep 10
fi

# https://stackoverflow.com/questions/37475222/ncurses-6-0-compilation-error-error-expected-before-int
export CPPFLAGS=$CPPFLAGS" -P"

check_source_dir "ncurses"
change_into_obj_directory

# This works for ncurses v6 and above

#If using ncurses v6.x
#configure_it --prefix=$PREFIX \
#	     --host=$ARCH  ......

#If using ncurses v5.x BERTO DELME
#configure_it --prefix=$BUILDHOST_DEST/$PREFIX \
#	     --host=$ARCH ......

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

if [ -f $SEAGATE_LIBS_BASE/usr/lib/libncurses.so ]; then
    # Install the headers only
    #
    make DESTDIR=$BUILDHOST_DEST install.includes
    finish_it
    echo 
    echo NOTE : Installed ncurses headers only!
    echo
    exit 0
fi

# Here we proceed to build ncurses libraries.

# Generate embedded terminal definitions for
# the most basic of terminals.
# I've included the most common types here
# but you may wish to add others if you're
# getting "terminals database is inaccessible"
# messages when using the target unit.
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
popd
make_it
install_it
finish_it
echo
echo NOTE Installed ncurses full library!
