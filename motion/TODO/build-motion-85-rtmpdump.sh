#!/bin/bash


# https://git.ffmpeg.org/rtmpdump.git
# Might be of benefit to have rtmpdump / librtmp
# If so, then add this build script to the list of
# scripts and modify the ffmpeg build script
# configure stage accordingly.
#
source ../build-common
source ../build-functions
check_source_dir "rtmpdump"

# No "out of tree" for rtmpdump
#change_into_obj_directory

# No "configure" stage for rtmpdump
#configure_it 


# These environment variables need
# to be set and exported 
#
export CROSS_COMPILE
export XCFLAGS=$CFLAGS
export XLDFLAGS=$LDFLAGS
export DESTDIR=$BUILDHOST_DEST/$EXEC_PREFIX/

make_it SYS=posix CRYPTO=GNUTLS 
install_it SYS=posix CRYPTO=GNUTLS
finish_it
