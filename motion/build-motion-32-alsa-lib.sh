#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "alsa-lib"
change_into_obj_directory
configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --enable-python2

# If you want static libraries then add
# the following line to configure. alsa-lib
# won't let you build both shared and static
# at the same time!!
#
#	     --enable-static --disable-shared

# N.B. Seagate Central uses python 2 so we
# specify "--enable-python2"

make_it
install_it
finish_it
