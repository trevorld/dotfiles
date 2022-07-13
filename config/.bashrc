export PATH=$PATH:$HOME/bin:$HOME/a/dotfiles/bin:$HOME/.local/bin:$HOME/.cabal/bin:$HOME/.cargo/bin
export PYTHONPATH=$PYTHONPATH:unit_tests

if [[ "$HOSTNAME" =~ "zareason-zu8330" ]]
then
    export DEV=/home/trading_game/development/cgi-bin
fi
if [[ "$HOSTNAME" =~ "fsi-pesd" ]]
then
    export DEV=/home/trading_game/development/cgi-bin
fi
if [[ "$HOSTNAME" =~ "stoic-sloth" ]]
then
    export XMODIFIERS="@im=fcitx"
    export QT_IM_MODULE=fcitx
    export GTK_IM_MODULE=fcitx
    export DEV=/home/trevorld/a/projects/trading_game/development/cgi-bin
fi

export HISTSIZE=10000
export SHELL=/bin/bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/lib
export EDITOR="/usr/bin/gvim"
export GIT_EDITOR="/usr/bin/gvim -f"
export COLUMNS

## Improve XDG standard compliance
export XDG_CACHE_HOME=${XDG_CACHE_HOME:=$HOME/.cache}
[ -d $XDG_CACHE_HOME ] || mkdir $XDG_CACHE_HOME
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}
[ -d $XDG_CONFIG_HOME ] || mkdir $XDG_CONFIG_HOME
export HISTFILE=$XDG_CACHE_HOME/bash/bash_history
[ -d "$XDG_CACHE_HOME/bash" ] || mkdir -p $XDG_CACHE_HOME/bash
export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc
export R_PROFILE_USER=$XDG_CONFIG_HOME/R/Rprofile
# export R_LIBS_USER=$XDG_CONFIG_HOME/R/%p-platform/%v
export R_HISTFILE=$XDG_CACHE_HOME/R/Rhistory
[ -d $XDG_CACHE_HOME/R ] || mkdir $XDG_CACHE_HOME/R
export TEXINPUTS=".:$XDG_CONFIG_HOME/latex:"
alias tmux="tmux -f ${XDG_CONFIG_HOME}/tmux/tmux.conf"
export TODOTXT_CFG_FILE=$XDG_CONFIG_HOME/todo/todo.cfg
[ -d $XDG_CONFIG_HOME/todo ] || mkdir $XDG_CONFIG_HOME/todo
source $XDG_CONFIG_HOME/todo/todo_completion
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
[ -d "$XDG_CACHE_HOME/vim" ] || mkdir -p $XDG_CACHE_HOME/vim

# alias anki="QT_XCB_FORCE_SOFTWARE_OPENGL=1 anki --base=${HOME}/a/sync/Dropbox/Anki"
if [[ "$HOSTNAME" =~ "fsi-pesd" ]]
then
    alias anki="anki --base=${HOME}/external/a/sync/Dropbox/Anki"
else
    alias anki="QT_XCB_FORCE_SOFTWARE_OPENGL=1 anki --base=${HOME}/a/sync/Dropbox/Anki"
fi
# alias anki_beta="QT_XCB_FORCE_SOFTWARE_OPENGL=1 ~/tmp/anki_beta/bin/anki --base=${HOME}/tmp/Anki"
alias ssh="ssh -X"
alias gvim="gvim -p"
alias vim="vim -p"
alias R="R --no-restore-data --no-save --quiet"
alias xstata="xstata-se"
alias rst2pdf="rst2pdf -s letter -l en_US.UTF-8 -s freetype-sans"
alias o="xdg-open"
alias pdfjoin="pdfjoin --paper letter"
alias rsync="rsync -avh --exclude=vms --exclude=*.swp --exclude=projects/trading_game/register_1.0 --exclude=projects/trading_game/development/WWW/records/independent"
# alias rsync="rsync -avh --exclude=sync/Dropbox --exclude=vms --exclude=*.swp --exclude=projects/trading_game/register_1.0 --exclude=projects/trading_game/development/WWW/records/independent"
alias rsync2="command rsync -rvl --size-only --omit-dir-times --no-perms -e 'ssh -p 2222' --exclude=*.swp --exclude=*.git"

PS1="\w\$ "

## Stuff in default .bashrc file
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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

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

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

PATH="/home/trevorld/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/trevorld/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/trevorld/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/trevorld/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/trevorld/perl5"; export PERL_MM_OPT;

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/trevor/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/trevor/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/trevor/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/trevor/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
