#!/bin/bash
source ../build-common
source ../build-functions
check_source_dir "mjpg-streamer"
change_into_obj_directory

# mjpeg-streamer from
# https://github.com/jacksonliam/mjpg-streamer
# is a low cpu streaming tool that allows a user
# to stream directly from a webcam. This can be built
# at any point after libjpeg-turbo has been built.
#
# Install on the Seagate Central by copying the binaries
# in the "cross" directory and the entire "mjpg-streamer-experimental"
# subdirectory as seen in the source code to the Seagate
# Central then running as an appropriate user
#
# mjpg_streamer --i "input_uvc.so -d /dev/video0" -o "output_http.so -p 8090 -w ./www"
#
# where "./www" is the "www" subdirectory of the
# mjpg-streamer-experimental directory.
#

if ! type cmake > /dev/null ; then
    echo "Unable to find cmake. Has cmake been installed?"
    echo "Exiting"
    exit -1
fi

cmake -G"Unix Makefiles" -DCMAKE_INSTALL_PREFIX=$PREFIX \
      $SRC/$LIB_NAME/mjpg-streamer-experimental
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
