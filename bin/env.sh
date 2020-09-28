SSC_VER="2020.2.29_Release"
ROOT_DIR=${ROOT_DIR:-$(pwd)}
SSC_DIR="$ROOT_DIR/ssc-$SSC_VER"
BUILD_DIR="$SSC_DIR/build"
INSTALL_PREFIX=${INSTALL_PREFIX:-/usr}
UNAME_OUT="$(uname -s)"
case "${UNAME_OUT}" in
    Linux*)     PLATFORM=linux; PLATFORM_LIB=ssc.so; PLATFORM_LIB_DEST=libssc.so;;
    Darwin*)    PLATFORM=osx; PLATFORM_LIB=ssc.dylib; PLATFORM_LIB_DEST=ssc.dylib;;
    *)          echo "Unknown platform: ${UNAME_OUT}" && exit 1
esac
