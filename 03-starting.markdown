---
layout: default
title: getting started
permalink: starting.html
---
# How do you get started using MESA star?

This page has information about how to use MESA to evolve a single
star.  It assumes you have already installed MESA. It tries to give
you a tour of the basic MESA features and introduce you to some "best
practices" along the way.  It is by no means a complete guide to MESA.

## A whirlwind tour of MESA

When you download MESA, you get a directory with lots of
subdirectories.  Most of these subdirectories are modules (the "M" in
MESA) that provides some specific functionality (e.g., "kap" provides
routines for calculating opacities).  The most important module is
"star", which contains the module that knows how to put the capabilities
of all the other modules together and advance the state of a stellar
model by a single step and then suggest a new time increment for the
next step.  Basically, that’s all it does.

But presumably you came here for a program that can use these modules
to do multi-step stellar evolution.  You're in luck, because such a
program lives in the star/work directory, so that's where we'll start.


## Make a copy of the star/work directory

You should perform and store your work somewhere other than the main
MESA directory.  This will make your life simpler when you do a fresh
checkout of a new MESA version at some point in the future.  Therefore
each time you want to start a new MESA project, you should make a new
copy of the star/work directory.  Let's do that for this tutorial.

    cp -r $MESA_DIR/star/work tutorial

Now that we have our copy of the work directory, we need to compile
the code that lives in it.

    cd tutorial
    ./mk

## Set up configuration files

The work directory already contains a set of simple configuration
files that will evolve a 15 solar mass star through on to the zero-age
main sequence (core hydrogen ignition).  For now, you won't need to
edit anything, but you should take a look at each of these files.

### inlist -- the master configuration file

This is the file that MESA reads when it starts up.  There are three
sections in the file (technically fortran "namelists"):

* **star_job** -- options for the program that evolves the star
* **controls** -- options for the MESA star module
* **pgstar** -- options for on-screen plotting

Each definition in a namelist is of the form

{% highlight fortran %}
name = value ! comment
{% endhighlight %}

Values are specified using the normal fortran syntax.  Blank lines and
comment lines can be freely included in the list.  Blanks at the start
of a line containing a name-value pair are okay too so you can (and
should) indent things to make them more readable.

All of the controls are given reasonable default values at
initialization, so you only need to set the ones that you actually
want to change.

{% highlight fortran %}
! this is the master inlist that MESA reads when it starts.

! This file tells MESA to go look elsewhere for its configuration
! info. This makes changing between different inlists easier, by
! allowing you to easily change the name of the file that gets read.

&star_job

    read_extra_star_job_inlist1 = .true.
    extra_star_job_inlist1_name = 'inlist_project'

/ ! end of star_job namelist


&controls

    read_extra_controls_inlist1 = .true.
    extra_controls_inlist1_name = 'inlist_project'

/ ! end of controls namelist


&pgstar

    read_extra_pgstar_inlist1 = .true.
    extra_pgstar_inlist1_name = 'inlist_pgstar'

/ ! end of pgstar namelist
{% endhighlight %}

### inlist_project

These are the options that we'll use to construct a 15 solar mass star
from a pre-main sequence model and then stop the evolution once we
reach the zero-age main sequence (ZAMS).

{% highlight fortran %}
! inlist to evolve a 15 solar mass star

! For the sake of future readers of this file (yourself included),
! ONLY include the controls you are actually using.  DO NOT include
! all of the other controls that simply have their default values.

&star_job

  ! begin with a pre-main sequence model
    create_pre_main_sequence_model = .true.

  ! save a model at the end of the run
    save_model_when_terminate = .false.
    save_model_filename = '15M_at_TAMS.mod'

  ! display on-screen plots
    pgstar_flag = .true.

/ !end of star_job namelist


&controls

  ! starting specifications
    initial_mass = 15 ! in Msun units

  ! stop when the star nears ZAMS (Lnuc/L > 0.99)
    Lnuc_div_L_zams_limit = 0.99d0
    stop_near_zams = .true.

  ! stop when the center mass fraction of h1 drops below this limit
    xa_central_lower_limit_species(1) = 'h1'
    xa_central_lower_limit(1) = 1d-3

/ ! end of controls namelist
{% endhighlight %}


### inlist_pgstar

This houses the options for on-screen plotting.  Feel free to ignore
these for now, but to learn more, have look at the
["using pgstar"](pgstar.html) section of this website.

{% highlight fortran %}
&pgstar

  ! MESA uses PGPLOT for live plotting and gives the user a tremendous
  ! amount of control of the presentation of the information.

  ! show HR diagram
  ! this plots the history of L,Teff over many timesteps
    HR_win_flag = .true.

  ! set static plot bounds
    HR_logT_min = 3.5
    HR_logT_max = 4.6
    HR_logL_min = 2.0
    HR_logL_max = 6.0

  ! set window size (aspect_ratio = height/width)
    HR_win_width = 6
    HR_win_aspect_ratio = 1.0


  ! show temperature/density profile
  ! this plots the internal structure at single timestep
    TRho_Profile_win_flag = .true.

  ! add legend explaining colors
    show_TRho_Profile_legend = .true.

  ! display numerical info about the star
    show_TRho_Profile_text_info = .true.

  ! set window size (aspect_ratio = height/width)
    TRho_Profile_win_width = 8
    TRho_Profile_win_aspect_ratio = 0.75

/ ! end of pgstar namelist
{% endhighlight %}

## Running MESA

Running the code is now as simple as typing

    ./rn

MESA will keep you updated via terminal output that looks like this:

           step    lg_Tcntr    Teff       lg_LH     lg_Lnuc     Mass       H_rich     H_cntr     N_cntr     Y_surf     X_avg     eta_cntr   pts  retry
       lg_dt_yr    lg_Dcntr    lg_R       lg_L3a    lg_Lneu     lg_Mdot    He_core    He_cntr    O_cntr     Z_surf     Y_avg     gam_cntr  iters bckup
            age    lg_Pcntr    lg_L       lg_LZ     lg_Psurf    lg_Dsurf   C_core     C_cntr     Ne_cntr    Z_cntr     Z_avg     v_div_cs     dt_limit
    __________________________________________________________________________________________________________________________________________________
    
            901   7.464247  2.859E+04   4.293831   4.293831  15.000000  15.000000   0.699804   0.002387   0.280000   0.699941  -5.930046    874      0
       2.515128   0.602226   0.810643 -33.103384   3.115247 -99.000000   0.000000   0.279999   0.009360   0.020000   0.280000   0.013816      2      0
     4.7741E+04  16.240936   4.399572 -99.000000   3.736601  -8.981681   0.000000   0.002260   0.002099  2.020E-02  2.006E-02 -0.130E-06    varcontrol

MESA will also display some pgstar plots that look like:

![HR Diagram](/assets/images/hr_00900.png "HR Diagram")

![TRho Profile](/assets/images/trho_profile_00900.png "TRho Profile")

This should run for about 950 steps before stopping with the following
message:

    stop because Lnuc_div_L >= Lnuc_div_L_zams_limit

## Resuming MESA

You are not limited to using the same parameter settings for an entire
run.  You can stop the run, edit the inlist file, and restart with new
settings.  This stop-restart mechanism has been carefully constructed
so that if you restart from an intermediate state without changing any
controls, you'll get exactly the same results.  For that to work, the
saved information must be complete, and that means there's a lot of
it.  To make this run fast, the restart information is dumped in
binary format.  These binary dumps are referred to as "photos" and are
saved in a subdirectory with the same name.

It should be emphasized that the photos are not intended for long-term
storage of models.  In particular, when you update to a new version of
MESA star, you should expect your existing photo files to become
obsolete.

If you scroll back in the terminal output from the run, you should
find a line that looks like (though the number may differ slightly
between MESA versions):

    save photos/x944 for model 944

indicating that one of these snapshots was automatically saved when
the run terminated.

Open up inlist\_project in your editor.  You can see there were two
stopping conditions,

{% highlight fortran %}
  ! stop when the star nears ZAMS (Lnuc/L > 0.99)
    Lnuc_div_L_zams_limit = 0.99d0
    stop_near_zams = .true.

  ! stop when the center abundance by mass of h1 drops below this limit
    xa_central_lower_limit_species(1) = 'h1'
    xa_central_lower_limit(1) = 1d-3
{% endhighlight %}

As MESA indicated in the termination message, we stopped because of
the first condition (naturally, ZAMS is before H-exhaustion).  Turn
off this stopping condition by editing your inlist so that

{% highlight fortran %}
    stop_near_zams = .false.
{% endhighlight %}

and save the inlist file.

Now we can restart using the photo and our new settings.  Try it.

    ./re x944

This resumes the run from model 944, but this time the run will stop
when our other condition is satisfied, when the central hydrogen
drops below 1e-3.  This will happen at about model number 1050.

## Saving a model

Remember that the photo file is a machine readable binary that is not
designed for portability to different machines or even to different
versions of MESA.  So we need another way to save a model so we can
use it later, perhaps as a starting model for later runs, or to send
to someone for them to use with their own copy of MESA.  For example,
if you find some bug in MESA, and the developers will want to see if
they can reproduce it on their machines.  You'll be asked to save a
model from just before the bug happens and send it in an email along
with your inlist.

Let's save a model file at the end of our run.  Go to the following
lines to the &star_job section of your inlist:

{% highlight fortran %}
  ! save a model at the end of the run
    save_model_when_terminate = .false.
    save_model_filename = '15M_at_TAMS.mod'
{% endhighlight %}

Tell MESA that you want to save a model file at the end by editing
your inlist and changing save\_model\_when\_terminate to true.

Save the file and then restart MESA from the same point as before.

    ./re x944

This time when the run terminates MESA will save a model named
15M\_at\_TAMS.mod.  Take a look and see.

## Loading a model

Now you could begin studying the post-main sequence evolution of
stars, starting a new MESA run using the model you've just saved.  In
order to do this your inlist might look like:

{% highlight fortran %}
&star_job

  ! start a run from a saved model
    load_saved_model = .true.
    saved_model_name = '15M_at_TAMS.mod'

  ! display on-screen plots
    pgstar_flag = .true.

/ !end of star_job namelist

&controls

  ! use C/O enhanced opacities
  ! important for He-burning onwards
    use_Type2_opacities = .true.
    Zbase = 0.02

  ! configure mass loss on RGB & AGB
    RGB_wind_scheme = 'Dutch'
    AGB_wind_scheme = 'Dutch'
    RGB_to_AGB_wind_switch = 1d-4
    Dutch_wind_eta = 0.8

/ ! end of controls namelist
{% endhighlight %}

If you want to try this out, save the preceding text as a file named
inlist\_load in your work directory.  Then edit your main inlist file
so that it will use "inlist\_load" instead of "inlist\_project"
everywhere within inlist (i.e., extra\_star\_job\_inlist1\_name and
extra\_controls\_inlist1\_name).


Then as usual, do

    ./rn

and MESA will start up using your newly saved file.  Unlike the
photos, saved models don't have a complete snapshot of the internal
state of the system.  Photos are guaranteed to give the same results;
saved models are not.  There may be small differences when you run a
saved model compared to what you saw in the run before you saved it.
The differences should be minor, so you shouldn't have to worry, but
don't be surprised by them.

## Learning about the many MESA options

After looking at the previous inlist, your more pressing question may
be "where did those options come from?" and "how do I find the options
appropriate for my problem?".  Your first stop should be the
instrument papers, which discuss the most important flags.

The files that contain a description of all of the MESA options and
their default values live in the directory

    $MESA_DIR/star/defaults

The options are organized by the namelist that they are a part of.  So
the file "controls.defaults" contains a discussion of options in the
controls namelist.

Suppose we want to learn more about what this "Dutch_wind" is.
Searching in controls.defaults for the word "Dutch" quickly leads to
the following summary of these options.

{% highlight fortran %}
! the "Dutch" wind scheme for massive stars combines results from
! several papers, all with authors mostly from the Netherlands.
   
! the particular combination we use is based on
   ! Glebbeek, E., et al, A&A 497, 255-264 (2009) [more Dutch authors!]

! for Teff > 1e4 and surface H > 0.4 by mass, use Vink et al 2001
   ! Vink, J.S., de Koter, A., & Lamers, H.J.G.L.M., 2001, A&A, 369, 574.
   
! for Teff > 1e4 and surface H < 0.4 by mass, use Nugis & Lamers 2000
   ! Nugis, T.,& Lamers, H.J.G.L.M., 2000, A&A, 360, 227
   
! for Teff < 1e4, 
   ! use de Jager if Dutch_wind_logT_scheme = 'de Jager'
      ! de Jager, C., Nieuwenhuijzen, H., & van der Hucht, K. A. 1988, A&AS, 72, 259.
   ! use van Loon if Dutch_wind_logT_scheme = 'van Loon'
      ! van Loon et al. 2005, A&A, 438, 273.
   ! use Nieuwenhuijzen if Dutch_wind_logT_scheme = 'Nieuwenhuijzen'
      ! Nieuwenhuijzen, H.; de Jager, C. 1990, A&A, 231, 134

Dutch_wind_lowT_scheme = 'de Jager'
{% endhighlight %}

You can browse through the .defaults files to familiarize yourself
with what's available.  It can be easy to be overwhelmed by the shear
number of options.  That's where the test_suite comes in handy.

## The "test suite" as a source of examples

Your first stop when setting up a new problem with MESA should be the
MESA test suite.  You will find a wide range of sample cases there.
Looking at the test\_suite inlists is a quick way to familiarize
yourself with the set of options relevant to your problem.  You may
want to copy an inlist from the test suite to one of your working
directories to use as a starting point for a project of your own.

Each test suite problem lives in a subdirectory of

    $MESA_DIR/star/test_suite

and you can find (slightly out-of-date, but still useful) descriptions
of most of the test problems on the [MESA Forum][test_suite].

[test_suite]:http://mesastar.org/documentation/tutorials
[high_mass]:http://mesastar.org/documentation/tutorials/massive-star-test-cases/high_mass/view

For example, take a look at the ["high mass" test case][high_mass].
It starts by creating a pre-main-sequence model of 100 Msun with
Z=0.02, and then it "relaxes" Z down to 1e-5 and the mass up to 110
Msun before starting the evolution.  It will take under 200 steps (and
a few minutes) to reach a central X of 0.5.  To try it yourself,

    cd star/test_suite/high_mass
    ./mk
    ./rn

You can do the same with any of the test\_suite cases.
