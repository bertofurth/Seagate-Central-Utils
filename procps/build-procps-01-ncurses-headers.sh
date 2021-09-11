#!/bin/bash
source build-common
source build-functions
export CXXFLAGS=$CXXFLAGS" -std=gnu++11"

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
