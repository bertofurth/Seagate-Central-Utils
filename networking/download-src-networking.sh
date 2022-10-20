#!/bin/sh

# Run this script to download and extract the versions
# of source code this project was tested with. Unless
# otherwise noted these are the latest stable versions
# available at the time of writing.

# Based on gcc's download_prerequisites script

ncurses='http://mirrors.kernel.org/gnu/ncurses/ncurses-6.2.tar.gz'

iperf3='https://downloads.es.net/pub/iperf/iperf-3.11.tar.gz'

libnml='https://netfilter.org/projects/libmnl/files/libmnl-1.0.5.tar.bz2'
ethtool='https://mirrors.edge.kernel.org/pub/software/network/ethtool/ethtool-5.19.tar.xz'

nettools='https://downloads.sourceforge.net/project/net-tools/net-tools-2.10.tar.xz'

libnl='https://www.infradead.org/~tgr/libnl/files/libnl-3.2.25.tar.gz'
readline='https://ftp.gnu.org/gnu/readline/readline-8.1.tar.gz'
libpcap='https://www.tcpdump.org/release/libpcap-1.10.1.tar.gz'

binutils='https://mirrors.kernel.org/gnu/binutils/binutils-2.39.tar.xz'
dropwatch='https://github.com/nhorman/dropwatch/archive/refs/tags/v1.5.4.tar.gz'

iproute2='https://mirrors.edge.kernel.org/pub/linux/utils/net/iproute2/iproute2-5.5.0.tar.xz'

echo_archives() {
    echo "${ncurses}"

    echo "${iperf3}"

    echo "${libnml}"
    echo "${ethtool}"
    
    echo "${nettools}"

    echo "${libnl}"
    echo "${readline}"
    echo "${libpcap}"
    echo "${binutils}"
    echo "${dropwatch}"

    echo "${iproute2}"
}

echo_git() {
    echo ""
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

if ! type git > /dev/null ; then
    die "Unable to find git!"
fi

for ar in $(echo_git)
do
	git clone "${ar}"    \
		 || die "Cannot git clone download $ar"
done
unset ar	  
