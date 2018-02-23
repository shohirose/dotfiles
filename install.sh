#!/bin/bash

# set -e
#
# unset tmp

atexit () {
    [ -n ${tmp-} ] && rm -rf "$tmp"
}

trap 'atexit; exit 1' SIGINT

# Set local dir
LOCAL_DIR=$HOME/.local

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
    # Create a file containing path to pkg-config under aclocal
    file="${LOCAL_DIR}/share/aclocal/dirlist"
    touch $file
    echo "$(which pkg-config)/share/aclocal" >> $file
fi

# echo ""
# echo "========================================================================"
# echo "checking libevent"
# result=$(find ${LOCAL_DIR}/bin -name "event_rpcgen.py")
# if [ -n "$result" ]; then
#     echo "libevent is already installed"
# else
#     echo "libevent not found"
#     echo "installing libevent"
#     (\
#         cd $tmp; \
#         wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
#         tar -zxvf libevent-2.1.8-stable.tar.gz && \
#         cd libevent-2.1.8-stable && \
#         ./configure --prefix=${LOCAL_DIR} --disable-static && \
#         make && \
#         make install \
#     )
# fi
#
# echo ""
# echo "========================================================================"
# echo "checking libgpg-error"
# result="$(which gpg-error)"
# if [ -n "$result" ]; then
#     echo "libgpg-error is already installed"
# else
#     echo "libgpg-error not found"
#     echo "installing libgpg-error"
#     (\
#         cd $tmp; \
#         wget https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.27.tar.bz2
#         tar -xvf libgpg-error-1.27.tar.bz2 && \
#         cd libgpg-error-1.27 && \
#         ./configure --prefix=${LOCAL_DIR} && \
#         make && \
#         make install \
#     )
# fi
# echo ""
#
# echo "========================================================================"
# echo "checking libgcrypt"
# result="$(which libgcrypt-config)"
# if [ -n "$result" ]; then
#     echo "libgcrypt is already installed"
# else
#     echo "libgcrypt not found"
#     echo "installing libgcrypt"
#     (\
#         cd $tmp; \
#         wget https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.2.tar.bz2
#         tar -xvf libgcrypt-1.8.2.tar.bz2 && \
#         cd libgcrypt-1.8.2 && \
#         ./configure --prefix=${LOCAL_DIR} && \
#         make && \
#         make install \
#     )
# fi

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
    tmp=$(mktemp -d ./tmp.XXXXXXXX)
    (\
        cd $tmp; \
        git clone https://github.com/powerline/fonts.git --depth=1 && \
        cd fonts && \
        ./install.sh \
    )
    echo "please change terminal font setting from [edit]>[profile setting]>[specifying font]"
    echo "e.g. Ubuntu Mono derivative Powerline Regular"
fi

echo ""
echo "========================================================================"
echo "checking minos-static"
if [ -d "${LOCAL_DIR}/src/minos-static" ]; then
    echo "minos-static is already installed"
else
    echo "minos-static not found"
    echo "downloading minos-static..."
    cd $HOME/.local/src
    git clone https://github.com/minos-org/minos-static.git
    MINOS_DIR=${LOCAD_DIR}/src/minos-static
    echo "please add $MINOS_DIR to PATH and source it"
fi

# Check if tmux is installed
# echo ""
# echo "========================================================================"
# echo "checking tmux"
# result=$(which tmux)
# if [ -n "$result" ]; then
#     echo "tmux is already installed"
# else
#     echo "tmux not found"
#     echo "installing tmux using minos-static..."
#     cd $MINOS_DIR
#     tar xvf tmux-1.9a.tar.xz
# fi

atexit
