# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
if [ "$OS" == "linux" ]; then
    alias ls='ls --color=auto' GREP_COLOR='1;32'
#    export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rb=90'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ==============================================================================
# OpenFOAM settings
# ==============================================================================
if [[ $(hostname) == "muse" ]]; then
    # source $HOME/foam/foam-extend-3.2/etc/bashrc
    # source $HOME/foam/geo32/etc/bashrc
    alias fe32='cd $HOME/foam/foam-extend-3.2/etc/bashrc'
    alias geo='cd $HOME/foam/geo32/'
    alias gsrc='cd $HOME/foam/geo32/src'
    alias gtut='cd $HOME/foam/geo32/tutorials'
    alias fedebug='export WM_COMPILE_OPTION=Debug; source $HOME/.bash_profile'
    alias feopt='export WM_COMPILE_OPTION=Opt; source $HOME/.bash_profile'
fi

# ==============================================================================
# Terminal settings
# ==============================================================================

# Set directory colors for ls command
# eval `dircolors $HOME/.dir_colors -b`

# Replace rm command with trash-put
# Download trash-cli from github
if type trash-put &> /dev/null
then
    alias rm=trash-put
fi

# # Set Paths
# # For .pc files
# PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$HOME/include/googletest/build
# export PKG_CONFIG_PATH

# Alias
alias ll='ls -l'
alias lla='ls -la'
# Set terminal size
COLS=85
ROWS=60
alias rs='resize -s $ROWS $COLS > /dev/null'

# # Setup some colors to use later in interactive shell or scripts
# export COLOR_NC='\033[0m' # No Color
# export COLOR_WHITE='\033[1;37m'
# export COLOR_BLACK='\033[0;30m'
# export COLOR_BLUE='\033[0;34m'
# export COLOR_LIGHT_BLUE='\033[1;34m'
# export COLOR_GREEN='\033[0;32m'
# export COLOR_LIGHT_GREEN='\033[1;32m'
# export COLOR_CYAN='\033[0;36m'
# export COLOR_LIGHT_CYAN='\033[1;36m'
# export COLOR_RED='\033[0;31m'
# export COLOR_LIGHT_RED='\033[1;31m'
# export COLOR_PURPLE='\033[0;35m'
# export COLOR_LIGHT_PURPLE='\033[1;35m'
# export COLOR_BROWN='\033[0;33m'
# export COLOR_YELLOW='\033[1;33m'
# export COLOR_GRAY='\033[1;30m'
# export COLOR_LIGHT_GRAY='\033[0;37m'
# alias colorslist="set | egrep 'COLOR_\w*'"  # lists all the colors

# -----------------------------------------------------------------------------
# Set paths
# -----------------------------------------------------------------------------

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
    pathadd PATH "$HOME/ThirdParty/ParaView/bin"
    pathadd PATH "$HOME/Projects/cmake/bin"
fi
# UT pc
if [ "$(hostname)" == "muse" ]; then
    pathadd PATH "$HOME/anaconda3/bin"
    pathadd PATH "$HOME/.local/bin"
    pathadd PATH "$HOME/Projects/MATLAB/R2017a/bin"
    pathadd PATH "$HOME/.local/texlive/2017/bin/x86_64-linux"
    pathadd MANPATH "$HOME/.local/texlive/2017/texmf-dist/doc/man"
    pathadd INFOPATH "$HOME/.local/texlive/2017/texmf-dist/doc/info"
fi

alias untar="tar -zxf"

# Powerline Shell settings
result=$(pip list --format=columns | grep powerline-shell)
if [ -n "$result" ]; then
    function _update_ps1() {
        PS1="$(~/.local/bin/powerline-shell $?)"
    }

    if [[ "$TERM" != "linux" && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
fi

export LS_COLORS='di=01;35'
