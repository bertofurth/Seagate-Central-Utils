#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "procps"

# Generate configure script (unusual but procps needs this)
./autogen.sh

change_into_obj_directory

# undefined reference to `rpl_realloc' with arm
# https://github.com/openvenues/libpostal/issues/134
export ac_cv_func_malloc_0_nonnull=yes
export ac_cv_func_realloc_0_nonnull=yes

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH
make_it
install_it
finish_it
