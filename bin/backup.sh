#!/usr/bin/env bash
if [[ "$HOSTNAME" =~ "siductionbox" ]]
then
    true
else
    backup_file=/media/$USER/data/data.tc 
    if [ -e $backup_file ]
    then
        truecrypt $backup_file $HOME/data
    else
        echo "$backup_file does not exist"
    fi
fi
if [ -e $HOME/.bashrc ]
then
    dropbox start
    SpiderOak &
    source $HOME/.bashrc
fi

