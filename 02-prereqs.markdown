---
layout: default
title: prereqs & installation
permalink: prereqs.html
---
# What should you do before using MESA?

This page has information to help you prepare for using MESA.  It is
important to remember that MESA is under construction -- and probably
will be for the indefinite future.

[Several screencasts][guides] that will visually guide you through
these instructions are available.  You may want to take a look!

[guides]:http://cococubed.asu.edu/mesa_market/guides.html

## Look through this presentation; skim the MESA papers

Before you use MESA, you should get a feel for what it can do.

For a brief summary of the capabilities of MESA, take a look at this
[presentation by Matteo Cantiello](assets/mesa_slides.pdf).  (He has
also provided a [Keynote version](assets/mesa_slides.key.zip).)

The full capabilities of MESA are documented in the instrument papers.
Looking through the figures will give you a feel for the broad range
of problems that can be studied using MESA.

* [Paper 1 (Paxton et al. 2011)](http://adsabs.harvard.edu/abs/2011ApJS..192....3P)
* [Paper 2 (Paxton et al. 2013)](http://adsabs.harvard.edu/abs/2013ApJS..208....4P)
* [Paper 3 (Paxton et al. 2015)](http://adsabs.harvard.edu/abs/2015ApJS..220...15P)
* [Paper 4 (Paxton et al. 2018)](http://adsabs.harvard.edu/abs/2018ApJS..234...34P)

## Join the mailing list

The "how-to" documentation is largely embedded in the experience of
the community of users.  Therefore the first step to becoming a MESA
user is to join the
[mesa-users mailing list](https://lists.mesastar.org/mailman/listinfo/mesa-users).
(Click the preceding link and complete the "Subscribing to
mesa-users" section of the form.)

If you have requests for help, you should post your questions to
mesa-users.  You should also
[search the mailing list archives](https://lists.mesastar.org/pipermail/mesa-users/)
to look for similar questions that may have been asked in the past.
And once you begin to know how to use MESA, please help by responding
to posts on the list.

## Check the MESA map
<a id="maps"></a>

Take a look at the maps below to see the locations of MESA users.  To
have your location added, [email Frank Timmes](mailto:fxt44@mac.com).

[![Map of MESA users (World)][mmw_png]][mmw_pdf]

[mmw_png]:assets/images/mesa_users_01jan2018_world_mercator.png
[mmw_pdf]:assets/images/mesa_users_01jan2018_world_mercator.pdf

[![Map of MESA users (USA)][mmu_png]][mmu_pdf]

[mmu_png]:assets/images/mesa_users_01jan2018_usa_mercator.png
[mmu_pdf]:assets/images/mesa_users_01jan2018_usa_mercator.pdf

## Ensure your system meets the minimum hardware requirements

The minimum system requirements for MESA are:

* Mac or Linux operating system (Windows users may want to try [MESA-Docker])
* 64-bit processor
* 4 GB RAM
* 10 GB free disk space

[MESA-Docker]:https://github.com/evbauer/MESA-Docker

Most laptop or desktop computers built in the last three years will
satisfy these requirements.

## Install the prerequisites (MESA SDK)

Before you can do an install for MESA, you need to get the
prerequisites.  The [MESA SDK] provided by Rich Townsend simplifies
this process.  It provides a prebuilt set of compilers and run-time
libraries that should make your MESA install go smoothly.  Visit the
[MESA SDK website][MESA SDK] for the details of setting it up.

[MESA SDK]:http://www.astro.wisc.edu/~townsend/static.php?ref=mesasdk

If you would prefer to use ifort (the MESA SDK uses gfortran), that is
also an option, so long as you use ifort 14 or later.  Even if you
choose to use ifort, you should still visit the MESA SDK website to
get a feel for the other MESA requirements.

Not using the MESA SDK means you'll need to replace the file
$MESA\_DIR/utils/makefile\_header with a version customized to your
system.  There's a template to get you started at
$MESA\_DIR/utils/makefile\_header\_non\_mesasdk.

Regardless of whether you use the MESA SDK or ifort, and whether your
machine runs mac or linux, the output of MESA should be bit-for-bit
identical.  If it's not, Bill considers it to be a bug.  (This has
been the case since Release 5819 in early January 2014.)

## Download MESA

The simplest way to get the MESA software is to download a zip file of
the [latest MESA release][release].

[release]:http://sourceforge.net/projects/mesa/files/releases/mesa-r{{site.version}}.zip/download

The compressed file is about 1GB, so don't worry if it takes a little
while to download.  If you are experiencing slow download speeds, you
may want to change which mirror you are using.  (After you select a
zipfile to download, click the "try another mirror" link near the top
of the page.)

The unzipped and installed package will be large, so make sure you
have at least 10 GB free on your disk.

When you unzip the file, it will create a directory named
mesa-r{{site.version}}.  This will be your main MESA directory.  You
are free to rename it, just make sure to set MESA\_DIR accordingly
(see the next section).

You can also download zip files of [older MESA releases][releases].
If you plan to do so, please read [this FAQ entry][oldversion].

[releases]:http://sourceforge.net/projects/mesa/files/releases/
[svnerror]:faq.html#svn-error
[oldversion]:faq.html#old-version

If you'd prefer, you can instead checkout a copy of MESA from its
subversion repository, using the command:

    svn co -r {{site.version}} svn://svn.code.sf.net/p/mesa/code/trunk mesa

Note that there might be newer versions out there in the svn
repository, but they are probably untested, unstable, and generally
not at all what you want, so please stick to the officially released
ones.  To repeat: always use "-r", and to make sure that you get an
officially released version always follow "-r" with the version
number of an [official MESA release][versions].

[versions]:faq.html#releases

<a id="env"></a>
## Set your environment variables

The easiest way to make sure that your system is always configured
appropriately is to define the neccessary environment variables in
your [shell start-up file][startup].  The file that you need to edit
will depend on [which shell you're using][whichshell].  (If you don't
set the environment variables in your shell start-up file, you will
need to re-define them each time you open a new shell.)

The exact paths will vary depending on where you installed MESA and
which operating system that you are using.  After you add these
commands to your shell startup file, don't forget to open a new shell
(or source the startup file in an existing one).

[startup]:https://kb.iu.edu/d/abdy
[whichshell]:http://askubuntu.com/questions/590899/how-to-check-which-shell-am-i-using

You will need to mix and match different aspects of the following
example configurations depending on your shell, your operating system,
and your installation method.

Here is an example from a machine that uses bash as its shell (and
hence uses export to set variables):

{% highlight bash %}
# set MESA_DIR to be the directory to which you downloaded MESA
export MESA_DIR=/Users/jschwab/Software/mesa-r{{site.version}}

# set OMP_NUM_THREADS to be the number of cores on your machine
export OMP_NUM_THREADS=2

# you should have done this when you set up the MESA SDK
export MESASDK_ROOT=/Applications/mesasdk
source $MESASDK_ROOT/bin/mesasdk_init.sh
{% endhighlight %}

Here is an example from a machine that uses csh as its shell (and
hence uses setenv to set variables):

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
you'll always be using the MESA SDK supplied version of gcc which may be a compatibility issue if
you work with other other codes.  Alternative (unsupported)
initialization scripts are available [here][mesa-init].

[mesa-init]:https://github.com/jschwab/mesa-init

## Compile MESA

Now we are ready to compile the code.  This will take a little while,
so do something else for a bit or get up and get a cup of coffee.

    cd $MESA_DIR
    ./install

Note that there is no reason to use `sudo`.  The MESA install does not
require root privileges.  Once it is done, you should receive the
message

    ************************************************
    ************************************************
    ************************************************
    
    mesa installation was successful.
    
    ************************************************
    ************************************************
    ************************************************

If so, move on to "getting started".  If not, take a look below.

# What should you if MESA did not install successfully?

First, confirm that you can reproduce the error.  Do

    cd $MESA_DIR
    ./clean
    ./install | tee build.log

and see if you get the same error.  (The use of the `tee` command will
save the output of `./install` in the file `build.log` while still
displaying it in your terminal.)

## Check that your environment variables are set correctly

One of the most common issues is unset or incorrectly set environment
variables.  In the same terminal window where you are trying to install MESA,
execute the command
{% highlight bash %}
echo $MESA_DIR
{% endhighlight %}
and if you're using the MESA SDK, execute the command
{% highlight bash %}
echo $MESASDK_ROOT
{% endhighlight %}
Confirm that these showed the directories where you have installed
MESA and the MESA SDK.  If they did not, please re-read the
instructions on how to [set your environment variables][env].

[env]:prereqs.html#env

## Confirm that you installed the MESA SDK correctly

Please check that you followed the MESA SDK [installation
instructions](http://www.astro.wisc.edu/~townsend/static.php?ref=mesasdk).
Pay particular attention to the prerequisites for your system.

## Consult the FAQ

Check to see if there is any information about your problem in the
[MESA FAQ][faq].

[faq]:faq.html

If you are using the MESA SDK and are having a problem with
installation, you should also consult the [MESA SDK FAQ][sdkfaq].

[sdkfaq]:http://www.astro.wisc.edu/~townsend/static.php?ref=mesasdk#Frequently_Asked_Questions_.01FAQ.01


## Search the mesa-users mailing list archive

Search the [mailing list archives][mla] to see if someone has had a similar
problem in the past.

[mla]:https://lists.mesastar.org/pipermail/mesa-users/


## Post a question to mesa-users

If the previous steps have not solved your problem, send an email
message to mesa-users@lists.mesastar.org describing the problem.

Please provide the following information:

+ What version of MESA are you trying to build?

+ Are you using the MESA SDK?  If so, what version?

+ Describe your computer (machine type, operating system, operating system version).

+ What is the output of each of the following commands?

```
uname -a
gfortran -v
echo $MESASDK_ROOT
echo $PATH
echo $MESA_DIR
```


+ What is the error message you recieved?  In addition, please attach the full `build.log` file.
