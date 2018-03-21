#!/bin/bash

echo ""
echo "========================================================================"
echo "Install cmake"

MAJOR=3
MINOR=10
REVISION=2
VERSION="${MAJOR}.${MINOR}.${REVISION}"
if [ -n "${INSTALL_DIR}" ]; then
    INSTALL_DIR="${HOME}/.local"
fi

echo ""
echo "library version  : ${VERSION}"
echo "install directory: ${INSTALL_DIR}"

echo ""
echo "Checking if cmake is installed ..."
dir="$(which cmake)"
if [ -n "${dir}" ]; then
    echo "cmake is already installed in ${dir}"
    echo "$(cmake --version | grep -e "^cmake")"
    exit 0
fi

echo "cmake not found. Downloading cmake ..."
cd ${HOME}/Downloads
wget https://cmake.org/files/v${MAJOR}.${MINOR}/cmake-${VERSION}.tar.gz \
    || ( echo "Download failed"; exit 1 )

tar zxf cmake-${VERSION}.tar.gz
cd cmake-${VERSION}
( ./configure --prefix=${INSTALL_DIR} && make && make install ) \
    || ( echo "Installation failed"; exit 1 )

exit 0

