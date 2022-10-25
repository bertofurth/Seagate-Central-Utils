#!/bin/sh
source ../common/download-common

# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

# Download source files specific to this project
do_download http://download.savannah.gnu.org/releases/acl/acl-2.3.1.tar.xz
do_download http://mirrors.kernel.org/gnu/coreutils/coreutils-8.32.tar.xz

if [[ -n $SKIP_COMMON ]]; then
    exit 0
fi

# Download common libraries
../libs/download-src-gmp.sh



