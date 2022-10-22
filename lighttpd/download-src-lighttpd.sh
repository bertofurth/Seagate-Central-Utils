#!/bin/sh

# Run this script to download and extract the versions
# of source code this project was tested with. Unless
# otherwise noted these are the latest stable versions
# available at the time of writing.

# Based on gcc's download_prerequisites script

ncurses='http://mirrors.kernel.org/gnu/ncurses/ncurses-6.2.tar.gz'
gmp='http://mirrors.kernel.org/gnu/gmp/gmp-6.2.1.tar.xz'
nettle='http://mirrors.kernel.org/gnu/nettle/nettle-3.7.3.tar.gz'
readline='https://ftp.gnu.org/gnu/readline/readline-8.1.tar.gz'
lua='https://www.lua.org/ftp/lua-5.4.4.tar.gz'
lighttpd='https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-1.4.67.tar.xz'

echo_archives() {
    echo "${ncurses}"
    echo "${gmp}"
    echo "${nettle}"
    echo "${readline}"
    echo "${lua}"
    echo "${lighttpd}"
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
