#!/bin/sh
source ../common/download-common

# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

# Download source files specific to this project

do_download https://downloads.sourceforge.net/project/libjpeg-turbo/2.1.1/libjpeg-turbo-2.1.1.tar.gz
do_download http://ffmpeg.org/releases/ffmpeg-4.4.tar.xz
do_download https://download.osgeo.org/libtiff/tiff-4.3.0.tar.gz
do_download https://download.sourceforge.net/libpng/libpng-1.6.37.tar.xz
do_download https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.2.1.tar.gz
do_download http://mirrors.kernel.org/gnu/libmicrohttpd/libmicrohttpd-0.9.73.tar.gz
do_download https://www.alsa-project.org/files/pub/lib/alsa-lib-1.2.5.tar.bz2
do_download https://www.linuxtv.org/downloads/v4l-utils/v4l-utils-1.20.0.tar.bz2
do_download https://code.videolan.org/videolan/x264/-/archive/stable/x264-stable.tar.bz2
do_download https://github.com/Motion-Project/motion/archive/refs/tags/release-4.3.2.tar.gz

if [[ -n $SKIP_COMMON ]]; then
    exit 0
fi

# Download common libraries
../libs/download-src-zlib.sh
../libs/download-src-gmp.sh
../libs/download-src-nettle.sh
../libs/download-src-libunistring.sh
../libs/download-src-libidn2.sh
../libs/download-src-libtasn1.sh
../libs/download-src-p11-kit.sh
../libs/download-src-gnutls.sh
