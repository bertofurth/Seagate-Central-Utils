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
# name and location of the cross compiling gcc
# and the required linker flags with
# "-C link-arg=" for each linker flag argument.
#
export CARGO_TARGET_ARM_UNKNOWN_LINUX_GNUEABI_LINKER=$TOOLS/$CC
export CARGO_TARGET_ARM_UNKNOWN_LINUX_GNUEABI_RUSTFLAGS="-C link-arg=--sysroot=$SYSROOT"

mkdir -p $LOG

cargo build --target arm-unknown-linux-gnueabi |& tee $LOG/"$NAME"_make.log
if [ $? -ne 0 ]; then
    echo
    echo cargo build for $LIB_NAME failed. See $LOG/"$NAME"_make.log
    echo Exiting \($SECONDS seconds\)
    exit -1
fi
echo cargo build for $LIB_NAME complete. See $LOG/"$NAME"_make.log

cd ..

# Copy the generated binary into the expected place
mkdir -p $BUILDHOST_DEST/$EXEC_PREFIX/bin
cp target/arm-unknown-linux-gnueabi/debug/diskus $BUILDHOST_DEST/$EXEC_PREFIX/bin/
finish_it
