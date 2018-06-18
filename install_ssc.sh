#!/bin/sh

set -e

INSTALL_PREFIX=${INSTALL_PREFIX:-/usr}
BUILD_DIR=${BUILD_DIR:-/tmp}
SSC_VER="1.0.4"
SSC_DIR="$BUILD_DIR/ssc-$SSC_VER"

UNAME_OUT="$(uname -s)"
case "${UNAME_OUT}" in
    Linux*)     PLATFORM=linux; PLATFORM_LIB=ssc.so; PLATFORM_LIB_DEST=libssc.so;;
    Darwin*)    PLATFORM=osx; PLATFORM_LIB=ssc.dylib; PLATFORM_LIB_DEST=ssc.dylib;;
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
cd $SSC_DIR/build_$PLATFORM
make -f Makefile-shared -j4
make -f Makefile-nlopt -j4
make -f Makefile-lpsolve -j4
make -f Makefile-solarpilot -j4
make -f Makefile-tcs -j4
make -f Makefile-ssc -j4
mkdir -p $INSTALL_PREFIX/lib $INSTALL_PREFIX/include
cp $SSC_DIR/ssc/sscapi.h $INSTALL_PREFIX/include/sscapi.h
cp $PLATFORM_LIB $INSTALL_PREFIX/lib/$PLATFORM_LIB_DEST
cd $OLDPWD

rm -rf $SSC_DIR
