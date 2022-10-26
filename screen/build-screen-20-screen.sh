#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "screen"
change_into_obj_directory
# --enable-pam : Allow screen to be locked with the
#                user's password
# --enable-colors256 : Why not? I like colors!
# --with-sys-screenrc : Put the global screenrc in
#                       /etc/screenrc instead of the
#                       default /usr/local/etc/
configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --enable-pam \
	     --enable-colors256 \
	     --with-sys-screenrc=/etc/screenrc
make_it
install_it
finish_it
