#!/bin/sh
source ../common/download-common

# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

# Download source files specific to this project
do_download https://gitlab.com/procps-ng/procps/-/archive/v3.3.16/procps-v3.3.16.tar.bz2
do_download http://pagesperso-orange.fr/sebastien.godard/sysstat-12.6.0.tar.xz
do_download https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/snapshot/libtraceevent-1.6.2.tar.gz
do_download https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/snapshot/libtracefs-1.4.2.tar.gz
do_download https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/snapshot/trace-cmd-v3.1.2.tar.gz

#do_download http://ftp.rpm.org/popt/releases/popt-1.x/popt-1.18.tar.gz
#do_download https://prdownloads.sourceforge.net/oprofile/oprofile-1.4.0.tar.gz'


if [[ -n $SKIP_COMMON ]]; then
    exit 0
fi

# Download common libraries
../libs/download-src-ncurses.sh
#../libs/download-src-zlib.sh
#../libs/download-src-binutils.sh
