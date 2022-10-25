#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "libjpeg-turbo"
change_into_obj_directory

if ! type cmake > /dev/null ; then
    echo "Unable to find cmake. Has cmake been installed?"
    echo "Exiting"
    exit -1
fi

cmake -G"Unix Makefiles" -DCMAKE_INSTALL_PREFIX=$PREFIX \
      $SRC/$LIB_NAME
if [ $? -ne 0 ]; then
    echo
    echo cmake for $LIB_NAME failed. Exiting
    echo Make sure you have "cmake" installed on your
    echo build system.
    exit -1
fi

make_it
install_it
finish_it
