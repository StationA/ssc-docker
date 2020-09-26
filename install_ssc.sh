#!/bin/sh

set -e

INSTALL_PREFIX=${INSTALL_PREFIX:-/usr}
BUILD_ROOT_DIR=${BUILD_ROOT_DIR:-/tmp}
SSC_VER="2020.2.29_Release"
SSC_DIR="$BUILD_ROOT_DIR/ssc-$SSC_VER"
CMAKE_DIR="$SSC_DIR/build"

UNAME_OUT="$(uname -s)"
case "${UNAME_OUT}" in
    Linux*)     PLATFORM=linux; PLATFORM_LIB=ssc.so; PLATFORM_LIB_DEST=libssc.so;;
    Darwin*)    PLATFORM=osx; PLATFORM_LIB=ssc.dylib; PLATFORM_LIB_DEST=ssc.dylib;;
    *)          echo "Unknown platform: ${UNAME_OUT}" && exit 1
esac

# Download source and unzip contents
OLDPWD=`pwd`
cd $BUILD_ROOT_DIR
wget -O ssc.zip https://github.com/NREL/ssc/archive/$SSC_VER.zip
unzip ssc.zip
rm ssc.zip
cd $OLDPWD

# Copy built libs to system directories
OLDPWD=`pwd`
cd $SSC_DIR

# Create a build directory for CMake
mkdir -p $CMAKE_DIR
cd $CMAKE_DIR

# Run the build
cmake -Dskip_tools=ON -Dskip_tests=ON -DCMAKE_BUILD_TYPE=Release ..
make -j4

mkdir -p $INSTALL_PREFIX/lib $INSTALL_PREFIX/include
cp $SSC_DIR/ssc/sscapi.h $INSTALL_PREFIX/include/sscapi.h
cp $CMAKE_DIR/ssc/$PLATFORM_LIB $INSTALL_PREFIX/lib/$PLATFORM_LIB_DEST
cd $OLDPWD

rm -rf $SSC_DIR
