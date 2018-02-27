#!/bin/bash

# set -e
#

unset tmp

atexit () {
    [ -n ${tmp-} ] && rm -rf "$tmp"
}

trap 'atexit; exit 1' SIGINT

# Set local dir
LOCAL_DIR="${HOME}/.local"
SRC_DIR="${LOCAL_DIR}/src"
MINOS_DIR="${SRC_DIR}/minos-static"

# Create temp directory
tmp=$(mktemp -d ./tmp.XXXXXXXX)

# Create local src directory
mkdir -p ${LOCAL_DIR}/src

echo ""
echo "========================================================================"
echo "checking autoconf"
result="$(which autoconf)"
if [ -n "$result" ]; then
    echo "autoconf is already installed"
else
    echo "autoconf not found"
    echo "installing autoconf"
    (\
        cd $tmp; \
        wget https://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz && \
        tar -zxvf autoconf-2.69.tar.gz && \
        cd autoconf-2.69 && \
        ./configure --prefix=${LOCAL_DIR} && \
        make && \
        make install \
    )
fi

echo ""
echo "========================================================================"
echo "checking automake"
result=$(which automake)
if [ -n "$result" ]; then
    echo "automake is already installed"
else
    echo "automake not found"
    echo "installing automake"
    (\
        cd $tmp; \
        wget https://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz
        tar -zxvf automake-1.15.tar.gz && \
        cd automake-1.15 && \
        ./configure --prefix=${LOCAL_DIR} && \
        make && \
        make install \
    )
fi

# Check if powerline-shell is installed
echo ""
echo "========================================================================"
echo "checking powerline-shell"
count=$(pip list --format=columns | grep -c powerline-shell)
if [ $count != 0 ]; then
    echo "powerline-shell is already installed"
else
    echo "powerline-shell not found"
    echo "installing powerline-shell..."
    # pip install --user git+git://github.com/powerline/powerline
    pip install --user powerline-shell
    echo "installing powerline fonts..."
    (\
        cd $tmp; \
        git clone https://github.com/powerline/fonts.git --depth=1 && \
        cd fonts && \
        ./install.sh \
    )
    echo "please change terminal font setting from [Edit] > [Profile Preferences] > [Custom font]"
    echo "e.g. Ubuntu Mono derivative Powerline Regular"
fi

# Check if minos-static is installed
# This is for installing tmux
echo ""
echo "========================================================================"
echo "checking minos-static"
if [ -d "$MINOS_DIR" ]; then
    echo "minos-static is already installed at $MINOS_DIR"
else
    echo "minos-static not found"
    echo "downloading minos-static..."
    cd $SRC_DIR
    git clone https://github.com/minos-org/minos-static.git
    export PATH="${MINOS_DIR}/bin:$PATH"
    echo "please add ${MINOS_DIR}/bin to PATH in bashrc or basrh_profile"
fi

# Check if tmux is installed
echo ""
echo "========================================================================"
echo "checking tmux"
result=$(which tmux)
if [ -n "$result" ]; then
    echo "tmux is already installed"
else
    echo "tmux not found"
    echo "installing tmux using minos-static..."
    cd $MINOS_DIR
    ./static-get tmux
    tar xvf tmux-1.9a.tar.xz
fi

atexit
