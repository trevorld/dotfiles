.. contents::

~~~~~~~~~~~~~~~~~~~~~
FSI-PESD-Server notes
~~~~~~~~~~~~~~~~~~~~~

PESD has an Ubuntu Server (version 14.04 LTS) with 128GB of memory, 4 processors (for a total of 32 cores), and a 4TB hard drive (as well as an additional 240 GB SSD hard drive for the OS and home directories).

The server has Stata (release 13), SAS 9.4, NAG Fortran libraries (Mark 24), and Matlab as well as numerous open source tools such as R, Python, BASH, etc.

Logging in
----------

One can log onto the server using SSH using your provided username and password.  Mac and Linux computers have SSH built in.  If you are on one of those systems or you have installed a Unix environment with SSH on Windows (such as the one provided by Cygwin_) then open up a terminal and login in::

  bash$ ssh -X username@fsi-pesd-server.stanford.edu

And then enter your password at the prompt.  If you are not connected to PESD's ethernet network then you'll first need to VPN_ onto Stanford's network.

Stanford Itservices also provides instructions for logging on via SSH_ on Windows in various ways such as SecureCRT (if you don't care about graphics) or Xming_ (if you want graphics).

.. _VPN: http://itservices.stanford.edu/service/vpn/
.. _SSH: https://itservices.stanford.edu/service/sharedcomputing/loggingin
.. _Cygwin: http://cygwin.com/
.. _Xming: http://www.straightrunning.com/XmingNotes/

Setting up Cygwin on Windows so you can use GUIs on the server
--------------------------------------------------------------

Grab the Cygwin_ installer and follow the directions.  When choosing which additional packages to install choose ``xinit``, ``openssh``, and ``mintty`` (which is better than xterm since you can scroll and also copy/paste).

After ``xinit`` has been installed you should be able to start X-windows and an xterm by running a program called "Cygwin-X" in the Windows Programs menu.  In the xterm launch ``mintty.exe`` (this is step is optional but recommended).  Then in the mintty shell login using ``ssh -X`` with your username as above.  After you have logged in you'll hopefully be able to launch X applications like ``xterm``.

Data storage
------------

Your home directories are currently on the smaller 240GB SSD hard drive.  Please put all large datasets on the 4TB hard drive which has been mounted to `/data`.  Note you can create a symbolic link in your home directory that points to other directories::

  bash$ ln -s /data/your_project_subdirectory link_name

Data transfer
-------------

`Secure File Transfers`_ to the FSI-PESD-Server can be accomplished in a number of ways including using SCP or SFTP.  On \*nix environments this can be as simple as::

   bash$ scp -r local_project_directory  username@fsi-pesd-server.stanford.edu:/data/server_project_directory

.. _Secure File Transfers: http://web.stanford.edu/group/security/securecomputing/sftp.html

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

Note if you will be running a long job using ``nohup``, ``screen``, or ``tmux`` you should probably need to use the non-graphical command-line versions of ``matlab``, ``sas``, ``stata``, etc.  For example use ``state-se`` instead of ``xstata-se`` or you can launch ``matlab`` with the ``-nodesktop`` and ``-nosplash`` options (see `Matlab no gui`_ for more details).

.. _Matlab no gui: http://aspratyush.wordpress.com/tag/matlab-no-gui/

STATA
-----

We have a 2-user network license for Stata 13.1.  This means up to two different users can have open multiple sessions of Stata.

NB. the ``stata``, ``xstata``, ``stata-sm``, ``xstata-sm`` commands will launch data limited versions of stata.  Instead use the ``stata-se``, ``xstata-se``, ``stata-mp``, or ``xstata-mp`` commands (since we didn't buy MP version of stata the latter two should be equivalent to the SE version) which do not have data size restriction imposed on them.  If you are using a ``.bashrc`` configuration file for your bash shell you may want it to include an alias like::

    alias xstata="env TMPDIR=/data/tmp xstata-se"
    alias stata="env TMPDIR=/data/tmp stata-se"

NB. Stata writes alot of temporary files to the location of ``$TMPDIR`` which by default is ``/tmp`` on the smaller solid state hard drive.  If you are running a lot of big stata jobs you will need to set this environmental variable to somewhere on the larger ``/data`` hard drive otherwise the smaller solid state drive can fill up.  For example for a single batch stata job in the bash shell you could enter::

   env TMPDIR=/data/tmp stata-se < filename.do > filename.log &

This variable can also be permanently set in a configuration file like ``.bashrc`` (in the example above the ``xstata`` alias always sets ``$TMPDIR`` to ``/data/tmp``).


NAG Fortran on FSI-PESD-Server
------------------------------

The FSI-PESD-Server currently has the 64-bit, Mark 24, GNU Fortran Compiler 4.7 compatible version of the NAG Fortran Library installed in ``/opt/NAG``.

You can generate example fortran scripts for all NAG routines in your working directory with the following command::

	/opt/NAG/fll6a24dfl/scripts/nag_example XXXXXX

where XXXXXX is the code for the desired routine.  For example to create an example for the module "e04ucf" run::

	/opt/NAG/fll6a24dfl/scripts/nag_example e04ucf

The example command tells you that it runs the following commands (as well as outputting the example program output)::

	cp /opt/NAG/fll6a24dfl/examples/source/e04ucfe.f90 .
	gfortran-4.7 -I/opt/NAG/fll6a24dfl/nag_interface_blocks e04ucfe.f90 /opt/NAG/fll6a24dfl/lib/libnag_nag.a -o e04ucfe.exe
	cp /opt/NAG/fll6a24dfl/examples/data/e04ucfe.d .
	./e04ucfe.exe < e04ucfe.d > e04ucfe.r

The second line in particular shows how to compile a FORTRAN program while linking with the NAG library, note the use of ``gfortran-4.7`` instead of ``gfortran``.  This is because ``gfortran`` on the server is version 4.8 but at the moment NAG does not have any version 4.8 compatible versions of their library so we must use an earlier version of gfortran with NAG.

MATLAB
------

Sometimes Matlab won't work because the Matlab license server isn't running.  To restart the Matlab license server uset the following command in the shell::

    /usr/local/MATLAB/R2014a/etc/lmstart

If you want to use the non-GUI version of Matlab use (i.e. for use in nohup or tmux/screen)::

   matlab -nodesktop -nosplash
