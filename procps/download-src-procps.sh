#!/bin/sh

# Run this script to download and extract the versions
# of source code this project was tested with. Unless
# otherwise noted these are the latest stable versions
# available at the time of writing.

# Based on gcc's download_prerequisites script

ncurses='http://mirrors.kernel.org/gnu/ncurses/ncurses-6.2.tar.gz'
procps='https://gitlab.com/procps-ng/procps/-/archive/v3.3.16/procps-v3.3.16.tar.bz2'
sysstat='http://pagesperso-orange.fr/sebastien.godard/sysstat-12.6.0.tar.xz'

libtraceevent='https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/snapshot/libtraceevent-1.6.2.tar.gz'
libtracefs='https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/snapshot/libtracefs-1.4.2.tar.gz'
tracecmd='https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/snapshot/trace-cmd-v3.1.2.tar.gz'

popt='http://ftp.rpm.org/popt/releases/popt-1.x/popt-1.18.tar.gz'
binutils='https://mirrors.kernel.org/gnu/binutils/binutils-2.39.tar.xz'
zlib='https://zlib.net/fossils/zlib-1.2.12.tar.gz'
oprofile='https://prdownloads.sourceforge.net/oprofile/oprofile-1.4.0.tar.gz'

echo_archives() {
    echo "${ncurses}"
    echo "${procps}"
    echo "${sysstat}"
    echo "${libtraceevent}"
    echo "${libtracefs}"
    echo "${tracecmd}"
#    echo "${popt}"
#    echo "${binutils}"
#    echo "${zlib}"
#    echo "${oprofile}"
}

die() {
    echo "error: $@" >&2
    exit 1
}

mkdir -p src
cd src

if type wget > /dev/null ; then
    fetch='wget'
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


