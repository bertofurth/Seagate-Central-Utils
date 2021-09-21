#!/bin/bash
source ../build-common
source ../build-functions

if ! type cargo > /dev/null ; then
    echo "Unable to find cargo. Has rust been installed?"
    echo "Exiting"
    exit -1
fi

check_source_dir "diskus"
# Have to change into the "src" subdirectory
# of the extracted source.
cd src

#
# When building with Rust we need to supply the
# name and location of the gcc we wish to use
# as well as the linker flags we need to pass.
#
export CARGO_TARGET_ARM_UNKNOWN_LINUX_GNUEABI_LINKER=$TOOLS/$CC
export CARGO_TARGET_ARM_UNKNOWN_LINUX_GNUEABI_RUSTFLAGS="-C link-arg=--sysroot=$SYSROOT"


#       -C link-arg=-L$SYSROOT/lib \
#       -C link-arg=-L$SYSROOT/usr/lib \
#       -C link-arg=-Wl,-rpath-link=$SYSROOT/lib \
#       -C link-arg=-Wl,-rpath-link=$SYSROOT/usr/lib"

cargo build --target arm-unknown-linux-gnueabi

#      --config link-arg="-Wl,-rpath-link=$SYSROOT/lib" \
#      --config link-arg="-Wl,-rpath-link=$SYSROOT/usr/lib"

if [ $? -ne 0 ]; then
    echo
    echo cargo build for $LIB_NAME failed.
    echo Exiting \($SECONDS seconds\)
    exit -1
fi
cd ..

# Copy the generated binary into the expected place
mkdir -p $BUILDHOST_DEST/$EXEC_PREFIX
cp target/arm-unknown-linux-gnueabi/debug/diskus $BUILDHOST_DEST/$EXEC_PREFIX/
finish_it
