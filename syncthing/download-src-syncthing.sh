#!/bin/sh
source ../common/download-common

# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

# Download source files specific to this project
do_download https://github.com/syncthing/syncthing/archive/refs/tags/v1.18.2.tar.gz

if [[ -n $SKIP_COMMON ]]; then
    exit 0
fi

# Download common libraries
