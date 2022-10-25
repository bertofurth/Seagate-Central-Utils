#!/bin/bash
source ../common/build-common
source ../common/build-functions
check_source_dir "screen"
change_into_obj_directory

# Account for weird location of ncurses
export CFLAGS="$CFLAGS -I$BUILDHOST_DEST/$PREFIX/include/ncurses"

# --enable-pam : Allow screen to be locked with the
#                user's password
# --with-sys-screenrc : Put the global screenrc in
#                       /etc/screenrc instead of the
#                       default /usr/local/etc/

configure_it --prefix=$PREFIX \
	     --bindir=$EXEC_PREFIX/bin \
	     --sbindir=$EXEC_PREFIX/sbin \
	     --host=$ARCH \
	     --enable-pam \
	     --with-sys-screenrc=/etc/screenrc
make_it
install_it
finish_it
