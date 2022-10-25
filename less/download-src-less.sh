#!/bin/sh
source ../common/download-common

# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

# Download source files specific to this project
do_download http://mirrors.kernel.org/gnu/less/less-590.tar.gz

# Download common libraries
../libs/download-src-ncurses.sh
