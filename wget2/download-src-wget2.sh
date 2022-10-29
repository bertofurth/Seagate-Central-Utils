#!/bin/sh
source ../common/download-common

# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

# Download source files specific to this project
do_download https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.46.tar.bz2
do_download https://gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.5.tar.bz2
do_download https://gnupg.org/ftp/gcrypt/gpgme/gpgme-1.18.0.tar.bz2
do_download https://ftp.gnu.org/gnu/wget/wget2-2.0.1.tar.gz

if [[ -n $SKIP_COMMON ]]; then
    exit 0
fi

# Download common libraries
../libs/download-src-ncurses.sh
../libs/download-src-readline.sh
../libs/download-src-zlib.sh
../libs/download-src-gmp.sh
../libs/download-src-nettle.sh
../libs/download-src-libunistring.sh
../libs/download-src-libidn2.sh
../libs/download-src-libtasn1.sh
../libs/download-src-p11-kit.sh
../libs/download-src-gnutls.sh
