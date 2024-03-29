#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "p11-kit"
change_into_obj_directory

# --without-libffi : Disable foreign language functions.
# --without-systemd  : No systemd on Seagate Central

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --without-libffi \
	     --without-systemd
make_it
install_it
finish_it

