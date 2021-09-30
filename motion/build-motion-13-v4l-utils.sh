#!/bin/bash
source ../build-common
source ../build-functions
check_source_dir "v4l-utils"
change_into_obj_directory

#
# --disable-v4l-utils
# v4l-utils don't work on Seagate Central
# because the version of GLIBCXX on the unit
# is too old. If you decide to embed a later
# version of GLIBCXX then hopefully they will
# work.

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --disable-v4l-utils
make_it
install_it
finish_it
