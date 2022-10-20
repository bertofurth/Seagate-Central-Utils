#!/bin/sh

# Run this script to download and extract the versions
# of source code this project was tested with. Unless
# otherwise noted these are the latest stable versions
# available at the time of writing.

# Based on gcc's download_prerequisites script

#ncurses='http://mirrors.kernel.org/gnu/ncurses/ncurses-6.2.tar.gz'

zlib='https://zlib.net/fossils/zlib-1.2.13.tar.gz'
gmp='http://mirrors.kernel.org/gnu/gmp/gmp-6.2.1.tar.xz'
nettle='http://mirrors.kernel.org/gnu/nettle/nettle-3.7.3.tar.gz'
libtasn1='http://mirrors.kernel.org/gnu/libtasn1/libtasn1-4.17.0.tar.gz'
gnutls='https://www.gnupg.org/ftp/gcrypt/gnutls/v3.7/gnutls-3.7.6.tar.xz'
libgpg-error='https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.46.tar.bz2'
libassuan='https://gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.5.tar.bz2'
gpgme='https://gnupg.org/ftp/gcrypt/gpgme/gpgme-1.18.0.tar.bz2'
wget2='https://ftp.gnu.org/gnu/wget/wget2-2.0.1.tar.gz'

echo_archives() {
    echo "${zlib}"
    echo "${gmp}"
    echo "${nettle}"
    echo "${libtasn1}"
    echo "${gnutls}"
    echo "${libgpg-error}"
    echo "${libassuan}"
    echo "${gpgme}"
    echo "${wget2}"
}

die() {
    echo "error: $@" >&2
    exit 1
}

mkdir -p src
cd src

if type wget > /dev/null ; then
    fetch='wget --backups=1'
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
