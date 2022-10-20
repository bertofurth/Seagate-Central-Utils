#!/bin/sh

# Run this script to download and extract the versions
# of source code this project was tested with. Unless
# otherwise noted these are the latest stable versions
# available at the time of writing.

# Based on gcc's download_prerequisites script

gmp='http://mirrors.kernel.org/gnu/gmp/gmp-6.2.1.tar.xz'
acl='http://download.savannah.gnu.org/releases/acl/acl-2.3.1.tar.xz'
coreutils='http://mirrors.kernel.org/gnu/coreutils/coreutils-8.32.tar.xz'

echo_archives() {
    echo "${gmp}"
    echo "${acl}"
    echo "${coreutils}"
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


