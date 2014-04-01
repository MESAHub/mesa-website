---
layout: default
title: prereqs & installation
permalink: prereqs.html
---
# What should you do before using MESA?

This page has information to help you prepare for using MESA.  It is
important to remember that MESA is under construction -- and probably
will be for the indefinite future.


## Skim the MESA papers

Before you use MESA, you should at least skim the "instrument papers".

* [Paper 1 (Paxton et al. 2011)](http://adsabs.harvard.edu/abs/2011ApJS..192....3P)
* [Paper 2 (Paxton et al. 2013)](http://adsabs.harvard.edu/abs/2013ApJS..208....4P)

These document the basic algorthims and capabilities of MESA.


## Join the mailing list

The "how-to" documentation is largely embedded in the experience of
the community of users.  Therefore the first step to becoming a MESA
user is to join the
[mesa-users mailing list](https://lists.sourceforge.net/lists/listinfo/MESA-users).
(Click the preceeding link and complete the "Subscribing to
mesa-users" section of the form.)

If you have requests for help, you should post your questions to
mesa-users.  And once you begin to know how to use MESA, please help
by responding to posts on the list.  You should also visit the
[MESA Forum](http://mesastar.org/).  Registration (upper right corner)
is not mandatory to view pages, but is required to post material on
pages.


## Check the MESA map

Take a look at the maps below to see the locations of MESA users.  To
have your location added, [email Frank Timmes](mailto:fxt44@mac.com).

[![Map of MESA users (USA)][mmu_png]][mmu_pdf]
[mmu_png]:assets/images/mesa_users_usa.png
[mmu_pdf]:assets/images/mesa_users_usa.pdf

[![Map of MESA users (Europe)][mme_png]][mme_pdf]
[mme_png]:assets/images/mesa_users_europe.png
[mme_pdf]:assets/images/mesa_users_europe.pdf

[![Map of MESA users (World)][mmw_png]][mmu_pdf]
[mmw_png]:assets/images/mesa_users_world.png
[mmw_pdf]:assets/images/mesa_users_world.pdf


## Install the prerequisites (MESA SDK)

*MESA is no longer supported on 32-bit systems.  This isn't by design;
we simply haven't been able to get it to work!  So if you REALLY want
to use an antique 32-bit system for MESA, you'll have to try to make
it work yourself.*

Before you can do an install for MESA, you need to get the
prerequisites.  Unless you are a masochist, you'll probably want to
use the [MESA SDK] provided by Rich Townsend.  It provides a prebuilt
set of compilers and run-time libraries that should make your MESA
install go smoothly.  Visit the [MESA SDK website][MESA SDK] for the
details of setting it up.

[MESA SDK]:http://www.astro.wisc.edu/~townsend/static.php?ref=mesasdk


## Download MESA

The following command will download the latest release version of MESA
into a directory named mesa.  The package is large, so make sure you
have at least 10 GB free on your disk and don't worry if it takes a
little while to download.

    svn co -r {{site.version}} svn://svn.code.sf.net/p/mesa/code/trunk mesa

Note that there might be newer versions out there in the svn
repository, but they are probably untested, unstable, and generally
not at all what you want, so please stick to the officially released
ones.  To repeat: always use "-r", and to make sure that you get an
officially released version always follow "-r" with a version
number from this page.


## Set your enviroment variables

The easiest way to make sure that your system is always configured
appropriately is to add the needed commands to the appropriate shell
start-up file.  The exact paths will vary depending on where you
installed MESA and whether you are using OS X or Linux.  After you add
these commands to your shell startup file, don't forget to open a new
shell (or source the file in an existing one).

Here is an example from a .bashrc on OS X:
{% highlight bash %}
# set MESA_DIR to be the directory to which you downloaded MESA
export MESA_DIR=/Users/jschwab/Software/mesa

# set OMP_NUM_THREADS to be the number of cores on your machine
export OMP_NUM_THREADS=2

# you should have done this when you set up the MESA SDK
export MESASDK_ROOT=/Applications/mesasdk
source $MESASDK_ROOT/bin/mesasdk_init.sh
{% endhighlight %}

Here is an example from a .cshrc on Linux:
{% highlight csh %}
# set MESA_DIR to be the directory to which you downloaded MESA
setenv MESA_DIR /home/jschwab/Software/mesa

# set OMP_NUM_THREADS to be the number of cores on your machine
setenv OMP_NUM_THREADS 4

# you should have done this when you set up the MESA SDK
setenv MESASDK_ROOT /opt/mesasdk
source $MESASDK_ROOT/bin/mesasdk_init.csh
{% endhighlight %}

One caveat is that if you put the MESA SDK in your shell profile,
you'll always be using gcc 4.9 which may be a compatibility issue if
you work with other other codes.  Alternative (unsupported)
initialization scripts are available [here][mesasdk-init].

[mesasdk-init]:https://github.com/jschwab/mesasdk-init

## Compile MESA

Now we are ready to compile the code.  This will take a little while,
so do something else for a bit or get up and get a cup of coffee.

    cd $MESA_DIR
    ./install

You should receive the message

    ************************************************
    ************************************************
    ************************************************
    
    mesa installation was successful.
    
    ************************************************
    ************************************************
    ************************************************

If so, move on to "getting started".  If not, take a look at
"troubleshooting".
