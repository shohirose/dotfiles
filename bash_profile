# Identify OS and Machine
export OS=$(uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/')
export OSVERSION=`uname -r`; OSVERSION=`expr "$OSVERSION" : '[^0-9]*\([0-9]*\.[0-9]*\)'`
export MACHINE=`uname -m | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export PLATFORM="$MACHINE-$OS-$OSVERSION"

# set PATH to shared libraries
# LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.local/lib"

# Set TMP/TMPDIR
if [ ! "$TMP" ]; then
    :
elif [ "$TEMP" ]; then
    export TMP=$TEMP
elif [ -w /tmp ]; then
    export TMP=/tmp
elif [ ~/.tmp ]; then
    export TMP=~/.tmp
else
    mkdir -p ~/.tmp
    export TMP=~/.tmp
fi

# Load in .bashrc
source $HOME/.bashrc

# Hello Message -----------------------------------
echo "Kernel Info: $(uname -smr)"
