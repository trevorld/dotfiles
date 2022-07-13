#!/bin/bash

UTILITIES_CONFIG_HOME=`pwd`

if hash kde4-config 2>/dev/null
then
    KDEHOME=`kde4-config --localprefix`
    mkdir --parents $KDEHOME/env
    file=source_bashrc.sh
    ln --symbolic --interactive $UTILITIES_CONFIG_HOME/.kde/env/$file $KDEHOME/env/$file
else
    true
fi

files=( .bashrc .vimrc .XCompose )
for file in ${files[@]}
do
    echo "Creating symbolic link for $HOME/$file"
    ln --symbolic --interactive $UTILITIES_CONFIG_HOME/$file $HOME/$file
done

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
if ! [ -d $XDG_CONFIG_HOME ]
then
    mkdir $XDG_CONFIG_HOME
    echo "Created $XDG_CONFIG_HOME"
fi

for file in $(ls .config)
do
    echo "Creating symbolic link for .config/$file"
    if ! [ -d $XDG_CONFIG_HOME/$file ]
    then
        ln --symbolic --interactive $UTILITIES_CONFIG_HOME/.config/$file $XDG_CONFIG_HOME/$file
    else
        echo "$XDG_CONFIG_HOME/$file is a directory"
    fi
done

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
if ! [ -d $XDG_DATA_HOME ]
then
    mkdir $XDG_DATA_HOME
    echo "Created $XDG_DATA_HOME"
fi

for file in $(ls .local/share)
do
    echo "Creating symbolic link for $XDG_DATA_HOME/$file"
    if ! [ -d $XDG_DATA_HOME/$file ]
    then
        ln --symbolic --interactive $UTILITIES_CONFIG_HOME/.local/share/$file $XDG_DATA_HOME/$file
    else
        echo "$XDG_DATA_HOME/$file is a directory"
    fi
done
