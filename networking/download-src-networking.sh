#!/bin/sh
source ../common/download-common

# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

# Download source files specific to this project
do_download https://downloads.es.net/pub/iperf/iperf-3.11.tar.gz
do_download https://netfilter.org/projects/libmnl/files/libmnl-1.0.5.tar.bz2
do_download https://mirrors.edge.kernel.org/pub/software/network/ethtool/ethtool-5.19.tar.xz
do_download https://downloads.sourceforge.net/project/net-tools/net-tools-2.10.tar.xz
do_download https://www.infradead.org/~tgr/libnl/files/libnl-3.2.25.tar.gz
do_download https://www.tcpdump.org/release/libpcap-1.10.1.tar.gz
do_download https://github.com/nhorman/dropwatch/archive/refs/tags/v1.5.4.tar.gz
do_download https://mirrors.edge.kernel.org/pub/linux/utils/net/iproute2/iproute2-5.5.0.tar.xz

if [[ -n $SKIP_COMMON ]]; then
    exit 0
fi

# Download common libraries
../libs/download-src-ncurses.sh
../libs/download-src-readline.sh
../libs/download-src-binutils.sh
