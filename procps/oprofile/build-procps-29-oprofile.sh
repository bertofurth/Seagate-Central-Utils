#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "oprofile"

change_into_obj_directory
#
# libstdc++ on the Seagate Central is not
# recent enough for some of the oprofile tools
# so we are forced to link libstdc++ statically
export CXXFLAGS="-static-libstdc++ $CXXFLAGS"

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH
make_it V=1
install_it
finish_it
