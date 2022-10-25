#!/bin/sh
source ../common/download-common

# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

# Download source files specific to this project
do_download


libtasn1='http://mirrors.kernel.org/gnu/libtasn1/libtasn1-4.17.0.tar.gz'
gnutls='https://www.gnupg.org/ftp/gcrypt/gnutls/v3.7/gnutls-3.7.6.tar.xz'
libgpgerror='https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.46.tar.bz2'
libassuan='https://gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.5.tar.bz2'
gpgme='https://gnupg.org/ftp/gcrypt/gpgme/gpgme-1.18.0.tar.bz2'
wget2='https://ftp.gnu.org/gnu/wget/wget2-2.0.1.tar.gz'

if [[ -n $SKIP_COMMON ]]; then
    exit 0
fi

# Download common libraries
../libs/download-src-zlib.sh
../libs/download-src-gmp.sh
../libs/download-src-nettle.sh
