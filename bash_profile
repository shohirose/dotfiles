# Identify OS and Machine
export OS=$(uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/')
export OSVERSION=`uname -r`; OSVERSION=`expr "$OSVERSION" : '[^0-9]*\([0-9]*\.[0-9]*\)'`
export MACHINE=`uname -m | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export PLATFORM="$MACHINE-$OS-$OSVERSION"

# set PATH

# Functions to add and remove paths to a given environmental variable
# example: pathadd [env-name] [path-to-add] (after)
# Note that 'after' is optional. If 'after' is passed, the given path is put
# at the end of the given environmental variable.
pathadd() {
    envname=$1
    eval envpath='$'$envname
    newelement=${2%/}
    # Clean-up a successive colons (:::::::...)
    eval $envname="$(echo $envpath | sed -r -e 's;:{2,};:;g' -e 's;^:|:$;;g')"
    # Add new path
    if [[ -d "$2" && $(echo $envpath | grep -E -c "(^|:)$newelement($|:)") -eq 0 ]]; then
        if [ "$3" == "after" ]; then
            eval $envname="$envpath:$newelement"
        else
            eval $envname="$newelement:$envpath"
        fi
    fi
}

pathrm() {
    envname=$1
    eval envpath='$'$envname
    eval $envname="$(echo $envpath | sed -e "s;\(^\|:\)${2%/}\(:\|\$\);\1\2;g" -e 's;^:\|:$;;g' -e 's;::;:;g')"
}

# home pc
if [ "$(hostname)" == "kashima" ]; then
    pathadd PATH "$HOME/anaconda3/bin"
    pathadd PATH "$HOME/.local/bin"
fi
# UT pc
if [ "$(hostname)" == "muse" ]; then
    pathadd PATH "$HOME/anaconda3/bin"
    pathadd PATH "$HOME/.local/src/minos-static/bin"
    pathadd PATH "$HOME/.local/bin"
    pathadd PATH "$HOME/Projects/gmsh/bin"
    pathadd PATH "$HOME/Projects/paraview/bin"
    pathadd PATH "$HOME/Projects/MATLAB/R2017a/bin"
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
