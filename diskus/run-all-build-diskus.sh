!#/bin/bash
SECONDS=0
if ! type cargo > /dev/null ; then
    echo "Unable to find cargo. Has rust been installed?"
    echo "Exiting"
    exit -1
fi
cd src
LIB_NAME=$(ls -1drv diskus*/ | cut -f1 -d'/' | head -1)
if [ -z $LIB_NAME ]; then
    echo
    echo Unable to find source directory for diskus
    echo Has the source code been extracted\? \(tar -xf\)
    exit -1
fi
cd src/$LIB_NAME
cargo build --target arm-unknown-linux-gnueabi 
if [ $? -ne 0 ]; then
    echo
    echo cargo build for $LIB_NAME failed.
    echo Exiting \($SECONDS seconds\)
    exit -1
fi
mkdir -p cross/usr/local
cp src/$LIB_NAME/target/arm-unknown-linux-gnueabi/debug/discus cross/usr/local

echo
echo "****************************************"
echo
echo Success! Finished installing discus to cross/usr/local/ \($SECONDS seconds\)
echo
echo "****************************************"
echo
