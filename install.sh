#!/bin/sh

set -e

unset tmp

atexit () {
    [ -n ${tmp-} ] && rm -rf "$tmp"
}

trap atexit EXIT
trap 'trap - EXIT; atexit; exit -1' INT PIPE TERM

# Set local dir
LOCAL_DIR=$HOME/.local

# Check if powerline-shell is installed
echo ""
echo "1. checking powerline-shell"
result=$(pip list --format=columns | grep powerline-shell)
if [ -n "$result" ]; then
    echo "   powerline-shell is already installed"
else
    echo "   powerline-shell not found"
    echo "   installing powerline-shell..."
    pip install --user git+git://github.com/powerline/powerline
    echo "   installing powerline fonts..."
    tmp=$(mktmp -d ./tmp.XXXXXXXX)
    (cd $tmp; git clone https://github.com/powerline/fonts.git --depth=1 && cd fonts && ./install.sh)
    echo "   please change terminal font setting from [edit]>[profile setting]>[specifying font]"
    echo "   e.g. Ubuntu Mono derivative Powerline Regular"
fi

# Check if tmux is installed
echo ""
echo "2. checking tmux"
result=$(which tmux)
if [ -n "$result" ]; then
    echo "   tmux is already installed"
else
    echo "   tmux not found"
    echo "   installing tmux..."
    mkdir -p ${LOCAL_DIR}/src
    (cd $LOCAL_DIR && ./autogen.sh && ./configure --prefix=${LOCAL_DIR} && make && make install)
fi

echo ""
