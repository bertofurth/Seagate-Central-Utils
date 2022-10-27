#!/bin/bash
source ../common/build-common
source ../common/build-functions

#
# Cross compiling perl is quite an unusual process
# See https://arsv.github.io/perl-cross/ for the details

TEMP_PERL_DIR=temp-perl
# First find the perl-cross- directory
# and save the location

check_source_dir "perl-cross"
PERL_CROSS_SRC=${SRC}/${LIB_NAME}
unset LIB_NAME

# Now find the actual perl-5 directory and
# save this location
check_source_dir "perl-5"
PERL_5_SRC=${SRC}/${LIB_NAME}
unset LIB_NAME

# Now create a new directory with the
# combined contents of the perl-5 source
# directory with perl-cross copied over it

# Copy the contents of the perl-cross
# directory over the top of the perl
# source directory.
mkdir -p ${SRC}/${TEMP_PERL_DIR}
check_source_dir ${TEMP_PERL_DIR}
# Clear out the directory. Build doesn't work
# well if there's stuff in there already
rm -rf ${SRC}/${TEMP_PERL_DIR}/*
echo Copying contents of ${PERL_5_SRC} to ${SRC}/${LIB_NAME}
cp -r ${PERL_5_SRC}/* .
echo Copying contents of ${PERL_CROSS_SRC} to ${SRC}/${LIB_NAME}
cp -r ${PERL_CROSS_SRC}/* .

# Build works better in tree
#change_into_obj_directory

#
# Configure options for perl-cross are a little
# non-standard.
#
# The arguments with -D are the same as those used by
# native Seagate Central perl
#
# Note that we specify an "otherlibdirs" as the location
# of the original perl modules installed on the Seagate
# Central
configure_it --prefix=$PREFIX \
	     --target=$ARCH \
	     --target-tools-prefix=$CROSS_COMPILE \
	     -des \
	     -Dmyhostname=localhost \
	     -Dperladmin=root@localhost \
	     -Dusethreads -Duseithreads 

#	     -Dotherlibdirs=/usr/lib/perl5/5.8.8 


make_it
install_it
finish_it
