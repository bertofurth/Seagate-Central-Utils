#!/bin/sh
# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

# Download source files specific to this project

do_download https://github.com/sharkdp/diskus/archive/refs/tags/v0.6.0.tar.gz

if [[ -n $SKIP_COMMON ]]; then
    exit 0
fi

# Download common libraries

# No common lbraries for diskus
