#!/bin/bash
source ../build-common
source ../build-functions
check_source_dir "x264"
change_into_obj_directory
configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --cross-prefix=$CROSS_COMPILE \
	     --host=arm-linux-gnueabi \
	     --enable-shared \
	     --enable-static 
make_it
install_it
finish_it
