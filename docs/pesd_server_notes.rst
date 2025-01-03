~~~~~~~~~~~~~~~~~~~~~~~
PESD Linux Server notes
~~~~~~~~~~~~~~~~~~~~~~~

PESD has one Ubuntu Linux servers:

fsi-pesd.stanford.edu
    This newer server (Ubuntu 22.04 LTS) has 256GB of memory, 1 CPU processor with 32 cores, and 2TB+4TB NVMe hard drives.

    The server has Gurobi_, Knitro_, and Stata_ as well as numerous open source tools such as R_, Python, Bash, etc.

.. contents::

Intro
~~~~~

Logging in
----------

One can log onto the server using SSH using your provided username and password.  Mac and Linux computers have SSH built in.  If you are on one of those systems or you have installed a Unix environment with SSH on Windows (such as the one provided by Cygwin_) then open up a terminal and login in::

  bash$ ssh -X username@fsi-pesd.stanford.edu

And then enter your password at the prompt.  If you are not connected to PESD's ethernet network then you'll first need to VPN_ onto Stanford's network.

Stanford Itservices also provides instructions for logging on via SSH_ on Windows in various ways such as SecureCRT (if you don't care about graphics) or Xming_ (if you want graphics).

It is possible to `set up SSH keys`_ such that you do not need to enter a password to login to the server.  These keys can also be used by many programs used to copy files over to the server (i.e. scp and rsync).

.. _VPN: http://itservices.stanford.edu/service/vpn/
.. _SSH: https://itservices.stanford.edu/service/sharedcomputing/loggingin
.. _Cygwin: http://cygwin.com/
.. _Xming: http://www.straightrunning.com/XmingNotes/
.. _set up SSH keys: https://wiki.archlinux.org/index.php/SSH_Keys#Generating_an_SSH_key_pair

Setting up Cygwin on Windows so you can use GUIs on the server
--------------------------------------------------------------

Grab the Cygwin_ installer and follow the directions.  When choosing which additional packages to install choose ``xinit``, ``openssh``, and ``mintty`` (which is better than xterm since you can scroll and also copy/paste).

After ``xinit`` has been installed you should be able to start X-windows and an xterm by running a program called "Cygwin-X" in the Windows Programs menu.  In the xterm launch ``mintty.exe`` (this is step is optional but recommended).  Then in the mintty shell login using ``ssh -X`` with your username as above.  Some users have experienced trouble with ``ssh -X`` but experienced success using the less secure ``ssh -Y``.  After you have logged in you'll hopefully be able to launch X applications like ``xterm``.

Data storage
------------

Your home directories are currently located on a 1TB SSD hard drive.  If you have any large datasets you aren't actively reading/writing to then it might be a good idea to place them on the slower 4TB hard drive which has been mounted to `/data`.  Note you can create a symbolic link in your home directory that points to other directories::

  bash$ ln -s /data/your_project_subdirectory link_name

PESD has paid for some data storage from Stanford provided as Samba.  To access this data storage you may temporarily mount a samba share into your home directory::

  bash$ mkdir ~/mnt_samba
  bash$ sudo mount -t cifs //files/pesd$ ~/mnt_samba -o username=SUNET_ID,domain=win,gid=pesd,uid=$USER,vers=3.0

Where SUNET_ID is your Sunet id.  You'll be asked for both your pesd server password (for sudo) and your Sunet password (to access samba share).  When you are done dismount the samba share::

  bash$ umount ~/mnt_samba 

Data transfer
-------------

`Secure File Transfers`_ to the FSI-PESD-Server can be accomplished in a number of ways including using SCP or SFTP.  On \*nix environments this can be as simple as::

   bash$ scp -r local_project_directory  username@fsi-pesd.stanford.edu:/data/server_project_directory

.. _Secure File Transfers: http://web.stanford.edu/group/security/securecomputing/sftp.html

Another useful tool for transferring data or keeping data in sync is `rsync`.  For example to make (and/or synchronize an existing) copy of the trading game to my laptop I can use the command::

  bash$ rsync -avz --delete --verbose --progress --recursive --size-only trevor@fsi-pesd.stanford.edu:/home/trading_game/ /home/trevorld/media/SpiderOak/trading_game/

One helpful option to `rsynce` is the `--dry-run` flag which tells you what it would have done without actually doing it.

General Linux Notes 
--------------------

There are multiple online resources and books to help you understand Linux and various open source tools.  O'Reilly in particular is a technology publisher known for excellent books on open source tools and through the Stanford library you can read their books for free online.

Some particular books you may find useful include:

1) `Linux in a nutshell`_
#) `Bash pocket reference`_
#) `Learning the vi and vim editors`_
#) `R in a nutshell`_
#) `Learning Python`_
#) `Version control with Git`_

.. _Linux in a nutshell: http://searchworks.stanford.edu/view/5644376
.. _Bash pocket reference: http://searchworks.stanford.edu/view/8837104
.. _R in a nutshell: http://searchworks.stanford.edu/view/10087393
.. _Learning the vi and vim editors:  http://searchworks.stanford.edu/view/8261314
.. _Learning Python: http://searchworks.stanford.edu/view/8387828
.. _Version control with Git: http://searchworks.stanford.edu/view/10087829

Running long running jobs
-------------------------

Unlike other Linux servers at Stanford the FSI-PESD-Server doesn't have any queuing system.  If you will be running long jobs you should familiarize yourself with the UNIX programs ``nohup``, ``screen``, and/or  ``tmux`` each of which allows you to have jobs continue running after you log of the server.

For example::

	nohup ./e04ucfe.exe < e04ucfe.d > e04ucfe.r &

Note if you will be running a long job using ``nohup``, ``screen``, or ``tmux`` you should probably need to use the non-graphical command-line versions of ``stata``, etc.  For example use ``state-se`` instead of ``xstata-se``.

Killing Jobs
------------

There are two main commands for killing currently running jobs: ``kill`` and ``killall``.  If you want to kill all the instances of a certain executable you have launched you can use ``killall executable_name``, for example ``killall R`` or ``killall python``.  Doing so will not affect jobs launched by other users.  If you want to kill a specific job use ``kill PID``.  You can get the PID number of a job by either using ``top`` or ``ps aux``.  Oftentimes you'll want to pipe the output of ``ps aux`` to ``grep`` in order to filter the output to a smaller number of jobs such as ``ps aux | grep $USERNAME`` to find all jobs that ``$USERNAME`` has running or ``ps aux | grep matlab`` in order to see all matlab jobs that are currently running.

Limiting memory usage
---------------------

One can limit the maximum memory used by the program with `systemd-run`.  For example to limit an R session to "only" using 32GB of RAM::

    systemd-run --user --scope -p MemoryLimit=32G R

Computational Software Notes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Stata
-----

fsi-pesd
++++++++

We have unlimited-user 4-core network license for Stata 16.1.  Use the ``stata-mp`` or ``xstata-mp`` commands.

NB. the ``stata``, ``xstata``, ``stata-sm``, ``xstata-sm`` commands will launch data limited versions of stata.  Instead use the ``stata-se``, ``xstata-se``, ``stata-mp``, or ``xstata-mp`` commands (since we didn't buy MP version of stata the latter two should be equivalent to the SE version) which do not have data size restriction imposed on them.  If you are using a ``.bashrc`` configuration file for your bash shell you may want it to include an alias like::

    alias xstata="env TMPDIR=/data/tmp xstata-se"
    alias stata="env TMPDIR=/data/tmp stata-se"

NB. Stata writes alot of temporary files to the location of ``$TMPDIR`` which by default is ``/tmp`` on the smaller solid state hard drive.  If you are running a lot of big stata jobs you will need to set this environmental variable to somewhere on the larger ``/data`` hard drive otherwise the smaller solid state drive can fill up.  For example for a single batch stata job in the bash shell you could enter::

   env TMPDIR=/data/tmp stata-se < filename.do > filename.log &

This variable can also be permanently set in a configuration file like ``.bashrc`` (in the example above the ``xstata`` alias always sets ``$TMPDIR`` to ``/data/tmp``).

Gurobi
------

* The Gurobi directory is currently located on both servers at ``/opt/gurobi1001/linux64/``
* Gurobi may require that several environmental variables are setup before it runs correctly e.g. in ``bash`` shell::

    export GUROBI_HOME="/opt/gurobi1001/linux64"
    export PATH=$PATH:$GUROBI_HOME/bin
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GUROBI_HOME/lib

  + Can place these in a ``.bash_profile`` or ``.bashrc`` file...
  + If using ``RStudio Server`` (versus base ``R``) you may need to set these via ``Sys.setenv()``...

  We don't have a multi-user license but you can request a free personal academic license from gurobi.com.

* We've installed the ``R`` bindings.

Knitro
------

* The Knitro directory is currently located on the servers at ``/data/knitro-12.4.0-Linux-64``.
* Knitro may require that several environmental variables are setup before it runs correctly e.g. in ``bash`` shell::

    export ARTELYS_LICENSE_NETWORK_ADDR=license4.stanford.edu
    export KNITRODIR=/data/knitro-12.4.0-Linux-64
    export KMP_DUPLICATE_LIB_OK=TRUE
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/data/knitro-12.4.0-Linux-64/lib

  + Can place these in a ``.bash_profile`` or ``.bashrc`` file...
  + If using ``RStudio Server`` (versus base ``R``) you may need to set these via ``Sys.setenv()``...

* We've installed the ``R`` and ``python3`` bindings.

NAG Fortran
-----------

The FSI-PESD-Server currently has the 64-bit, Mark 26 (GNU Fortran Compiler 5.3 compatible) version of the NAG Fortran Library installed in ``/opt/NAG/fll6i26dfl``.

.. and a Multi-core 64-bit, Mark 23 (GNU Fortran Compiler 4.6 compatible) version of the NAG Fortran Library installed in ``/opt/NAG/fsl6a23dfl``.

You can generate example fortran scripts for all NAG routines in your working directory with the following command::

	/opt/NAG/fll6i26dfl/scripts/nag_example XXXXXX  # Single-threaded Mark 26

..        /opt/NAG/fsl6a23dfl/scripts/nagsmp_example XXXXXX NUM_CORES # Multi-core Mark 23

where XXXXXX is the code for the desired routine.  For example::

	/opt/NAG/fll6i26dfl/scripts/nag_example e04ucf    # Single-threaded Mark 26

..         /opt/NAG/fsl6a23dfl/scripts/nagsmp_example e01tnfe 2  # Multi-core  Mark 23

The example single-threaded command tells you that it runs the following commands (as well as outputting the example program output)::

        cp /opt/NAG/fll6i26dfl/examples/source/e04ucfe.f90 .
        gfortran-5 -I/opt/NAG/fll6i26dfl/nag_interface_blocks e04ucfe.f90 /opt/NAG/fll6i26dfl/lib/libnag_nag.a -lstdc++ -o e04ucfe.exe
        cp /opt/NAG/fll6i26dfl/examples/data/e04ucfe.d .
        ./e04ucfe.exe < e04ucfe.d > e04ucfe.r

R
--

We have R installed, you can either use the command-line version with the ``R`` or ``Rscript`` commands or R Studio Server's web-based GUI:

* http://fsi-pesd.stanford.edu:8787

If using RStudio Server and see an "RStudio Initialization Error: Error occurred during transmission" try deleting the ``.rstudio`` directory in your home directory.

Admin Notes
~~~~~~~~~~~

Adding new users
----------------

Let USER be the new username (probably lowercase).  An administrator can add them using::

    sudo useradd -g pesd USER -d /home/USER -s /bin/bash
    sudo mkdir /home/USER
    sudo chown USER:pesd /home/USER
    sudo passwd USER
    sudo adduser USER samba

An okay starting password would be::

    echo "some string depending on USER but not this one" | sha512sum | cut -c -11

If they forget their password you can change it for them with::

    sudo passwd USER

Remember that user might need to VPN onto Stanford network before can access the server.

Wiping a disk
-------------

::

    sfdisk -l -x # gets drive names
    wipe -kD DRIVEPATH  

Installing a SSL certificate for Apache
---------------------------------------

* https://certbot.eff.org/instructions


Fix "A start job is running for Create Volatile Files..." hanging up server reboot
----------------------------------------------------------------------------------

* https://serverfault.com/questions/987488/boot-stuck-at-a-start-job-is-running-for-create-volatile-files-and-directories
* https://askubuntu.com/questions/132965/how-do-i-boot-into-single-user-mode-from-grub

Troubleshooting network connectivity issues
-------------------------------------------

* https://upcloud.com/community/tutorials/troubleshoot-network-connectivity-linux-server/

Fixing "/user.slice/user-1000.slice/session-1.scope is not a snap cgroup"
-------------------------------------------------------------------------

* https://bugs.launchpad.net/ubuntu/+source/snapd/+bug/1951491

In a terminal do::

    export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR:-/run/user/1000}/bus"

Fixing "X11 connection rejected because of wrong authentication" when using firefox
-----------------------------------------------------------------------------------

* https://stackoverflow.com/a/56661420/2121942

In a terminal do::

    export XAUTHORITY=$HOME/.Xauthority
