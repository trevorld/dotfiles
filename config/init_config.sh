#!/bin/bash

# config_original="$HOME/tmp/config_backup"
# config=$HOME/projects/utilities/config
UTILITIES_CONFIG_HOME=$HOME/utilities/config/

files=( .bashrc .hgrc )
#        $(echo $(ls -A .config) | sed -e "s,^\| , .config/,g") )
for file in $files
do
    ln --symbolic --interactive $UTILITIES_CONFIG_HOME/$file $HOME/$file
done

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
if ! [ -d $XDG_CONFIG_HOME ]
then
    mkdir $XDG_CONFIG_HOME
    echo "Created $XDG_CONFIG_HOME"
fi

# HT Kerrek SB
# http://stackoverflow.com/questions/9795538/bash-script-to-loop-through-subdirectories-and-create-symlinks-to-all-files 
UTILITIES_XDG_CONFIG_HOME=$UTILITIES_CONFIG_HOME/.config
cd "$UTILITIES_XDG_CONFIG_HOME"
find -type d -exec mkdir --parents -- "$XDG_CONFIG_HOME"/{} \;
find -type f -exec ln --symbolic --interactive -- "$UTILITIES_XDG_CONFIG_HOME"/{} "$XDG_CONFIG_HOME"/{} \;
