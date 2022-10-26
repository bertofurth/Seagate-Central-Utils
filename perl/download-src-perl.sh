#!/bin/sh
source ../common/download-common

# Run this script to download and extract the versions
# of source code this project was tested with. In general
# these are the latest stable versions at the time of
# writing.

# Download source files specific to this project
do_download https://github.com/arsv/perl-cross/releases/download/1.4/perl-cross-1.4.tar.gz
do_download https://www.cpan.org/src/5.0/perl-5.36.0.tar.gz

# Download common libraries
#../libs/download-src-ncurses.sh
