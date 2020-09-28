#!/bin/bash

set -e

BASE_DIR=$(dirname "$0")
source $BASE_DIR/env.sh

# Enter the SSC root directory
pushd $SSC_DIR

# Create the build tree and build
mkdir -p $BUILD_DIR
pushd $BUILD_DIR
cmake -Dskip_tools=ON -Dskip_tests=ON -DCMAKE_BUILD_TYPE=Release $SSC_DIR
make -j4
popd

popd
