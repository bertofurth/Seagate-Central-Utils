#!/bin/bash
source ../build-common
source ../build-functions

check_source_dir "sysstat"

# sysstat doesn't seem to like building out of tree
#
# change_into_obj_directory

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --disable-documentation \
	     --disable-nls

# Sysstat seem to want to install some stuff to a "lib64"
# directory which might be fine for the building system
# but the Seagate Central is a 32 bit target so we need
# to use the "lib" directory.
#
# Check if the "lib64" directory already exists.
#
if [[ -d $BUILDHOST_DEST/$PREFIX/lib64/ ]]; then
    LIB64_ALREADY_EXISTS=1
    echo
    echo pre-existing lib64 sub directory detected in $BUILDHOST_DEST/$PREFIX/
    echo
fi

make_it
install_it

# sysstat seems to want to install stuff to "lib64"

#

if [[ -d $BUILDHOST_DEST/$PREFIX/lib64/sa ]]; then
    echo
    echo Moving sysstat binaries from lib64 to lib
    echo
    rsync -r $BUILDHOST_DEST/$PREFIX/lib64/sa $BUILDHOST_DEST/$PREFIX/lib/sa
    rm -rf $BUILDHOST_DEST/$PREFIX/lib64/sa
fi

# If "lib64" existed before building sysstat then leave it alone
# but if it was created only by building sysstat then delete it.
#

if [[ -n $LIB64_ALREADY_EXISTS ]]; then
    echo Deleting empty lib64 directory
    rm -rf $BUILDHOST_DEST/$PREFIX/lib64
fi

finish_it
