#!/bin/bash
source ../build-common
source ../build-functions
check_source_dir "alsa-lib"
change_into_obj_directory
configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --enable-python2

# N.B. Seagate Central uses python 2

make_it
install_it
finish_it
