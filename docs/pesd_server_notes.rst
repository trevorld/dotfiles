.. contents::

.. _VPN: http://itservices.stanford.edu/service/vpn/

FSI-PESD-Server notes
~~~~~~~~~~~~~~~~~~~~~

PESD has an Ubuntu Server (version 14.04 LTS) with 128GB of memory, 4 processors (for a total of 32 cores), and a 4TB hard drive (as well as an additional 240 GB SSD hard drive for the OS and home directories).

The server has Stata (release 13), SAS 9.4, NAG Fortran libraries (Mark 24), and Matlab as well as numerous open source tools such as R, Python, BASH, etc.

Logging in
----------

One can log onto the server using SSH using your provided username and password.  On Mac / Linux systems or if you have installed a Unix environment on Windows like Cygwin ( open up a terminal and use something like::

  bash$ ssh -X username@fsi-pesd-server.stanford.edu

And then enter your password at the prompt.  If you are not connected to PESD's ethernet network then you'll first need to VPN_ onto Stanford's network.

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

The FSI-PESD-Server doesn't have any queing system.  If you will be running long FORTRAN jobs you should familarize yourself with the UNIX programs ``nohup``, ``screen``, and/or  ``tmux`` each of which allows you to have jobs continue running after you log of the server.

For example::

	nohup ./e04ucfe.exe < e04ucfe.d > e04ucfe.r &
	



