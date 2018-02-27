# Identify OS and Machine
export OS=$(uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/')
export OSVERSION=`uname -r`; OSVERSION=`expr "$OSVERSION" : '[^0-9]*\([0-9]*\.[0-9]*\)'`
export MACHINE=`uname -m | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export PLATFORM="$MACHINE-$OS-$OSVERSION"

# set PATH

# Functions to add and remove paths
pathadd() {
    newelement="${1%/}"
    if [[ -d "$1" && $(echo $PATH | grep -E -c "(^|:)$newelement($|:)") -eq 0 ]]; then
        if [ "$2" = "after" ]; then
            PATH="${PATH}:${newelement}"
        else
            PATH="${newelement}:$PATH"
        fi
    fi
}

pathrm() {
    PATH="$(echo $PATH | sed -e "s;\(^\|:\)${1%/}\(:\|\$\);\1\2;g" -e 's;^:\|:$;;g' -e 's;::;:;g')"
}


# home pc
if [ "$(hostname)" = "kashima" ]; then
    # PATH="$HOME/anaconda3/bin:$HOME/.local/bin:$PATH"
    pathadd "$HOME/anaconda3/bin"
    pathadd "$HOME/.local/bin"
fi
# UT pc
if [ "$(hostname)" = "muse" ]; then
    # PATH="$HOME/anaconda3/bin:$HOME/.local/src/minos-static/bin:$HOME/.local/bin:$HOME/Projects/gmsh/bin:$HOME/Projects/paraview/bin:$HOME/Projects/MATLAB/R2017a/bin:$PATH"
    pathadd "$HOME/anaconda3/bin"
    pathadd "$HOME/.local/src/minos-static/bin"
    pathadd "$HOME/.local/bin"
    pathadd "$HOME/Projects/gmsh/bin"
    pathadd "$HOME/Projects/paraview/bin"
    pathadd "$HOME/Projects/MATLAB/R2017a/bin"
fi

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
