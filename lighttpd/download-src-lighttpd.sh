#!/bin/sh
source ../common/download-common

# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

ncurses='http://mirrors.kernel.org/gnu/ncurses/ncurses-6.2.tar.gz'
gmp='http://mirrors.kernel.org/gnu/gmp/gmp-6.2.1.tar.xz'
nettle='http://mirrors.kernel.org/gnu/nettle/nettle-3.7.3.tar.gz'
readline='https://ftp.gnu.org/gnu/readline/readline-8.1.tar.gz'
lua='https://www.lua.org/ftp/lua-5.4.4.tar.gz'
zlib='https://zlib.net/fossils/zlib-1.2.13.tar.gz'
zstd='https://github.com/facebook/zstd/releases/download/v1.5.2/zstd-1.5.2.tar.gz'
pcre2='https://downloads.sourceforge.net/project/pcre/pcre2/10.37/pcre2-10.37.tar.bz2'
LinuxPAM='https://github.com/linux-pam/linux-pam/releases/download/v1.5.2/Linux-PAM-1.5.2.tar.xz'
libtasn1='http://mirrors.kernel.org/gnu/libtasn1/libtasn1-4.17.0.tar.gz'
gnutls='https://www.gnupg.org/ftp/gcrypt/gnutls/v3.7/gnutls-3.7.6.tar.xz'
sqlite='https://www.sqlite.org/2021/sqlite-autoconf-3360000.tar.gz'
libxml2='https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.10.3/libxml2-v2.10.3.tar.bz2'
lighttpd='https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-1.4.67.tar.xz'

echo_archives() {
    echo "${ncurses}"
    echo "${gmp}"
    echo "${nettle}"
    echo "${readline}"
    echo "${lua}"
    echo "${zlib}"
    echo "${zstd}"
    echo "${pcre2}"
    echo "${LinuxPAM}"
    echo "${libtasn1}"
    echo "${gnutls}"
    echo "${sqlite}"
    echo "${libxml2}"
    echo "${lighttpd}"
}

do_download $(echo_archives)
