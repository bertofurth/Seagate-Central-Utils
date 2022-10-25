#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "minidlna"

# MiniDLNA 1.3.0 doesn't seem to build well "out
# of tree" so we build within the source directory.
#
#change_into_obj_directory

# If you want to link minidlna statically you need to
# add "--enable-static" to the configure options and
# a few extra libaries to the LIBS variable as per the
# commented out line below.
# Note that"-lm" must come last because it provides
# symbols needed by the other libraries. See
# https://stackoverflow.com/questions/45135/why-does-the-order-in-which-libraries-are-linked-sometimes-cause-errors-in-gcc
#
#export LIBS="-lswresample -ldl -lm"

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH 
#	     --enable-static
make_it
install_it
finish_it




