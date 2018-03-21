#!/bin/bash

echo "========================================================================"
echo "Install OpenBLAS"

VERSION="0.2.20"
if [ -n "${INSTALL_DIR}" ]; then
    INSTALL_DIR="${HOME}/.local"
fi

echo ""
echo "library version  : ${VERSION}"
echo "install directory: ${INSTALL_DIR}"

cd ${HOME}/Downloads
wget http://github.com/xianyi/OpenBLAS/archive/v${VERSION}.tar.gz || \
    ( echo "Download failed"; exit 1 )

tar zxf v${VERSION}.tar.gz
cd OpenBLAS-${VERSION}
( make && make install PREFIX=${INSTALL_DIR} ) || \
    ( echo "Installation failed"; exit 1 )
