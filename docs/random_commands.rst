create IP addresses after directly connecting two laptops by ethernet cord
---------------------------------------------------------------------------

On computer A (assuming wired connection is eth0 - use ``ip ad`` to check)::

    sudo ip ad add 10.0.0.10/24 dev eth0

On computer B::

    sudo ip ad add 10.0.0.20/24 dev eth0


rsync
-----

Bonobo to Stoic::

    rsync --dry-run -avh --progress --exclude=sync/Dropbox --exclude=vms --delete -L 
    rsync  -avh --progress --exclude=sync/Dropbox --exclude=vms --delete -L 
    rsync --dry-run -avh --progress --exclude=sync/Dropbox --exclude=vms --delete -L ~/a/ trevorld@192.168.42.72:~/a | tee ~/a/tmp/sync.txt
    rsync -avh --progress --exclude=sync/Dropbox --exclude=vms --delete -L ~/a/ trevorld@192.168.42.72:~/a | tee ~/a/tmp/sync.txt
    
Stoic to Bonobo::

    rsync --dry-run -avh --progress --exclude=sync/Dropbox --exclude=vms --delete -K trevorld@192.168.42.72:~/a/ ~/a | tee ~/a/tmp/sync.txt

    rsync -avh --progress --exclude=sync/Dropbox --delete --exclude=vms -K  trevorld@192.168.42.72:~/a/ ~/a | tee ~/a/tmp/sync.txt

MTP (Android)::

    rsync --dry-run --verbose --progress --omit-dir-times --no-perms --recursive --inplace --delete ~/a/media/ebooks/ToRead .
    rsync  --verbose --progress --omit-dir-times --no-perms --recursive --inplace --delete ~/a/media/ebooks/ToRead .

    rsync --dry-run --verbose --progress --omit-dir-times --no-perms --recursive --inplace --delete ~/a/media/music .
    rsync --verbose --progress --omit-dir-times --no-perms --recursive --inplace --delete ~/a/media/music .

    # Start sshelper
    rsync -avh --dry-run --size-only --progress --omit-dir-times --no-perms --delete -e 'ssh -p 2222' ~/a/media/music/ 192.168.42.65:SDCard/music
    rsync -avh --dry-run --size-only --progress --omit-dir-times --no-perms --delete -e 'ssh -p 2222' ~/a/media/ebooks/ToRead/ 192.168.42.65:SDCard/ToRead
