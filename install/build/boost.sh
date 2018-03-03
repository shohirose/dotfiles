#!/bin/bash

echo ""
echo "========================================================================"
echo "Install boost"

MAJOR=1
MINOR=66
REVISION=0
VERSION_DIR="${MAJOR}.${MINOR}.${REVISION}"
VERSION_NUM="${MAJOR}_${MINOR}_${REVISION}"
if [ -n "${INSTALL_DIR}" ]; then
    INSTALL_DIR="${HOME}/.local"
fi

echo ""
echo "library version  : ${VERSION_NUM}"
echo "install directory: ${INSTALL_DIR}"

cd ${HOME}/Downloads
wget https://dl.bintray.com/boostorg/release/${VERSION_DIR}/source/boost_${VERSION_NUM}.tar.gz \
    || ( echo "Download failed"; exit 1 )

tar zxf boost_${VERSION_NUM}.tar.gz
cd boost_${VERSION_NUM}
./b2 --prefix=${INSTALL_DIR} install || ( echo "Installation failed"; exit 1 )
