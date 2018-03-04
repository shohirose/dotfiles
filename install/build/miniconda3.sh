#!/bin/bash

echo ""
echo "========================================================================"
echo "Install miniconda (64bit)"

if [ -n "${INSTALL_DIR}" ]; then
    INSTALL_DIR="${HOME}/.local"
fi

echo ""
echo "Checking if miniconda is installed ..."
dir="$(which conda)"
if [ -n "${dir}" ]; then
    if [ $(echo ${dir} | grep -c -e "miniconda") -gt 0 ]; then
        echo "miniconda is already installed in ${dir}"
    elif [ $(echo ${dir} | grep -c -e "anaconda") -gt 0 ]; then
        echo "anaconda is already installed in ${dir}"
    else
        echo "Unknown conda installed in ${dir}"
    fi
    echo "$(conda --version)"
    exit 0
fi

echo "Neither miniconda nor anaconda found."
echo "Downloading miniconda3 for python 3.6 ..."
cd ${HOME}/Downloads
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    || ( echo "Download failed"; exit 1 )
bash Miniconda3-latest-Linux-x86_64.sh -b
export PATH="$HOME/miniconda3/bin:$PATH"
echo "Please add $HOME/miniconda3/bin to PATH"

exit 0


