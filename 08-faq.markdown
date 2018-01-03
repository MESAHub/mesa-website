---
layout: default
title: FAQ
permalink: faq.html
---

# General Questions

## How do you say MESA?

Say "MAY-sa".

## Can I use the MESA logo in a talk or presentation?

Yes.  It is available in a variety of sizes for your convenience.

* [30 pt](/assets/logo/mesa_logo2_30pt.png)
* [60 pt](/assets/logo/mesa_logo2_60pt.png)
* [100 pt](/assets/logo/mesa_logo2_100pt.png)
* [144 pt](/assets/logo/mesa_logo2_144pt.png)
* [200 pt](/assets/logo/mesa_logo2_200pt.png)
* [400 pt](/assets/logo/mesa_logo2_400pt.png)

## What happens when an instrument paper is being written?

The picture shows the intense authors hard at work making final edits.

![writing the mesa paper](/assets/images/paper_session.jpg "Paper Session")

A late night session working on the paper around Bill's dining room
table with a projector, a makeshift screen, and ample red wine (left
to right, Frank Timmes, Aaron Dotter, Falk Herwig, Lars Bildsten, and
Bill Paxton).  Photo taken by Bill's patient wife, Kathlyn, who
deserves a great deal of credit for the existence of MESA.

## Why did my inlists and/or run\_star\_extras stop working?

As MESA evolves, inlist options, variable names, and other aspects of
the code change in ways that are not backward-compatible.  Here is a
list of some of the major renaming events; it is by no means
exhaustive.  Consult the release notes for these versions for more
information.

+ [r4411](release/2012/08/25/r4411.html): major renaming and reorganization of the code
+ [r8118](release/2016/02/03/r8118.html): renaming and restructuring of controls related to winds. `run_star_extras` routines changed to hooks.
+ [r8845](release/2016/06/19/r8845.html): names using "cnt" were changed to use "interval" (e.g., `terminal_cnt` was renamed to `terminal_interval`).  the option `photostep` was renamed to `photo_interval`.


# Prereqs & Installation

## Can MESA be run on 32-bit machines?

MESA is no longer supported on 32-bit systems.  This isn't by design;
we simply haven't been able to get it to work!  So if you REALLY want
to use an antique 32-bit system for MESA, you'll have to try to make
it work yourself.

<a id="releases"></a>
## Which SVN revisions were MESA release versions?

{% include releases.html %}

## Why is my MESA zipfile download taking forever?

The MESA zipfiles are large (~1GB), so if you're on a slow connection,
there's nothing to be done.  However, users have reported substantial
variations in download speed from the sourceforge site.  If you are
experiencing slow download speeds, you may want to change which mirror
you are using.  (After you select a zipfile to download, click the
"try another mirror" link near the top of the page.)

## Why am I getting "wrong module version" errors?

Errors like

    Fatal Error: Wrong module version '7' (expected '5')

typically arise because you have changed the gfortran compiler since
you last built MESA.  (Sometimes a changed gfortran version is an
indication that you forgot to activate the MESA SDK.)  To fix, run
./clean in the MESA directory, and then try building again.

<a id="svn-error"></a>
## When I install MESA from a zipfile, why do I get svn errors?

Older versions of MESA (r6794 or earlier) assumed that they would be
installed from the subversion repository.  Therefore, if you install
these versions from a zipfile, you will see messages like

    svn: E155007: '/Users/fxt/mesa/mesa-r6794' is not a working copy

when you run MESA.  These messages are safe to ignore.

<a id="yosemite"></a>
<a id="osx"></a>
## What do I need to do to run MESA on OS X?

It is necessary to take the following actions on recent versions of OS
X (10.9 or later) , even if you had a working version of MESA on your
previous version of OS X.

* Install or reinstall the current version of [Xquartz][xquartz].

* Install the [command line tools][clt], using the command

{% highlight bash %}
xcode-select --install
{% endhighlight %}

* Install the latest version of the [MESA SDK][sdkosx] appropriate for
your version of OS X.

[xquartz]:http://xquartz.macosforge.org/landing/
[clt]:https://developer.apple.com/library/ios/technotes/tn2339/_index.html#//apple_ref/doc/uid/DTS40014588-CH1-WHAT_IS_THE_COMMAND_LINE_TOOLS_PACKAGE_
[sdkosx]:http://www.astro.wisc.edu/~townsend/static.php?ref=mesasdk#Mac_OS_X

<a id="crlibm-fail"></a>
## Why do I get the error "C compiler cannot create executables"?

If you receive the error

    configure: error: C compiler cannot create executables
    See `config.log' for more details.

during the MESA installation of crlibm, please check that you are not
using an unsupported 32-bit system.  If you're using OS X, make sure
you've [installed Xcode and the command line tools][xcode].

[xcode]:#osx

If you're using Linux and you see an error message like

    In file included from /opt/mesasdk/lib/gcc/x86_64-pc-linux-gnu/5.3.1/include-fixed/features.h:338:0,
                     from /usr/include/bits/libc-header-start.h:33,
                     from /usr/include/stdio.h:28,
                     from test.c:1:
    /usr/include/sys/cdefs.h:481:49: error: missing binary operator before token "("
     #if __GNUC_PREREQ (4,8) || __glibc_clang_prereq (3,5)
                                                     ^
    In file included from test.c:1:0:
    /usr/include/stdio.h:320:43: error: missing binary operator before token "("
     #if defined __USE_XOPEN2K8 || __GLIBC_USE (LIB_EXT2)
                                               ^
    /usr/include/stdio.h:399:17: error: missing binary operator before token "("
     #if __GLIBC_USE (LIB_EXT2)
                     ^
    /usr/include/stdio.h:657:43: error: missing binary operator before token "("
     #if defined __USE_XOPEN2K8 || __GLIBC_USE (LIB_EXT2)

you may need to [tell gcc to regenerate its fixed header files][fix].

[fix]:https://gcc.gnu.org/onlinedocs/gcc-7.2.0/gcc/Fixed-Headers.html#Fixed-Headers

You can do so with the commands:

    GCC_VERSION=`gcc --version | grep ^gcc | sed 's/^.* //g'`
    $MESASDK_ROOT/libexec/gcc/x86_64-pc-linux-gnu/$GCC_VERSION/install-tools/mkheaders $MESASDK_ROOT

If the error persists, please email mesa-users@lists.mesastar.org
and

+ give your operating system and its version information
+ indicate which version of the SDK you are using
+ attach the file `$MESA_DIR/crlibm/crlibm/config.log`

<a id="build_and_test_error"></a>
## Why do i get an error during installation "./build_and_test FAILED"?

If you receive the error:
    
    ./build_and_test FAILED
    
during installation, then please email mesa-users@lists.mesastar.org list, and

+ attach the file `$MESA_DIR/MODULE/test/tmp.txt'

where MODULE is replaced with the name of the module that failed. The name of the 
module that failed should be printed on the line before the ./build_and_test message was printed.

If the file tmp.txt file does not exist in the folder then run the tester program

    ./tester 2>&1 | tee tester.log

and send the tester.log file to the mesa-users@lists.mesastar.org list. If the tester program does not exist then contact the mesa-users@lists.mesastar.org list.

# PGPLOT and pgstar

## Why don't I see any PGPLOT output when I run MESA?

Make sure you have the option pgstar\_flag = .TRUE. in the &star\_job
section of your input file. Also, if you're not using the SDK, make
sure you enabled PGPLOT in your utils/makefile_header file (when using
the SDK, PGPLOT is enabled by default).

## How can I make a movie from my pgstar output?

As of the 20140713 release, the MESA SDK includes the ffmpeg encoder
and a simple script, images\_to\_movie.sh, which uses ffmpeg to create
movies from PNG files produced by MESA.

To make use of this capability, consult [Rich's instructions][movie-making].

[movie-making]:http://www.astro.wisc.edu/~townsend/static.php?ref=mesasdk#Making_Movies

# Programming

## What programming language is MESA written in?

Fortran.  But MESA is written using advanced features of modern
Fortran which make it very different from Fortran 77 codes you might
have previously seen (or written!).  If you are not already familiar
with the new and wonderful things that have been added, there are good
resources available on the web -- here's one:
[Fortran 95 language features][Fortran].

[Fortran]:http://en.wikipedia.org/wiki/Fortran_95_language_features

## What does "thread-safe" mean?

"Thread-safe" simply means that users can take advantage of multicore
processors.

For example, during stellar evolution, you need to evaluate the eos at
lots of points:

{% highlight fortran %}
do k = 1, num_zones
    call eos(T(k), rho(k), ....)
end do
{% endhighlight %}

Most fortran compilers (ifort and gfortran and others) support OpenMP,
so the loop can be made to run in parallel by adding 2 lines of magic:


{% highlight fortran %}
!$OMP PARALLEL DO PRIVATE (k)
do k = 1, num_zones
    call eos(T(k), rho(k), ....)
end do
!$OMP END PARALLEL DO
{% endhighlight %}

Now, if I have 4 cores, I'll have 4 threads of execution evaluating
the eos.

However, for it to work, the implementation needs to be thread-safe.
In practice this means, making shared data read-only after
initialization.  Working memory must be allocated from the stack (as
local variables of routines) or allocated dynamically (using
fortran95's allocate primitive).  So, basically it boils down to
avoiding common blocks and save's.  It's easy to arrange for this in
new code; it can be nasty converting old code however.  Stellar
evolution is a good candidate for making use of many cores.  Just
wrapping "parallel" directives around some loops does it if the system
is designed with that in mind -- and MESA is.  But there is still much
to be done to make good use of more than 3 or 4 cores in
MESA/star.<br> It will be an ongoing effort to improve the design of
the code in that area; help with that is welcomed!


## How can I use an individual MESA module?

The easiest way to get the idea is to look at a sample, and in the
MESA directory you will find a subdirectory called “sample”. Make a
copy of the sample directory anywhere you’d like and give it whatever
name you want. Follow the instructions in the README file to make and
test the sample.

# Third-party Tools

## How can I read and/or plot MESA data using language X?

Users have posted numerous useful scripts in a variety of languages on
[the MESA marketplace][tools].

[tools]:http://cococubed.asu.edu/mesa_market/add-ons.html

## How can I include the effects of chemical enhancements on the opacities?

Ehsan Moravveji has developed a package available for
[free access on bitbucket][opmono] to recompute OP opacities for any
desired mixture (that MESA supports) and for any user-specified iron
and nickel enhancement factors.

[opmono]:https://bitbucket.org/ehsan_moravveji/op_mono/overview
