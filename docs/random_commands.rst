create IP addresses after directly connecting two laptops by ethernet cord
---------------------------------------------------------------------------

On computer A (assuming wired connection is eth0 - use ``ip ad`` to check)::

    sudo ip ad add 10.0.0.10/24 dev eth0

On computer B::

    sudo ip ad add 10.0.0.20/24 dev eth0


rsync
-----

Bonobo to Stoic::

    rsync --dry-run -avh --progress --exclude=sync/Dropbox --delete -L 
    rsync  -avh --progress --exclude=sync/Dropbox --delete -L 
    rsync --dry-run -avh --progress --exclude=sync/Dropbox --delete -L ~/a/ trevorld@192.168.42.72:~/a
    
Stoic to Bonobo::

    rsync dry-run -avh --progress --exclude=sync/Dropbox --delete -K 
    rsync -avh --progress --exclude=sync/Dropbox --delete -K 
