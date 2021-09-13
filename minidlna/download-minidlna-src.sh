#!/bin/sh

# Run this script to download and extract the versions
# of source code this project was tested with. Unless
# otherwise noted these are the latest stable versions
# available at the time of writing.

# Based on gcc's download_prerequisites script

libexif='https://github.com/libexif/libexif/archive/refs/tags/libexif-0_6_22-release.tar.gz'
libjpeg='https://downloads.sourceforge.net/project/libjpeg-turbo/2.1.1/libjpeg-turbo-2.1.1.tar.gz'
zlib='https://zlib.net/zlib-1.2.11.tar.xz'
libid3tag='https://downloads.sourceforge.net/project/mad/libid3tag/0.15.1b/libid3tag-0.15.1b.tar.gz'
libogg='https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.tar.xz'
flac='https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.3.tar.xz'
libvorbis='https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.tar.xz'
sqlite='https://www.sqlite.org/2021/sqlite-autoconf-3360000.tar.gz'
ffmpeg='http://ffmpeg.org/releases/ffmpeg-4.4.tar.xz'
minidlna='https://downloads.sourceforge.net/project/minidlna/minidlna/1.3.0/minidlna-1.3.0.tar.gz'

echo_archives() {
    echo "${libexif}"
    echo "${libjpeg}"
    echo "${zlib}"
    echo "${libid3tag}"
    echo "${libogg}"
    echo "${flac}"
    echo "${libvorbis}"
    echo "${sqlite}"
    echo "${ffmpeg}"
    echo "${minidlna}"
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


