#!/bin/bash
source ../build-common
source ../build-functions
check_source_dir "libtraceevent"
change_into_obj_directory

# Have to build from the source directory
check_source_dir "libtraceevent"

# No configure stage for libtraceevent
#configure_it

# Specify the directory to generate objects in
# using the O= flag
make_it prefix=$PREFIX \
	O=$OBJ/$LIB_NAME

# Need to define where pkgconfig files go otherwise
# they end up in the /usr/lib64 directory
install_it pkgconfig_dir=/usr/local/lib/pkgconfig libdir_relative=lib

finish_it
