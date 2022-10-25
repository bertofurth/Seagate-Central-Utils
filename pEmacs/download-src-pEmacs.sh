#!/bin/sh
source ../common/download-common
# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

pEmacsgit='https://github.com/hughbarney/pEmacs.git'

echo_git() {
    echo "${pEmacsgit}"
}

mkdir -p src
cd src

if ! type git > /dev/null ; then
    die "Unable to find git!"
fi

for ar in $(echo_git)
do
    git clone "${ar}"    \
	|| die "Cannot git clone download $ar"
done
unset ar	  

if [[ -n $SKIP_COMMON ]]; then
    exit 0
fi

# Download common libraries
../libs/download-src-ncurses.sh
