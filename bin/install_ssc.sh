#!/bin/bash

set -e

BASE_DIR=$(dirname "$0")
source $BASE_DIR/env.sh

# Copy built artifacts to install locations
mkdir -p $INSTALL_PREFIX/lib $INSTALL_PREFIX/include
cp $SSC_DIR/ssc/sscapi.h $INSTALL_PREFIX/include/sscapi.h
cp $BUILD_DIR/ssc/$PLATFORM_LIB $INSTALL_PREFIX/lib/$PLATFORM_LIB_DEST

# Clean up our mess
rm -rf $SSC_DIR
