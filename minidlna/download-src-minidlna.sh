#!/bin/sh
source ../common/download-common

# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

# Download source files specific to this project
do_download https://github.com/libexif/libexif/archive/refs/tags/libexif-0_6_22-release.tar.gz
do_download https://downloads.sourceforge.net/project/libjpeg-turbo/2.1.1/libjpeg-turbo-2.1.1.tar.gz
do_download https://zlib.net/fossils/zlib-1.2.12.tar.gz
do_download https://downloads.sourceforge.net/project/mad/libid3tag/0.15.1b/libid3tag-0.15.1b.tar.gz
do_download https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.tar.xz
do_download https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.3.tar.xz
do_download https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.tar.xz
do_download https://www.sqlite.org/2021/sqlite-autoconf-3360000.tar.gz
do_download http://ffmpeg.org/releases/ffmpeg-4.4.tar.xz
do_download https://downloads.sourceforge.net/project/minidlna/minidlna/1.3.0/minidlna-1.3.0.tar.gz

if [[ -n $SKIP_COMMON ]]; then
    exit 0
fi

# Download common libraries
../libs/download-src-zlib.sh
../libs/download-src-sqlite.sh
