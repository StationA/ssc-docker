#!/bin/bash

set -e

INSTALL_PREFIX="/usr/local"
SSC_VER="de6cd48031d45f18e35a6df677b2e6c97d029103"
SSC_DIR="$PWD/ssc-$SSC_VER"

# Download source, verify md5, and unzip contents
# TODO: Use a proper release when it's available!
wget -O ssc.zip https://github.com/NREL/ssc/archive/$SSC_VER.zip
echo "60ea7e2820b14496ceef59c3d51506a2  ssc.zip" > checksum && md5sum -c checksum
unzip ssc.zip

# Apply source patches
pushd $SSC_DIR
curl https://github.com/bje-/ssc/commit/c8ed260fb44e325bed553b0bb139da39183bfcef.patch | git apply
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
mkdir -p /usr/local/lib /usr/local/include

cp $SSC_DIR/build_linux/ssc.so $INSTALL_PREFIX/lib/libssc.so
cp $SSC_DIR/ssc/sscapi.h $INSTALL_PREFIX/include/sscapi.h

rm -rf ssc.zip $SSC_DIR
