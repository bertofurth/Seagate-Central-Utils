#!/bin/bash
# Prerequisites for lua
# readline

source ../common/build-common
source ../common/build-functions
check_source_dir "lua"
# no "configure" for lua
#change_into_obj_directory
#configure_it --prefix=$PREFIX \
#	     --eprefix=$EXEC_PREFIX

# The lua Makefile has an issue with the AR
# variable being preset.
#
# Using the "native" version of AR should be ok
unset AR

# All These flags are required because of the non
# standard nature of the lua build system.
# If you can do it more elegantly than this then
# please let us know.

make_it linux-readline CC="$CC" LDFLAGS="-L/$DESTDIR/$PREFIX/lib" MYLIBS="-lncurses"
install_it INSTALL_TOP="$DESTDIR/$PREFIX"
finish_it
