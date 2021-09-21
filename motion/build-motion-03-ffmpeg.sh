#!/bin/bash
source ../build-common
source ../build-functions
check_source_dir "ffmpeg"
change_into_obj_directory
configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --enable-cross-compile \
	     --target-os=linux \
	     --arch=$ARCH --cpu=armv6k \
	     --cross-prefix=$CROSS_COMPILE \
	     --enable-shared \
	     --disable-doc 
make_it
install_it
finish_it
