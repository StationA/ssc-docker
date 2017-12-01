#!/bin/bash

set -e

INSTALL_PREFIX=${INSTALL_PREFIX:-/usr}
BUILD_DIR=${BUILD_DIR:-/tmp}
SSC_VER="d559121384ab5dbe9d0ed7bbab8e02aab19156c0"
SSC_DIR="$BUILD_DIR/ssc-$SSC_VER"

# Download source and unzip contents
# TODO: Use a proper release when it's available!
pushd $BUILD_DIR
wget -O ssc.zip https://github.com/NREL/ssc/archive/$SSC_VER.zip
unzip ssc.zip
rm ssc.zip
popd

# Build ssc core libs
pushd $SSC_DIR/build_linux
make -f Makefile-shared -j9
make -f Makefile-nlopt -j9
make -f Makefile-lpsolve -j9
make -f Makefile-solarpilot -j9
make -f Makefile-tcs -j9
make -f Makefile-ssc -j9
popd

# Copy built libs to system directories
mkdir -p $INSTALL_PREFIX/lib $INSTALL_PREFIX/include

cp $SSC_DIR/build_linux/ssc.so $INSTALL_PREFIX/lib/libssc.so
cp $SSC_DIR/ssc/sscapi.h $INSTALL_PREFIX/include/sscapi.h

rm -rf $SSC_DIR
