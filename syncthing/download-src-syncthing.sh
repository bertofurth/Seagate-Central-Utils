#!/bin/sh

# Run this script to download and extract the versions
# of source code this project was tested with. Unless
# otherwise noted these are the latest stable versions
# available at the time of writing.

# Based on gcc's download_prerequisites script

syncthing='https://github.com/syncthing/syncthing/archive/refs/tags/v1.18.2.tar.gz'

echo_archives() {
    echo "${syncthing}"
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
