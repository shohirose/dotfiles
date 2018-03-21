#!/bin/bash

echo ""
echo "========================================================================"
echo "Install anaconda (64bit)"

if [ -n "${INSTALL_DIR}" ]; then
    INSTALL_DIR="${HOME}/.local"
fi

echo ""
echo "Checking if anaconda is installed ..."
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
echo "Downloading anaconda3 for python 3.6 ..."
cd ${HOME}/Downloads
wget https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh \
    || ( echo "Download failed"; exit 1 )
bash Anaconda3-5.1.0-Linux-x86_64.sh -b
export PATH="$HOME/anaconda3/bin:$PATH"
echo "Please add $HOME/anaconda3/bin to PATH"

exit 0



