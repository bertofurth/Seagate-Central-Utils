#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "perl"
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
