#!/bin/sh
source ../common/download-common
ncurses='http://mirrors.kernel.org/gnu/ncurses/ncurses-6.2.tar.gz'


echo_archives() {
    echo "${ncurses}"
}

do_download $(echo_archives)
