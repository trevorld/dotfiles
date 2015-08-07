if [[ "$HOSTNAME" =~ "corn" ]]
then
    export PATH=/mnt/glusterfs/apps/stata12:$PATH:$HOME/bin:$HOME/utilities/bin
    #source /usr/sweet/etc/nag/nagasli.sh
    #export NAG_KUSARI_FILE=$HOME/Documents/license.lic
    export FRANKCLASS=/afs/.ir/class/gsbgen336/cgi-bin
    #eval `tclsh /mnt/glusterfs/software/free/modules/tcl/modulecmd.tcl sh autoinit`
else
    export PATH=$PATH:$HOME/bin:$HOME/utilities/bin
    statapath=$HOME/data/SpiderOak/apps/stata12
    [ -d "$statapath" ] && export PATH=$PATH:$statapath
fi

if [[ "$HOSTNAME" =~ "zareason-zu8330" ]]
then
    export DEV=/home/trading_game/development/cgi-bin
    export GSB=/home/trading_game/w15gsbgen336/WWW/records/stanford/W15-GSBGEN-336
fi

if [[ "$HOSTNAME" =~ "siductionbox" ]]
then
    #export GTK_IM_MODULE=ibus
    export XMODIFIERS=@im=ibus
    export QT_IM_MODULE=ibus
    export GTK_IM_MODULE=xim
fi

export HISTSIZE=10000
export SHELL=/bin/bash
export podcasts=$HOME/media/SpiderOak/Podcasts

# Improve XDG standard compliance
export XDG_CACHE_HOME=${XDG_CACHE_HOME:=$HOME/.cache}
[ -d $XDG_CACHE_HOME ] || mkdir $XDG_CACHE_HOME
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}
[ -d $XDG_CONFIG_HOME ] || mkdir $XDG_CONFIG_HOME

export HISTFILE=$XDG_CACHE_HOME/bash/bash_history
[ -d "$XDG_CACHE_HOME/bash" ] || mkdir -p $XDG_CACHE_HOME/bash

export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc

export MATLABPATH=$XDG_CONFIG_HOME/matlab

export R_PROFILE_USER=$XDG_CONFIG_HOME/R/Rprofile
export R_LIBS_USER=$XDG_CONFIG_HOME/R/%p-platform/%v
export R_HISTFILE=$XDG_CACHE_HOME/R/Rhistory
[ -d $XDG_CACHE_HOME/R ] || mkdir $XDG_CACHE_HOME/R

export TODOTXT_CFG_FILE=$XDG_CONFIG_HOME/todo/todo.cfg
[ -d $XDG_CONFIG_HOME/todo ] || mkdir $XDG_CONFIG_HOME/todo
source $XDG_CONFIG_HOME/todo/todo_completion

#export VIMINIT=$XDG_CONFIG_HOME/.vimrc
#export VIMPERATOR_INIT=$XDG_CONFIG_HOME/.vimperatorrc
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
[ -d "$XDG_CACHE_HOME/vim" ] || mkdir -p $XDG_CACHE_HOME/vim
export VIMPERATOR_INIT=":source $XDG_CONFIG_HOME/vimperator/vimperatorrc"
#export PENTADACTYL_INIT=":source $XDG_CONFIG_HOME/pentadactyl/pentadactylrc"
export TEXINPUTS=".:$XDG_CONFIG_HOME/latex:"

# export XDG_DATA_HOME=${XDG_DATA_HOME:=$HOME/.local/share}

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/lib
export EDITOR="/usr/bin/gvim"
export COLUMNS

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_colored_prompt=yes

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
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi
alias 2='todo.sh'
alias 2k='todo.sh kanban'
alias cdT='cd /opt/econ/projects/energy/trevorld'
alias keynes="ssh -X keynes.stanford.edu"
alias corn="ssh -X corn.stanford.edu"
alias ssh="ssh -X"
alias gvim="gvim -p"
alias vim="vim -p"
alias anki="anki --base=${HOME}/data/Dropbox/Anki"
alias xstata="env TMPDIR=${HOME}/media/tmp xstata-se"
alias rst2pdf="rst2pdf -s letter -l en_US.UTF-8 -s freetype-sans"
alias aiyo='eval $(thefuck $(fc -ln -1))' # 哎哟
alias o="xdg-open"

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
