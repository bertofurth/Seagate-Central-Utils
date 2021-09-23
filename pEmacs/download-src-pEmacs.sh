#!/bin/sh

# Run this script to download and extract the versions
# of source code this project was tested with. Unless
# otherwise noted these are the latest stable versions
# available at the time of writing.

# Based on gcc's download_prerequisites script

ncurses='http://mirrors.kernel.org/gnu/ncurses/ncurses-6.2.tar.gz'

pEmacsgit='https://github.com/hughbarney/pEmacs.git'

echo_archives() {
    echo "${ncurses}"

}

echo_git() {
    echo "${pEmacsgit}"
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

if ! type git > /dev/null ; then
    die "Unable to find git!"
fi

for ar in $(echo_git)
do
	git clone "${ar}"    \
		 || die "Cannot git clone download $ar"
done
unset ar	  
