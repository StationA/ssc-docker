#!/bin/bash

set -e

BASE_DIR=$(dirname "$0")
source $BASE_DIR/env.sh

# Download source and unzip contents
pushd $ROOT_DIR
wget -O ssc.zip https://github.com/NREL/ssc/archive/$SSC_VER.zip
unzip ssc.zip

# Get rid of custom sys/time.h includes that break the build.
rm -fr $SSC_DIR/nlopt/sys

rm ssc.zip
popd
