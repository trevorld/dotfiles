#!/usr/bin/env bash
function main {
    mount_data_partitions
    if [ -e $HOME/.bashrc ]
    then
        dropbox start
        SpiderOak &
        source $HOME/.bashrc
    fi
}

function mount_data_partitions {
    if [[ "$HOSTNAME" =~ "siductionbox" ]]
    then
        echo "Please enter root "
        ibus-daemon -dx
        bk_dir=/media/disk1part6
        su -c "mount /dev/sdb5 media; truecrypt -t -k '' --protect-hidden=no $bk_dir/data.tc $HOME/data"
    else
        sudo mount /dev/sdb5 media
        sudo mount /dev/sda6 /media/$USER/data
        backup_file=/media/$USER/data/data.tc 
        if [ -e $backup_file ]
        then
            truecrypt -t -k "" --protect-hidden=no $backup_file $HOME/data
        else
            echo "$backup_file does not exist"
        fi
    fi
}

main
