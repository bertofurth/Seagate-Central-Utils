#!/bin/bash
# iproute2 - Latest version I can get to cross compile
# for Seagate Central with this script is v5.5

source ../build-common
source ../build-functions
check_source_dir "iproute2"

# iproute2 doesn't build "out of tree"
#change_into_obj_directory

# Need to define a few values that may not be included
# in older linux headers but are needed by iproute2.

export EXTRA_CFLAGS="-DMS_PRIVATE=262144 -DMS_REC=16384 -DCLOCK_BOOTTIME=7"

configure_it

export SBINDIR=$PREFIX/sbin
export DESTDIR=$BUILDHOST_DEST
make_it V=1
install_it
finish_it

