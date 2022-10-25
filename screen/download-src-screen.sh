#!/bin/sh
source ../common/download-common

# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

# Download source files specific to this project
do_download http://mirrors.kernel.org/gnu/screen/screen-4.8.0.tar.gz


if [[ -n $SKIP_COMMON ]]; then
    exit 0
fi

# Download common libraries
../libs/download-src-ncurses.sh
