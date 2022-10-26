#!/bin/bash
source ../common/build-common
source ../common/build-functions

# First find the perl-cross- directory
# and save the location

check_source_dir "perl-cross"
PERL_CROSS_SRC=${SRC}/${LIB_NAME}
unset LIB_NAME

# Now find the actual perl-5 directory
check_source_dir "perl-5"

# Copy the contents of the perl-cross
# directory over the top of the perl
# source directory.

cp -r $PERL_CROSS_SRC/* ${SRC}/${LIB_NAME}/

change_into_obj_directory

#
# N.B. Configure options for perl-cross are a little
# non-standard.
#
configure_it --prefix=$PREFIX \
	     --target=$ARCH \
	     --target-tools-prefix=$CROSS_COMPILE
make_it
install_it
finish_it
