#!/usr/bin/env bash
backup_file=/media/$USER/data/data.tc 
if [ -e $backup_file ]
then
    truecrypt $backup_file $HOME/data
    dropbox start
    SpiderOak &
    source $HOME/.bashrc
else
    echo "$backup_file does not exist"
fi

