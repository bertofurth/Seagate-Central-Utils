#!/bin/sh

# Run this script to download and extract the versions
# of source code this project was tested with. Unless
# otherwise noted these are the latest stable versions
# available at the time of writing.

# Based on gcc's download_prerequisites script

ncurses='http://mirrors.kernel.org/gnu/ncurses/ncurses-6.2.tar.gz'
procps='https://gitlab.com/procps-ng/procps/-/archive/v3.3.16/procps-v3.3.16.tar.bz2'
sysstat='http://pagesperso-orange.fr/sebastien.godard/sysstat-12.6.0.tar.xz'

echo_archives() {
    echo "${ncurses}"
    echo "${procps}"
    echo "${sysstat}"
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


