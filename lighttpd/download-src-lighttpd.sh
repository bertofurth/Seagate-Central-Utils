#!/bin/sh
source ../common/download-common

# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

# Download source files specific to this project
do_download https://downloads.sourceforge.net/project/pcre/pcre2/10.37/pcre2-10.37.tar.bz2
do_download https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.10.3/libxml2-v2.10.3.tar.bz2
do_download https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-1.4.67.tar.xz

if [[ -n $SKIP_COMMON ]]; then
   exit 0	 
fi

# Download common libraries
../libs/download-src-ncurses.sh
../libs/download-src-gmp.sh
../libs/download-src-nettle.sh
../libs/download-src-readline.sh
../libs/download-src-lua.sh
../libs/download-src-zlib.sh
../libs/download-src-zstd.sh
../libs/download-src-Linux-PAM.sh
../libs/download-src-libtasn1.sh
../libs/download-src-gnutls.sh
../libs/download-src-sqlite.sh

