#!/bin/bash

echo ""
echo "========================================================================"
echo "Install autoconf"

MAJOR=2
MINOR=69
VERSION="${MAJOR}.${MINOR}"
if [ -n "${INSTALL_DIR}" ]; then
    INSTALL_DIR="${HOME}/.local"
fi

echo ""
echo "library version  : ${VERSION}"
echo "install directory: ${INSTALL_DIR}"

echo ""
echo "Checking if autoconf is installed ..."
dir="$(which autoconf)"
if [ -n "${dir}" ]; then
    echo "autoconf is already installed in ${dir}"
    echo "$(autoconf --version | grep -e "^autoconf")"
    exit 0
fi

echo "autoconf not found. Downloading autoconf ..."
cd ${HOME}/Downloads
wget https://ftp.gnu.org/gnu/autoconf/autoconf-${VERSION}.tar.gz \
    || ( echo "Download failed"; exit 1 )

tar zxf autoconf-${VERSION}.tar.gz
cd autoconf-${VERSION}
( ./configure --prefix=${INSTALL_DIR} && make && make install ) \
    || ( echo "Installation failed"; exit 1 )

exit 0
