# Identify OS and Machine
export OS=$(uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/')
export OSVERSION=`uname -r`; OSVERSION=`expr "$OSVERSION" : '[^0-9]*\([0-9]*\.[0-9]*\)'`
export MACHINE=`uname -m | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export PLATFORM="$MACHINE-$OS-$OSVERSION"

# set PATH
# home pc
if [ "$(hostname)" == "kashima" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi
# UT pc
if [ "$(hostname)" == "muse" ]; then
    PATH="$HOME/.local/src/minos-static/bin:$HOME/bin:$HOME/.local/bin:$HOME/Projects/global/bin/:$HOME/Projects/gmsh/bin:$HOME/Projects/paraview/bin:$HOME/Projects/MATLAB/R2017a/bin:$PATH"
fi

# set PATH to shared libraries
# LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.local/lib"

# Load in .bashrc
source $HOME/.bashrc

# Hello Message -----------------------------------
echo "Kernel Info: $(uname -smr)"
