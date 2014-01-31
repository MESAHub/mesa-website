---
layout: default
title: using run_star_extras
permalink: run_star_extras.html
---
# How do you use run\_star\_extras.f?

Sometimes MESA's many options are not sufficient to tackle the problem
you're interested in solving.  MESA is designed such that for most
uses, one should not have to modify the main MESA code.  Instead, MESA
provides a file "run\_star\_extras.f" that has a variety of hooks.

## Activate run\_star\_extras.f

The first step in making use of these capabilities is to activate
them.  In the MESA work directory you made as part of the tutorial,
navigate to the src directory

    cd tutorial/src

and open up run\_star\_extras.f in your text editor of choice.  The
stock version of run\_star\_extras.f is quite boring.  It "includes"
another file which holds the default set of routines.

    include 'standard_run_star_extras.inc'

The routines included in this file are the ones we will want to
customize.  Because we want these modifications to apply only to this
working copy of MESA, and not to MESA as a whole, we want to replace
this include statement with the contents of the included file.

Delete the aforementioned include line and insert the contents of
$MESA\_DIR/include/standard\_run\_star\_extras.inc. (The command to
insert the contents of a file in emacs is C-x f <filename> or in vim
:r <filename>.)

Before we make any changes, we should check that the code compiles.

    cd ..
    ./mk

If it doesn't compile, make sure that you cleanly inserted the file
and removed the include line.

## Adding History & Profile Output

If you already looked at run\_star\_extras.f you may have noticed the
function \`how\_many\_extra\_history\_columns' and the subroutine
\`data\_for\_extra\_history\_columns'.  Adding new data to the history file
is as easy as editing these functions.

Perhaps we're interested in quantifying how centrally concentrated the
burning is. Let's add columns to our history file that track the
Lagrangian mass and physical radius interior to which 90% of the
nuclear energy generation takes place.

Let's indicate that we want to add two columns to our history file.

{% highlight fortran %}
integer function how_many_extra_history_columns(s, id, id_extra)
   type (star_info), pointer :: s
   integer, intent(in) :: id, id_extra
   how_many_extra_history_columns = 2
end function how_many_extra_history_columns
{% endhighlight %}

Now let's calculate the information we want to output.  This
subroutine has access to the star\_info pointer, so you can make use of
any of the quantities defined in star/private/star\_data.inc to compute
additional information about the star.  Here's a subroutine that
calculates what we want to know.  There are a few "best practices"
shown in this routine that are worth remembering, so read through the
code and pay attention to the comments.

{% highlight fortran %}
subroutine data_for_extra_history_columns(s, id, id_extra, n, names, vals, ierr)

   ! MESA provides routines for taking logarithms which will handle
   ! cases where you pass them zero, etc.  Take advantage of this!
   use num_lib, only : safe_log10

   type (star_info), pointer :: s
   integer, intent(in) :: id, id_extra, n
   character (len=maxlen_history_column_name) :: names(n)
   real(dp) :: vals(n)
   integer, intent(out) :: ierr

   real(dp), parameter :: frac = 0.90
   integer :: i
   real(dp) :: edot, edot_partial

   ! calculate the total nuclear energy release rate by integrating
   ! the specific rate (eps_nuc) over the star.  using the dot_product
   ! intrinsic is a common idiom for calculating integrated quantities.
   ! note that one needs to explicitly limit the range of the arrays.
   ! NEVER assume that the array size is the same as the number of zones.
   edot = dot_product(s% dm(1:s% nz), s% eps_nuc(1:s% nz))

   ! the center of the star is at i = s% nz and the surface at i = 1 .
   ! so go from the center outward until 90% of the integrated eps_nuc
   ! is enclosed.  exit and then i will contain the desired cell index.
   edot_partial = 0
   do i = s% nz, 1, -1
      edot_partial = edot_partial + s% dm(i) * s% eps_nuc(i)
      if (edot_partial .ge. (frac * edot)) exit
   end do

   ! note: do NOT add these names to history_columns.list
   ! the history_columns.list is only for the built-in log column options.
   ! it must not include the new column names you are adding here.

   ! column 1
   names(1) = "m90"
   vals(1) = s% q(i) * s% star_mass  ! in solar masses

   ! column 2
   names(2) = "log_R90"
   vals(2) = safe_log10(s% R(i) / rsol) ! in solar radii

   ierr = 0
end subroutine data_for_extra_history_columns
{% endhighlight %}

## New Profile Output

Adding new output to the profiles, proceeds by close analogy to the
history, using the function \`how\_many\_extra\_profile\_columns' and the
subroutine \`data\_for\_extra\_profile\_columns'.

Here I've just uncommented the stock example.

{% highlight fortran %}
integer function how_many_extra_profile_columns(s, id, id_extra)
   type (star_info), pointer :: s
   integer, intent(in) :: id, id_extra
   how_many_extra_profile_columns = 1
end function how_many_extra_profile_columns

subroutine data_for_extra_profile_columns(s, id, id_extra, n, nz, names, vals, ierr)
   type (star_info), pointer :: s
   integer, intent(in) :: id, id_extra, n, nz
   character (len=maxlen_profile_column_name) :: names(n)
   real(dp) :: vals(nz,n)
   integer, intent(out) :: ierr
   integer :: k
   ierr = 0

   ! note: do NOT add these names to profile_columns.list
   ! the profile_columns.list is only for the built-in profile column options.
   ! it must not include the new column names you are adding here.

   ! here is an example for adding a profile column
   if (n /= 1) stop 'data_for_extra_profile_columns'
   names(1) = 'beta'
   do k = 1, nz
     vals(k,1) = s% Pgas(k)/s% P(k)
   end do

end subroutine data_for_extra_profile_columns
{% endhighlight %}

## Choosing when to output history or profiles

Frequently, you want to output a profile or update the history at a
set of milestones along the way.  This is especially true for the
profiles, when it's not possible (or even desirable) to save and store
a profile every few steps.

The star\_info structure has a couple of flags &#x2013;
need\_to\_save\_profiles\_now and need\_to\_update\_history\_now &#x2013; that let
you tell MESA that it is time to output data.

The place to set these is in the function extras\_finish\_step which
will get called at the end of each step.

For our massive star, let's dump a profile at logarithmically-spaced
intervals in central density.  We will let the user specify the number
of divisions per decade.  We need to be careful, because the
trajectory in rho-T space is not guaranteed to be monotonic.

Here's some code to do just that.  Again, read though it as the
comments discuss some useful MESA features.

{% highlight fortran %}
! returns either keep_going or terminate.
! note: cannot request retry or backup; extras_check_model can do that.
integer function extras_finish_step(s, id, id_extra)
   type (star_info), pointer :: s
   integer, intent(in) :: id, id_extra
   integer :: ierr
   integer :: f
   extras_finish_step = keep_going
   call store_extra_info(s)

   ! MESA provides a number of variables that make it easy to get user input.
   ! these are part of the star_info structure and are named
   ! x_character_ctrl, x_integer_ctrl, x_logical_ctrl, and x_ctrl.
   ! by default there are num_x_ctrls, which defaults to 100, of each.
   ! they can be specified in the controls section of your inlist.

   f = s% x_integer_ctrl(1)

   ! MESA also provides a number variables that are useful for implementing
   ! algorithms which require a state. if you just use these variables
   ! restarts, retries, and backups will work without doing anything special.
   ! they are named xtra1 .. xtra30, ixtra1 .. ixtra30, and lxtra1 .. lxtra30.
   ! they are automatically versioned, that is if you set s% xtra1, then
   ! s% xtra1_old will contains the value of s% xtra1 from the previous step
   ! and s% xtra1_older contains the one from two steps ago.

   s% xtra1 = s% log_center_density

   ! this expression will evaluate to true if f times the log center density
   ! has crossed an integer during the last step.  If f = 5, then we will get
   ! output at log center density = {... 1.0, 1.2, 1.4, 1.6, 1.8, 2.0 ... }
   if ((floor(f * s% xtra1_old) - floor(f * s% xtra1) .ne. 0)) then

      ! save a profile & update the history
      s% need_to_update_history_now = .true.
      s% need_to_save_profiles_now = .true.

      ! by default the priority is 1; you can change that if you'd like
      ! s% save_profiles_model_priority = ?

   endif

end function extras_finish_step
{% endhighlight %}

To prevent you from filling up your disk, MESA will only save a
limited number of profiles.  The default is 100.  Here's what Bill has
to say in star/defaults/controls.defaults.

{% highlight fortran %}
 max_num_profile_models = 100  ! < 0 means no limit
    ! maximum number of saved profiles
    ! if there's no limit on the number of profiles saved,
    ! you can fill up your disk -- I've done it.
    ! so it's a good idea to set this limit to a reasonable number such as 20 or 30.
    ! once that many have been saved during a run, old ones will be discarded
    ! to make room for new ones.
    ! profiles that were saved for key events are given priority
    ! and aren't removed as long as there
    ! is a lower priority profile that can be discarded instead.
{% endhighlight %}

If you want to be sure the profiles that you're triggering in
extras\_finish\_step stick around &#x2013; perhaps you're making a movie &#x2013;
you should set max\_num\_profile\_models to be greater that the number of
profiles you anticipate generating.  You might also want to crank up
the priority which with they are saved by setting
save\_profiles\_model\_priority to be 10.  This will prevent MESA from
discarding them in lieu of other automatically saved profiles.

# Adding a custom stopping condition

MESA provides many ways to choose when to terminate a run.  If your
condition can be expressed as "stop when quantity X rises above or
falls below some limit", there's a good chance that you can choose to
stop simply by setting a few existing flags.  Take a look at the "when
to stop" section of star/defaults/controls.defaults, which starts
around line 230.

If your condition isn't there or is a more complicated logical
combination of conditions, then you will probably need to implement it
yourself.

The place to do this in the subroutine extras\_check\_model.  (You can
also use this routine to trigger backups or retries.)

Here's a routine that stops when the star's luminosity is dominated by
neon burning.

{% highlight fortran %}
    ! returns either keep_going, retry, backup, or terminate.
    integer function extras_check_model(s, id, id_extra)

       use chem_def, only : i_burn_ne, category_name

       type (star_info), pointer :: s
       integer, intent(in) :: id, id_extra
       integer :: i_burn_max
       extras_check_model = keep_going

       ! determine the category of maximum burning
       i_burn_max = maxloc(s% L_by_category,1)

       ! stop if the luminosity is dominated by neon burning
       if ( i_burn_max .eq. i_burn_ne) then
          extras_check_model = terminate
          write(*, *) 'terminating because neon burning is dominant'
          return
       end if
    end function extras_check_model
{% endhighlight %}

# Using the "other" hooks

MESA provides a way to override most of the physics routines with no
need to modify anything more than run\_star\_extras.  There are two main
steps needed to take advantage of this functionality.  In the
following example, we will add controls that allow us to control the
various non-nuclear neutrino losses (e.g. plasmon, bremsstrahlung) in
our massive star.

## Writing a routine

Navigate to $MESA\_DIR/star/other, where you will see a set of files
named with the pattern other\_\\\*.f, where the wildcard match describes
some sort of MESA physics (e.g. other\_neu.f, other\_wind.f ).

Find the one corresponding to the physics that you want to alter.
Open it up and read through the contents.  Many of the files have
helpful comments and examples.

Note that we do not want to directly edit these files.  Instead we
want to copy the template routines that these files provide into our
working directory copy of run\_star\_extras.f and then further modify
them there.  The template routines are named either null\_other\_\\\* or
default\_other\_\\\*.

For our neutrino example, copy the following subroutine into
run\_star\_extras.f.

{% highlight fortran %}
subroutine null_other_neu(  &
      id, k, T, log10_T, Rho, log10_Rho, abar, zbar, z2bar, log10_Tlim, flags, &
      loss, sources, ierr)
   use neu_lib, only: neu_get
   use neu_def
   integer, intent(in) :: id ! id for star
   integer, intent(in) :: k ! cell number or 0 if not for a particular cell
   real(dp), intent(in) :: T ! temperature
   real(dp), intent(in) :: log10_T ! log10 of temperature
   real(dp), intent(in) :: Rho ! density
   real(dp), intent(in) :: log10_Rho ! log10 of density
   real(dp), intent(in) :: abar ! mean atomic weight
   real(dp), intent(in) :: zbar ! mean charge
   real(dp), intent(in) :: z2bar ! mean charge squared
   real(dp), intent(in) :: log10_Tlim
   logical, intent(inout) :: flags(num_neu_types) ! true if should include the type of loss
   real(dp), intent(out) :: loss(num_neu_rvs) ! total from all sources
   real(dp), intent(out) :: sources(num_neu_types, num_neu_rvs)
   integer, intent(out) :: ierr
   call neu_get(  &
      T, log10_T, Rho, log10_Rho, abar, zbar, z2bar, log10_Tlim, flags, &
      loss, sources, ierr)
end subroutine null_other_neu
{% endhighlight %}

This template routine illustrates the interface and as is, it will
produce exactly the same results as the default MESA routine.  This is
useful because the most frequent sorts of modifications that one wants
to make are based on modifying information that MESA already
calculates as opposed to a wholesale re-implementation of the physics
routines.

In this case, we want to add controls that will allow us to toggle
whether specific kinds of non-nuclear neutrino losses are included.

Let's rename the subroutine and add the functionality that we want.

{% highlight fortran %}
subroutine tutorial_other_neu(  &
     id, k, T, log10_T, Rho, log10_Rho, abar, zbar, z2bar, log10_Tlim, flags, &
     loss, sources, ierr)
   use neu_lib, only: neu_get
   use neu_def
   integer, intent(in) :: id ! id for star
   integer, intent(in) :: k ! cell number or 0 if not for a particular cell
   real(dp), intent(in) :: T ! temperature
   real(dp), intent(in) :: log10_T ! log10 of temperature
   real(dp), intent(in) :: Rho ! density
   real(dp), intent(in) :: log10_Rho ! log10 of density
   real(dp), intent(in) :: abar ! mean atomic weight
   real(dp), intent(in) :: zbar ! mean charge
   real(dp), intent(in) :: z2bar ! mean charge squared
   real(dp), intent(in) :: log10_Tlim
   logical, intent(inout) :: flags(num_neu_types) ! true if should include the type of loss
   real(dp), intent(out) :: loss(num_neu_rvs) ! total from all sources
   real(dp), intent(out) :: sources(num_neu_types, num_neu_rvs)
   integer, intent(out) :: ierr

   ! before we can use controls associated with the star we need to get access
   type (star_info), pointer :: s
   call star_ptr(id, s, ierr)
   if (ierr /= 0) then ! OOPS
      return
   end if

   ! separately control whether each type of neutrino loss is included
   flags(pair_neu_type) = s% x_logical_ctrl(1)
   flags(plas_neu_type) = s% x_logical_ctrl(2)
   flags(phot_neu_type) = s% x_logical_ctrl(3)
   flags(brem_neu_type) = s% x_logical_ctrl(4)
   flags(reco_neu_type) = s% x_logical_ctrl(5)

   ! the is the normal routine that MESA provides
   call neu_get(  &
       T, log10_T, Rho, log10_Rho, abar, zbar, z2bar, log10_Tlim, flags, &
       loss, sources, ierr)

end subroutine tutorial_other_neu
{% endhighlight %}

## Instruct MESA to use your routine

There are two things that you must do in order to have MESA execute
your other\_\\\* routine.  Failure to do both of these is the most common
problem people encounter when using the other\_\\\* hooks.

First, edit the controls section of your inlist to set the appropriate
use\_other\_\\\* flag to .true. .  In our example, this means adding the line

    use_other_neu = .true.

Second, edit the extras\_controls routine in run\_star\_extras.f to point
the other\_neu at the routine you want to be executed.

{% highlight fortran %}
subroutine extras_controls(s, ierr)
   type (star_info), pointer :: s
   integer, intent(out) :: ierr
   ierr = 0

   ! this is the place to set any procedure pointers you want to change
   ! e.g., other_wind, other_mixing, other_energy  (see star_data.inc)
   s% other_neu => tutorial_other_neu

end subroutine extras_controls
{% endhighlight %}

Now, recompile your working directory

    ./mk

and run MESA as usual.
