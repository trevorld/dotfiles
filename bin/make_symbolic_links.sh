#!/usr/bin/bash
backup_dir=$HOME/data
for dir in Documents Music Pictures Videos projects src
do
    ln -s $backup_dir/SpiderOak/$dir $HOME/$dir
done

for dir in Dropbox .SpiderOak .dropbox
do
    ln -s $backup_dir/$dir $HOME/$dir
done
