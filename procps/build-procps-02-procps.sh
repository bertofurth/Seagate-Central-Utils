#!/bin/bash
source build-common
source build-functions
check_source_dir "procps"

# Generate configure script
./autogen.sh

change_into_obj_directory

# https://github.com/openvenues/libpostal/issues/134
export ac_cv_func_malloc_0_nonnull=yes
export ac_cv_func_realloc_0_nonnull=yes

# Make sure we don't try to include -ltinfo
# because we've embedded term defs inside ncurses
export NCURSES_LIBS=-lncurses

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH
make_it V=1 
install_it
finish_it
