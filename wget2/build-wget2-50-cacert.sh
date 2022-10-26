#!/bin/bash
source ../common/build-common
source ../common/build-functions

# This script downloads the latest set of ca certificates
# as used by web browsers to authenticate web sites and then
# copies it to the appropriate location in the
# /etc/ssl/certs directory
#
# It doesn't build anything so it doesn't really use any
# of the functions in the build-functions include file.

SECONDS=0
ca='https://curl.se/ca/cacert.pem'

if type wget > /dev/null ; then
    fetch='wget --backups=1'
else
    if type curl > /dev/null; then
	fetch='curl -LO'
    else
	echo "Unable to find wget or curl"
    fi
fi

cd $SRC
${fetch} "${ca}"
if [[ $? -ne 0 ]]; then
    echo "Unable to fetch ${ca}"
    exit -1
fi

if [ -z $CA_NAME ]; then
    CA_NAME=$(ls -1drv cacert*.pem | cut -f1 -d'/' | head -1)
fi

if [ -z $CA_NAME ]; then
    echo
    echo Unable to find cacert.pem
    exit -1
fi

echo "Copying $CA_NAME into $DESTDIR/etc/cert/ssl/"
mkdir -p $DESTDIR/etc/cert/ssl/
cp $CA_NAME $DESTDIR/etc/cert/ssl/

echo
echo "****************************************"
echo
echo Success! $NAME finished installing $CA_NAME to $DESTDIR \($SECONDS seconds\)
echo
echo "****************************************"
echo


