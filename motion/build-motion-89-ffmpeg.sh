#!/bin/bash
source ../build-common
source ../build-functions
check_source_dir "ffmpeg"
change_into_obj_directory

# TODO We need an av encoder
# Like mkv somewhere in here?
# Maybe sound as well

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --pkg-config=pkg-config \
	     --enable-cross-compile \
	     --target-os=linux \
	     --arch=$ARCH --cpu=armv6k \
	     --cross-prefix=$CROSS_COMPILE \
	     --enable-gpl \
	     --enable-version3 \
	     --enable-gmp \
	     --enable-gnutls \
	     --enable-libv4l2 \
	     --enable-libwebp \
	     --enable-libx264 \
	     --enable-shared \
	     --disable-doc

make_it
install_it
finish_it
