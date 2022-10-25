#!/bin/bash
source ../common/build-common
source ../common/build-functions

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

mkdir -p $LOG
# Perform the build
go run build.go -goos linux -goarch arm build |& tee $LOG/"$NAME"_make.log
if [ $? -ne 0 ]; then
    echo
    echo go build for $LIB_NAME failed. See $LOG/"$NAME"_make.log
    echo Exiting \($SECONDS seconds\)
    exit -1
fi
echo make for $LIB_NAME complete. See $LOG/"$NAME"_make.log

# Copy the generated binary into the expected place
mkdir -p $BUILDHOST_DEST/$EXEC_PREFIX/sbin
cp syncthing $BUILDHOST_DEST/$EXEC_PREFIX/sbin
finish_it
