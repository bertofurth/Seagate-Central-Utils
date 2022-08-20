#!/bin/bash
source ../build-common
source ../build-functions

# Optional : Use Seagate Central specific ncurses library
# and stop from using libtinfo which doesn't exist
# on the Seagate Central.
# export NCURSES_LIBS=-l:libncurses.so.5.0.7

# Specify location of ncurses include header.
# This should work but it doesn't.
# export NCURSES_CFLAGS="$CFLAGS -I$BUILDHOST_DEST/$PREFIX/include/ncurses"
#
# export CFLAGS="$CFLAGS -I$BUILDHOST_DEST/$PREFIX/include/ncurses"

check_source_dir "procps"

# Generate configure script (unusual but procps needs this)
./autogen.sh

change_into_obj_directory

# undefined reference to `rpl_realloc' with arm
# https://github.com/openvenues/libpostal/issues/134
export ac_cv_func_malloc_0_nonnull=yes
export ac_cv_func_realloc_0_nonnull=yes

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH
make_it
install_it
finish_it
