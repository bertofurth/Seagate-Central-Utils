#!/bin/bash
source ../build-common
source ../build-functions

if ! type go > /dev/null ; then
    echo "Unable to find go. Has go been installed?"
    echo "Exiting"
    exit -1
fi

check_source_dir "syncthing"

# We need to let "go" use the system's native gcc
# and not the cross compiler. Therefore we have to
# unset the CC variable configured by "build-common"
# script which is pointing at the cross compiling
# version.
#
unset CC

# Perform the build
go run build.go -goos linux -goarch arm build
if [ $? -ne 0 ]; then
    echo
    echo go build for $LIB_NAME failed.
    echo Exiting \($SECONDS seconds\)
    exit -1
fi

# Copy the generated binary into the expected place
mkdir -p $BUILDHOST_DEST/$EXEC_PREFIX/sbin
cp syncthing $BUILDHOST_DEST/$EXEC_PREFIX/sbin
finish_it
