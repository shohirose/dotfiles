#!/bin/bash

echo ""
echo "========================================================================"
echo "Install automake"

MAJOR=1
MINOR=15
VERSION="${MAJOR}.${MINOR}"
if [ -n "${INSTALL_DIR}" ]; then
    INSTALL_DIR="${HOME}/.local"
fi

echo ""
echo "library version  : ${VERSION}"
echo "install directory: ${INSTALL_DIR}"

echo ""
echo "Checking if automake is installed ..."
dir="$(which automake)"
if [ -n "${dir}" ]; then
    echo "automake is already installed in ${dir}"
    echo "$(automake --version | grep -e "^automake")"
    exit 0
fi

echo "automake not found. Downloading automake ..."
cd ${HOME}/Downloads
wget https://ftp.gnu.org/gnu/automake/automake-${VERSION}.tar.gz \
    || ( echo "Download failed"; exit 1 )

tar zxf automake-${VERSION}.tar.gz
cd automake-${VERSION}
( ./configure --prefix=${INSTALL_DIR} && make && make install ) \
    || ( echo "Installation failed"; exit 1 )

exit 0

