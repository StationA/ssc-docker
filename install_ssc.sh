#!/bin/sh

set -e

INSTALL_PREFIX=${INSTALL_PREFIX:-/usr}
BUILD_DIR=${BUILD_DIR:-/tmp}
SSC_VER="1.0.4"
SSC_DIR="$BUILD_DIR/ssc-$SSC_VER"

UNAME_OUT="$(uname -s)"
case "${UNAME_OUT}" in
    Linux*)     PLATFORM=linux64; PLATFORM_LIB=ssc.so;;
    Darwin*)    PLATFORM=osx64; PLATFORM_LIB=ssc.dylib;;
    *)          echo "Unknown platform: ${UNAME_OUT}" && exit 1
esac

# Download source and unzip contents
OLDPWD=`pwd`
cd $BUILD_DIR
wget -O ssc.zip https://github.com/NREL/ssc/archive/v$SSC_VER.zip
unzip ssc.zip
rm ssc.zip
cd $OLDPWD

# Copy built libs to system directories
OLDPWD=`pwd`
cd $SSC_DIR/sdk-release
mkdir -p $INSTALL_PREFIX/lib $INSTALL_PREFIX/include
cp sscapi.h $INSTALL_PREFIX/include/sscapi.h
cp $PLATFORM/$PLATFORM_LIB $INSTALL_PREFIX/lib/libssc.so
cd $OLDPWD

rm -rf $SSC_DIR
