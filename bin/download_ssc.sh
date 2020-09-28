#!/bin/bash

set -e

BASE_DIR=$(dirname "$0")
source $BASE_DIR/env.sh

# Download source and unzip contents
pushd $ROOT_DIR
wget -O ssc.zip https://github.com/NREL/ssc/archive/$SSC_VER.zip
unzip ssc.zip
rm ssc.zip
popd
