#!/bin/sh

# Run this script to download and extract the versions
# of source code this project was tested with. Unless
# otherwise noted these are the latest stable versions
# available at the time of writing.

# Based on gcc's download_prerequisites script

libjpegturbo='https://downloads.sourceforge.net/project/libjpeg-turbo/2.1.1/libjpeg-turbo-2.1.1.tar.gz'
zlib='https://zlib.net/zlib-1.2.11.tar.xz'
ffmpeg='http://ffmpeg.org/releases/ffmpeg-4.4.tar.xz'
tiff='https://download.osgeo.org/libtiff/tiff-4.3.0.tar.gz'
libpng='https://download.sourceforge.net/libpng/libpng-1.6.37.tar.xz'
libwebp='https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.2.1.tar.gz'
gmp='http://mirrors.kernel.org/gnu/gmp/gmp-6.2.1.tar.xz'
nettle='http://mirrors.kernel.org/gnu/nettle/nettle-3.7.3.tar.gz'
libtasn1='http://mirrors.kernel.org/gnu/libtasn1/libtasn1-4.17.0.tar.gz'
gnutls='https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.16.tar.xz'
libmicrohttpd='http://mirrors.kernel.org/gnu/libmicrohttpd/libmicrohttpd-0.9.73.tar.gz'
alsalib='https://www.alsa-project.org/files/pub/lib/alsa-lib-1.2.5.tar.bz2'
v4lutils='https://www.linuxtv.org/downloads/v4l-utils/v4l-utils-1.20.0.tar.bz2'
motion='https://github.com/Motion-Project/motion/archive/refs/tags/release-4.3.2.tar.gz'

echo_archives() {
    echo "${libjpegturbo}"
    echo "${zlib}"
    echo "${ffmpeg}"
    echo "${tiff}"
    echo "${libpng}"
    echo "${libwebp}"
    echo "${gmp}"
    echo "${nettle}"
    echo "${libtasn1}"
    echo "${gnutls}"
    echo "${libmicrohttpd}"
    echo "${alsalib}"
    echo "${v4lutils}"
    echo "${motion}"
}

die() {
    echo "error: $@" >&2
    exit 1
}

mkdir -p src
cd src

if type wget > /dev/null ; then
    fetch='wget'
else
    if type curl > /dev/null; then
	fetch='curl -LO'
    else
	die "Unable to find wget or curl"
    fi    
fi


for ar in $(echo_archives)
do
	${fetch} "${ar}"    \
		 || die "Cannot download $ar"
        tar -xf "$(basename ${ar})" \
		 || die "Cannot extract $(basename ${ar})"
done
unset ar


