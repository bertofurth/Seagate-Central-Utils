#!/bin/bash
source ../build-common
source ../build-functions
check_source_dir "gnutls"
change_into_obj_directory

# Tried to get rid of the thousands
# of warning messages during build saying
# 
# "warning: 'ASN1_TYPE' macro is deprecated, use 'asn1_node' instead."
#
# I expected the following to work but it didn't.
# export CPPFLAGS="$CPPFLAGS -Wno-cpp"

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --disable-doc \
	     --disable-cxx \
	     --disable-tools \
	     --disable-tests \
	     --enable-shared \
	     --enable-static \
	     --without-p11-kit \
	     --with-included-unistring \
	     --without-idn \
	     --enable-openssl-compatibility
make_it
install_it
finish_it

