<h1 id="specifications_for_starting_model">specifications for starting model <a href="#specifications_for_starting_model" title="Permalink to this location">¶</a></h1>


NOTE: if you are loading a saved model,
then the following initial values are NOT USED to modify the model.
in particular, you cannot use these to change Y or Z of an existing model.
if you want to do that, see `star_job.defaults` controls such as `change_Y`.
however, these are reported in output as the initial values for the star.

<h3 id="initial_mass">initial_mass <a href="#initial_mass" title="Permalink to this location">¶</a></h3>


initial mass in Msun units.
can be any value you'd like when  you are creating a pre-main sequence model.

not used when loading a saved model.
however is reported in output as the initial mass of the star.

if you are loading a ZAMS model and the requested mass is in the range of
prebuilt models, the code will interpolate in mass using the closest prebuilt models.
if the requested mass is beyond the range of the prebuilt models, the code will
load the closest one and then call "relax mass" to create a model to match the request.
the prebuilt range is 0.08 Msun to 100 Msun, so the `relax_mass`
method is only used for extreme cases.  there are enough prebuilt models that the
interpolation in mass seems to work fine for many applications.

{% highlight fortran %}
initial_mass = 1
{% endhighlight %}


<h3 id="initial_z">initial_z <a href="#initial_z" title="Permalink to this location">¶</a></h3>


initial metallicity for create pre-ms and create initial model
`initial_z` can be any value from 0 to 0.04

not used when loading a saved model.
however is reported in output as the initial Z of the star.

however, if you are loading a zams model,
then `initial_z` must match one of the prebuilt values.
look in the `'data/star_data/zams_models'` directory
to see what prebuilt zams Z's are available.
at time of writing, only 0.02 was included in the standard version of star.

{% highlight fortran %}
initial_z = 0.02d0
{% endhighlight %}


<h3 id="initial_y">initial_y <a href="#initial_y" title="Permalink to this location">¶</a></h3>


initial helium mass fraction for create pre-ms and create initial
(< 0 means use default which is 0.24 + 2*initial_z)

not used when loading a saved model or a zams model.
however is reported in output as the initial Y of the star.

NOTE: this is only used for create pre-main-sequence model
and create initial model, and not when loading a zams model.

{% highlight fortran %}
initial_y = -1
{% endhighlight %}


<h3 id="initial_he3">initial_he3 <a href="#initial_he3" title="Permalink to this location">¶</a></h3>


initial mass fraction of he3. Must be smaller than initial_y.
(< 0 means use default which is taken as solar scaled such
that he4/he3 has the same value as the Sun)

not used when loading a saved model or a zams model.

{% highlight fortran %}
initial_he3 = -1
{% endhighlight %}

<h1 id="controls_for_output">controls for output <a href="#controls_for_output" title="Permalink to this location">¶</a></h1>


<h3 id="terminal_interval">terminal_interval <a href="#terminal_interval" title="Permalink to this location">¶</a></h3>


write info to terminal when `mod(model_number, terminal_interval) = 0`.
note: this replaces the obsolete control `terminal_cnt`.

{% highlight fortran %}
terminal_interval = 1
{% endhighlight %}


<h3 id="write_header_frequency">write_header_frequency <a href="#write_header_frequency" title="Permalink to this location">¶</a></h3>


output the log header info to the terminal
when `mod(model_number, write_header_frequency*terminal_interval) = 0`.

{% highlight fortran %}
write_header_frequency = 10
{% endhighlight %}


<h3 id="extra_terminal_output_file">extra_terminal_output_file <a href="#extra_terminal_output_file" title="Permalink to this location">¶</a></h3>


if not empty, output terminal info to this file in addition to terminal.
this does not capture all of the terminal output -- just the common items.
it is intended for use in situations where you cannot directly see the terminal output
such as when running on a cluster.  if you want to be able to monitor
the progress for such cases, you can set `extra_terminal_output_file = 'log'`
and then do `tail -f log` to view the terminal output as it is recorded in the file.

{% highlight fortran %}
extra_terminal_output_file = ''
{% endhighlight %}


<h3 id="terminal_show_age_in_years">terminal_show_age_in_years <a href="#terminal_show_age_in_years" title="Permalink to this location">¶</a></h3>


if false, then show in seconds

{% highlight fortran %}
terminal_show_age_in_years = .true.
{% endhighlight %}


<h3 id="terminal_show_age_in_days">terminal_show_age_in_days <a href="#terminal_show_age_in_days" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
terminal_show_age_in_days = .false.
{% endhighlight %}


<h3 id="num_trace_history_values">num_trace_history_values <a href="#num_trace_history_values" title="Permalink to this location">¶</a></h3>


any valid name for a history data column, such as `surf_v_rot`
for example if you have rapid rotation at the surface,
you might want to try something like this:

    num_trace_history_values = 7
    trace_history_value_name(1) = 'surf_v_rot'
    trace_history_value_name(2) = 'surf_omega_div_omega_crit'
    trace_history_value_name(3) = 'log_rotational_mdot_boost'
    trace_history_value_name(4) = 'log_total_angular_momentum'
    trace_history_value_name(5) = 'center n14'
    trace_history_value_name(6) = 'surface n14'
    trace_history_value_name(7) = 'average n14'

value must be less than or equal to 10

{% highlight fortran %}
num_trace_history_values = 0
{% endhighlight %}


<h3 id="trace_history_value_name">trace_history_value_name(:) <a href="#trace_history_value_name" title="Permalink to this location">¶</a></h3>


write values to terminal

{% highlight fortran %}
trace_history_value_name(:) = ''
{% endhighlight %}


<h3 id="photo_directory">photo_directory <a href="#photo_directory" title="Permalink to this location">¶</a></h3>


directory for binary snapshots used in restarts

{% highlight fortran %}
photo_directory = 'photos'
{% endhighlight %}


<h3 id="photo_interval">photo_interval <a href="#photo_interval" title="Permalink to this location">¶</a></h3>


save a photo file for possible restarting when `mod(model_number, photo_interval) = 0`.
note: this replaces the obsolete control `photostep`.

{% highlight fortran %}
photo_interval = 50
{% endhighlight %}


<h3 id="photo_digits">photo_digits <a href="#photo_digits" title="Permalink to this location">¶</a></h3>


use this many digits from the end of the `model_number` for the photo name

{% highlight fortran %}
photo_digits = 3
{% endhighlight %}


<h3 id="log_directory">log_directory <a href="#log_directory" title="Permalink to this location">¶</a></h3>


for data files about the run

{% highlight fortran %}
log_directory = 'LOGS'
{% endhighlight %}


<h3 id="do_history_file">do_history_file <a href="#do_history_file" title="Permalink to this location">¶</a></h3>


history file is created if this is true

{% highlight fortran %}
do_history_file = .true.
{% endhighlight %}


<h3 id="history_interval">history_interval <a href="#history_interval" title="Permalink to this location">¶</a></h3>


append an entry to the history.data file when `mod(model_number, history_interval) = 0`.

{% highlight fortran %}
history_interval = 5
{% endhighlight %}


<h3 id="star_history_name">star_history_name <a href="#star_history_name" title="Permalink to this location">¶</a></h3>


name of history file

{% highlight fortran %}
star_history_name = 'history.data'
{% endhighlight %}


<h3 id="star_history_header_name">star_history_header_name <a href="#star_history_header_name" title="Permalink to this location">¶</a></h3>


If not empty, then put star history header info in `star_history_name` file.
In this case the history file has only data, making it easier
to use with some plotting packages.

{% highlight fortran %}
star_history_header_name = ''
{% endhighlight %}


<h3 id="star_history_dbl_format">star_history_dbl_format <a href="#star_history_dbl_format" title="Permalink to this location">¶</a></h3>


format for writing reals to `star_history_name` file

{% highlight fortran %}
star_history_dbl_format = '(1pes40.16e3, 1x)'
{% endhighlight %}


<h3 id="star_history_int_format">star_history_int_format <a href="#star_history_int_format" title="Permalink to this location">¶</a></h3>


format for writing integer to `star_history_name` file

{% highlight fortran %}
star_history_int_format = '(i40, 1x)'
{% endhighlight %}


<h3 id="star_history_txt_format">star_history_txt_format <a href="#star_history_txt_format" title="Permalink to this location">¶</a></h3>


format for writing characters to `star_history_name` file

{% highlight fortran %}
star_history_txt_format = '(a40, 1x)'
{% endhighlight %}


<h3 id="write_profiles_flag">write_profiles_flag <a href="#write_profiles_flag" title="Permalink to this location">¶</a></h3>


profiles are written only if this is true

{% highlight fortran %}
write_profiles_flag = .true.
{% endhighlight %}


<h3 id="profile_interval">profile_interval <a href="#profile_interval" title="Permalink to this location">¶</a></h3>


save a model profile info when `mod(model_number, profile_interval) = 0`.

{% highlight fortran %}
profile_interval = 50
{% endhighlight %}


<h3 id="priority_profile_interval">priority_profile_interval <a href="#priority_profile_interval" title="Permalink to this location">¶</a></h3>


give saved profile a higher priority for retention when
`mod(model_number, priority_profile_interval) = 0`.

{% highlight fortran %}
priority_profile_interval = 1000
{% endhighlight %}


<h3 id="profiles_index_name">profiles_index_name <a href="#profiles_index_name" title="Permalink to this location">¶</a></h3>


name of the profile index file

{% highlight fortran %}
profiles_index_name = 'profiles.index'
{% endhighlight %}


<h3 id="profiles_data_prefix">profiles_data_prefix <a href="#profiles_data_prefix" title="Permalink to this location">¶</a></h3>


prefix of the profile data

{% highlight fortran %}
profile_data_prefix = 'profile'
{% endhighlight %}


<h3 id="profiles_data_suffix">profiles_data_suffix <a href="#profiles_data_suffix" title="Permalink to this location">¶</a></h3>


suffix of the profile data

{% highlight fortran %}
profile_data_suffix = '.data'
{% endhighlight %}


<h3 id="profile_data_header_suffix">profile_data_header_suffix <a href="#profile_data_header_suffix" title="Permalink to this location">¶</a></h3>


If not empty, then put profile data header info here.
In this case the profile data file has only data, making it easier
to use with some plotting packages.

{% highlight fortran %}
profile_data_header_suffix = ''
{% endhighlight %}


<h3 id="profile_dbl_format">profile_dbl_format <a href="#profile_dbl_format" title="Permalink to this location">¶</a></h3>


format for writing reals to profile file

{% highlight fortran %}
profile_dbl_format = '(1pes40.16e3, 1x)'
{% endhighlight %}


<h3 id="profile_int_format">profile_int_format <a href="#profile_int_format" title="Permalink to this location">¶</a></h3>


format for writing integers to profile file

{% highlight fortran %}
profile_int_format = '(i40, 1x)'
{% endhighlight %}


<h3 id="profile_txt_format">profile_txt_format <a href="#profile_txt_format" title="Permalink to this location">¶</a></h3>


format for writing characters to profile file

{% highlight fortran %}
profile_txt_format = '(a40, 1x)'
{% endhighlight %}


<h3 id="max_num_profile_zones">max_num_profile_zones <a href="#max_num_profile_zones" title="Permalink to this location">¶</a></h3>


if `nz > this`, then only write a subsample of the zones.
only used if > 1

{% highlight fortran %}
max_num_profile_zones = -1
{% endhighlight %}


<h3 id="max_num_profile_models">max_num_profile_models <a href="#max_num_profile_models" title="Permalink to this location">¶</a></h3>


Maximum number of saved profiles.
If there's no limit on the number of profiles saved,
you can fill up your disk -- I've done it.
So it's a good idea to set this limit to a reasonable number such as 20 or 30.
Once that many have been saved during a run, old ones will be discarded
to make room for new ones.
Profiles that were saved for key events are given priority
and aren't removed as long as there
is a lower priority profile that can be discarded instead.
Less than zero means no limit.

{% highlight fortran %}
max_num_profile_models = 100
{% endhighlight %}


<h3 id="profile_model">profile_model <a href="#profile_model" title="Permalink to this location">¶</a></h3>


save profile when `model_number` equals this

{% highlight fortran %}
profile_model = -1
{% endhighlight %}


<h3 id="write_model_with_profile">write_model_with_profile <a href="#write_model_with_profile" title="Permalink to this location">¶</a></h3>


if this is true, models are written at same time as profiles

{% highlight fortran %}
write_model_with_profile = .false.
{% endhighlight %}


<h3 id="model_data_prefix">model_data_prefix <a href="#model_data_prefix" title="Permalink to this location">¶</a></h3>


prefix of the model data files

{% highlight fortran %}
model_data_prefix = 'profile'
{% endhighlight %}


<h3 id="model_data_suffix">model_data_suffix <a href="#model_data_suffix" title="Permalink to this location">¶</a></h3>


suffix of the model data files

{% highlight fortran %}
model_data_suffix = '.mod'
{% endhighlight %}


<h3 id="write_controls_info_with_profile">write_controls_info_with_profile <a href="#write_controls_info_with_profile" title="Permalink to this location">¶</a></h3>


if this is true, the values of the options in the controls
inlist are written at same time as profiles

{% highlight fortran %}
write_controls_info_with_profile = .false.
{% endhighlight %}


<h3 id="controls_data_prefix">controls_data_prefix <a href="#controls_data_prefix" title="Permalink to this location">¶</a></h3>


prefix of the control data files

{% highlight fortran %}
controls_data_prefix = 'controls'
{% endhighlight %}


<h3 id="controls_data_suffix">controls_data_suffix <a href="#controls_data_suffix" title="Permalink to this location">¶</a></h3>


suffix of the control data files

{% highlight fortran %}
controls_data_suffix = '.data'
{% endhighlight %}


<h3 id="mixing_D_limit_for_log">mixing_D_limit_for_log <a href="#mixing_D_limit_for_log" title="Permalink to this location">¶</a></h3>


if max `D_mix` in mixing region is less than this, don't include the region in the log
doesn't apply to thermohaline or semiconvective regions

{% highlight fortran %}
mixing_D_limit_for_log = 1d4
{% endhighlight %}


<h3 id="eta_RTI_limit_for_log">eta_RTI_limit_for_log <a href="#eta_RTI_limit_for_log" title="Permalink to this location">¶</a></h3>


if `eta_RTI` is less than this, treat it as zero for history log

{% highlight fortran %}
eta_RTI_limit_for_log = 1d4
{% endhighlight %}


<h3 id="mass_loc_for_extra_log_info">mass_loc_for_extra_log_info <a href="#mass_loc_for_extra_log_info" title="Permalink to this location">¶</a></h3>


log contains info about this mass location in the model
negative value means "don't bother"

{% highlight fortran %}
mass_loc_for_extra_log_info = -1
{% endhighlight %}


<h3 id="write_pulse_data_with_profile">write_pulse_data_with_profile <a href="#write_pulse_data_with_profile" title="Permalink to this location">¶</a></h3>


if true, write pulse info file when writing profile

{% highlight fortran %}
write_pulse_data_with_profile = .false.
{% endhighlight %}


<h3 id="pulse_data_format">pulse_data_format <a href="#pulse_data_format" title="Permalink to this location">¶</a></h3>


pulsation code format, e.g., 'FGONG', 'OSC', 'GYRE'

{% highlight fortran %}
pulse_data_format = 'FGONG'
{% endhighlight %}


<h3 id="add_atmosphere_to_pulse_data">add_atmosphere_to_pulse_data <a href="#add_atmosphere_to_pulse_data" title="Permalink to this location">¶</a></h3>


if true, write atmosphere to pulse files

{% highlight fortran %}
add_atmosphere_to_pulse_data = .false.
{% endhighlight %}


<h3 id="add_center_point_to_pulse_data">add_center_point_to_pulse_data <a href="#add_center_point_to_pulse_data" title="Permalink to this location">¶</a></h3>


if true, add point for r=0 to pulse files

{% highlight fortran %}
add_center_point_to_pulse_data = .true.
{% endhighlight %}


<h3 id="keep_surface_point_for_pulse_data">keep_surface_point_for_pulse_data <a href="#keep_surface_point_for_pulse_data" title="Permalink to this location">¶</a></h3>


if true, add k=1 cell to pulse files

{% highlight fortran %}
keep_surface_point_for_pulse_data = .false.
{% endhighlight %}


<h3 id="add_double_points_to_pulse_data">add_double_points_to_pulse_data <a href="#add_double_points_to_pulse_data" title="Permalink to this location">¶</a></h3>


add double points at discontinuities

{% highlight fortran %}
add_double_points_to_pulse_data = .false.
{% endhighlight %}


<h3 id="interpolate_rho_for_pulse_data">interpolate_rho_for_pulse_data <a href="#interpolate_rho_for_pulse_data" title="Permalink to this location">¶</a></h3>


If true, then get `rho_face` by interpolating rho at cell center.
If false, then calculate rho_face by `dm/(4*pi*r^2*dr)`.

{% highlight fortran %}
interpolate_rho_for_pulse_data = .true.
{% endhighlight %}


<h3 id="threshold_grad_mu_for_double_point">threshold_grad_mu_for_double_point <a href="#threshold_grad_mu_for_double_point" title="Permalink to this location">¶</a></h3>


threshold in grad_mu = dln(mu)/dln(P) for a double point to be written

{% highlight fortran %}
threshold_grad_mu_for_double_point = 10d0
{% endhighlight %}


<h3 id="max_number_of_double_points">max_number_of_double_points <a href="#max_number_of_double_points" title="Permalink to this location">¶</a></h3>


maximum number of double points to be written (0 = no limit); when this limit
is set, double points are chosen in order of decreasing |grad_mu|

{% highlight fortran %}
max_number_of_double_points = 0
{% endhighlight %}


<h3 id="format_for_FGONG_data">format_for_FGONG_data <a href="#format_for_FGONG_data" title="Permalink to this location">¶</a></h3>


This is the 'wide' FGONG format, as agreed on at the
5th Aarhus RGB workshop (University of Birmingham, UK, October 2015)

{% highlight fortran %}
format_for_FGONG_data = '(1P,5(X,E26.18E3))'
{% endhighlight %}


<h3 id="format_for_OSC_data">format_for_OSC_data <a href="#format_for_OSC_data" title="Permalink to this location">¶</a></h3>


[FGONG Format Documentation]
(http://www.astro.up.pt/corot/ntools/docs/CoRoT_ESTA_Files.pdf)

{% highlight fortran %}
format_for_OSC_data = '(1P5E19.12,x)'
{% endhighlight %}


<h3 id="write_pulsation_plot_data">write_pulsation_plot_data <a href="#write_pulsation_plot_data" title="Permalink to this location">¶</a></h3>


if true and saving pulsation info, also write out text file in column format for plotting

{% highlight fortran %}
write_pulsation_plot_data = .false.
{% endhighlight %}


<h3 id="max_num_gyre_points">max_num_gyre_points <a href="#max_num_gyre_points" title="Permalink to this location">¶</a></h3>


limit gyre output files to at most this number of points
only used when > 1

{% highlight fortran %}
max_num_gyre_points = -1
{% endhighlight %}


<h3 id="fgong_zero_A_inside_r">fgong_zero_A_inside_r <a href="#fgong_zero_A_inside_r" title="Permalink to this location">¶</a></h3>


when writing FGONG, if r < this and cell has mixing of some kind, force A = 0
Rsun units

{% highlight fortran %}
fgong_zero_A_inside_r = 0d0
{% endhighlight %}


<h3 id="trace_mass_location">trace_mass_location <a href="#trace_mass_location" title="Permalink to this location">¶</a></h3>


location for `trace_mass_radius`, `trace_mass_logT`, etc. (Msun units)

{% highlight fortran %}
trace_mass_location = 0
{% endhighlight %}


<h3 id="min_tau_for_max_abs_v_location">min_tau_for_max_abs_v_location <a href="#min_tau_for_max_abs_v_location" title="Permalink to this location">¶</a></h3>


controls choice of location in model for `max_abs_v` history info.
can use this to exclude locations too close to surface.
ignore if <= 0

{% highlight fortran %}
min_tau_for_max_abs_v_location = 0
{% endhighlight %}


<h3 id="min_q_for_inner_mach1_location">min_q_for_inner_mach1_location <a href="#min_q_for_inner_mach1_location" title="Permalink to this location">¶</a></h3>


controls choice of location in model for innermost mach 1 history info.
can use this to exclude locations too close to center.

{% highlight fortran %}
min_q_for_inner_mach1_location = 0
{% endhighlight %}


<h3 id="max_q_for_outer_mach1_location">max_q_for_outer_mach1_location <a href="#max_q_for_outer_mach1_location" title="Permalink to this location">¶</a></h3>


controls choice of location in model for outermost mach 1 history info.
can use this to exclude locations too close to surface.

{% highlight fortran %}
max_q_for_outer_mach1_location = 1
{% endhighlight %}


<h3 id="burn_min1">burn_min1 <a href="#burn_min1" title="Permalink to this location">¶</a></h3>


used for reporting where burning zone occur, for example in the pgstar TRho profiles.
see `star/public/star_data.inc` for details.
must be < `burn_min2`.
In ergs/g/sec.

{% highlight fortran %}
burn_min1 = 50
{% endhighlight %}


<h3 id="burn_min2">burn_min2 <a href="#burn_min2" title="Permalink to this location">¶</a></h3>


used for reporting where burning zone occur, for example in the pgstar TRho profiles.
see `star/public/star_data.inc` for details.
In ergs/g/sec.

{% highlight fortran %}
burn_min2 = 1000
{% endhighlight %}


<h3 id="max_conv_vel_div_csound_maxq">max_conv_vel_div_csound_maxq <a href="#max_conv_vel_div_csound_maxq" title="Permalink to this location">¶</a></h3>


only consider from center out to this location

{% highlight fortran %}
max_conv_vel_div_csound_maxq = 1
{% endhighlight %}


<h3 id="width_for_limit_conv_vel">width_for_limit_conv_vel <a href="#width_for_limit_conv_vel" title="Permalink to this location">¶</a></h3>


look this number of cells on either side of boundary to see if
any boundary k in that range has s% csound(k) < s% v(k) <= s% csound(k-1)
i.e. transition from subsonic to supersonic as go inward
if find any such transition then don't allow increase in convection velocity.
this implies no change from radiative to convective.
the purpose of this is to prevent convective energy transport
from moving energy from behind a shock to in front of the shock.

{% highlight fortran %}
width_for_limit_conv_vel = 3
{% endhighlight %}


<h3 id="max_q_for_limit_conv_vel">max_q_for_limit_conv_vel <a href="#max_q_for_limit_conv_vel" title="Permalink to this location">¶</a></h3>


for q(k) <= this, don't allow conv_vel to grow

{% highlight fortran %}
max_q_for_limit_conv_vel = -1
{% endhighlight %}


<h3 id="max_r_in_cm_for_limit_conv_vel">max_r_in_cm_for_limit_conv_vel <a href="#max_r_in_cm_for_limit_conv_vel" title="Permalink to this location">¶</a></h3>


for r(k) <= this, don't allow conv_vel to grow

{% highlight fortran %}
max_r_in_cm_for_limit_conv_vel = -1
{% endhighlight %}


<h3 id="max_mass_in_gm_for_limit_conv_vel">max_mass_in_gm_for_limit_conv_vel <a href="#max_mass_in_gm_for_limit_conv_vel" title="Permalink to this location">¶</a></h3>


for m(k) <= this, don't allow conv_vel to grow

{% highlight fortran %}
max_mass_in_gm_for_limit_conv_vel = -1
{% endhighlight %}


<h3 id="center_avg_value_dq">center_avg_value_dq <a href="#center_avg_value_dq" title="Permalink to this location">¶</a></h3>


reported center values are averages over this fraction of star mass

{% highlight fortran %}
center_avg_value_dq = 1d-8
{% endhighlight %}


<h3 id="surface_avg_abundance_dq">surface_avg_abundance_dq <a href="#surface_avg_abundance_dq" title="Permalink to this location">¶</a></h3>


reported surface abundances are averages over this fraction of star mass

{% highlight fortran %}
surface_avg_abundance_dq = 1d-8
{% endhighlight %}


<h3 id="mass_depth_for_L_surf">mass_depth_for_L_surf <a href="#mass_depth_for_L_surf" title="Permalink to this location">¶</a></h3>


only if `use_flux_limiting_with_dPrad_dm_form`

{% highlight fortran %}
mass_depth_for_L_surf = 0d0
{% endhighlight %}


<h3 id="conv_core_gap_dq_limit">conv_core_gap_dq_limit <a href="#conv_core_gap_dq_limit" title="Permalink to this location">¶</a></h3>


skip non-convective gaps of less than this limit when reporting convective core size

{% highlight fortran %}
conv_core_gap_dq_limit = 0d0
{% endhighlight %}

<h1 id="definition_of_core_overshooting_boundary_for_output">definition of core overshooting boundary for output <a href="#definition_of_core_overshooting_boundary_for_output" title="Permalink to this location">¶</a></h1>


<h3 id="alpha_bdy_core_overshooting">alpha_bdy_core_overshooting <a href="#alpha_bdy_core_overshooting" title="Permalink to this location">¶</a></h3>


    bdy = core_overshoot_r0 + core_overshoot_Hp* &
        (alpha_bdy_core_overshooting*core_overshoot_f - core_overshoot_f0)
The values of `core_overshoot_r0`, `core_overshoot_Hp`, `core_overshoot_f`, and `core_overshoot_f0` are the actual values used for this step to calculate the core overshooting.

{% highlight fortran %}
alpha_bdy_core_overshooting = 5
{% endhighlight %}

<h1 id="definition_of_core_boundaries">definition of core boundaries <a href="#definition_of_core_boundaries" title="Permalink to this location">¶</a></h1>


<h3 id="he_core_boundary_h1_fraction">he_core_boundary_h1_fraction <a href="#he_core_boundary_h1_fraction" title="Permalink to this location">¶</a></h3>


If >= 0, boundary is outermost location where h1 mass fraction is <= this value,
          and he4 mass fraction >= `min_boundary_fraction` (see below).
If < 0, boundary is outermost location where he4 is the most abundant species.

{% highlight fortran %}
he_core_boundary_h1_fraction = 0.01d0
{% endhighlight %}


<h3 id="c_core_boundary_he4_fraction">c_core_boundary_he4_fraction <a href="#c_core_boundary_he4_fraction" title="Permalink to this location">¶</a></h3>


If >= 0, boundary is outermost location where he4 mass fraction is <= this value,
          and c12 mass fraction >= `min_boundary_fraction` (see below).
If < 0, boundary is outermost location where c12 is the most abundant species.

{% highlight fortran %}
c_core_boundary_he4_fraction = 0.01d0
{% endhighlight %}


<h3 id="o_core_boundary_c12_fraction">o_core_boundary_c12_fraction <a href="#o_core_boundary_c12_fraction" title="Permalink to this location">¶</a></h3>


If >= 0, boundary is outermost location where c12 mass fraction is <= this value,
          and o16 mass fraction >= `min_boundary_fraction` (see below).
If < 0, boundary is outermost location where o16 is the most abundant species.

{% highlight fortran %}
o_core_boundary_c12_fraction = 0.01d0
{% endhighlight %}


<h3 id="si_core_boundary_o16_fraction">si_core_boundary_o16_fraction <a href="#si_core_boundary_o16_fraction" title="Permalink to this location">¶</a></h3>


If >= 0, boundary is outermost location where o16 mass fraction is <= this value,
          and si28 mass fraction >= `min_boundary_fraction` (see below).
If < 0, boundary is outermost location where si28 is the most abundant species.

{% highlight fortran %}
si_core_boundary_o16_fraction = 0.01d0
{% endhighlight %}


<h3 id="fe_core_boundary_si28_fraction">fe_core_boundary_si28_fraction <a href="#fe_core_boundary_si28_fraction" title="Permalink to this location">¶</a></h3>


For this case, "iron" includes any species with A > 46.
If >= 0, boundary is outermost location where si28 mass fraction is <= this value,
          and "iron" mass fraction >= `min_boundary_fraction` (see below).
If < 0, boundary is outermost location where "iron" is the most abundant species.

{% highlight fortran %}
fe_core_boundary_si28_fraction = 0.01d0
{% endhighlight %}


<h3 id="neutron_rich_core_boundary_Ye_max">neutron_rich_core_boundary_Ye_max <a href="#neutron_rich_core_boundary_Ye_max" title="Permalink to this location">¶</a></h3>


Boundary is outermost location where Ye is <= this value.

{% highlight fortran %}
neutron_rich_core_boundary_Ye_max = 0.48d0
{% endhighlight %}


<h3 id="min_boundary_fraction">min_boundary_fraction <a href="#min_boundary_fraction" title="Permalink to this location">¶</a></h3>


Value for deciding boundary regions.

{% highlight fortran %}
min_boundary_fraction = 0.1d0
{% endhighlight %}

<h1 id="when_to_stop">when to stop <a href="#when_to_stop" title="Permalink to this location">¶</a></h1>


<h3 id="max_model_number">max_model_number <a href="#max_model_number" title="Permalink to this location">¶</a></h3>


The code will stop when it reaches this model number.
Negative means no maximum.

{% highlight fortran %}
max_model_number = -1
{% endhighlight %}


<h3 id="when_to_stop_rtol">when_to_stop_rtol <a href="#when_to_stop_rtol" title="Permalink to this location">¶</a></h3>


Relative error criteria when hitting stop target time.
The system will automatically redo with a smaller timestep to hit a stopping target.
It calculates the following "error" term and retries if it is > 1.

    error = abs(value - target_value)/ &
            (when_to_stop_atol + when_to_stop_rtol*max(abs(value),abs(target_value)))

{% highlight fortran %}
when_to_stop_rtol = 1d99
{% endhighlight %}


<h3 id="when_to_stop_atol">when_to_stop_atol <a href="#when_to_stop_atol" title="Permalink to this location">¶</a></h3>


Abolute error criteria when hitting stop target time.
The system will automatically redo with a smaller timestep to hit a stopping target.
It calculates the following "error" term and retries if it is > 1.

    error = abs(value - target_value)/ &
            (when_to_stop_atol + when_to_stop_rtol*max(abs(value),abs(target_value)))

{% highlight fortran %}
when_to_stop_atol = 1d99
{% endhighlight %}


<h3 id="max_age">max_age <a href="#max_age" title="Permalink to this location">¶</a></h3>


Stop when the age of the star exceeds this value (in years).
only applies when > 0.

{% highlight fortran %}
max_age = 1d36
{% endhighlight %}


<h3 id="max_age_in_seconds">max_age_in_seconds <a href="#max_age_in_seconds" title="Permalink to this location">¶</a></h3>


Stop when the age of the star exceeds this value (in seconds).
only applies when > 0.

{% highlight fortran %}
max_age_in_seconds = -1
{% endhighlight %}


<h3 id="num_adjusted_dt_steps_before_max_age">num_adjusted_dt_steps_before_max_age <a href="#num_adjusted_dt_steps_before_max_age" title="Permalink to this location">¶</a></h3>


This adjusts `max_years_for_timestep` so that hit `max_age` exactly,
without needing possibly large change in timestep at end of run.
only used if > 0

number of time steps to adjust to prior to hitting max age
only used if > 0

{% highlight fortran %}
num_adjusted_dt_steps_before_max_age = 0
{% endhighlight %}


<h3 id="dt_years_for_steps_before_max_age">dt_years_for_steps_before_max_age <a href="#dt_years_for_steps_before_max_age" title="Permalink to this location">¶</a></h3>


timestep in years

{% highlight fortran %}
dt_years_for_steps_before_max_age = 1d6
{% endhighlight %}


<h3 id="reduction_factor_for_max_timestep">reduction_factor_for_max_timestep <a href="#reduction_factor_for_max_timestep" title="Permalink to this location">¶</a></h3>


per time step reduction limited to this

{% highlight fortran %}
reduction_factor_for_max_timestep = 0.98d0
{% endhighlight %}


<h3 id="gamma_center_limit">gamma_center_limit <a href="#gamma_center_limit" title="Permalink to this location">¶</a></h3>


gamma is the plasma interaction parameter.
Stop when the center value of gamma exceeds this limit.

{% highlight fortran %}
gamma_center_limit = 1d99
{% endhighlight %}


<h3 id="eta_center_limit">eta_center_limit <a href="#eta_center_limit" title="Permalink to this location">¶</a></h3>


eta is the electron chemical potential in units of k*T.
Stop when the center value of eta exceeds this limit.

{% highlight fortran %}
eta_center_limit = 1d99
{% endhighlight %}


<h3 id="log_center_density_limit">log_center_density_limit <a href="#log_center_density_limit" title="Permalink to this location">¶</a></h3>


Stop when log10 of the center density exceeds this limit.

{% highlight fortran %}
log_center_density_limit = 12d0
{% endhighlight %}


<h3 id="log_center_density_lower_limit">log_center_density_lower_limit <a href="#log_center_density_lower_limit" title="Permalink to this location">¶</a></h3>


Stop when log10 of the center density is below this limit.

{% highlight fortran %}
log_center_density_lower_limit = -1d99
{% endhighlight %}


<h3 id="log_center_temp_limit">log_center_temp_limit <a href="#log_center_temp_limit" title="Permalink to this location">¶</a></h3>


Stop when log10 of the center temperature exceeds this limit.

{% highlight fortran %}
log_center_temp_limit = 11d0
{% endhighlight %}


<h3 id="log_center_temp_lower_limit">log_center_temp_lower_limit <a href="#log_center_temp_lower_limit" title="Permalink to this location">¶</a></h3>


Stop when log10 of the center temperature is below this limit.

{% highlight fortran %}
log_center_temp_lower_limit = -1d99
{% endhighlight %}


<h3 id="surface_accel_div_grav_limit__1">surface_accel_div_grav_limit = -1 <a href="#surface_accel_div_grav_limit__1" title="Permalink to this location">¶</a></h3>


This is used when do not have a velocity variable.
The acceleration ratio is `abs(accel)/grav` at surface,
where accel is `(rdot-rdot_old)/dt` and grav is `G*m/r^2`.
Stop if the ratio becomes larger than this limit.
Ignored if <= 0.

{% highlight fortran %}
surface_accel_div_grav_limit = -1
{% endhighlight %}


<h3 id="log_max_temp_upper_limit">log_max_temp_upper_limit <a href="#log_max_temp_upper_limit" title="Permalink to this location">¶</a></h3>


stop when log10 of the maximum temperature rises above this limit.

{% highlight fortran %}
log_max_temp_upper_limit = 99
{% endhighlight %}


<h3 id="log_max_temp_lower_limit">log_max_temp_lower_limit <a href="#log_max_temp_lower_limit" title="Permalink to this location">¶</a></h3>


stop when log10 of the maximum temperature drops below this limit.

{% highlight fortran %}
log_max_temp_lower_limit = -99
{% endhighlight %}


<h3 id="center_entropy_limit">center_entropy_limit <a href="#center_entropy_limit" title="Permalink to this location">¶</a></h3>


stop when the center entropy exceeds this limit.
in kerg per baryon

{% highlight fortran %}
center_entropy_limit = 1d99
{% endhighlight %}


<h3 id="center_entropy_lower_limit">center_entropy_lower_limit <a href="#center_entropy_lower_limit" title="Permalink to this location">¶</a></h3>


stop when the center entropy is below this limit.
in kerg per baryon

{% highlight fortran %}
center_entropy_lower_limit = -1d99
{% endhighlight %}


<h3 id="max_entropy_limit">max_entropy_limit <a href="#max_entropy_limit" title="Permalink to this location">¶</a></h3>


stop when the max entropy exceeds this limit.
in kerg per baryon

{% highlight fortran %}
max_entropy_limit = 1d99
{% endhighlight %}


<h3 id="max_entropy_lower_limit">max_entropy_lower_limit <a href="#max_entropy_lower_limit" title="Permalink to this location">¶</a></h3>


stop when the max entropy is below this limit.
in kerg per baryon

{% highlight fortran %}
max_entropy_lower_limit = -1d99
{% endhighlight %}


<h3 id="xa_central_lower_limit_species">xa_central_lower_limit_species <a href="#xa_central_lower_limit_species" title="Permalink to this location">¶</a></h3>


<h3 id="xa_central_lower_limit">xa_central_lower_limit <a href="#xa_central_lower_limit" title="Permalink to this location">¶</a></h3>


Lower limits on central mass fractions.
Stop when central abundance drops below this limit.
Can have up to `num_xa_central_limits` of these (see `star_def.inc` for value).
`xa_central_lower_limit_species` contains an isotope name as defined in `chem_def.f`.
`xa_central_lower_limit` contains the lower limit value.

{% highlight fortran %}
xa_central_lower_limit_species(1) = ''
xa_central_lower_limit(1) = 0
{% endhighlight %}


<h3 id="xa_central_upper_limit_species">xa_central_upper_limit_species <a href="#xa_central_upper_limit_species" title="Permalink to this location">¶</a></h3>


<h3 id="xa_central_upper_limit">xa_central_upper_limit <a href="#xa_central_upper_limit" title="Permalink to this location">¶</a></h3>


Upper limits on central mass fractions.
Stop when central abundance rises above this limit.
Can have up to `num_xa_central_limits` of these (see `star_def.inc` for value).
E.g., to stop when center c12 abundance reaches 0.5, set

    xa_central_upper_limit_species(1) = 'c12'
    xa_central_upper_limit(1) = 0.5

{% highlight fortran %}
xa_central_upper_limit_species(1) = ''
xa_central_upper_limit(1) = 0
{% endhighlight %}


<h3 id="xa_surface_lower_limit_species">xa_surface_lower_limit_species <a href="#xa_surface_lower_limit_species" title="Permalink to this location">¶</a></h3>


<h3 id="xa_surface_lower_limit">xa_surface_lower_limit <a href="#xa_surface_lower_limit" title="Permalink to this location">¶</a></h3>


Lower limits on surface mass fractions.
Stop when surface abundance drops below this limit.
Can have up to `num_xa_surface_limits` of these (see `star_def` for value)
`xa_surface_lower_limit_species` contains an isotope name as defined in `chem_def.f`
`xa_surface_lower_limit` contains the lower limit value

{% highlight fortran %}
xa_surface_lower_limit_species(1) = ''
xa_surface_lower_limit(1) = 0
{% endhighlight %}


<h3 id="xa_surface_upper_limit_species">xa_surface_upper_limit_species <a href="#xa_surface_upper_limit_species" title="Permalink to this location">¶</a></h3>


<h3 id="xa_surface_upper_limit">xa_surface_upper_limit <a href="#xa_surface_upper_limit" title="Permalink to this location">¶</a></h3>


upper limits on surface mass fractions
stop when surface abundance rises above this limit
can have up to `num_xa_surface_limits` of these (see `star_def` for value)
e.g., to stop when surface c12 abundance reaches 0.5, set

    xa_surface_upper_limit_species(1) = 'c12'
    xa_surface_upper_limit(1) = 0.5

{% highlight fortran %}
xa_surface_upper_limit_species(1) = ''
xa_surface_upper_limit(1) = 0
{% endhighlight %}


<h3 id="xa_average_lower_limit_species">xa_average_lower_limit_species <a href="#xa_average_lower_limit_species" title="Permalink to this location">¶</a></h3>


<h3 id="xa_average_lower_limit">xa_average_lower_limit <a href="#xa_average_lower_limit" title="Permalink to this location">¶</a></h3>


lower limits on average mass fractions
stop when average abundance drops below this limit
can have up to `num_xa_average_limits` of these (see `star_def` for value)

{% highlight fortran %}
xa_average_lower_limit_species(1) = ''
xa_average_lower_limit(1) = 0
{% endhighlight %}


<h3 id="xa_average_upper_limit_species">xa_average_upper_limit_species <a href="#xa_average_upper_limit_species" title="Permalink to this location">¶</a></h3>


<h3 id="xa_average_upper_limit">xa_average_upper_limit <a href="#xa_average_upper_limit" title="Permalink to this location">¶</a></h3>


upper limits on average mass fractions
stop when average abundance rises above this limit
can have up to `num_xa_average_limits` of these (see `star_def` for value)

{% highlight fortran %}
xa_average_upper_limit_species(1) = ''
xa_average_upper_limit(1) = 0
{% endhighlight %}


<h3 id="HB_limit">HB_limit <a href="#HB_limit" title="Permalink to this location">¶</a></h3>


For detecting horizontal branch.
Only applies when center abundance by mass of h1 is < 1d-4.
Stop when the center abundance by mass of he4 drops below this limit.

{% highlight fortran %}
HB_limit = 0
{% endhighlight %}


<h3 id="stop_at_TP">stop_at_TP <a href="#stop_at_TP" title="Permalink to this location">¶</a></h3>


If true, stop at next AGB thermal pulse.
This is defined as having a convective zone with helium burning
when central helium is depleted
and `he_core_mass - c_core_mass <= TP_he_shell_max`.

{% highlight fortran %}
stop_at_TP = .false.
{% endhighlight %}


<h3 id="TP_he_shell_max">TP_he_shell_max <a href="#TP_he_shell_max" title="Permalink to this location">¶</a></h3>


Stop when thermal pulse helium shell mass reaches this value, in Msun units

{% highlight fortran %}
TP_he_shell_max = 0.2d0
{% endhighlight %}


<h3 id="star_mass_min_limit">star_mass_min_limit <a href="#star_mass_min_limit" title="Permalink to this location">¶</a></h3>


Stop when star mass in Msun units is < this.  <= 0 means no limit.

{% highlight fortran %}
star_mass_min_limit = 0
{% endhighlight %}


<h3 id="star_mass_max_limit">star_mass_max_limit <a href="#star_mass_max_limit" title="Permalink to this location">¶</a></h3>


Stop when star mass in Msun units is > this.  <= 0 means no limit.

{% highlight fortran %}
star_mass_max_limit = 0
{% endhighlight %}


<h3 id="star_H_mass_min_limit">star_H_mass_min_limit <a href="#star_H_mass_min_limit" title="Permalink to this location">¶</a></h3>


Stop when star hydrogen mass in Msun units is < this.  <= 0 means no limit.

{% highlight fortran %}
star_H_mass_min_limit = 0
{% endhighlight %}


<h3 id="star_H_mass_max_limit">star_H_mass_max_limit <a href="#star_H_mass_max_limit" title="Permalink to this location">¶</a></h3>


Stop when star hydrogen mass in Msun units is > this.  <= 0 means no limit.

{% highlight fortran %}
star_H_mass_max_limit = 0
{% endhighlight %}


<h3 id="star_He_mass_min_limit">star_He_mass_min_limit <a href="#star_He_mass_min_limit" title="Permalink to this location">¶</a></h3>


Stop when star he3+he4 mass in Msun units is < this.  <= 0 means no limit.

{% highlight fortran %}
star_He_mass_min_limit = 0
{% endhighlight %}


<h3 id="star_He_mass_max_limit__0">star_He_mass_max_limit = 0 <a href="#star_He_mass_max_limit__0" title="Permalink to this location">¶</a></h3>


Stop when star he3+he4 mass in Msun units is > this.  <= 0 means no limit.

{% highlight fortran %}
star_He_mass_max_limit = 0
{% endhighlight %}


<h3 id="star_C_mass_min_limit">star_C_mass_min_limit <a href="#star_C_mass_min_limit" title="Permalink to this location">¶</a></h3>


Stop when star c12 mass in Msun units is < this.  <= 0 means no limit.

{% highlight fortran %}
star_C_mass_min_limit = 0
{% endhighlight %}


<h3 id="star_C_mass_max_limit__0">star_C_mass_max_limit = 0 <a href="#star_C_mass_max_limit__0" title="Permalink to this location">¶</a></h3>


Stop when star c12 mass in Msun units is > this.  <= 0 means no limit.

{% highlight fortran %}
star_C_mass_max_limit = 0
{% endhighlight %}


<h3 id="envelope_mass_limit">envelope_mass_limit <a href="#envelope_mass_limit" title="Permalink to this location">¶</a></h3>


    envelope_mass = star_mass - he_core_mass

Stop when `envelope_mass` drops below this limit, in Msun units.

{% highlight fortran %}
envelope_mass_limit = 0
{% endhighlight %}


<h3 id="envelope_fraction_left_limit">envelope_fraction_left_limit <a href="#envelope_fraction_left_limit" title="Permalink to this location">¶</a></h3>


    envelope_fraction_left = (star_mass - he_core_mass)/(initial_mass - he_core_mass)
Stop when `envelope_fraction_left` < this limit.

{% highlight fortran %}
envelope_fraction_left_limit = 0
{% endhighlight %}


<h3 id="xmstar_min_limit">xmstar_min_limit <a href="#xmstar_min_limit" title="Permalink to this location">¶</a></h3>


! xmstar = mstar - M_center
stop when xmstar in grams is < this.  <= 0 means no limit.

{% highlight fortran %}
xmstar_min_limit = 0
{% endhighlight %}


<h3 id="xmstar_max_limit">xmstar_max_limit <a href="#xmstar_max_limit" title="Permalink to this location">¶</a></h3>


xmstar = mstar - M_center
stop when xmstar in grams is > this.  <= 0 means no limit.

{% highlight fortran %}
xmstar_max_limit = 0
{% endhighlight %}


<h3 id="he_core_mass_limit">he_core_mass_limit <a href="#he_core_mass_limit" title="Permalink to this location">¶</a></h3>


stop when helium core reaches this mass, in Msun units

{% highlight fortran %}
he_core_mass_limit = 1d99
{% endhighlight %}


<h3 id="c_core_mass_limit">c_core_mass_limit <a href="#c_core_mass_limit" title="Permalink to this location">¶</a></h3>


stop when carbon core reaches this mass, in Msun units

{% highlight fortran %}
c_core_mass_limit = 1d99
{% endhighlight %}


<h3 id="o_core_mass_limit">o_core_mass_limit <a href="#o_core_mass_limit" title="Permalink to this location">¶</a></h3>


stop when oxygen core reaches this mass, in Msun units

{% highlight fortran %}
o_core_mass_limit = 1d99
{% endhighlight %}


<h3 id="si_core_mass_limit">si_core_mass_limit <a href="#si_core_mass_limit" title="Permalink to this location">¶</a></h3>


stop when silicon core reaches this mass, in Msun units

{% highlight fortran %}
si_core_mass_limit = 1d99
{% endhighlight %}


<h3 id="fe_core_mass_limit">fe_core_mass_limit <a href="#fe_core_mass_limit" title="Permalink to this location">¶</a></h3>


stop when iron core reaches this mass, in Msun units

{% highlight fortran %}
fe_core_mass_limit = 1d99
{% endhighlight %}


<h3 id="neutron_rich_core_mass_limit">neutron_rich_core_mass_limit <a href="#neutron_rich_core_mass_limit" title="Permalink to this location">¶</a></h3>


stop when neutron rich core reaches this mass, in Msun units

{% highlight fortran %}
neutron_rich_core_mass_limit = 1d99
{% endhighlight %}


<h3 id="he_layer_mass_lower_limit">he_layer_mass_lower_limit <a href="#he_layer_mass_lower_limit" title="Permalink to this location">¶</a></h3>


he layer mass is defined as `he_core_mass` - `c_core_mass`
stop when `c_core_mass` > 0 and he layer mass < this limit (Msun units).

{% highlight fortran %}
he_layer_mass_lower_limit = 0
{% endhighlight %}


<h3 id="abs_diff_lg_LH_lg_Ls_limit">abs_diff_lg_LH_lg_Ls_limit <a href="#abs_diff_lg_LH_lg_Ls_limit" title="Permalink to this location">¶</a></h3>


stop when `abs(lg_LH - lg_Ls) <= abs_diff_LH_Lsurf_limit`
can be useful for deciding when pre-main sequence star has reached ZAMS
set to negative value to disable

{% highlight fortran %}
abs_diff_lg_LH_lg_Ls_limit = -1
{% endhighlight %}


<h3 id="Teff_upper_limit">Teff_upper_limit <a href="#Teff_upper_limit" title="Permalink to this location">¶</a></h3>


stop when Teff is greater than this limit.

{% highlight fortran %}
Teff_upper_limit = 1d99
{% endhighlight %}


<h3 id="Teff_lower_limit">Teff_lower_limit <a href="#Teff_lower_limit" title="Permalink to this location">¶</a></h3>


stop when Teff is less than this limit.

{% highlight fortran %}
Teff_lower_limit = -1d99
{% endhighlight %}


<h3 id="photosphere_r_upper_limit">photosphere_r_upper_limit <a href="#photosphere_r_upper_limit" title="Permalink to this location">¶</a></h3>


stop when `photosphere_r` is greater than this limit, in Rsun units

{% highlight fortran %}
photosphere_r_upper_limit = 1d99
{% endhighlight %}


<h3 id="photosphere_r_lower_limit">photosphere_r_lower_limit <a href="#photosphere_r_lower_limit" title="Permalink to this location">¶</a></h3>


stop when `photosphere_r` is less than this limit, in Rsun units

{% highlight fortran %}
photosphere_r_lower_limit = -1d99
{% endhighlight %}


<h3 id="photosphere_m_upper_limit">photosphere_m_upper_limit <a href="#photosphere_m_upper_limit" title="Permalink to this location">¶</a></h3>


stop when `photosphere_m` is greater than this limit, in Msun units

{% highlight fortran %}
photosphere_m_upper_limit = 1d99
{% endhighlight %}


<h3 id="photosphere_m_lower_limit">photosphere_m_lower_limit <a href="#photosphere_m_lower_limit" title="Permalink to this location">¶</a></h3>


stop when `photosphere_m` is less than this limit, in Msun units

{% highlight fortran %}
photosphere_m_lower_limit = -1d99
{% endhighlight %}


<h3 id="photosphere_m_sub_M_center_limit">photosphere_m_sub_M_center_limit <a href="#photosphere_m_sub_M_center_limit" title="Permalink to this location">¶</a></h3>


stop when `photosphere_m` is less than this limit above `M_center`, in Msun units

{% highlight fortran %}
photosphere_m_sub_M_center_limit = -1d99
{% endhighlight %}


<h3 id="log_Teff_upper_limit">log_Teff_upper_limit <a href="#log_Teff_upper_limit" title="Permalink to this location">¶</a></h3>


stop when log10 of Teff is greater than this limit.

{% highlight fortran %}
log_Teff_upper_limit = 1d99
{% endhighlight %}


<h3 id="log_Teff_lower_limit">log_Teff_lower_limit <a href="#log_Teff_lower_limit" title="Permalink to this location">¶</a></h3>


stop when log10 of Teff is less than this limit.

{% highlight fortran %}
log_Teff_lower_limit = -1d99
{% endhighlight %}


<h3 id="log_Tsurf_upper_limit">log_Tsurf_upper_limit <a href="#log_Tsurf_upper_limit" title="Permalink to this location">¶</a></h3>


stop when log10 of T in outermost cell is greater than this limit.

{% highlight fortran %}
log_Tsurf_upper_limit = 1d99
{% endhighlight %}


<h3 id="log_Tsurf_lower_limit">log_Tsurf_lower_limit <a href="#log_Tsurf_lower_limit" title="Permalink to this location">¶</a></h3>


stop when log10 of T in outermost cell is less than this limit.

{% highlight fortran %}
log_Tsurf_lower_limit = -1d99
{% endhighlight %}


<h3 id="log_L_upper_limit">log_L_upper_limit <a href="#log_L_upper_limit" title="Permalink to this location">¶</a></h3>


stop when log10(total luminosity in Lsun units) is greater than this limit.
in order to skip pre-ms, this limit only applies when `L_nuc` > 0.01*L

{% highlight fortran %}
log_L_upper_limit = 1d99
{% endhighlight %}


<h3 id="log_L_lower_limit">log_L_lower_limit <a href="#log_L_lower_limit" title="Permalink to this location">¶</a></h3>


stop when log10(total luminosity in Lsun units) is less than this limit.

{% highlight fortran %}
log_L_lower_limit = -1d99
{% endhighlight %}


<h3 id="log_g_upper_limit">log_g_upper_limit <a href="#log_g_upper_limit" title="Permalink to this location">¶</a></h3>


stop when log10(gravity at surface) is greater than this limit.

{% highlight fortran %}
log_g_upper_limit = 1d99
{% endhighlight %}


<h3 id="log_g_lower_limit">log_g_lower_limit <a href="#log_g_lower_limit" title="Permalink to this location">¶</a></h3>


stop when log10(gravity at surface) is less than this limit.

{% highlight fortran %}
log_g_lower_limit = -1d99
{% endhighlight %}


<h3 id="log_Psurf_upper_limit">log_Psurf_upper_limit <a href="#log_Psurf_upper_limit" title="Permalink to this location">¶</a></h3>


stop when log10 of surface pressure is greater than this limit.

{% highlight fortran %}
log_Psurf_upper_limit = 1d99
{% endhighlight %}


<h3 id="log_Psurf_lower_limit">log_Psurf_lower_limit <a href="#log_Psurf_lower_limit" title="Permalink to this location">¶</a></h3>


stop when log10 of surface pressure is less than this limit.

{% highlight fortran %}
log_Psurf_lower_limit = -1d99
{% endhighlight %}


<h3 id="log_Dsurf_upper_limit">log_Dsurf_upper_limit <a href="#log_Dsurf_upper_limit" title="Permalink to this location">¶</a></h3>


stop when log10 of surface density is greater than this limit.

{% highlight fortran %}
log_Dsurf_upper_limit = 1d99
{% endhighlight %}


<h3 id="log_Dsurf_lower_limit">log_Dsurf_lower_limit <a href="#log_Dsurf_lower_limit" title="Permalink to this location">¶</a></h3>


stop when log10 of surface density is less than this limit.

{% highlight fortran %}
log_Dsurf_lower_limit = -1d99
{% endhighlight %}


<h3 id="power_nuc_burn_upper_limit">power_nuc_burn_upper_limit <a href="#power_nuc_burn_upper_limit" title="Permalink to this location">¶</a></h3>


stop when total power from all nuclear reactions (in Lsun units) is > this.

{% highlight fortran %}
power_nuc_burn_upper_limit = 1d99
{% endhighlight %}


<h3 id="power_h_burn_upper_limit">power_h_burn_upper_limit <a href="#power_h_burn_upper_limit" title="Permalink to this location">¶</a></h3>


stop when total power from hydrogen-consuming reactions (in Lsun units) is > this.

{% highlight fortran %}
power_h_burn_upper_limit = 1d99
{% endhighlight %}


<h3 id="power_he_burn_upper_limit">power_he_burn_upper_limit <a href="#power_he_burn_upper_limit" title="Permalink to this location">¶</a></h3>


stop when total power from reactions burning helium (in Lsun units) is > this.

{% highlight fortran %}
power_he_burn_upper_limit = 1d99
{% endhighlight %}


<h3 id="power_c_burn_upper_limit">power_c_burn_upper_limit <a href="#power_c_burn_upper_limit" title="Permalink to this location">¶</a></h3>


stop when total power from reactions burning carbon (in Lsun units) is > this

{% highlight fortran %}
power_c_burn_upper_limit = 1d99
{% endhighlight %}


<h3 id="power_nuc_burn_lower_limit">power_nuc_burn_lower_limit <a href="#power_nuc_burn_lower_limit" title="Permalink to this location">¶</a></h3>


stop when total power from all nuclear reactions (in Lsun units) is < this.

{% highlight fortran %}
power_nuc_burn_lower_limit = -1d99
{% endhighlight %}


<h3 id="power_h_burn_lower_limit">power_h_burn_lower_limit <a href="#power_h_burn_lower_limit" title="Permalink to this location">¶</a></h3>


stop when total power from hydrogen consuming reactions (in Lsun units) is < this.

{% highlight fortran %}
power_h_burn_lower_limit = -1d99
{% endhighlight %}


<h3 id="power_he_burn_lower_limit">power_he_burn_lower_limit <a href="#power_he_burn_lower_limit" title="Permalink to this location">¶</a></h3>


stop when total power from reactions burning helium (in Lsun units) is < this.

{% highlight fortran %}
power_he_burn_lower_limit = -1d99
{% endhighlight %}


<h3 id="power_c_burn_lower_limit">power_c_burn_lower_limit <a href="#power_c_burn_lower_limit" title="Permalink to this location">¶</a></h3>


stop when total power from reactions burning carbon (in Lsun units) is < this.

{% highlight fortran %}
power_c_burn_lower_limit = -1d99
{% endhighlight %}


<h3 id="max_number_backups">max_number_backups <a href="#max_number_backups" title="Permalink to this location">¶</a></h3>


Stop if the number of backups exceeds this value.
Ignore if < 0.

{% highlight fortran %}
max_number_backups = -1
{% endhighlight %}


<h3 id="max_number_retries">max_number_retries <a href="#max_number_retries" title="Permalink to this location">¶</a></h3>


Stop if the number of retries exceeds this value.
Ignore if < 0.

{% highlight fortran %}
max_number_retries = -1
{% endhighlight %}


<h3 id="max_backups_in_a_row">max_backups_in_a_row <a href="#max_backups_in_a_row" title="Permalink to this location">¶</a></h3>


if do more than this many without a successful step, then terminate the run.

{% highlight fortran %}
max_backups_in_a_row = 15
{% endhighlight %}


<h3 id="relax_max_number_backups">relax_max_number_backups <a href="#relax_max_number_backups" title="Permalink to this location">¶</a></h3>


Stop if the number of backups during a "relax" evolution exceeds this value.
ignore if < 0

{% highlight fortran %}
relax_max_number_backups = 100
{% endhighlight %}


<h3 id="relax_max_number_retries">relax_max_number_retries <a href="#relax_max_number_retries" title="Permalink to this location">¶</a></h3>


Stop if the number of retries during a "relax" evolution exceeds this value.
ignore if < 0

{% highlight fortran %}
relax_max_number_retries = 300
{% endhighlight %}


<h3 id="min_timestep_limit">min_timestep_limit <a href="#min_timestep_limit" title="Permalink to this location">¶</a></h3>


stop if need timestep smaller than this limit, in seconds

{% highlight fortran %}
min_timestep_limit = 1d-6
{% endhighlight %}


<h3 id="logQ_limit">logQ_limit <a href="#logQ_limit" title="Permalink to this location">¶</a></h3>


logQ = logRho - 2*logT + 12.
stop if logQ at any zone is larger than this limit.
5 is a reasonable limit for the current mesa/eos.

{% highlight fortran %}
logQ_limit = 5d0
{% endhighlight %}


<h3 id="logQ_min_limit">logQ_min_limit <a href="#logQ_min_limit" title="Permalink to this location">¶</a></h3>


logQ = logRho - 2*logT + 12.
stop if logQ at any zone is smaller than this limit.
-10 is a reasonable limit for the current mesa/eos.

{% highlight fortran %}
logQ_min_limit = -10d0
{% endhighlight %}


<h3 id="center_Ye_lower_limit">center_Ye_lower_limit <a href="#center_Ye_lower_limit" title="Permalink to this location">¶</a></h3>


stop if `center_ye` drops below this limit

{% highlight fortran %}
center_Ye_lower_limit = -1
{% endhighlight %}


<h3 id="center_R_lower_limit">center_R_lower_limit <a href="#center_R_lower_limit" title="Permalink to this location">¶</a></h3>


stop if `R_center` drops below this limit (in cm)

{% highlight fortran %}
center_R_lower_limit = -1
{% endhighlight %}


<h3 id="fe_core_infall_limit">fe_core_infall_limit <a href="#fe_core_infall_limit" title="Permalink to this location">¶</a></h3>


stop if max infall speed at any location interior to `fe_core_mass`, in cm/s

{% highlight fortran %}
fe_core_infall_limit = 3d7
{% endhighlight %}


<h3 id="non_fe_core_infall_limit">non_fe_core_infall_limit <a href="#non_fe_core_infall_limit" title="Permalink to this location">¶</a></h3>


stop if max infall speed at any location interior to `he_core_mass`. in cm/s

{% highlight fortran %}
non_fe_core_infall_limit = 1d99
{% endhighlight %}


<h3 id="v_div_csound_max_limit">v_div_csound_max_limit <a href="#v_div_csound_max_limit" title="Permalink to this location">¶</a></h3>


stop if any `v/csound` > this limit

{% highlight fortran %}
v_div_csound_max_limit = 1d99
{% endhighlight %}


<h3 id="v_div_csound_surf_limit">v_div_csound_surf_limit <a href="#v_div_csound_surf_limit" title="Permalink to this location">¶</a></h3>


stop if `v_surf/csound_surf` > this limit

{% highlight fortran %}
v_div_csound_surf_limit = 1d99
{% endhighlight %}


<h3 id="v_surf_div_v_kh_upper_limit">v_surf_div_v_kh_upper_limit <a href="#v_surf_div_v_kh_upper_limit" title="Permalink to this location">¶</a></h3>


stop if `abs(v_surf/v_kh)` > this limit, where `v_kh = photosphere_r/kh_timescale`

{% highlight fortran %}
v_surf_div_v_kh_upper_limit = 1d99
{% endhighlight %}


<h3 id="v_surf_div_v_kh_lower_limit">v_surf_div_v_kh_lower_limit <a href="#v_surf_div_v_kh_lower_limit" title="Permalink to this location">¶</a></h3>


stop if `abs(v_surf/v_kh)` < this limit, where `v_kh = photosphere_r/kh_timescale`

{% highlight fortran %}
v_surf_div_v_kh_lower_limit = -1d99
{% endhighlight %}


<h3 id="v_surf_div_v_esc_limit">v_surf_div_v_esc_limit <a href="#v_surf_div_v_esc_limit" title="Permalink to this location">¶</a></h3>


stop if `v_surf/v_esc` > this limit

{% highlight fortran %}
v_surf_div_v_esc_limit = 1d99
{% endhighlight %}


<h3 id="v_surf_kms_limit">v_surf_kms_limit <a href="#v_surf_kms_limit" title="Permalink to this location">¶</a></h3>


stop if `v_surf` in km/s > this limit

{% highlight fortran %}
v_surf_kms_limit = 1d99
{% endhighlight %}


<h3 id="Lnuc_div_L_zams_limit">Lnuc_div_L_zams_limit <a href="#Lnuc_div_L_zams_limit" title="Permalink to this location">¶</a></h3>


defines "near zams" -- note: must also set `stop_near_zams`

{% highlight fortran %}
Lnuc_div_L_zams_limit = 0.9d0
{% endhighlight %}


<h3 id="stop_near_zams">stop_near_zams <a href="#stop_near_zams" title="Permalink to this location">¶</a></h3>


if true, stop if Lnuc/L > `Lnuc_div_L_zams_limit`

{% highlight fortran %}
stop_near_zams = .false.
{% endhighlight %}


<h3 id="Lnuc_div_L_upper_limit">Lnuc_div_L_upper_limit <a href="#Lnuc_div_L_upper_limit" title="Permalink to this location">¶</a></h3>


stop when Lnuc/L is greater than this limit.

{% highlight fortran %}
Lnuc_div_L_upper_limit = 1d99
{% endhighlight %}


<h3 id="Lnuc_div_L_lower_limit">Lnuc_div_L_lower_limit <a href="#Lnuc_div_L_lower_limit" title="Permalink to this location">¶</a></h3>


stop when Lnuc/L is less than this limit.

{% highlight fortran %}
Lnuc_div_L_lower_limit = -1d99
{% endhighlight %}


<h3 id="Pgas_div_P_limit">Pgas_div_P_limit <a href="#Pgas_div_P_limit" title="Permalink to this location">¶</a></h3>


criteria for stopping on Pgas/P

{% highlight fortran %}
Pgas_div_P_limit = 0
{% endhighlight %}


<h3 id="Pgas_div_P_limit_max_q">Pgas_div_P_limit_max_q <a href="#Pgas_div_P_limit_max_q" title="Permalink to this location">¶</a></h3>


stop if Pgas/P < this limit at any location with `q <= Pgas_div_P_limit_max_q`
values near unity skip the outer envelope

{% highlight fortran %}
Pgas_div_P_limit_max_q = 0.95d0
{% endhighlight %}


<h3 id="peak_burn_vconv_div_cs_limit">peak_burn_vconv_div_cs_limit <a href="#peak_burn_vconv_div_cs_limit" title="Permalink to this location">¶</a></h3>


limits ratio of convection velocity to sound speed at location of peak `eps_nuc`

{% highlight fortran %}
peak_burn_vconv_div_cs_limit = 1d99
{% endhighlight %}


<h3 id="omega_div_omega_crit_limit">omega_div_omega_crit_limit <a href="#omega_div_omega_crit_limit" title="Permalink to this location">¶</a></h3>


stop if omega/omega_crit is > this anywhere in star
ignore if < 0

{% highlight fortran %}
omega_div_omega_crit_limit = -1
{% endhighlight %}


<h3 id="delta_nu_lower_limit">delta_nu_lower_limit <a href="#delta_nu_lower_limit" title="Permalink to this location">¶</a></h3>


stop when asteroseismology `delta_nu` in micro Hz is < this.  <= 0 means no limit.

{% highlight fortran %}
delta_nu_lower_limit = 0
{% endhighlight %}


<h3 id="delta_nu_upper_limit">delta_nu_upper_limit <a href="#delta_nu_upper_limit" title="Permalink to this location">¶</a></h3>


stop when asteroseismology `delta_nu` in micro Hz is > this.  <= 0 means no limit.

{% highlight fortran %}
delta_nu_upper_limit = 0
{% endhighlight %}


<h3 id="shock_mass_upper_limit">shock_mass_upper_limit <a href="#shock_mass_upper_limit" title="Permalink to this location">¶</a></h3>


stop when shock_mass is > this.  <= 0 means no limit.

{% highlight fortran %}
shock_mass_upper_limit = -1
{% endhighlight %}


<h3 id="mach1_mass_upper_limit">mach1_mass_upper_limit <a href="#mach1_mass_upper_limit" title="Permalink to this location">¶</a></h3>


stop when outer location of mach 1 is > this.  <= 0 means no limit.

{% highlight fortran %}
mach1_mass_upper_limit = -1
{% endhighlight %}


<h3 id="delta_Pg_lower_limit">delta_Pg_lower_limit <a href="#delta_Pg_lower_limit" title="Permalink to this location">¶</a></h3>


stop when `delta_Pg` in micro Hz is < this.  <= 0 means no limit.

{% highlight fortran %}
delta_Pg_lower_limit = 0
{% endhighlight %}


<h3 id="delta_Pg_upper_limit">delta_Pg_upper_limit <a href="#delta_Pg_upper_limit" title="Permalink to this location">¶</a></h3>


stop when `delta_Pg` in micro Hz is > this.  <= 0 means no limit.

{% highlight fortran %}
delta_Pg_upper_limit = 0
{% endhighlight %}


<h3 id="stop_when_reach_this_cumulative_extra_heating">stop_when_reach_this_cumulative_extra_heating <a href="#stop_when_reach_this_cumulative_extra_heating" title="Permalink to this location">¶</a></h3>


(ignore if <= 0)

{% highlight fortran %}
stop_when_reach_this_cumulative_extra_heating = 0d0
{% endhighlight %}

<h1 id="mixing_parameters">mixing parameters <a href="#mixing_parameters" title="Permalink to this location">¶</a></h1>


<h3 id="mixing_length_alpha">mixing_length_alpha <a href="#mixing_length_alpha" title="Permalink to this location">¶</a></h3>


The mixing length is this parameter times a local pressure scale height.
To increase R vs. L, decrease `mixing_length_alpha`.

{% highlight fortran %}
mixing_length_alpha = 2
{% endhighlight %}


<h3 id="remove_small_D_limit">remove_small_D_limit <a href="#remove_small_D_limit" title="Permalink to this location">¶</a></h3>


If MLT diffusion coeff D (cm^2/sec) is less than this limit,
then set D to zero and change the point to `mixing_type == no_mixing`.

{% highlight fortran %}
remove_small_D_limit = 1d-6
{% endhighlight %}


<h3 id="use_Ledoux_criterion">use_Ledoux_criterion <a href="#use_Ledoux_criterion" title="Permalink to this location">¶</a></h3>


a location in the model is Schwarzschild stable when `gradr < grada`
it is Ledoux stable when `gradr < gradL`, where `gradL = grada + composition_gradient`
note that these are the same when `composition_gradient = 0`
so you can force the use of the Schwarzschild criterion by passing 0 for
the `composition_gradient` argument to the mlt routine.
that's what happens if you set the control "`use_Ledoux_criterion`" to false.

overshooting and rotational mixing are dealt with separately
 and are added after the MLT classifications are made.

{% highlight fortran %}
use_Ledoux_criterion = .false.
{% endhighlight %}


<h3 id="num_cells_for_smooth_gradL_composition_term">num_cells_for_smooth_gradL_composition_term <a href="#num_cells_for_smooth_gradL_composition_term" title="Permalink to this location">¶</a></h3>


Number of cells on either side to use in weighted smoothing of `gradL_composition_term`.
`gradL_composition_term` is set to the "raw" unsmoothed `brunt_B`
and then optionally smoothed according `num_cells_for_smooth_gradL_composition_term`.
In cases where the Ledoux criterion is used to evaluate the boundary for burning
convective cores, you may need to set `num_cells_for_smooth_gradL_composition_term = 0`
to avoid smoothing the stabilizing composition jump into the convection zone and
unphysically causing it to shrink. See section 3.2 in Moore, K., & Garaud, P. 2016, APJ, 817, 54

{% highlight fortran %}
num_cells_for_smooth_gradL_composition_term = 3
{% endhighlight %}


<h3 id="threshold_for_smooth_gradL_composition_term">threshold_for_smooth_gradL_composition_term <a href="#threshold_for_smooth_gradL_composition_term" title="Permalink to this location">¶</a></h3>


Threshold for weighted smoothing of `gradL_composition_term`. Only apply smoothing (controlled
by `num_cells_for_smooth_gradL_composition_term`) for contiguous regions where |gradL| exceeds
this threshold. Might be useful for preventing narrow composition jumps from being excessively
broadened by smoothing

{% highlight fortran %}
threshold_for_smooth_gradL_composition_term = 0
{% endhighlight %}


<h3 id="alpha_semiconvection">alpha_semiconvection <a href="#alpha_semiconvection" title="Permalink to this location">¶</a></h3>


Determines efficiency of semiconvective mixing.
Semiconvection only applies if `use_Ledoux_criterion` is true.

{% highlight fortran %}
alpha_semiconvection = 0
{% endhighlight %}


<h3 id="semiconvection_upper_limit_center_h1">semiconvection_upper_limit_center_h1 <a href="#semiconvection_upper_limit_center_h1" title="Permalink to this location">¶</a></h3>


Turn off semiconvection when `center_h1` > this limit.
This let's you delay semiconvection until helium burning.
E.g., you can do overshooting for core hydrogen burning,
then switch to semiconvection after core h is gone.

{% highlight fortran %}
semiconvection_upper_limit_center_h1 = 1d99
{% endhighlight %}


<h3 id="semiconvection_option">semiconvection_option <a href="#semiconvection_option" title="Permalink to this location">¶</a></h3>


+ 'Langer_85 mixing; gradT = gradr' : uses Langer scheme for mixing but sets gradT = gradr
+ 'Langer_85' : this calculates special gradT as well as doing mixing.

{% highlight fortran %}
semiconvection_option = 'Langer_85 mixing; gradT = gradr'
{% endhighlight %}


<h3 id="thermohaline_coeff">thermohaline_coeff <a href="#thermohaline_coeff" title="Permalink to this location">¶</a></h3>


Determines efficiency of thermohaline mixing.
was previously named `thermo_haline_coeff`.
thermohaline mixing only applies if `use_Ledoux_criterion` is true.

{% highlight fortran %}
thermohaline_coeff = 0
{% endhighlight %}


<h3 id="thermohaline_option">thermohaline_option <a href="#thermohaline_option" title="Permalink to this location">¶</a></h3>


determines which method to use for calculating thermohaline diffusion coef:

+ `'Kippenhahn'` : use method of Kippenhahn, R., Ruschenplatt, G., & Thomas, H.-C. 1980, A&A, 91, 175.
+ `'Traxler_Garaud_Stellmach_11'` : use method of Traxler, Garaud, & Stellmach, ApJ Letters, 728:L29 (2011).
+ `'Brown_Garaud_Stellmach_13'` : use method of Brown, Garaud, & Stellmach, (2013). Recommends `thermohaline_coeff = 1`, but it can nevertheless be changed.

{% highlight fortran %}
thermohaline_option = 'Kippenhahn'
{% endhighlight %}


<h3 id="alt_scale_height_flag">alt_scale_height_flag <a href="#alt_scale_height_flag" title="Permalink to this location">¶</a></h3>


If false, then stick to the usual definition -- P/(g*rho).
If true, use min of the usual and sound speed * hydro time scale, sqrt(P/G)/rho.

{% highlight fortran %}
alt_scale_height_flag = .true.
{% endhighlight %}


<h3 id="mlt_use_rotation_correction">mlt_use_rotation_correction <a href="#mlt_use_rotation_correction" title="Permalink to this location">¶</a></h3>


When doing rotation, multiply `grad_rad` by `ft_rot/ft_rot` if this flag is true.

{% highlight fortran %}
mlt_use_rotation_correction = .true.
{% endhighlight %}


<h3 id="MLT_option">MLT_option <a href="#MLT_option" title="Permalink to this location">¶</a></h3>


Options are:

+ 'none'       : just give radiative values with no mixing.
+ 'Cox'        : MLT as developed in Cox & Giuli 1968, Chapter 14.
+ 'ML1'        : Bohm-Vitense 1958
+ 'ML2'        : Bohm and Cassinelli 1971
+ 'Mihalas'    : Mihalas 1978, Kurucz 1979
+ 'Henyey'     : Henyey, Vardya, and Bodenheimer 1965

'Cox' option assumes optically thick material.
The other options are various ways of extending to include optically thin material.

{% highlight fortran %}
MLT_option = 'Cox'
{% endhighlight %}


<h3 id="Henyey_MLT_y_param">Henyey_MLT_y_param <a href="#Henyey_MLT_y_param" title="Permalink to this location">¶</a></h3>


<h3 id="Henyey_MLT_nu_param">Henyey_MLT_nu_param <a href="#Henyey_MLT_nu_param" title="Permalink to this location">¶</a></h3>


Values of the f1..f4 coefficients are taken from Table 1 of Ludwig et al. 1999, A&A, 346, 111
with the following exception: their value of f3 for Henyey convection is `f4/8` when it should be
`8*f4`, i.e., `f3=32*pi**2/3` and `f4=4*pi**2/3`. f3 and f4 are related to the henyey y parameter, so
for the 'Henyey' case they are set based on the value of `Henyey_y_param`.

{% highlight fortran %}
Henyey_MLT_y_param = 0.33333333d0
Henyey_MLT_nu_param = 8
{% endhighlight %}


<h3 id="make_gradr_sticky_in_newton_iters">make_gradr_sticky_in_newton_iters <a href="#make_gradr_sticky_in_newton_iters" title="Permalink to this location">¶</a></h3>


if true, then location that becomes radiative during newton iterations,
stays radiative for rest of the newton iterations.
to avoid flip-flopping between radiative and convective.

{% highlight fortran %}
make_gradr_sticky_in_newton_iters = .false.
{% endhighlight %}


<h3 id="no_MLT_below_shock">no_MLT_below_shock <a href="#no_MLT_below_shock" title="Permalink to this location">¶</a></h3>


if true, then no MLT below an outward going shock (just radiative).

{% highlight fortran %}
no_MLT_below_shock = .false.
{% endhighlight %}


<h3 id="no_MLT_below_T_max">no_MLT_below_T_max <a href="#no_MLT_below_T_max" title="Permalink to this location">¶</a></h3>


if true, then no MLT below location of max T (just radiative).

{% highlight fortran %}
no_MLT_below_T_max = .false.
{% endhighlight %}


<h3 id="T_mix_limit">T_mix_limit <a href="#T_mix_limit" title="Permalink to this location">¶</a></h3>


If there is any convection in surface zones with `T < T_mix_limit`,
then extend the innermost such convective region outward all the way to the surface.
For example,

+ `T_mix_limit <= 0` means omit this operation.
+ `T_mix_limit = 1d5` will effectively make the star convective down to the He++ region.

units in Kelvin

{% highlight fortran %}
T_mix_limit = 0
{% endhighlight %}


<h3 id="mlt_gradT_fraction">mlt_gradT_fraction <a href="#mlt_gradT_fraction" title="Permalink to this location">¶</a></h3>


let f := `mlt_gradT_fraction`
if f is >= 0 and <= 1, then
gradT from mlt is replaced by `f*grada_at_face(k) + (1-f)*gradr(k)`
see also the vector control `adjust_mlt_gradT_fraction` for fine grain control

{% highlight fortran %}
mlt_gradT_fraction = -1
{% endhighlight %}


<h3 id="okay_to_reduce_gradT_excess">okay_to_reduce_gradT_excess <a href="#okay_to_reduce_gradT_excess" title="Permalink to this location">¶</a></h3>


`gradT_excess` = `gradT_sub_grada` = superadiabaticity.

Inefficient convection => large gradT excess and steep T gradient to enhance radiative transport.
Reduce gradT excess by making gradT closer to adiabatic gradient.
If true, code is allowed to adjust gradT to boost efficiency of energy transport
See `gradT_excess_f1`, `gradT_excess_f2`, and `gradT_excess_age_fraction` below.

This is the treatment of convection, referred to as MLT++
in Section 7.2 of Paxton et al. (2013), that reduces the
superadiabaticity in some radiation-dominated convective regions.

{% highlight fortran %}
okay_to_reduce_gradT_excess = .false.
{% endhighlight %}


<h3 id="gradT_excess_f1">gradT_excess_f1 <a href="#gradT_excess_f1" title="Permalink to this location">¶</a></h3>


<h3 id="gradT_excess_f2">gradT_excess_f2 <a href="#gradT_excess_f2" title="Permalink to this location">¶</a></h3>


These are for calculation of efficiency boosted gradT.

{% highlight fortran %}
gradT_excess_f1 = 1d-4
gradT_excess_f2 = 1d-3
{% endhighlight %}


<h3 id="gradT_excess_age_fraction">gradT_excess_age_fraction <a href="#gradT_excess_age_fraction" title="Permalink to this location">¶</a></h3>


These are for calculation of efficiency boosted gradT.
Fraction of old to mix with new to get next.

{% highlight fortran %}
gradT_excess_age_fraction = 0.9d0
{% endhighlight %}


<h3 id="gradT_excess_max_change">gradT_excess_max_change <a href="#gradT_excess_max_change" title="Permalink to this location">¶</a></h3>


These are for calculation of efficiency boosted gradT.
Maximum change allowed in one timestep for `gradT_excess_alpha`.
Ignored if negative.

{% highlight fortran %}
gradT_excess_max_change = -1d0
{% endhighlight %}


<h3 id="gradT_excess_lambda1">gradT_excess_lambda1 <a href="#gradT_excess_lambda1" title="Permalink to this location">¶</a></h3>


<h3 id="gradT_excess_beta1">gradT_excess_beta1 <a href="#gradT_excess_beta1" title="Permalink to this location">¶</a></h3>


In some situations you might want to force alfa = 1.
You can do that by setting `gradT_excess_lambda1 < 0`.
The following are for the normal calculation of `gradT_excess_alfa`

{% highlight fortran %}
gradT_excess_lambda1 = 1.0d0
gradT_excess_beta1 = 0.35d0
{% endhighlight %}


<h3 id="gradT_excess_lambda2">gradT_excess_lambda2 <a href="#gradT_excess_lambda2" title="Permalink to this location">¶</a></h3>


<h3 id="gradT_excess_beta2">gradT_excess_beta2 <a href="#gradT_excess_beta2" title="Permalink to this location">¶</a></h3>


The following are for the normal calculation of `gradT_excess_alfa`.

{% highlight fortran %}
gradT_excess_lambda2 = 0.5d0
gradT_excess_beta2 = 0.25d0
{% endhighlight %}


<h3 id="gradT_excess_dlambda">gradT_excess_dlambda <a href="#gradT_excess_dlambda" title="Permalink to this location">¶</a></h3>


<h3 id="gradT_excess_dbeta">gradT_excess_dbeta <a href="#gradT_excess_dbeta" title="Permalink to this location">¶</a></h3>


The following are for the normal calculation of `gradT_excess_alfa`.

{% highlight fortran %}
gradT_excess_dlambda = 0.1d0
gradT_excess_dbeta = 0.1d0
{% endhighlight %}


<h3 id="gradT_excess_max_center_h1">gradT_excess_max_center_h1 <a href="#gradT_excess_max_center_h1" title="Permalink to this location">¶</a></h3>


No boost if center H1 > this limit.

{% highlight fortran %}
gradT_excess_max_center_h1 = 1d0
{% endhighlight %}


<h3 id="gradT_excess_min_center_he4">gradT_excess_min_center_he4 <a href="#gradT_excess_min_center_he4" title="Permalink to this location">¶</a></h3>


No boost if center He4 < this limit.

{% highlight fortran %}
gradT_excess_min_center_he4 = 0d0
{% endhighlight %}


<h3 id="gradT_excess_max_logT">gradT_excess_max_logT <a href="#gradT_excess_max_logT" title="Permalink to this location">¶</a></h3>


No local boost if local logT > this limit.

{% highlight fortran %}
gradT_excess_max_logT = 8
{% endhighlight %}


<h3 id="gradT_excess_min_log_tau_full_on">gradT_excess_min_log_tau_full_on <a href="#gradT_excess_min_log_tau_full_on" title="Permalink to this location">¶</a></h3>


<h3 id="gradT_excess_max_log_tau_full_off">gradT_excess_max_log_tau_full_off <a href="#gradT_excess_max_log_tau_full_off" title="Permalink to this location">¶</a></h3>


No local boost if local `log_tau < gradT_excess_max_log_tau_full_off`.
Reduced local boost if local `log_tau < gradT_excess_min_log_tau_full_on`.

{% highlight fortran %}
gradT_excess_min_log_tau_full_on = -99
gradT_excess_max_log_tau_full_off = -99
{% endhighlight %}


<h3 id="smooth_gradT">smooth_gradT <a href="#smooth_gradT" title="Permalink to this location">¶</a></h3>


<h3 id="gradT_smooth_low">gradT_smooth_low <a href="#gradT_smooth_low" title="Permalink to this location">¶</a></h3>


<h3 id="gradT_smooth_high">gradT_smooth_high <a href="#gradT_smooth_high" title="Permalink to this location">¶</a></h3>


EXPERIMENTAL: soften gradT at the boundaries of convective zones to help convergence

{% highlight fortran %}
smooth_gradT = .false.
gradT_smooth_low = -0.005d0
gradT_smooth_high = 0.01d0
{% endhighlight %}


<h3 id="max_logT_for_mlt">max_logT_for_mlt <a href="#max_logT_for_mlt" title="Permalink to this location">¶</a></h3>


No mlt at cell if local logT > this limit.

{% highlight fortran %}
max_logT_for_mlt = 99
{% endhighlight %}


<h2 id="overshooting">overshooting <a href="#overshooting" title="Permalink to this location">¶</a></h2>


Overshooting depends on the classification of the convective zone
and can be different at the top and the bottom of the zone.

<h3 id="min_overshoot_q">min_overshoot_q <a href="#min_overshoot_q" title="Permalink to this location">¶</a></h3>


Overshooting is only allowed at locations with mass `m >= min_overshoot_q * mstar`.
E.g., if `min_overshoot_q = 0.1`, then only the outer 90% by mass can have overshooting.
This provides a simple way of suppressing bogus center overshooting in which a small
convective region at the core can produce excessively large overshooting because of
a large pressure scale height at the center.

{% highlight fortran %}
min_overshoot_q = 1d-3
{% endhighlight %}


<h3 id="D_mix_ov_limit">D_mix_ov_limit <a href="#D_mix_ov_limit" title="Permalink to this location">¶</a></h3>


Overshooting shuts off when the exponential decay has dropped the diffusion
coefficient to this level.

{% highlight fortran %}
D_mix_ov_limit = 1d2
{% endhighlight %}


<h3 id="max_brunt_B_for_overshoot">max_brunt_B_for_overshoot <a href="#max_brunt_B_for_overshoot" title="Permalink to this location">¶</a></h3>


Terminate overshoot region when encounter stabilizing composition gradient
where (unsmoothed) `brunt_B` is greater than this limit. (<= 0 means ignore this limit)
note: both `brunt_B` and `gradL_composition_term` come from `unsmoothed_brunt_B`
and differ only in optional smoothing.
(see `num_cells_for_smooth_brunt_B` and `num_cells_for_smooth_gradL_composition_term`).

{% highlight fortran %}
max_brunt_B_for_overshoot = 0
{% endhighlight %}


Parameters for exponential diffusive overshoot are described in the paper by Falk Herwig,
"The evolution of AGB stars with convective overshoot", A&A, 360, 952-968 (2000).

NOTE: In addition to giving these 'f' parameters non-zero values, you should also
check the settings for `mass_for_overshoot_full_on` and `mass_for_overshoot_full_off`.

The switch from convective mixing to overshooting happens
at a distance f0*Hp into the convection zone
from the estimated location where `grad_ad == grad_rad`,
where Hp is the pressure scale height at that location.
A value <= 0 for f0 is a mistake -- you are required to set f0 as well as f.
take a look at the following from an email concerning this:

Overshooting works by taking the diffusion mixing coefficient at the edge
of the convection zone and extending it beyond the zone. But -- and here's the issue --
at the exact edge of the zone the mixing coefficient goes to 0.  So we don't want that.
Instead we want the value of the mixing coeff NEAR the edge, but not AT the edge.
The "f0" parameter determines the exact meaning of "near" for this.  It tells the code
how far back into the zone to go in terms of scale height. The overshooting actually
begins at the location determined by f0 back into the convection zone rather than at
the edge where the diffusion coeff is ill-defined.  So, for example, if you want
overshooting of 0.2 scale heights beyond the normal edge, you might want to back up
0.05 scale heights to get the diffusion coeff from near the edge and then go out
by 0.25 scale heights from there to reach 0.2 Hp beyond the old boundary.  In the
inlist this would mean setting the "f0" to 0.05 and the "f" to 0.25.

There is no default value for f0; if you set f > 0 then you must get f0 > 0 as well.

<h3 id="overshoot_alpha">overshoot_alpha <a href="#overshoot_alpha" title="Permalink to this location">¶</a></h3>


The value of Hp for overshooting is limited to the radial thickness
of the convection zone divided by `overshoot_alpha`.
only used when > 0.  if <= 0, then use `mixing_length_alpha` instead.

{% highlight fortran %}
overshoot_alpha = -1
{% endhighlight %}


<h3 id="limit_overshoot_Hp_using_size_of_convection_zone">limit_overshoot_Hp_using_size_of_convection_zone <a href="#limit_overshoot_Hp_using_size_of_convection_zone" title="Permalink to this location">¶</a></h3>


if false, allow large distance of overshoot for small convective zones.

{% highlight fortran %}
limit_overshoot_Hp_using_size_of_convection_zone = .true.
{% endhighlight %}


<h3 id="burn_z_mix_region_logT">burn_z_mix_region_logT <a href="#burn_z_mix_region_logT" title="Permalink to this location">¶</a></h3>


<h3 id="burn_he_mix_region_logT">burn_he_mix_region_logT <a href="#burn_he_mix_region_logT" title="Permalink to this location">¶</a></h3>


<h3 id="burn_h_mix_region_logT">burn_h_mix_region_logT <a href="#burn_h_mix_region_logT" title="Permalink to this location">¶</a></h3>


max logT in convective region determines burn type for overshooting

{% highlight fortran %}
burn_z_mix_region_logT = 8.7d0
burn_he_mix_region_logT = 7.7d0
burn_h_mix_region_logT = 6.7d0
{% endhighlight %}


<h3 id="max_Y_for_burn_z_mix_region">max_Y_for_burn_z_mix_region <a href="#max_Y_for_burn_z_mix_region" title="Permalink to this location">¶</a></h3>


<h3 id="max_X_for_burn_he_mix_region">max_X_for_burn_he_mix_region <a href="#max_X_for_burn_he_mix_region" title="Permalink to this location">¶</a></h3>


Even if a region reaches the above temperature to be considered as
a z_burn region, only set it as such if the helium mass fraction
in all points of the region is below max_Y_for_burn_z_mix_region.
Similarly, max_X_for_burn_he_mix_region controls if a region is
considered as a he_burn region in terms of the hydrogen mass fraction.

{% highlight fortran %}
max_Y_for_burn_z_mix_region = 1d-4
max_X_for_burn_he_mix_region = 1d-4
{% endhighlight %}


<h3 id="overshoot_f_above_nonburn_core">overshoot_f_above_nonburn_core <a href="#overshoot_f_above_nonburn_core" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f0_above_nonburn_core">overshoot_f0_above_nonburn_core <a href="#overshoot_f0_above_nonburn_core" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f_above_nonburn_shell">overshoot_f_above_nonburn_shell <a href="#overshoot_f_above_nonburn_shell" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f0_above_nonburn_shell">overshoot_f0_above_nonburn_shell <a href="#overshoot_f0_above_nonburn_shell" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f_below_nonburn_shell">overshoot_f_below_nonburn_shell <a href="#overshoot_f_below_nonburn_shell" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f0_below_nonburn_shell">overshoot_f0_below_nonburn_shell <a href="#overshoot_f0_below_nonburn_shell" title="Permalink to this location">¶</a></h3>


For nonburning regions.

{% highlight fortran %}
overshoot_f_above_nonburn_core = 0
overshoot_f0_above_nonburn_core = -1
overshoot_f_above_nonburn_shell = 0
overshoot_f0_above_nonburn_shell = -1
overshoot_f_below_nonburn_shell = 0
overshoot_f0_below_nonburn_shell = -1
{% endhighlight %}


<h3 id="overshoot_f_above_burn_h_core">overshoot_f_above_burn_h_core <a href="#overshoot_f_above_burn_h_core" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f0_above_burn_h_core">overshoot_f0_above_burn_h_core <a href="#overshoot_f0_above_burn_h_core" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f_above_burn_h_shell">overshoot_f_above_burn_h_shell <a href="#overshoot_f_above_burn_h_shell" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f0_above_burn_h_shell">overshoot_f0_above_burn_h_shell <a href="#overshoot_f0_above_burn_h_shell" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f_below_burn_h_shell">overshoot_f_below_burn_h_shell <a href="#overshoot_f_below_burn_h_shell" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f0_below_burn_h_shell">overshoot_f0_below_burn_h_shell <a href="#overshoot_f0_below_burn_h_shell" title="Permalink to this location">¶</a></h3>


For hydrogen burning regions.

{% highlight fortran %}
overshoot_f_above_burn_h_core = 0
overshoot_f0_above_burn_h_core = -1
overshoot_f_above_burn_h_shell = 0
overshoot_f0_above_burn_h_shell = -1
overshoot_f_below_burn_h_shell = 0
overshoot_f0_below_burn_h_shell = -1
{% endhighlight %}


<h3 id="overshoot_f_above_burn_he_core">overshoot_f_above_burn_he_core <a href="#overshoot_f_above_burn_he_core" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f0_above_burn_he_core">overshoot_f0_above_burn_he_core <a href="#overshoot_f0_above_burn_he_core" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f_above_burn_he_shell">overshoot_f_above_burn_he_shell <a href="#overshoot_f_above_burn_he_shell" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f0_above_burn_he_shell">overshoot_f0_above_burn_he_shell <a href="#overshoot_f0_above_burn_he_shell" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f_below_burn_he_shell">overshoot_f_below_burn_he_shell <a href="#overshoot_f_below_burn_he_shell" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f0_below_burn_he_shell">overshoot_f0_below_burn_he_shell <a href="#overshoot_f0_below_burn_he_shell" title="Permalink to this location">¶</a></h3>


For helium burning regions.

{% highlight fortran %}
overshoot_f_above_burn_he_core = 0
overshoot_f0_above_burn_he_core = -1
overshoot_f_above_burn_he_shell = 0
overshoot_f0_above_burn_he_shell = -1
overshoot_f_below_burn_he_shell = 0
overshoot_f0_below_burn_he_shell = -1
{% endhighlight %}


<h3 id="overshoot_f_above_burn_z_core">overshoot_f_above_burn_z_core <a href="#overshoot_f_above_burn_z_core" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f0_above_burn_z_core">overshoot_f0_above_burn_z_core <a href="#overshoot_f0_above_burn_z_core" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f_above_burn_z_shell">overshoot_f_above_burn_z_shell <a href="#overshoot_f_above_burn_z_shell" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f0_above_burn_z_shell">overshoot_f0_above_burn_z_shell <a href="#overshoot_f0_above_burn_z_shell" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f_below_burn_z_shell">overshoot_f_below_burn_z_shell <a href="#overshoot_f_below_burn_z_shell" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f0_below_burn_z_shell">overshoot_f0_below_burn_z_shell <a href="#overshoot_f0_below_burn_z_shell" title="Permalink to this location">¶</a></h3>


For metals burning regions.

{% highlight fortran %}
overshoot_f_above_burn_z_core = 0
overshoot_f0_above_burn_z_core = -1
overshoot_f_above_burn_z_shell = 0
overshoot_f0_above_burn_z_shell = -1
overshoot_f_below_burn_z_shell = 0
overshoot_f0_below_burn_z_shell = -1
{% endhighlight %}


<h3 id="overshoot_below_noburn_shell_factor">overshoot_below_noburn_shell_factor <a href="#overshoot_below_noburn_shell_factor" title="Permalink to this location">¶</a></h3>


Multiply `overshoot_f_below_nonburn_shell` by this factor
only during dredge up phase of AGB thermal pulse.

{% highlight fortran %}
overshoot_below_noburn_shell_factor = 1
{% endhighlight %}


Optional step function for overshooting.
This can be used simultaneously with exponential overshooting.
When using step overshoot, you must set overshoot_f0 as well as f.

A convective region is considered a shell if it doesn't reach the center.

{% highlight fortran %}
step_overshoot_f_above_nonburn_core = 0
step_overshoot_f_above_nonburn_shell = 0
step_overshoot_f_below_nonburn_shell = 0
{% endhighlight %}


{% highlight fortran %}
step_overshoot_f_above_burn_h_core = 0
step_overshoot_f_above_burn_h_shell = 0
step_overshoot_f_below_burn_h_shell = 0
{% endhighlight %}


{% highlight fortran %}
step_overshoot_f_above_burn_he_core = 0
step_overshoot_f_above_burn_he_shell = 0
step_overshoot_f_below_burn_he_shell = 0
{% endhighlight %}


{% highlight fortran %}
step_overshoot_f_above_burn_z_core = 0
step_overshoot_f_above_burn_z_shell = 0
step_overshoot_f_below_burn_z_shell = 0
{% endhighlight %}


<h3 id="step_overshoot_D">step_overshoot_D <a href="#step_overshoot_D" title="Permalink to this location">¶</a></h3>


<h3 id="step_overshoot_D0_coeff">step_overshoot_D0_coeff <a href="#step_overshoot_D0_coeff" title="Permalink to this location">¶</a></h3>


As above, `f0*Hp` determines r0 where switch from convection to overshooting.
Overshooting extends a distance `step_f*Hp0` from r0
with constant diffusion coeff `D = step_D + step_D0_coeff*D0`
where D0 = diffusion coefficient D at point r0.

{% highlight fortran %}
step_overshoot_D = 0
step_overshoot_D0_coeff = 1
{% endhighlight %}


<h3 id="mass_for_overshoot_full_on">mass_for_overshoot_full_on <a href="#mass_for_overshoot_full_on" title="Permalink to this location">¶</a></h3>


You can specify a range of star masses over which overshooting
above H burning zones is gradually enabled.
Do specified overshooting above H burning zone if `star_mass` >= this (Msun).

{% highlight fortran %}
mass_for_overshoot_full_on = 0
{% endhighlight %}


<h3 id="mass_for_overshoot_full_off">mass_for_overshoot_full_off <a href="#mass_for_overshoot_full_off" title="Permalink to this location">¶</a></h3>


You can specify a range of star masses over which overshooting
above H burning zones is gradually enabled.
No overshooting above H burning zone if `star_mass` <= this  (Msun).

{% highlight fortran %}
mass_for_overshoot_full_off = 0
{% endhighlight %}


<h3 id="DUP_varcontrol_factor">DUP_varcontrol_factor <a href="#DUP_varcontrol_factor" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
DUP_varcontrol_factor = 1d0
{% endhighlight %}


<h3 id="max_DUP_counter">max_DUP_counter <a href="#max_DUP_counter" title="Permalink to this location">¶</a></h3>


For deciding when to terminate use of `overshoot_below_noburn_shell_factor`.

{% highlight fortran %}
max_DUP_counter = 200
{% endhighlight %}


<h3 id="ovr_below_burn_he_shell_factor">ovr_below_burn_he_shell_factor <a href="#ovr_below_burn_he_shell_factor" title="Permalink to this location">¶</a></h3>


Multiply `overshoot_f_below_burn_he_shell` by this factor
after the first AGB thermal pulse.

{% highlight fortran %}
ovr_below_burn_he_shell_factor = 1
{% endhighlight %}


<h3 id="overshoot_D2">overshoot_D2 <a href="#overshoot_D2" title="Permalink to this location">¶</a></h3>


<h3 id="overshoot_f2">overshoot_f2 <a href="#overshoot_f2" title="Permalink to this location">¶</a></h3>


optional 2nd scale length for exponential overshooting

`f0*Hp` determines location r0 where we switch from convection to overshooting.
Let D0 = diffusion coefficient D at point r0.
Let Hp0 = the scale height at r0.
In the standard version of exponential overshooting,
there is a single length scale = `f*Hp0`
and at a distance dr from r0, `D(dr) = D0*exp(-2*dr/(f*Hp0))`.

In the extended version there is a second length scale = `f2*Hp0`.
The second length scale takes effect for distances dr > dr2
where dr2 is defined by `D2 = D0*exp(-2*dr2/(f*Hp0))`.

+ for dr <= dr2, D(dr) = `D0*exp(-2*dr/(f*Hp0))`
+ for dr > dr2, D(dr) = `D2*exp(-2*(dr-dr2)/(f2*Hp0))`
    = `D0*exp(-2*dr2/(f*Hp0))*exp(-2*(dr-dr2)/(f2*Hp0))`
    = `D0*exp(-2*(dr2/(f*Hp0) + (dr-dr2)/(f2*Hp0)))`

{% highlight fortran %}
overshoot_D2_above_nonburn = -1d0
overshoot_D2_below_nonburn = -1d0
{% endhighlight %}


{% highlight fortran %}
overshoot_D2_above_burn_h = -1d0
overshoot_D2_below_burn_h = -1d0
{% endhighlight %}


{% highlight fortran %}
overshoot_D2_above_burn_he = -1d0
overshoot_D2_below_burn_he = -1d0
{% endhighlight %}


{% highlight fortran %}
overshoot_D2_above_burn_z = -1d0
overshoot_D2_below_burn_z = -1d0
{% endhighlight %}


{% highlight fortran %}
overshoot_f2_above_nonburn = 1d0
overshoot_f2_below_nonburn = 1d0
{% endhighlight %}


{% highlight fortran %}
overshoot_f2_above_burn_h = 1d0
overshoot_f2_below_burn_h = 1d0
{% endhighlight %}


{% highlight fortran %}
overshoot_f2_above_burn_he = 1d0
overshoot_f2_below_burn_he = 1d0
{% endhighlight %}


{% highlight fortran %}
overshoot_f2_above_burn_z = 1d0
overshoot_f2_below_burn_z = 1d0
{% endhighlight %}


<h3 id="RGB_to_AGB_cbm_switch">RGB_to_AGB_cbm_switch <a href="#RGB_to_AGB_cbm_switch" title="Permalink to this location">¶</a></h3>


If center hydrogen abundance is < 0.01
and center helium abundance by mass is less than `RGB_to_AGB_cbm_switch`,
then system will include `overshoot_D2` and `overshoot_f2` parameters to describe 
convective boundary mixing during the AGB phase if set to positive values.
See Battino et al. 2016, APJ, 827:30         
"Application of a theory and simulation-based convective boundary
 mixing model for AGB star evolution and nucleosynthesis"
`RGB_to_AGB_cbm_switch = 1d-4`  is used in the paper above.

{% highlight fortran %}
RGB_to_AGB_cbm_switch = -1
{% endhighlight %}


<h2 id="Predictive_mixing">Predictive mixing <a href="#Predictive_mixing" title="Permalink to this location">¶</a></h2>


Predictive mixing is an approach for expanding convective boundaries until
gradr = grada on the convective side of the boundary (as required by the criterion
that the convective velocity and luminosity vanish at the boundary). It is discussed
in detail in Paxton et al. 2018, ApJ, in press: "Modules for Experiments in Stellar 
Astrophysics (MESA): Convective boundaries, element diffusion, and massive star explosions"

Predictive mixing is controlled by specifying a set of parameters, which combines matching
criteria (determining which boundaries to apply the predictive mixing to) together with
values (determining how the predictive mixing should operate at those boundaries). Up to
`NUM_PREDICTIVE_PARAM_SETS` of these parameter sets can be defined (see `star_def.inc` for value).

<h3 id="predictive_mix">predictive_mix <a href="#predictive_mix" title="Permalink to this location">¶</a></h3>


Set to .true. to enable this set of parameters

{% highlight fortran %}
predictive_mix(1) = .false.
{% endhighlight %}


<h3 id="predictive_zone_type">predictive_zone_type <a href="#predictive_zone_type" title="Permalink to this location">¶</a></h3>


Matching criterion for the type of the convection zone. Possible values are `burn_H`
(hydrogen burning), `burn_He` (helium burning), `burn_Z` (metal burning), `nonburn`
(no burning) or `any` (which matches any type of zone).

{% highlight fortran %}
predictive_zone_type(1) = ''
{% endhighlight %}


<h3 id="predictive_zone_loc">predictive_zone_loc <a href="#predictive_zone_loc" title="Permalink to this location">¶</a></h3>


Matching criterion for the location of the convection zone. Possible values are `core`
(the core convection zone), `shell` (a convective shell), `surf` (the surface convection
zone) or `any` (which matches any location).

{% highlight fortran %}
predictive_zone_loc(1) = ''
{% endhighlight %}


<h3 id="predictive_bdy_loc">predictive_bdy_loc <a href="#predictive_bdy_loc" title="Permalink to this location">¶</a></h3>


Matching criterion for the location of the convective boundary. Possible values are
`top` (the top of the convection zone), `bottom` (the bottom of the convection zone)
or `any` (which matches any location).

{% highlight fortran %}
predictive_bdy_loc(1) = ''
{% endhighlight %}


<h3 id="predictive_bdy_q_min">predictive_bdy_q_min <a href="#predictive_bdy_q_min" title="Permalink to this location">¶</a></h3>


Matching criterion for the minimum fractional mass coordinate of the convective
boundary

{% highlight fortran %}
predictive_bdy_q_min(1) = 0d0
{% endhighlight %}


<h3 id="predictive_bdy_q_max">predictive_bdy_q_max <a href="#predictive_bdy_q_max" title="Permalink to this location">¶</a></h3>


Matching criterion for the maximum fractional mass coordinate of the convective
boundary

{% highlight fortran %}
predictive_bdy_q_max(1) = 1d0
{% endhighlight %}


<h3 id="predictive_superad_thresh">predictive_superad_thresh <a href="#predictive_superad_thresh" title="Permalink to this location">¶</a></h3>


Threshold for minimum superadiabaticity in the predictive mixing scheme; boundary
expansion stops when gradr/grada-1 drops below this threshold. Default value is usually
good for main-sequence evolution; for core He-burning, set to 0.005, 0.01 or larger
to prevent splitting of the core convection zone and/or core breathing pulses.

{% highlight fortran %}
predictive_superad_thresh(1) = 0d0
{% endhighlight %}


<h3 id="predictive_avoid_reversal">predictive_avoid_reversal <a href="#predictive_avoid_reversal" title="Permalink to this location">¶</a></h3>


Species to monitor for reversals in abundance evolution. If this is set to the name
of a species, then the predictive mixing scheme will try to avoid causing reversals
in the abundance of that species (e.g., changing the abundance evolution from decreasing
to increasing). Set to 'he4' during core He-burning to prevent splitting of the core
convection zone and/or core breathing pulses.

{% highlight fortran %}
predictive_avoid_reversal(1) = ''
{% endhighlight %}


<h3 id="predictive_limit_ingestion">predictive_limit_ingestion <a href="#predictive_limit_ingestion" title="Permalink to this location">¶</a></h3>


<h3 id="predictive_ingestion_factor">predictive_ingestion_factor <a href="#predictive_ingestion_factor" title="Permalink to this location">¶</a></h3>


Limit the rate of ingestion of a species, following the prescription given in
equation (2) of Constantino, Campbell & Lattanzio (2017, MNRAS, 472, 4900). The control
`predictive_limit_ingestion` specifies which species to limit, and the control
`predictive_ingestion_factor` gives the multiplying factor. Setting this factor to 5/12
is the same as choosing alpha_i = 1 in their equation (2).

{% highlight fortran %}
predictive_limit_ingestion(1) = ''
predictive_ingestion_factor(1) = 0d0
{% endhighlight %}


<h2 id="Convective_premixing">Convective premixing <a href="#Convective_premixing" title="Permalink to this location">¶</a></h2>


Convective premixing is a approach to handling mixing in convection zones that improves
upon the predictive mixing scheme described above. Like predictive mixing, it expands
convective boundaries until gradr = grada on the convective side of the boundary. Unlike
predictive mixing, it directly modifies abundances in the stellar model, via a iterative
series of mixings-to-homogeneity over a shifting window of cells. This iterative approach
allows convective premixing to build 'classical' semiconvection regions, where the abundance
gradient is tuned to yield convective neutrality.

<h3 id="do_conv_premix">do_conv_premix <a href="#do_conv_premix" title="Permalink to this location">¶</a></h3>


Set to .true. to perform convective premixing. Note that this cannot be enabled at the
same time as the `predictive_mix` control

{% highlight fortran %}
do_conv_premix = .false.
{% endhighlight %}


<h3 id="conv_premix_avoid_increase">conv_premix_avoid_increase <a href="#conv_premix_avoid_increase" title="Permalink to this location">¶</a></h3>


Attempt to avoid increases in the abundance of species being burned. Sometimes, the
convective premixing scheme can cause the abundance of a species being burned (e.g.,
helium during core helium burning) to increase across a timestep. This typically arises
when the scheme mixes a fresh supply of the species into the convection zone where the
burning is occurring. Setting the `conv_premix_avoid_increase` control to .true. will
tell the scheme to avoid such outcomes, if possible. In the case of core helium burning,
this helps to reduces the incidences of core breathing pulses (although in some situations
it doesn't completely eliminate them).

{% highlight fortran %}
conv_premix_avoid_increase = .false.
{% endhighlight %}


<h3 id="conv_premix_time_factor">conv_premix_time_factor <a href="#conv_premix_time_factor" title="Permalink to this location">¶</a></h3>


Scaling factor for deciding whether a convective boundary has enough time to advance during
a timestep. Simple physical arguments suggest that a convective boundary requires a time
delta_t ~ delta_r/v_conv to advance a distance delta_r. The convective premixing algorithm
keeps a tally of how much time a boundary has spent advancing, and it prevents further advancing
if this time would exceed conv_premix_time_factor*dt, where dt is the current timestep. Setting
conv_premix_time_factor to a value <= 0 disables this check. STILL UNDER DEVELOPMENT, AND DISABLED
BY DEFAULT

{% highlight fortran %}
conv_premix_time_factor = 0.0
{% endhighlight %}


### conv_premix_fix_pgas

Flag to decide whether gas pressure is kept constant during premixing (.true.), or instead
density is kept constant (.false.). In both cases, temperature is kept constant.

{% highlight fortran %}
conv_premix_fix_pgas = .true.
{% endhighlight %}


### conv_premix_dump_snapshots

Flag to write out snapshots of the intermediate stages during the convective premixing iterations.
Refer to the dump_snapshot_ routine in star/private/conv_premix.f90 to see what's written out. Note
that this can quickly fill up your disk!

{% highlight fortran %}
conv_premix_dump_snapshots = .false.
{% endhighlight %}


<h2 id="New_overshooting">New overshooting <a href="#New_overshooting" title="Permalink to this location">¶</a></h2>


{% highlight fortran %}
overshoot_new = .false.
overshoot_f = 0d0
overshoot_f0 = 0d0
overshoot_f2 = 0d0
overshoot_D0 = 0d0
overshoot_D2 = 0d0
overshoot_Delta0 = 1d0
overshoot_c1 = 100d0
overshoot_c2 = 90d0
overshoot_mass_full_on = 0d0
overshoot_mass_full_off = 0d0
overshoot_scheme = ''
overshoot_zone_type = ''
overshoot_zone_loc = ''
overshoot_bdy_loc = ''
overshoot_D_min = 1d2
overshoot_brunt_B_max = 0d0
{% endhighlight %}


<h2 id="turbulence">turbulence <a href="#turbulence" title="Permalink to this location">¶</a></h2>


<h3 id="RTI_max_time_full_off">RTI_max_time_full_off <a href="#RTI_max_time_full_off" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_min_time_full_on">RTI_min_time_full_on <a href="#RTI_min_time_full_on" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
RTI_max_time_full_off = 0d0
RTI_min_time_full_on = 0d0
{% endhighlight %}


<h3 id="RTI_smooth_mass">RTI_smooth_mass <a href="#RTI_smooth_mass" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_smooth_iterations">RTI_smooth_iterations <a href="#RTI_smooth_iterations" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_smooth_fraction">RTI_smooth_fraction <a href="#RTI_smooth_fraction" title="Permalink to this location">¶</a></h3>


smoothing for `dPdr_dRhodr_info`
done at start of step

{% highlight fortran %}
RTI_smooth_mass = 0d0
RTI_smooth_iterations = 0
RTI_smooth_fraction = 1d0
{% endhighlight %}


<h3 id="alpha_RTI_diffusion_factor">alpha_RTI_diffusion_factor <a href="#alpha_RTI_diffusion_factor" title="Permalink to this location">¶</a></h3>


<h3 id="dudt_RTI_diffusion_factor">dudt_RTI_diffusion_factor <a href="#dudt_RTI_diffusion_factor" title="Permalink to this location">¶</a></h3>


<h3 id="dedt_RTI_diffusion_factor">dedt_RTI_diffusion_factor <a href="#dedt_RTI_diffusion_factor" title="Permalink to this location">¶</a></h3>


<h3 id="dlnddt_RTI_diffusion_factor">dlnddt_RTI_diffusion_factor <a href="#dlnddt_RTI_diffusion_factor" title="Permalink to this location">¶</a></h3>


<h3 id="composition_RTI_diffusion_factor">composition_RTI_diffusion_factor <a href="#composition_RTI_diffusion_factor" title="Permalink to this location">¶</a></h3>


<h3 id="max_M_RTI_factors_full_on">max_M_RTI_factors_full_on <a href="#max_M_RTI_factors_full_on" title="Permalink to this location">¶</a></h3>


<h3 id="min_M_RTI_factors_full_off">min_M_RTI_factors_full_off <a href="#min_M_RTI_factors_full_off" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
alpha_RTI_diffusion_factor = 1d0
dudt_RTI_diffusion_factor = 1d0
dedt_RTI_diffusion_factor = 1d0
dlnddt_RTI_diffusion_factor = 1d0
composition_RTI_diffusion_factor = 1d0
max_M_RTI_factors_full_on = 1d99
min_M_RTI_factors_full_off = 1d99
{% endhighlight %}


<h3 id="alpha_RTI_src_max_q">alpha_RTI_src_max_q <a href="#alpha_RTI_src_max_q" title="Permalink to this location">¶</a></h3>


<h3 id="alpha_RTI_src_min_q">alpha_RTI_src_min_q <a href="#alpha_RTI_src_min_q" title="Permalink to this location">¶</a></h3>


option to set `alpha_RTI` source term to zero when cell q out of bounds.
to turn off RTI near surface or center

{% highlight fortran %}
alpha_RTI_src_max_q = 1d0
alpha_RTI_src_min_q = 0d0
{% endhighlight %}


<h3 id="alpha_RTI_src_min_v_div_cs">alpha_RTI_src_min_v_div_cs <a href="#alpha_RTI_src_min_v_div_cs" title="Permalink to this location">¶</a></h3>


option to set alpha_RTI source term to zero when v/cs < this min.
e.g. to filter out false sources ahead of shock

{% highlight fortran %}
alpha_RTI_src_min_v_div_cs = 1d0
{% endhighlight %}


<h3 id="radial_stellar_pulsations_RSP">radial stellar pulsations (RSP) <a href="#radial_stellar_pulsations_RSP" title="Permalink to this location">¶</a></h3>


inspired by Radec Smolec's program
if you use RSP, please cite the following in addition to mesa:
R.Smolec and P.Moskalik, ACTA ASTRONOMICA, 58(2008), pp. 193-232.

must set mass, Teff, L, X, and Z.

{% highlight fortran %}
RSP_mass = -1
RSP_Teff = -1
RSP_L = -1
RSP_X = -1
RSP_Z = -1
{% endhighlight %}


Parameters of the convection model.
Note that RSP_alfap, RSP_alfas, RSP_alfac, RSP_alfad and RSP_gammar
are expressed in the units of standard values.
Standard values are the ones for which static version of the Kuhfuss
model reduces to standard MLT.
See Table 1 in Smolec & Moskalik 2008
http://adsabs.harvard.edu/abs/2008AcA....58..193S
for standard values and the description of the parameters.

{% highlight fortran %}
RSP_alfa = 1.5d0
RSP_alfac = 1.0d0
RSP_alfas = 1.0d0
RSP_alfad = 1.0d0
RSP_alfap = 0.0d0
RSP_alfat = 0.0d0
RSP_alfam = 0.25d0
RSP_gammar = 0.0d0
{% endhighlight %}


time weighting for end-of-step vs start-of-step values in equations.
1 corresponds to fully implicit scheme - stable, but can have large numerical damping.
0.5 corresponds to trapezoidal rule integration - gives least numerical damping.
do not use values less than 0.5.  strongly recommend 0.5 for theta and thetat.
don't mess with any of these unless you know what you are doing or like to watch the code crash.

{% highlight fortran %}
RSP_theta = 0.5d0
RSP_thetat = 0.5d0
RSP_thetae = 0.5d0
RSP_thetaq = 1.0d0
RSP_thetau = 1.0d0
RSP_wtr = 0.6667d0
RSP_wtc = 0.6667d0
RSP_wtt = 0.6667d0
RSP_gam = 1.0d0
{% endhighlight %}


controls for building the initial model

{% highlight fortran %}
RSP_nz = 150
RSP_nz_outer = 40
RSP_T_anchor = 11d3
RSP_T_inner = 2d6
{% endhighlight %}


{% highlight fortran %}
RSP_max_outer_dm_tries = 100
RSP_max_inner_scale_tries = 100
RSP_T_anchor_tolerance = 1d-8
{% endhighlight %}


allowed relative difference between T at base of outer region and T_anchor
if fail trying to create initial model, try increasing this to 1d-6 or more

{% highlight fortran %}
RSP_T_inner_tolerance = 1d-8
{% endhighlight %}


allowed relative difference between T at inner boundary and T_inner
if fail trying to create initial model, try increasing this to 1d-6 or more

{% highlight fortran %}
RSP_relax_initial_model = .true.
RSP_relax_alfap_before_alfat = .true.
RSP_relax_max_tries = 1000
RSP_relax_dm_tolerance = 1d-6
{% endhighlight %}


Initial kick makes use of the scaled linear velocity eigenvector
of a given mode or of the linear combination of the eigenvectors
for the fundamental mode and first two radial overtones. 
The surface velocity is set to RSP_kick_vsurf_km_per_sec and
the mode content is set by RSP_fraction_1st_overtone and RSP_fraction_2nd_overtone

{% highlight fortran %}
RSP_kick_vsurf_km_per_sec = 0.1d0
RSP_fraction_1st_overtone = 0d0
RSP_fraction_2nd_overtone = 0d0
{% endhighlight %}


fraction from fundamental = 1d0 - (1st + 2nd)
Note: This is important for models in which two or more modes are linearly unstable.
Appropriate setting may help to arrive at the desired mode, since the final pulsation
state may depend on initial conditions set by the three parameters above.
Integration of the same model with different initial kicks is a way to study
the nonlinear mode selection -
for an example see Fig. 1 in Smolec & Moskalik 2010
http://adsabs.harvard.edu/abs/2010A%26A...524A..40S .

random initial velocity profile.  added to any kick from eigenvector.

{% highlight fortran %}
RSP_Avel = 0d0
RSP_Arnd = 0d0
{% endhighlight %}


period controls

{% highlight fortran %}
RSP_target_steps_per_cycle = 600
RSP_save_profile_at_end_of_each_period = .true.
RSP_min_max_R_for_periods = -1
RSP_min_PERIOD_div_PERIODLIN = 0.5d0
RSP_mode_for_setting_PERIODLIN = 1
{% endhighlight %}


when to stop

{% highlight fortran %}
RSP_max_num_periods = -1
RSP_GREKM_avg_abs_frac_new = 0.1d0
RSP_GREKM_avg_abs_limit = -1
{% endhighlight %}


timestep limiting

{% highlight fortran %}
RSP_initial_dt_factor = 1d-2
{% endhighlight %}


start with smaller timestep to give time for initial model to adjust

{% highlight fortran %}
RSP_Uq_threshold_for_dt_limit = 100d0
RSP_v_div_cs_threshold_for_dt_limit = 0.8d0
RSP_max_dt_times_min_dr_div_cs = 5d0
{% endhighlight %}


i.e., make dt <= this times min sound crossing time dr/cs
     for cells with abs(Uq) > threshold

{% highlight fortran %}
RSP_max_dt = -1
RSP_report_limit_dt = .false.
{% endhighlight %}


artificial viscosity controls
for the equations see: Appendix C in Stellingwerf 1975
http://adsabs.harvard.edu/abs/1975ApJ...195..441S.
In principle, for not too-non-adiabatic convective models artificial viscosity is not
needed or should be very small. Hence a large cut-off parameter below (in purely
radiative models the default value for cut-off was 0.01)

{% highlight fortran %}
RSP_cq = 4.0d0
RSP_zsh = 0.1d0
{% endhighlight %}


zsh > 0 delays onset of artificial viscosity
can eliminate most/all interior dissipation while still providing for extreme cases.
using this parameter the dependence of limiting amplitude on cq is very weak.

{% highlight fortran %}
RSP_Qvisc_quadratic = 0d0
{% endhighlight %}


as described in section 4.2 of mesa3, 2015.
RSP_Qvisc_quadratic is analogous to shock_spread_quadratic
if switch to this form, set RSP_cq = 0 to shut off the Neumann & Richtmyer form.
note that this form also uses RSP_zsh to delay onset of artficial viscosity

surface pressure.  provides outer boundary condition for momentum equation.

{% highlight fortran %}
RSP_use_Prad_for_Psurf = .false.
RSP_use_atm_grey_with_kap_for_Psurf = .false.
RSP_tau_surf_for_atm_grey_with_kap = 3d-3
RSP_fixed_Psurf = .true.
RSP_Psurf = 0d0
set_RSP_Psurf_to_multiple_of_initial_P1 = -1
{% endhighlight %}


set RSP_Psurf to this times initial surface cell pressure

solver controls

{% highlight fortran %}
RSP_tol_max_corr = 1d-8
RSP_tol_max_resid = 1d-6
RSP_max_iters_per_step = 100
RSP_max_retries_per_step = 8
max_number_retries = -1
RSP_report_undercorrections = .false.
RSP_nz_div_IBOTOM = 30d0
RSP_erad_eqn_dt_term_limit = 1d7
RSP_Fr_eqn_always_use_d_erad_dm = .false.
RSP_min_tau_for_turbulent_flux = 2d2
{% endhighlight %}


output data for work integrals during a particular period

{% highlight fortran %}
RSP_work_period = -1
RSP_work_filename = 'work.data'
{% endhighlight %}


output data for 3d map.  format same as for gnuplot pm3d 

{% highlight fortran %}
RSP_write_map = .false.
RSP_map_columns_filename = 'map_columns.list'
{% endhighlight %}


items listed in your map columns must also appear in your profile columns

{% highlight fortran %}
RSP_map_filename = 'map.data'
RSP_map_first_period = -1
RSP_map_last_period = -1
RSP_map_zone_interval = 2
RSP_map_history_filename = 'map_history.data'
{% endhighlight %}


rsp hooks

{% highlight fortran %}
use_other_RSP_starting_velocities = .false.
use_other_RSP_eddington_factor = .false.
use_other_RSP_build_model = .false.
{% endhighlight %}


for special tests
can set ALFA = 0 for pure radiative with no turbulence or convection.
can set gamma_law_hydro > 0 and it will be used by rsp for eos.
can set zero_gravity = .true.
can set opacity to be constant times density.

{% highlight fortran %}
RSP_kap_density_factor = -1
{% endhighlight %}


else set opacity to this times density

rsp misc

{% highlight fortran %}
RSP_efl0 = 1.0d2
RSP_nmodes = 3
RSP_trace_RSP_build_model = .false.
RSP_use_nlin_constants = .false.
{% endhighlight %}


-------- following are not ready for general use --------

rad hydro - not ready

{% highlight fortran %}
RSP_use_diffusion_limit = .true.
RSP_use_T_form_of_erad_eqn = .true.
RSP_use_T_form_of_Fr_eqn = .true.
RSP_accel_eqn_use_Prad_instead_of_Fr_term = .true.
{% endhighlight %}


f_Edd - not ready

{% highlight fortran %}
RSP_nz_div_number_of_core_rays_for_f_Edd = 5d0
RSP_max_tau_for_variable_f_Edd = 1d3
{% endhighlight %}


parameters for radiative energy equation - not ready

{% highlight fortran %}
RSP_kapE_factor = 1d0
RSP_kapP_factor = 1d0
{% endhighlight %}


mesh adjustment - not ready

{% highlight fortran %}
RSP_remesh_interval = 1
{% endhighlight %}


note: the following default weights are not appropriate for all situations.
check the test cases for examples.

{% highlight fortran %}
RSP_mesh_fcn_weight_lnd = 0d0
RSP_mesh_fcn_weight_lnT = 0d0
RSP_mesh_fcn_weight_lnP = 0d0
RSP_mesh_fcn_weight_lnE = 1d0
RSP_mesh_fcn_weight_lnm = 4d0
RSP_mesh_fcn_weight_lnkap = 1d0
RSP_mesh_fcn_weight_avg_charge_H = 0d0
RSP_mesh_fcn_weight_avg_charge_He = 0d0
{% endhighlight %}


{% highlight fortran %}
RSP_max_dq = 1d-1
RSP_min_dq = 1d-8
RSP_max_dq_jump = 1.5d0
RSP_max_periods_for_remeshing = 0
{% endhighlight %}


note that rsp remeshing is off if okay_to_remesh is false

{% highlight fortran %}
RSP_remesh_test_partials = .false.
trace_RSP_remesh = .false.
{% endhighlight %}


<h2 id="mixing_misc">mixing misc <a href="#mixing_misc" title="Permalink to this location">¶</a></h2>


<h3 id="radiation_turbulence_coeff">radiation_turbulence_coeff <a href="#radiation_turbulence_coeff" title="Permalink to this location">¶</a></h3>


To counter depletion of h and metals in outer envelope of stars with M > 1.4 Msun.
Morel, P., and Thevenin, F.,
Atomic diffusion in stellar models of type earlier than G.,
A&A, 390:611-620 (2002)

    D = radiation_turbulence_coeff * 4*crad*T^4/(15*clight*opacity*rho^2)

1 is reasonable value for this coefficient

{% highlight fortran %}
radiation_turbulence_coeff = 0
{% endhighlight %}


<h3 id="turbulent_diffusion_D0">turbulent_diffusion_D0 <a href="#turbulent_diffusion_D0" title="Permalink to this location">¶</a></h3>


Turbulent diffusion below outer convection zone.
Similar effect to overshooting.
Proffitt, C.R., and Michaud, G.,
GRAVITATIONAL SETTLING IN SOLAR MODELS,
ApJ, 380:238-290, 1991.
e.g., 8000 cm^2 s^-1

{% highlight fortran %}
turbulent_diffusion_D0 = 0
{% endhighlight %}


<h3 id="turbulent_diffusion_rho_max">turbulent_diffusion_rho_max <a href="#turbulent_diffusion_rho_max" title="Permalink to this location">¶</a></h3>


Only have turbulent diffusion if rho < this.
Diffusion coef `D = D0*(rho/rho_base_cz)^-3`,
but only if `rho_base_cz <= turbulent_diffusion_rho_max`.

{% highlight fortran %}
turbulent_diffusion_rho_max = 1d99
{% endhighlight %}


<h3 id="turbulent_diffusion_Dmin">turbulent_diffusion_Dmin <a href="#turbulent_diffusion_Dmin" title="Permalink to this location">¶</a></h3>


Only set turbulent diffusion if it gives D >= this.

{% highlight fortran %}
turbulent_diffusion_Dmin = 1d1
{% endhighlight %}


such as smoothing and editing of diffusion coefficients

<h3 id="mix_factor">mix_factor <a href="#mix_factor" title="Permalink to this location">¶</a></h3>


Mixing coefficients are multiplied by this factor.
The `mix_factor` is applied in subroutine `get_convection_sigmas` in `star/private/mix_info.f90` --
the lagrangian diffusion coefficient sigma(k) at cell boundary k is set to
        `mix_factor*D*(4*pi*r(k)^2*rho_face(k))^2`
Note that the value of D is not changed -- it is just used as a term in calculating sigma.

{% highlight fortran %}
mix_factor = 1
{% endhighlight %}


<h3 id="min_dt_for_increases_in_convection_velocity">min_dt_for_increases_in_convection_velocity <a href="#min_dt_for_increases_in_convection_velocity" title="Permalink to this location">¶</a></h3>


convective velocities are not increased if dt < this value (in seconds)

{% highlight fortran %}
min_dt_for_increases_in_convection_velocity = -1d0
{% endhighlight %}


<h3 id="max_conv_vel_div_csound">max_conv_vel_div_csound <a href="#max_conv_vel_div_csound" title="Permalink to this location">¶</a></h3>


convective velocities are limited to local sound speed times this factor

{% highlight fortran %}
max_conv_vel_div_csound = 1d99
{% endhighlight %}


<h3 id="max_v_for_convection">max_v_for_convection <a href="#max_v_for_convection" title="Permalink to this location">¶</a></h3>


disable convection for locations with v > than this limit. In km/s.

{% highlight fortran %}
max_v_for_convection = 1d99
{% endhighlight %}


<h3 id="max_q_for_convection_with_hydro_on">max_q_for_convection_with_hydro_on <a href="#max_q_for_convection_with_hydro_on" title="Permalink to this location">¶</a></h3>


disable convection for locations with q > than this limit when
either v_flag or u_flag are true.

{% highlight fortran %}
max_q_for_convection_with_hydro_on = 1d99
{% endhighlight %}


<h3 id="max_v_div_cs_for_convection">max_v_div_cs_for_convection <a href="#max_v_div_cs_for_convection" title="Permalink to this location">¶</a></h3>


disable convection for locations with abs(v)/cs > this limit

{% highlight fortran %}
max_v_div_cs_for_convection = 1d99
{% endhighlight %}


<h3 id="max_abs_du_div_cs_for_convection">max_abs_du_div_cs_for_convection <a href="#max_abs_du_div_cs_for_convection" title="Permalink to this location">¶</a></h3>


main purpose is to force radiative in shock face

{% highlight fortran %}
max_abs_du_div_cs_for_convection = 0.03
{% endhighlight %}


<h3 id="min_T_for_acceleration_limited_conv_velocity">min_T_for_acceleration_limited_conv_velocity <a href="#min_T_for_acceleration_limited_conv_velocity" title="Permalink to this location">¶</a></h3>


Acceleration limiting based on Wood 1974 and Arnett 1969.
Wood, P.R., ApJ, 190:609-630, 1974. (Appendix V, eqns 1-3)
Arnett, W.D., 1969, Ap. and Space Sci, 5, 180.

{% highlight fortran %}
min_T_for_acceleration_limited_conv_velocity = 99e9
{% endhighlight %}


<h3 id="max_T_for_acceleration_limited_conv_velocity">max_T_for_acceleration_limited_conv_velocity <a href="#max_T_for_acceleration_limited_conv_velocity" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
max_T_for_acceleration_limited_conv_velocity = 99e9
{% endhighlight %}


<h3 id="mlt_accel_g_theta">mlt_accel_g_theta <a href="#mlt_accel_g_theta" title="Permalink to this location">¶</a></h3>


use this (if > 0) for limiting the acceleration of convection velocities.

{% highlight fortran %}
mlt_accel_g_theta = -1
{% endhighlight %}


<h3 id="prune_bad_cz_min_Hp_height">prune_bad_cz_min_Hp_height <a href="#prune_bad_cz_min_Hp_height" title="Permalink to this location">¶</a></h3>


Lower limit on radial extent of cz (<= 0 to disable).
Remove tiny convection zones unless have strong nuclear burning
i.e., remove if `size < prune_bad_cz_min_Hp_height` .and.
`max_log_eps < prune_bad_cz_min_log_eps_nuc`.

{% highlight fortran %}
prune_bad_cz_min_Hp_height = 0
{% endhighlight %}


<h3 id="prune_bad_cz_min_log_eps_nuc">prune_bad_cz_min_log_eps_nuc <a href="#prune_bad_cz_min_log_eps_nuc" title="Permalink to this location">¶</a></h3>


Lower limit on max log eps nuc in cz.
In units of average pressure scale height at top and bottom of region.
This allows emergence of very small cz at site of he core flash, for example.

{% highlight fortran %}
prune_bad_cz_min_log_eps_nuc = -99
{% endhighlight %}


<h3 id="redo_conv_for_dr_lt_mixing_length">redo_conv_for_dr_lt_mixing_length <a href="#redo_conv_for_dr_lt_mixing_length" title="Permalink to this location">¶</a></h3>


Check for small convection zones with total height less than mixing length
and redo with reduced `mixing_length_alpha` to make `mixing_length <= dr`.

{% highlight fortran %}
redo_conv_for_dr_lt_mixing_length = .false.
{% endhighlight %}


<h3 id="limit_mixing_length_by_dist_to_bdy">limit_mixing_length_by_dist_to_bdy <a href="#limit_mixing_length_by_dist_to_bdy" title="Permalink to this location">¶</a></h3>


reduce local value of mixing length alpha if necessary in order to make
mixing length <= distance to convective boundary times this value
only applies when value is > 0
setting this value = 1 implements the restriction that near a convective boundary,
the mixing length doesn't exceed the distance to the boundary.
Peter Eggleton, "Composition Changes during Stellar Evolution", MNRAS 156, 361-376, 1972.

WARNING: I've seen problems with 25M before He core burn when using this.  bp.

{% highlight fortran %}
limit_mixing_length_by_dist_to_bdy = 0
{% endhighlight %}


<h3 id="conv_bdy_mix_softening_f0">conv_bdy_mix_softening_f0 <a href="#conv_bdy_mix_softening_f0" title="Permalink to this location">¶</a></h3>


<h3 id="conv_bdy_mix_softening_f">conv_bdy_mix_softening_f <a href="#conv_bdy_mix_softening_f" title="Permalink to this location">¶</a></h3>


<h3 id="conv_bdy_mix_softening_min_D_mix">conv_bdy_mix_softening_min_D_mix <a href="#conv_bdy_mix_softening_min_D_mix" title="Permalink to this location">¶</a></h3>


These controls cause the convective mixing coefficient to drop off "softly"
near the boundary of the convective zone -- i.e, they prevent situations
where the mixing coefficient drops from 10^10 or more to zero in a distance
covered by only one or two cells as can happen at jumps in composition.
Such a sharp edge is no problem when it is not adjacent to a convective region.
But when it shows up at a convective boundary, it is problematic.
It may not be physical, and it is certainly bad news numerically.
This has been discussed as early as 1970's -- see for example,
Peter Eggleton, "Composition Changes during Stellar Evolution", MNRAS 156, 361-376, 1972.

The implementation of softening at convective boundaries is like overshooting
but the distances are typically smaller by an order of magnitude or more.
Also, the softening is primarily inside the convective region rather
than penetrating strongly into the area beyond.  This is done by
backing up from the boundary into the convection region to start the
softening of the mixing coefficient so that most of the effect
takes place before reaching the exterior of the region.  The softening
extends a short way into the exterior with a decreasing value of mixing.
For example, it might start a distance of `0.003*Hp` into the convective
region (Hp = pressure scale height at the boundary), and then project
a mixing coefficient outward from there decreasing exponentially
with distance scale of `0.001*Hp`.  For those numbers, there are
3 e-foldings before reaching the boundary, so most of the drop
has happened inside the convective region.  The strength of the mixing
then continues to drop exponentially until it reaches some given limit.

The effect of this will be to soften the jump in abundances immediately
adjacent to the convective region.  That will in turn soften the jump
in opacity and the corresponding jump in `grad_rad` so that there will
not be a large jump from a convective point with `grad_rad >> grad_ad`
to a neighboring non-convective point with `grad_rad << grad_ad`.

{% highlight fortran %}
conv_bdy_mix_softening_f0 = 0
conv_bdy_mix_softening_f = 0
conv_bdy_mix_softening_min_D_mix = 0
{% endhighlight %}


<h3 id="smooth_convective_bdy">smooth_convective_bdy <a href="#smooth_convective_bdy" title="Permalink to this location">¶</a></h3>


This is an option to smooth composition gradients
in newly non-convective regions trailing behind a retreating convection zone.
This effectively erases (most) of the stair-casing that happens without it.
But you should be aware that the smoothing process does not conserve species mass --
e.g., if have retreating He burning core below H shell,
then the smoothing will convert some H into He in the newly non-convective region
(this can be hand waved away as modeling partial burning of those regions
during the substep period before the convection had retreated past the location).

set this true to have the stair-casing removed at the price of some changes in abundances.

{% highlight fortran %}
smooth_convective_bdy = .true.
{% endhighlight %}


<h3 id="max_dR_div_Hp_for_smooth">max_dR_div_Hp_for_smooth <a href="#max_dR_div_Hp_for_smooth" title="Permalink to this location">¶</a></h3>


Don't smooth across a newly nonconvective region larger than this limit
where dR is radial thickness of region and Hp is min pressure scale height in region.

{% highlight fortran %}
max_dR_div_Hp_for_smooth = 10
{% endhighlight %}


<h3 id="max_delta_limit_for_smooth">max_delta_limit_for_smooth <a href="#max_delta_limit_for_smooth" title="Permalink to this location">¶</a></h3>


Don't smooth across a newly nonconvective region where any mass
fraction changes by more than this limit.

{% highlight fortran %}
max_delta_limit_for_smooth = 0.1d0
{% endhighlight %}


<h3 id="remove_mixing_glitches">remove_mixing_glitches <a href="#remove_mixing_glitches" title="Permalink to this location">¶</a></h3>


If true, then okay to remove gaps and singletons.

{% highlight fortran %}
remove_mixing_glitches = .true.
{% endhighlight %}


<h2 id="glitches">glitches <a href="#glitches" title="Permalink to this location">¶</a></h2>


The following controls are for different kinds of "glitches" that can be removed.

<h3 id="okay_to_remove_mixing_singleton">okay_to_remove_mixing_singleton <a href="#okay_to_remove_mixing_singleton" title="Permalink to this location">¶</a></h3>


If true, remove singetons.

{% highlight fortran %}
okay_to_remove_mixing_singleton = .true.
{% endhighlight %}


<h3 id="clip_D_limit">clip_D_limit <a href="#clip_D_limit" title="Permalink to this location">¶</a></h3>


Zero mixing diffusion coeffs that are smaller than this.

{% highlight fortran %}
clip_D_limit = 0
{% endhighlight %}


<h3 id="min_convective_gap">min_convective_gap <a href="#min_convective_gap" title="Permalink to this location">¶</a></h3>


Close gap between convective regions if smaller than this (< 0 means skip this).
Gap measured radially in units of pressure scale height.

{% highlight fortran %}
min_convective_gap = -1
{% endhighlight %}


<h3 id="min_thermohaline_gap">min_thermohaline_gap <a href="#min_thermohaline_gap" title="Permalink to this location">¶</a></h3>


Close gap between thermohaline mixing regions if smaller than this (< 0 means skip this).
Gap measured radially in units of pressure scale height.

{% highlight fortran %}
min_thermohaline_gap = -1
{% endhighlight %}


<h3 id="min_thermohaline_dropout">min_thermohaline_dropout <a href="#min_thermohaline_dropout" title="Permalink to this location">¶</a></h3>


<h3 id="max_dropout_gradL_sub_grada">max_dropout_gradL_sub_grada <a href="#max_dropout_gradL_sub_grada" title="Permalink to this location">¶</a></h3>


If find radiative region embedded in thermohaline,
and `max(gradL - grada)` in region is everywhere `< max_dropout_gradL_sub_grada`
and region height is `< min_thermohaline_dropout`
then convert the region to thermohaline.
`min_thermohaline_dropout <= 0` disables.

{% highlight fortran %}
min_thermohaline_dropout = -1
max_dropout_gradL_sub_grada = 1d-3
{% endhighlight %}


<h3 id="min_semiconvection_gap">min_semiconvection_gap <a href="#min_semiconvection_gap" title="Permalink to this location">¶</a></h3>


Close gap between semiconvective mixing regions if smaller than this (< 0 means skip this).
Gap measured radially in units of pressure scale height.

{% highlight fortran %}
min_semiconvection_gap = -1
{% endhighlight %}


<h3 id="remove_embedded_semiconvection">remove_embedded_semiconvection <a href="#remove_embedded_semiconvection" title="Permalink to this location">¶</a></h3>


If have a semiconvection region bounded on each side by convection,
convert it to be convective too.

{% highlight fortran %}
remove_embedded_semiconvection = .false.
{% endhighlight %}


<h3 id="recalc_mix_info_after_evolve">recalc_mix_info_after_evolve <a href="#recalc_mix_info_after_evolve" title="Permalink to this location">¶</a></h3>


Re-evaluate mixing info after each evolve step. This is helpful if you want the profiles to
reflect the mixing params after the step; otherwise, they give the mixing info from the start
of the step (i.e., one step out-of-date) 

{% highlight fortran %}
recalc_mix_info_after_evolve = .false.
{% endhighlight %}


<h3 id="set_min_D_mix">set_min_D_mix <a href="#set_min_D_mix" title="Permalink to this location">¶</a></h3>


<h3 id="mass_lower_limit_for_min_D_mix">mass_lower_limit_for_min_D_mix <a href="#mass_lower_limit_for_min_D_mix" title="Permalink to this location">¶</a></h3>


<h3 id="mass_upper_limit_for_min_D_mix">mass_upper_limit_for_min_D_mix <a href="#mass_upper_limit_for_min_D_mix" title="Permalink to this location">¶</a></h3>


<h3 id="min_D_mix">min_D_mix <a href="#min_D_mix" title="Permalink to this location">¶</a></h3>


`D_mix` will be at least this large if `set_min_D_mix` is true.
doesn't apply for mass < lower limit or mass > upper limit.

{% highlight fortran %}
set_min_D_mix = .false.
mass_lower_limit_for_min_D_mix = 0d0
mass_upper_limit_for_min_D_mix = 1d99
min_D_mix = 1d3
{% endhighlight %}


<h3 id="set_min_D_mix_in_H_He">set_min_D_mix_in_H_He <a href="#set_min_D_mix_in_H_He" title="Permalink to this location">¶</a></h3>


<h3 id="min_D_mix_in_H_He">min_D_mix_in_H_He <a href="#min_D_mix_in_H_He" title="Permalink to this location">¶</a></h3>


`D_mix` will be at least this large in regions
where max mass fractions of H and He add to more that 0.5
if `set_min_D_mix_in_H_He` is true.

{% highlight fortran %}
set_min_D_mix_in_H_He = .false.
min_D_mix_in_H_He = 1d3
{% endhighlight %}


<h3 id="set_min_D_mix_below_Tmax">set_min_D_mix_below_Tmax <a href="#set_min_D_mix_below_Tmax" title="Permalink to this location">¶</a></h3>


<h3 id="min_D_mix_below_Tmax">min_D_mix_below_Tmax <a href="#min_D_mix_below_Tmax" title="Permalink to this location">¶</a></h3>


`D_mix` will be at least this large for cells below location of max temperature
if `set_min_D_mix_below_Tmax` is true.

{% highlight fortran %}
set_min_D_mix_below_Tmax = .false.
min_D_mix_below_Tmax = 1d3
{% endhighlight %}


<h3 id="min_center_Ye_for_min_D_mix">min_center_Ye_for_min_D_mix <a href="#min_center_Ye_for_min_D_mix" title="Permalink to this location">¶</a></h3>


`min_D_mix` is only used when `center_ye >= this`
i.e., when `center_ye` drops below this, `min_D_mix = 0`.

{% highlight fortran %}
min_center_Ye_for_min_D_mix = 0.47d0
{% endhighlight %}


<h3 id="smooth_outer_xa_big">smooth_outer_xa_big <a href="#smooth_outer_xa_big" title="Permalink to this location">¶</a></h3>


<h3 id="smooth_outer_xa_small">smooth_outer_xa_small <a href="#smooth_outer_xa_small" title="Permalink to this location">¶</a></h3>


Soften composition jumps in outer layers.
If `smooth_outer_xa_big` and `smooth_outer_xa_small` are bigger than 0, then
starting from the outermost grid point, homogeneously mix a region of size
`smooth_outer_xa_small` (in solar masses), and proceed inwards, linearly reducing
the size of the homogeneously mixed region in such a way that it becomes zero.
After going `smooth_outer_xa_big` solar masses in. In this way, the outer `smooth_outer_xa_big`
solar masses are "cleaned" of composition jumps.

{% highlight fortran %}
smooth_outer_xa_big = -1d0
smooth_outer_xa_small = -1d0
{% endhighlight %}

<h1 id="rotation_controls">rotation controls <a href="#rotation_controls" title="Permalink to this location">¶</a></h1>


In the following "am" stands for "angular momentum".

the mesa implementation of rotation closely follows these papers:

+ Heger, Langer, & Woosley, ApJ, 528, 368.  2000
+ Heger, Woosley, & Spruit, ApJ, 626, 350.  2005

+ `D_DSI` = dynamical shear instability
+ `D_SH` = Solberg-Hoiland
+ `D_SSI` = secular shear instability
+ `D_ES` = Eddington-Sweet circulation
+ `D_GSF` = Goldreich-Schubert-Fricke
+ `D_ST` = Spruit-Tayler dynamo

<h3 id="skip_rotation_in_convection_zones">skip_rotation_in_convection_zones <a href="#skip_rotation_in_convection_zones" title="Permalink to this location">¶</a></h3>


if true, then set rotational diffusion coefficients to 0 in convective regions.
This applies both for material mixing and diffusion of angular momentum.

{% highlight fortran %}
skip_rotation_in_convection_zones = .false.
{% endhighlight %}


<h3 id="am_D_mix_factor">am_D_mix_factor <a href="#am_D_mix_factor" title="Permalink to this location">¶</a></h3>


Rotation and mixing of material.
`D_mix` = diffusion coefficient for mixing of material.
It is sum of non-rotational and rotational components.
The rotational part is multiplied by this factor.

    D_mix = D_mix_non_rotation + f*am_D_mix_factor*(
        D_DSI_factor * D_DSI +
        D_SH_factor  * D_SH +
        D_SSI_factor * D_SSI +
        D_ES_factor  * D_ES +
        D_GSF_factor * D_GSF +
        D_ST_factor  * D_ST)

    f = 1  when logT <= D_mix_rotation_max_logT_full_on = full_on
      = 0  when logT >= D_mix_rotation_max_logT_full_on = full_off
      = (log(T)-full_on)/(full_off-full_on) else

note that for regions with brunt N^2 < 0, we set Richardson number to 1
which is > Ri_critical and therefore turns off DSI and SSI

according to Heger et al 2000 : 1/30d0
by default : 0

{% highlight fortran %}
am_D_mix_factor = 0
{% endhighlight %}


<h3 id="am_nu_factor">am_nu_factor <a href="#am_nu_factor" title="Permalink to this location">¶</a></h3>


<h3 id="am_nu_non_rotation_factor">am_nu_non_rotation_factor <a href="#am_nu_non_rotation_factor" title="Permalink to this location">¶</a></h3>


diffusion of angular momentum

`am_nu` = diffusion coefficient for angular momentum

    am_nu_non_rot = am_nu_factor*am_nu_non_rotation_factor*D_mix_non_rotation
    am_nu_rot = am_nu_factor*(
        am_nu_visc_factor* D_visc +
        am_nu_DSI_factor * D_DSI +
        am_nu_SH_factor  * D_SH +
        am_nu_SSI_factor * D_SSI +
        am_nu_ES_factor  * D_ES +
        am_nu_GSF_factor * D_GSF +
        am_nu_ST_factor  * nu_ST)
    am_nu = am_nu_non_rot + am_nu_rot

Note that for regions with brunt N^2 < 0, we set Richardson number to 1
which is > Ri_critical and therefore turns off DSI and SSI.

see also `star_job` controls for `am_nu_rot_flag`

{% highlight fortran %}
am_nu_factor = 1
am_nu_non_rotation_factor = 1
{% endhighlight %}


<h3 id="am_nu_DSI_factor">am_nu_DSI_factor <a href="#am_nu_DSI_factor" title="Permalink to this location">¶</a></h3>


< 0 means use `D_DSI_factor`

{% highlight fortran %}
am_nu_DSI_factor = -1
{% endhighlight %}


<h3 id="am_nu_SSI_factor">am_nu_SSI_factor <a href="#am_nu_SSI_factor" title="Permalink to this location">¶</a></h3>


< 0 means use `D_SSI_factor`

{% highlight fortran %}
am_nu_SSI_factor = -1
{% endhighlight %}


<h3 id="am_nu_SH_factor">am_nu_SH_factor <a href="#am_nu_SH_factor" title="Permalink to this location">¶</a></h3>


< 0 means use `D_SH_factor`

{% highlight fortran %}
am_nu_SH_factor = -1
{% endhighlight %}


<h3 id="am_nu_ES_factor">am_nu_ES_factor <a href="#am_nu_ES_factor" title="Permalink to this location">¶</a></h3>


< 0 means use `D_ES_factor`

{% highlight fortran %}
am_nu_ES_factor = -1
{% endhighlight %}


<h3 id="am_nu_GSF_factor">am_nu_GSF_factor <a href="#am_nu_GSF_factor" title="Permalink to this location">¶</a></h3>


< 0 means use `D_GSF_factor`

{% highlight fortran %}
am_nu_GSF_factor = -1
{% endhighlight %}


<h3 id="am_nu_ST_factor">am_nu_ST_factor <a href="#am_nu_ST_factor" title="Permalink to this location">¶</a></h3>


< 0 means use `D_ST_factor`

{% highlight fortran %}
am_nu_ST_factor = -1
{% endhighlight %}


<h3 id="am_nu_visc_factor">am_nu_visc_factor <a href="#am_nu_visc_factor" title="Permalink to this location">¶</a></h3>


< 0 means use `D_visc_factor`.
By default = 1 to mix angular momentum.

{% highlight fortran %}
am_nu_visc_factor = 1
{% endhighlight %}


<h3 id="am_nu_omega_rot_factor">am_nu_omega_rot_factor <a href="#am_nu_omega_rot_factor" title="Permalink to this location">¶</a></h3>


<h3 id="am_nu_omega_non_rot_factor">am_nu_omega_non_rot_factor <a href="#am_nu_omega_non_rot_factor" title="Permalink to this location">¶</a></h3>


    dj/dt = d/dm((4 pi r^2 rho)^2*(am_nu_omega*i_rot*domega/dm + am_nu_j*dj/dm))
    am_nu_omega = am_nu_omega_non_rot_factor*am_nu_non_rot + am_nu_omega_rot_factor*am_nu_rot

{% highlight fortran %}
am_nu_omega_rot_factor = 1
am_nu_omega_non_rot_factor = 1
{% endhighlight %}


<h3 id="am_nu_j_rot_factor">am_nu_j_rot_factor <a href="#am_nu_j_rot_factor" title="Permalink to this location">¶</a></h3>


<h3 id="am_nu_j_non_rot_factor">am_nu_j_non_rot_factor <a href="#am_nu_j_non_rot_factor" title="Permalink to this location">¶</a></h3>


    dj/dt = d/dm((4 pi r^2 rho)^2*(am_nu_omega*i_rot*domega/dm + am_nu_j*dj/dm))
    am_nu_j = am_nu_j_non_rot_factor*am_nu_non_rot + am_nu_j_rot_factor*am_nu_rot

{% highlight fortran %}
am_nu_j_rot_factor = 0
am_nu_j_non_rot_factor = 0
{% endhighlight %}


<h3 id="set_uniform_am_nu_non_rot">set_uniform_am_nu_non_rot <a href="#set_uniform_am_nu_non_rot" title="Permalink to this location">¶</a></h3>


<h3 id="uniform_am_nu_non_rot">uniform_am_nu_non_rot <a href="#uniform_am_nu_non_rot" title="Permalink to this location">¶</a></h3>


You can specify a uniform value for `am_nu_non_rot` by setting this flag true.
A large uniform `am_nu` will produce a uniform omega.

{% highlight fortran %}
set_uniform_am_nu_non_rot = .false.
uniform_am_nu_non_rot = 1d20
{% endhighlight %}


<h3 id="set_min_am_nu_non_rot">set_min_am_nu_non_rot <a href="#set_min_am_nu_non_rot" title="Permalink to this location">¶</a></h3>


<h3 id="min_am_nu_non_rot">min_am_nu_non_rot <a href="#min_am_nu_non_rot" title="Permalink to this location">¶</a></h3>


You can also specify a minimum `am_nu_non_rot`.
`am_nu` will be at least this large.

{% highlight fortran %}
set_min_am_nu_non_rot = .false.
min_am_nu_non_rot = 1d8
{% endhighlight %}


<h3 id="min_center_Ye_for_min_am_nu_non_rot">min_center_Ye_for_min_am_nu_non_rot <a href="#min_center_Ye_for_min_am_nu_non_rot" title="Permalink to this location">¶</a></h3>


`min_am_nu_non_rot` is only used when center Ye >= this.

{% highlight fortran %}
min_center_Ye_for_min_am_nu_non_rot = 0.47d0
{% endhighlight %}


Each rotationally induced diffusion coefficient has a factor that lets you control it.
Value of 1 gives normal strength; value of 0 turns it off.

Note that for regions with brunt N^2 < 0, we set Richardson number to 1,
which is > Ri_critical and therefore turns off DSI and SSI.

{% highlight fortran %}
D_DSI_factor = 0
D_SH_factor = 0
D_SSI_factor = 0
D_ES_factor = 0
D_GSF_factor = 0
D_ST_factor = 0
{% endhighlight %}


<h3 id="D_visc_factor">D_visc_factor <a href="#D_visc_factor" title="Permalink to this location">¶</a></h3>


Kinematic shear viscosity.
Should be = 0 because viscosity doesn't mix chemical elements.

{% highlight fortran %}
D_visc_factor = 0
{% endhighlight %}


<h3 id="am_gradmu_factor">am_gradmu_factor <a href="#am_gradmu_factor" title="Permalink to this location">¶</a></h3>


Sensitivity to composition gradients.
In calculation of rotational induced mixing, `grad_mu` is multiplied by `am_gradmu_factor`.
Value from from Heger et al 2000.

{% highlight fortran %}
am_gradmu_factor = 0.05d0
{% endhighlight %}


Spatial smoothing is used in calculations of diffusion coefficients.
These control the smoothing window widths (number of cells on each side).

{% highlight fortran %}
smooth_D_DSI = 0
smooth_D_SH = 0
smooth_D_SSI = 0
smooth_D_ES = 0
smooth_D_GSF = 0
smooth_D_ST = 0
smooth_nu_ST = 0
{% endhighlight %}


time smoothing.
Set to 0 to turn off time smoothing.

{% highlight fortran %}
angsmt_D_DSI = 0.0d0
angsmt_D_SH = 0.0d0
angsmt_D_SSI = 0.0d0
angsmt_D_ES = 0.0d0
angsmt_D_GSF = 0.0d0
angsmt_D_ST = 0.2d0
angsmt_nu_ST = 0.2d0
angsml = 1d-3
{% endhighlight %}


<h3 id="am_time_average">am_time_average <a href="#am_time_average" title="Permalink to this location">¶</a></h3>


If true, then `D = (D_new + D_old)/2`,
where `D_old` is D from previous step
and `D_new` is D as calculated for current as if no time smoothing.

{% highlight fortran %}
am_time_average = .false.
{% endhighlight %}


<h3 id="simple_i_rot_flag">simple_i_rot_flag <a href="#simple_i_rot_flag" title="Permalink to this location">¶</a></h3>


If true, `i_rot = (2/3)*r^2`.
If false, use slightly more complex expression
that takes into account finite shell thickness.
In practice, there doesn't seem to be a significant difference.
This is ignored if fitted_fp_ft_i_rot is equal to true, in which
case rotation dependent moments of inertia are computed.
TODO: better explain

{% highlight fortran %}
simple_i_rot_flag = .true.
{% endhighlight %}


<h3 id="do_adjust_J_lost">do_adjust_J_lost <a href="#do_adjust_J_lost" title="Permalink to this location">¶</a></h3>


<h3 id="adjust_J_fraction">adjust_J_fraction <a href="#adjust_J_fraction" title="Permalink to this location">¶</a></h3>


adjust angular momentum
With do_adjust_J_lost = .false., the angular momentum removed via winds
from the star corresponds to that contained in the removed layers.
However, since j_rot can increase steeply in the very outer layers,
very small steps are required to obtain a convergent solution. To avoid
this, the do_adjust_J_lost option adjusts the angular momentum content
of layers below those removed, such that

    actual_J_lost = &
       adjust_J_fraction*mass_lost*s% j_rot_surf + &
       (1d0 - adjust_J_fraction)*s% angular_momentum_removed

where s% angular_momentum_removed is the angular momentum contained
in the removed layers of the star in that step. Note that
s% angular_momentum_removed is set to actual_J_lost after this.

The region from which angular momentum is removed is chosen such that
at its bottom q<min_q_for_adjust_J_lost, it contains at least
min_J_div_delta_J times the angular momentum that needs to be accounted
for. Angular momentum in these regions is adjusted in such a way that
no artificial shear is produced at the inner boundary.

This can also be used to model mass loss mechanisms that remove more
angular momentum than mass_lost*s% j_rot_surf, for instance magnetic
braking or wind mass loss. In that case, you can use the
use_other_j_for_adjust_J_lost option to specify a specific angular momentum
of removed material different from j_rot_surf

{% highlight fortran %}
do_adjust_J_lost = .true.
adjust_J_fraction = 1d0
min_q_for_adjust_J_lost = 0.99d0
min_J_div_delta_J = 3d0
{% endhighlight %}


<h3 id="premix_omega">premix_omega <a href="#premix_omega" title="Permalink to this location">¶</a></h3>


if premix_omega is true, then do 1/2 of the transport of angular momentum
before updating the structure and 1/2 after.
otherwise, do all of the transport after updating the structure.
RECOMMENDED to turn it on when modelling an accreting star or when
using do_adjust_J_lost.

{% highlight fortran %}
premix_omega = .true.
{% endhighlight %}


<h3 id="recalc_mixing_info_each_substep">recalc_mixing_info_each_substep <a href="#recalc_mixing_info_each_substep" title="Permalink to this location">¶</a></h3>


if `recalc_mixing_info_each_substep` is true, then recalculate the omega mixing coefficients after each substep of the solve omega mix process.

{% highlight fortran %}
recalc_mixing_info_each_substep = .false.
{% endhighlight %}


<h3 id="fitted_fp_ft_i_rot">fitted_fp_ft_i_rot <a href="#fitted_fp_ft_i_rot" title="Permalink to this location">¶</a></h3>


Use analytical fits to the rotational corrections fp and ft, as well as the moments of inertia,
computed using the Roche potential for a point mass.

{% highlight fortran %}
fitted_fp_ft_i_rot = .true.
{% endhighlight %}


<h3 id="w_div_wcrit_max">w_div_wcrit_max <a href="#w_div_wcrit_max" title="Permalink to this location">¶</a></h3>


When fitted_fp_ft_i_rot = .true., limit fp and ft to their values at this
w_div_wcrit
TODO: better explain

{% highlight fortran %}
w_div_wcrit_max = 0.9
{% endhighlight %}


<h3 id="FP_min">FP_min <a href="#FP_min" title="Permalink to this location">¶</a></h3>


<h3 id="FT_min">FT_min <a href="#FT_min" title="Permalink to this location">¶</a></h3>


Lower limits for rotational distortion corrections factors FP and FT.
Used for the calculation when fitted_fp_ft_i_rot = .false., otherwise the
limits are set using w_div_wcrit_min_for_fp_ft_i_rot

{% highlight fortran %}
FP_min = 0.75d0
FT_min = 0.95d0
{% endhighlight %}


<h3 id="FP_error_limit">FP_error_limit <a href="#FP_error_limit" title="Permalink to this location">¶</a></h3>


If calculate an fp < this, treat it as an error.
Used for the calculation when fitted_fp_ft_i_rot = .false.

{% highlight fortran %}
FP_error_limit = 0d0
{% endhighlight %}


<h3 id="FT_error_limit">FT_error_limit <a href="#FT_error_limit" title="Permalink to this location">¶</a></h3>


If calculate an ft < this, treat it as an error.
Used for the calculation when fitted_fp_ft_i_rot = .false.

{% highlight fortran %}
FT_error_limit = 0d0
{% endhighlight %}


<h3 id="D_mix_rotation_max_logT_full_on">D_mix_rotation_max_logT_full_on <a href="#D_mix_rotation_max_logT_full_on" title="Permalink to this location">¶</a></h3>


Use rotational components of `D_mix` for locations where logT <= this.
For numerical stability, turn off rotational part of `D_mix` at very high T.

{% highlight fortran %}
D_mix_rotation_max_logT_full_on = 9.4d0
{% endhighlight %}


<h3 id="D_mix_rotation_min_logT_full_off">D_mix_rotation_min_logT_full_off <a href="#D_mix_rotation_min_logT_full_off" title="Permalink to this location">¶</a></h3>


Drop rotational components of `D_mix` for locations where logT >= this.
For numerical stability, turn off rotational part of `D_mix` at very high T.

{% highlight fortran %}
D_mix_rotation_min_logT_full_off = 9.5d0
{% endhighlight %}


<h3 id="D_omega_max_replacement_fraction">D_omega_max_replacement_fraction <a href="#D_omega_max_replacement_fraction" title="Permalink to this location">¶</a></h3>


<h3 id="D_omega_growth_rate">D_omega_growth_rate <a href="#D_omega_growth_rate" title="Permalink to this location">¶</a></h3>


<h3 id="D_omega_mixing_rate">D_omega_mixing_rate <a href="#D_omega_mixing_rate" title="Permalink to this location">¶</a></h3>


<h3 id="D_omega_mixing_across_convection_boundary_previously_called_D_omega_mixing_in_convection_regions">D_omega_mixing_across_convection_boundary (previously called D_omega_mixing_in_convection_regions) <a href="#D_omega_mixing_across_convection_boundary_previously_called_D_omega_mixing_in_convection_regions" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
D_omega_max_replacement_fraction = 0.5d0
D_omega_growth_rate = 1d0
D_omega_mixing_rate = 1d0
D_omega_mixing_across_convection_boundary = .false.
max_q_for_D_omega_zero_in_convection_region = 0.8d0
{% endhighlight %}


<h3 id="nu_omega_max_replacement_fraction">nu_omega_max_replacement_fraction <a href="#nu_omega_max_replacement_fraction" title="Permalink to this location">¶</a></h3>


<h3 id="nu_omega_growth_rate">nu_omega_growth_rate <a href="#nu_omega_growth_rate" title="Permalink to this location">¶</a></h3>


<h3 id="nu_omega_mixing_rate">nu_omega_mixing_rate <a href="#nu_omega_mixing_rate" title="Permalink to this location">¶</a></h3>


<h3 id="nu_omega_mixing_across_convection_boundary">nu_omega_mixing_across_convection_boundary <a href="#nu_omega_mixing_across_convection_boundary" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
nu_omega_max_replacement_fraction = 0.5d0
nu_omega_growth_rate = 1d0
nu_omega_mixing_rate = 1d0
nu_omega_mixing_across_convection_boundary = .false.
max_q_for_nu_omega_zero_in_convection_region = 0.8d0
{% endhighlight %}

<h1 id="atmosphere_boundary_conditions">atmosphere boundary conditions <a href="#atmosphere_boundary_conditions" title="Permalink to this location">¶</a></h1>


<h3 id="which_atm_option">which_atm_option <a href="#which_atm_option" title="Permalink to this location">¶</a></h3>


+ `'simple_photosphere'` :
don't integrate, just estimate for tau=2/3
+ `'Eddington_grey'` :
Eddington T-tau integration
+ `'Krishna_Swamy'` :
Krishna Swamy T-tau integration
K.S. Krishna-Swamy, ApJ 145, 174–194 (1966)
+ `'solar_Hopf_grey'` :
another T(tau), this one tuned to solar data. see Paper II, Sec. A.5
+ `'tau_100_tables', `tau_10_tables`, `tau_1_tables`, `tau_1m1_tables` :
use model atmosphere tables for Pgas and T at tau=100, 10, 1
or 0.1, respectively; solar Z only, as described in MESA Paper
I (Paxton et al. 2011), Sec. 5.3.
these tables are primarily for the evolution of low-mass
stars, brown dwarfs, and giant planets.  they are constructed
from Castelli & Kurucz (2003) for Teff > 3000 K and the COND
model atmospheres (Allard et al. 2001) for Teff < 3000 K.
where no published results are available, the table has been
filled in using integration of the Eddington T(tau) relation
+ `'photosphere_tables'` :
use model atmosphere tables for photosphere; range of Z's,
as described in MESA Paper I (Paxton et al. 2011), Sec. 5.3.
the tables cover log(Z/Zsun) from -4 to 0.5 for a GN93
solar mixture, and span logg = -0.5 to 5.5 in steps of
0.5 dex and Teff = 2000 to 50 000 K in steps of 250 K.
they are constructed, in order of precedence, using the
PHOENIX model atmospheres (Hauschildt et al. 1999a,b)
and the models by Castelli & Kurucz (2003).  where
neither is available, an entry is generated by
integrating the Eddington T(tau) relation
+ `'grey_and_kap'` :
iterate simple grey to find consistent P, T, and kap at surface
+ `'grey_irradiated'` :
based on Guillot, T, and Havel, M., A&A 527, A20 (2011).
+ `'Paczynski_grey'` :
create an atmosphere for given base conditions.
inspired by B. Paczynski, 1969, Acta Astr., vol. 19, 1.
takes into account dilution when tau < 2/3,
and calls mlt to get gradT allowing for convection in atmosphere.
+ `'WD_tau_25_tables'` :
hydrogen atmosphere tables for cool white dwarfs
giving Pgas and T at log10(tau) = 1.4 (tau = 25.11886)
Teff goes from 40,000 K down to 2,000K with step of 100 K
Log10(g) goes from 9.5 down to 5.5 with step of 0.1.
R.D. Rohrmann, L.G. Althaus, and S.O. Kepler,
Lyman α wing absorption in cool white dwarf stars,
Mon. Not. R. Astron. Soc. 411, 781–791 (2011)
+ `'fixed_Teff'` :
set Tsurf from Eddington T-tau relation
    for current surface tau and Teff = `atm_fixed_Teff`.
set Psurf = Radiation_Pressure(Tsurf)
+ `'fixed_Tsurf'` :
get value of Tsurf from control parameter `atm_fixed_Tsurf`.
set Teff from Eddington T-tau relation for given Tsurf and tau=2/3
set Psurf = Radiation_Pressure(Tsurf)
+ `'fixed_Psurf'` :
get value of Psurf from control parameter `atm_fixed_Psurf`.
set Tsurf from L and R using `L = 4*pi*R^2*boltz_sigma*T^4`.
set Teff using Eddington T-tau relation for tau=2/3 and T=Tsurf.
+ `'fixed_Psurf_and_Tsurf'` :
get value of Psurf from control parameter `atm_fixed_Psurf`.
get value of Tsurf from control parameter `atm_fixed_Tsurf`.

{% highlight fortran %}
which_atm_option = 'simple_photosphere'
{% endhighlight %}


<h3 id="which_atm_off_table_option">which_atm_off_table_option <a href="#which_atm_off_table_option" title="Permalink to this location">¶</a></h3>


If have selected an atm table as your option,
fallback to using this if the args are off the table.
`'simple_photosphere'` or `'grey_and_kap'`.

{% highlight fortran %}
which_atm_off_table_option = 'simple_photosphere'
{% endhighlight %}


<h3 id="atm_fixed_Teff">atm_fixed_Teff <a href="#atm_fixed_Teff" title="Permalink to this location">¶</a></h3>


Set this when using `atm_option = 'fixed_Teff'`

{% highlight fortran %}
atm_fixed_Teff = 0
{% endhighlight %}


<h3 id="atm_fixed_Tsurf">atm_fixed_Tsurf <a href="#atm_fixed_Tsurf" title="Permalink to this location">¶</a></h3>


Set this when using `atm_option = 'fixed_Tsurf'`

{% highlight fortran %}
atm_fixed_Tsurf = 0
{% endhighlight %}


<h3 id="atm_fixed_Psurf">atm_fixed_Psurf <a href="#atm_fixed_Psurf" title="Permalink to this location">¶</a></h3>


Set this when using `which_atm_option = 'fixed_Psurf'`

{% highlight fortran %}
atm_fixed_Psurf = -1
{% endhighlight %}


<h3 id="atm_switch_to_grey_as_backup">atm_switch_to_grey_as_backup <a href="#atm_switch_to_grey_as_backup" title="Permalink to this location">¶</a></h3>


If you select a table option, but the args are out of the range of the tables,
then this flag determines whether you get an error or the code automatically
switches to option = `atm_simple_photosphere` as a backup.

{% highlight fortran %}
atm_switch_to_grey_as_backup = .true.
{% endhighlight %}


<h3 id="Pextra_factor">Pextra_factor <a href="#Pextra_factor" title="Permalink to this location">¶</a></h3>


Parameter for extra pressure in surface boundary conditions.
Pressure at optical depth tau is calculated as `P = tau*g/kap*(1 + Pextra)`
Pextra takes into account nonzero radiation pressure at tau=0.
The equation for Pextra includes `Pextra_factor`

    Pextra = Pextra_factor*(kap/tau)*(L/M)/(6d0*pi*clight*cgrav)

For certain situations such super eddington L,
you may need to increase Pextra to help convergence.
e.g. try `Pextra_factor = 2`
`Pextra_factor < 0` means use (incorrect) old form `1.6d-4*kap*(L/Lsun)/(M/Msun)`.

{% highlight fortran %}
Pextra_factor = 1
{% endhighlight %}


<h3 id="atm_grey_and_kap_atol">atm_grey_and_kap_atol <a href="#atm_grey_and_kap_atol" title="Permalink to this location">¶</a></h3>


<h3 id="atm_grey_and_kap_rtol">atm_grey_and_kap_rtol <a href="#atm_grey_and_kap_rtol" title="Permalink to this location">¶</a></h3>


Relative and absolute tolerance parameters for the `grey_and_kap` option.
Iterates on kap until `err = |delta kap|/(atol + rtol*kap) < 1`.

{% highlight fortran %}
atm_grey_and_kap_atol = 1d-7
atm_grey_and_kap_rtol = 1d-7
{% endhighlight %}


<h3 id="atm_grey_and_kap_max_tries">atm_grey_and_kap_max_tries <a href="#atm_grey_and_kap_max_tries" title="Permalink to this location">¶</a></h3>


<h3 id="trace_atm_grey_and_kap">trace_atm_grey_and_kap <a href="#trace_atm_grey_and_kap" title="Permalink to this location">¶</a></h3>


Limit on iterations and trace.

{% highlight fortran %}
atm_grey_and_kap_max_tries = 50
trace_atm_grey_and_kap = .false.
{% endhighlight %}


`atm_grey_irradiated_atol` and `atm_grey_irradiated_rtol`.
Parameters for the `grey_irradiated` option.
Absolute and relative error tolerances.

{% highlight fortran %}
atm_grey_irradiated_atol = 1d-4
atm_grey_irradiated_rtol = 1d-4
{% endhighlight %}


<h3 id="atm_grey_irradiated_T_eq">atm_grey_irradiated_T_eq <a href="#atm_grey_irradiated_T_eq" title="Permalink to this location">¶</a></h3>


Equilibrium temperature based on irradiation.

    irrad_flux = Lstar/(4*pi*orbit**2)

+ Area of planet in plane perpendicular to `irrad_flux = pi*Rplanet**2`.
+ Stellar luminosity received by `planet = irrad_flux*area`.
+ This luminosity determines `T_eq`:  `T_eq**4 = irrad_flux/(4*sigma)`.

{% highlight fortran %}
atm_grey_irradiated_T_eq = 1000
{% endhighlight %}


<h3 id="atm_grey_irradiated_kap_v">atm_grey_irradiated_kap_v <a href="#atm_grey_irradiated_kap_v" title="Permalink to this location">¶</a></h3>


<h3 id="atm_grey_irradiated_simple_kap_th">atm_grey_irradiated_simple_kap_th <a href="#atm_grey_irradiated_simple_kap_th" title="Permalink to this location">¶</a></h3>


Opacity for irradiation.
The T(tau) relation for this option depends on the ratio `kap_v/kap_th`
where `kap_v` is the planet atmosphere opacity for stellar irradiation,
and `kap_th` is the thermal opacity for internally produced radiation.
You can either specify the ratio of `kap_v/kap_th`,
or you can specify `kap_v` and have the code calc `kap_th` to get the ratio.

{% highlight fortran %}
atm_grey_irradiated_kap_v = 4d-3
atm_grey_irradiated_simple_kap_th = .false.
{% endhighlight %}


<h3 id="atm_grey_irr_kap_v_div_kap_th">atm_grey_irr_kap_v_div_kap_th <a href="#atm_grey_irr_kap_v_div_kap_th" title="Permalink to this location">¶</a></h3>


If `atm_grey_irradiated_simple_kap_th` is true, then just set `kap_th = kap_v/kap_v_div_kap_th`.
Only used if > 0.

{% highlight fortran %}
atm_grey_irr_kap_v_div_kap_th = 0
{% endhighlight %}


<h3 id="atm_grey_irradiated_P_surf">atm_grey_irradiated_P_surf <a href="#atm_grey_irradiated_P_surf" title="Permalink to this location">¶</a></h3>


Surface pressure ; set to 1 bar in cgs units.

{% highlight fortran %}
atm_grey_irradiated_P_surf = 1d6
{% endhighlight %}


<h3 id="atm_grey_irradiated_max_tries">atm_grey_irradiated_max_tries <a href="#atm_grey_irradiated_max_tries" title="Permalink to this location">¶</a></h3>


Limit on iterations.

{% highlight fortran %}
atm_grey_irradiated_max_tries = 50
{% endhighlight %}


<h3 id="trace_atm_grey_irradiated">trace_atm_grey_irradiated <a href="#trace_atm_grey_irradiated" title="Permalink to this location">¶</a></h3>


Trace the grey atmosphere.

{% highlight fortran %}
trace_atm_grey_irradiated = .false.
{% endhighlight %}


<h3 id="atm_int_errtol">atm_int_errtol <a href="#atm_int_errtol" title="Permalink to this location">¶</a></h3>


<h3 id="dump_int_atm_info_model_number">dump_int_atm_info_model_number <a href="#dump_int_atm_info_model_number" title="Permalink to this location">¶</a></h3>


Parameters for integrate T(tau) and
write atm structure at model number to terminal.

{% highlight fortran %}
atm_int_errtol = 1d-7
dump_int_atm_info_model_number = -1111
{% endhighlight %}


Parameters for `Paczynski_grey`.
`create_atm_max_step_size` in units of `log10_tau`.

{% highlight fortran %}
trace_atm_Paczynski_grey = .false.
Paczynski_atm_R_surf_errtol = 3d-4
create_atm_max_step_size = 0.1d0
{% endhighlight %}


<h3 id="surface_extra_Pgas">surface_extra_Pgas <a href="#surface_extra_Pgas" title="Permalink to this location">¶</a></h3>


Extra gas pressure at surface. Added to surface pressure from atm.
In ergs/cm^3.

{% highlight fortran %}
surface_extra_Pgas = 0d0
{% endhighlight %}


<h3 id="use_atm_PT_at_center_of_surface_cell">use_atm_PT_at_center_of_surface_cell <a href="#use_atm_PT_at_center_of_surface_cell" title="Permalink to this location">¶</a></h3>


The surface boundary conditions for pressure and temperature,
compare the model values at the center of the surface cell to
values derived from the P and T returned by the atm module.
If this flag is true, then the atm values are directly used.
If false, then the values from the atm are treated as being
for the outer boundary of the surface cell, and those values
are used to estimate corresponding values for the cell center
for comparison to the model values at the cell center.

Most cases will have this flag false.
An example that sets this flag true is a case in which are
using a special boundary condition (BC) routine to force
a certain entropy for the surface cell.  In that situation,
it is better to have the special BC directly return P and T
for the center of cell 1 to produce the desired entropy.

{% highlight fortran %}
use_atm_PT_at_center_of_surface_cell = .false.
{% endhighlight %}


<h3 id="use_compression_outer_BC">use_compression_outer_BC <a href="#use_compression_outer_BC" title="Permalink to this location">¶</a></h3>


gradient of compression vanishes at surface

    see Grott, Chernigovski, Glatzel, 2005.
    d_dm(d_dm(r^2*v)) = 0 at surface
    by continuity, this is d_dm(d_dt(1/rho)) = 0 at surface
    finite volume form is
    (1/rho(1) - 1/rho_start(1)) = (1/rho(2) - 1/rho_start(2))
    this BC determines the density for surface cell.

{% highlight fortran %}
use_compression_outer_BC = .false.
{% endhighlight %}


<h3 id="use_momentum_outer_BC">use_momentum_outer_BC <a href="#use_momentum_outer_BC" title="Permalink to this location">¶</a></h3>


use `P_surf` from atm to set pressure gradient at surface in momentum equation
calculate v(1) based on pressure difference `P_surf - P(1)`

{% highlight fortran %}
use_momentum_outer_BC = .false.
{% endhighlight %}


<h3 id="use_zero_Pgas_outer_BC">use_zero_Pgas_outer_BC <a href="#use_zero_Pgas_outer_BC" title="Permalink to this location">¶</a></h3>


use `Psurf = Radiation_Pressure(T_start(1))`

{% highlight fortran %}
use_zero_Pgas_outer_BC = .false.
{% endhighlight %}


<h3 id="use_zero_dLdm_outer_BC">use_zero_dLdm_outer_BC <a href="#use_zero_dLdm_outer_BC" title="Permalink to this location">¶</a></h3>


use L(1) = L(2) for T outer BC

{% highlight fortran %}
use_zero_dLdm_outer_BC = .false.
{% endhighlight %}


<h3 id="use_T_Paczynski_outer_BC">use_T_Paczynski_outer_BC <a href="#use_T_Paczynski_outer_BC" title="Permalink to this location">¶</a></h3>


`T_surf^4` is set to `L/(8*pi*boltz_sig*R^2)`

{% highlight fortran %}
use_T_Paczynski_outer_BC = .false.
{% endhighlight %}


<h3 id="use_T_black_body_outer_BC">use_T_black_body_outer_BC <a href="#use_T_black_body_outer_BC" title="Permalink to this location">¶</a></h3>


`T_surf` is set to `Tsurf_factor*T_black_body(L_surf,R_surf)`

{% highlight fortran %}
use_T_black_body_outer_BC = .false.
{% endhighlight %}


<h3 id="use_fixed_vsurf_outer_BC">use_fixed_vsurf_outer_BC <a href="#use_fixed_vsurf_outer_BC" title="Permalink to this location">¶</a></h3>


<h3 id="fixed_vsurf">fixed_vsurf <a href="#fixed_vsurf" title="Permalink to this location">¶</a></h3>


v at outer boundary of model is set to be fixed_vsurf

{% highlight fortran %}
use_fixed_vsurf_outer_BC = .false.
fixed_vsurf = 0
{% endhighlight %}


<h3 id="use_fixed_L_for_BB_outer_BC">use_fixed_L_for_BB_outer_BC <a href="#use_fixed_L_for_BB_outer_BC" title="Permalink to this location">¶</a></h3>


<h3 id="fixed_L_for_BB_outer_BC">fixed_L_for_BB_outer_BC <a href="#fixed_L_for_BB_outer_BC" title="Permalink to this location">¶</a></h3>


for `use_T_black_body_outer_BC` and `use_T_Paczynski_outer_BC`

{% highlight fortran %}
use_fixed_L_for_BB_outer_BC = .false.
fixed_L_for_BB_outer_BC = 0
{% endhighlight %}


<h3 id="tau_for_L_BB">tau_for_L_BB <a href="#tau_for_L_BB" title="Permalink to this location">¶</a></h3>


determines location where get L for use with BB outer BCs
use the L at outermost location where tau >= tau_for_L_BB

{% highlight fortran %}
tau_for_L_BB = -1
{% endhighlight %}


<h3 id="Tsurf_factor">Tsurf_factor <a href="#Tsurf_factor" title="Permalink to this location">¶</a></h3>


used when `use_momentum_outer_BC`
`T_surf` is set to `Tsurf_factor*T_black_body(L_surf,R_surf)`

{% highlight fortran %}
Tsurf_factor = 1
{% endhighlight %}


<h3 id="irradiation_flux">irradiation_flux <a href="#irradiation_flux" title="Permalink to this location">¶</a></h3>


<h3 id="column_depth_for_irradiation">column_depth_for_irradiation <a href="#column_depth_for_irradiation" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
irradiation_flux = 0
column_depth_for_irradiation = -1
{% endhighlight %}

<h1 id="mass_gain_or_loss">mass gain or loss <a href="#mass_gain_or_loss" title="Permalink to this location">¶</a></h1>


<h3 id="mass_change">mass_change <a href="#mass_change" title="Permalink to this location">¶</a></h3>


Rate of accretion (Msun/year).  Negative for mass loss.
This only applies when the `wind_scheme = ''`.

{% highlight fortran %}
mass_change = 0d0
{% endhighlight %}


Enhanced mass loss due to rotation
as in Heger, Langer, and Woosley, 2000, ApJ, 528:368-396.

     Mdot = Mdot_no_rotation/(1 - Osurf/Osurf_crit)^mdot_omega_power

where

    Osurf = angular velocity at surface
    Osurf_crit^2 = (1 - Gamma_edd)*G*M/R^3
    Gamma_edd = kappa*L/(4 pi c G M), Eddington factor

Typical value for `mdot_omega_power = 0.43`.

<h3 id="mdot_omega_power">mdot_omega_power <a href="#mdot_omega_power" title="Permalink to this location">¶</a></h3>


Set to 0 to disable this feature.

{% highlight fortran %}
mdot_omega_power = 0.43d0
{% endhighlight %}


<h3 id="max_rotational_mdot_boost">max_rotational_mdot_boost <a href="#max_rotational_mdot_boost" title="Permalink to this location">¶</a></h3>


This limits the rotational boost.

{% highlight fortran %}
max_rotational_mdot_boost = 1d4
{% endhighlight %}


<h3 id="max_mdot_jump_for_rotation">max_mdot_jump_for_rotation <a href="#max_mdot_jump_for_rotation" title="Permalink to this location">¶</a></h3>


Don't increase prev mdot by more that this.
NOTE: use `vcrit_max_years_for_timestep` with this.

{% highlight fortran %}
max_mdot_jump_for_rotation = 2
{% endhighlight %}


<h3 id="lim_trace_rotational_mdot_boost">lim_trace_rotational_mdot_boost <a href="#lim_trace_rotational_mdot_boost" title="Permalink to this location">¶</a></h3>


Output to terminal if boost > this.

{% highlight fortran %}
lim_trace_rotational_mdot_boost = 1d99
{% endhighlight %}


<h3 id="rotational_mdot_boost_fac">rotational_mdot_boost_fac <a href="#rotational_mdot_boost_fac" title="Permalink to this location">¶</a></h3>


Increase mdot.

{% highlight fortran %}
rotational_mdot_boost_fac = 1d5
{% endhighlight %}


<h3 id="rotational_mdot_kh_fac">rotational_mdot_kh_fac <a href="#rotational_mdot_kh_fac" title="Permalink to this location">¶</a></h3>


Kelvin-helmholtz boost.

{% highlight fortran %}
rotational_mdot_kh_fac = 0.3d0
{% endhighlight %}


<h3 id="surf_avg_tau_min">surf_avg_tau_min <a href="#surf_avg_tau_min" title="Permalink to this location">¶</a></h3>


Use mass avg starting from this optical depth.

{% highlight fortran %}
surf_avg_tau_min = 1
{% endhighlight %}


<h3 id="surf_avg_tau">surf_avg_tau <a href="#surf_avg_tau" title="Permalink to this location">¶</a></h3>


Use mass avg down to this optical depth.

{% highlight fortran %}
surf_avg_tau = 100
{% endhighlight %}


<h3 id="hot_wind_scheme">hot_wind_scheme <a href="#hot_wind_scheme" title="Permalink to this location">¶</a></h3>


<h3 id="hot_wind_Wolf_Rayet_scheme">hot_wind_Wolf_Rayet_scheme <a href="#hot_wind_Wolf_Rayet_scheme" title="Permalink to this location">¶</a></h3>


<h3 id="cool_wind_RGB_scheme">cool_wind_RGB_scheme <a href="#cool_wind_RGB_scheme" title="Permalink to this location">¶</a></h3>


<h3 id="cool_wind_AGB_scheme">cool_wind_AGB_scheme <a href="#cool_wind_AGB_scheme" title="Permalink to this location">¶</a></h3>


This section replaces the old "`RGB_wind_scheme`" and "`AGB_wind_scheme`"
with temperature-dependent hot\_wind and cool\_wind.  You can still
use the RGB and AGB wind scheme as before, the functionality remains.

Now you can also select a hot wind scheme that takes effect *above*
some temperature, set by `hot_wind_full_on_T`.
Similarly, the cool wind scheme has temperature controls that
set the temperature *below* which they are relevant (`cool_wind_full_on_T`). 

As before, an empty string '' means no wind.

The wind "eta" values, which are constant scaling factors, have all
renamed \*\_wind\_eta -> \*\_scaling\_factor.

Here is an example of how to translate an existing inlist from the
old style to the new:

    |        Before                    |             After                 |
    |----------------------------------|-----------------------------------|
    | RGB_wind_scheme = 'Reimers'      |  cool_wind_RGB_scheme = 'Reimers' |
    | Reimers_wind_eta = 0.1           |  Reimers_scaling_factor = 0.1     |
    | AGB_wind_scheme = 'Blocker'      |  cool_wind_AGB_scheme = 'Blocker' |
    | Blocker_wind_eta = 0.5           |  Blocker_scaling_factor = 0.5     |
    | RGB_to_AGB_wind_switch = 1d-4    |  RGB_to_AGB_wind_switch = 1d-4    |
    |                                  |                                   |
    |                                  |  ! only use the cool_wind_scheme  |
    |                                  |  cool_wind_full_on_T = 1d10  !K   |
    |                                  |  hot_wind_full_on_T = 1.1d10 !K   |
    |                                  |  hot_wind_scheme = ''             |

suggested hot and cool wind schemes follow but any valid wind option
will work for either hot or cool.

Empty string means no wind

Suggested hot wind options:

+ 'Kudritzki'
+ 'Vink'

Suggested cool wind options:

  + 'Reimers'
  + 'Blöcker'
  + 'de Jager'
  + 'van Loon'
  + 'Nieuwenhuijzen'

For now the 'Dutch' scheme can be used in either capacity.

{% highlight fortran %}
hot_wind_scheme = ''
cool_wind_RGB_scheme = ''
cool_wind_AGB_scheme = ''
{% endhighlight %}


<h3 id="cool_wind_full_on_T">cool_wind_full_on_T <a href="#cool_wind_full_on_T" title="Permalink to this location">¶</a></h3>


<h3 id="hot_wind_full_on_T">hot_wind_full_on_T <a href="#hot_wind_full_on_T" title="Permalink to this location">¶</a></h3>


NOTE: hot_wind_full_on_T was previously called 'cool_wind_full_off_T'

use only cool wind schemes for T\_phot < `cool_wind_full_on_T`
use only hot wind schemes for T\_phot > `hot_wind_full_on_T`
if `cool_wind_full_on_T` /= `hot_wind_full_on_T` then ramp between these limits
requires `hot_wind_full_on_T` > `cool_wind_full_on_T`

{% highlight fortran %}
cool_wind_full_on_T = 0.8d4
hot_wind_full_on_T = 1.2d4
{% endhighlight %}


<h3 id="RGB_to_AGB_wind_switch">RGB_to_AGB_wind_switch <a href="#RGB_to_AGB_wind_switch" title="Permalink to this location">¶</a></h3>


If center hydrogen abundance is < 0.01
and center helium abundance by mass is less than `RGB_to_AGB_wind_switch`,
then system will use `AGB_wind_scheme` rather than `RGB_wind_scheme`.

{% highlight fortran %}
RGB_to_AGB_wind_switch = 1d-4
{% endhighlight %}


The code will automatically choose between an RGB wind and an AGB wind.
The following names for the different schemes are recognized:

+ 'Reimers'
+ 'Blocker'
+ 'de Jager'
+ 'van Loon'
+ 'Nieuwenhuijzen'
+ 'Kudritzki'
+ 'Vink'
+ 'Dutch'
+ 'Stern51'
+ 'Grafener'
+ 'other'  --- experimental

<h3 id="Reimers_scaling_factor">Reimers_scaling_factor <a href="#Reimers_scaling_factor" title="Permalink to this location">¶</a></h3>


Reimers mass loss for red giants.

D. Reimers
"Problems in Stellar Atmospheres and Envelopes"
Baschek, Kegel, Traving (eds), Springer, Berlin, 1975, p. 229.

Parameter for mass loss by Reimers wind prescription.
Reimers mdot is `eta*4d-13*L*R/M` (Msun/year), with L, R, and M in solar units.
Typical value is 0.5.

{% highlight fortran %}
Reimers_scaling_factor = 0
{% endhighlight %}


<h3 id="Blocker_scaling_factor__0">Blocker_scaling_factor = 0 <a href="#Blocker_scaling_factor__0" title="Permalink to this location">¶</a></h3>


Blocker's mass loss for AGB stars.

T. Blocker
"Stellar evolution of low and intermediate-mass stars"
A&A 297, 727-738 (1995).

Parameter for mass loss by Blocker's wind prescription.
Blocker mdot is `eta*4.83d-9*M**-2.1*L**2.7*4d-13*L*R/M` (Msun/year),
with L, R, and M in solar units.
Typical value is 0.1d0.

{% highlight fortran %}
Blocker_scaling_factor = 0
{% endhighlight %}


<h3 id="de_Jager_scaling_factor">de_Jager_scaling_factor <a href="#de_Jager_scaling_factor" title="Permalink to this location">¶</a></h3>


de Jager mass loss for various applications.
de Jager, C., Nieuwenhuijzen, H., & van der Hucht, K. A. 1988, A&AS, 72, 259.
Parameter for mass loss by de Jager wind prescription.

{% highlight fortran %}
de_Jager_scaling_factor = 0d0
{% endhighlight %}


<h3 id="van_Loon_scaling_factor">van_Loon_scaling_factor <a href="#van_Loon_scaling_factor" title="Permalink to this location">¶</a></h3>


see van Loon et al. 2005, A&A, 438, 273
"An empirical formula for the mass-loss rates of dust-enshrouded
red supergiants and oxygen-rich Asymptotic Giant Branch stars"

{% highlight fortran %}
van_Loon_scaling_factor = 0d0
{% endhighlight %}


<h3 id="Kudritzki_scaling_factor">Kudritzki_scaling_factor <a href="#Kudritzki_scaling_factor" title="Permalink to this location">¶</a></h3>


Radiation driven winds of hot stars.
See Kudritzki et al, Astron. Astrophys. 219, 205-218 (1989).

{% highlight fortran %}
Kudritzki_scaling_factor = 0d0
{% endhighlight %}


<h3 id="Nieuwenhuijzen_scaling_factor">Nieuwenhuijzen_scaling_factor <a href="#Nieuwenhuijzen_scaling_factor" title="Permalink to this location">¶</a></h3>


See Nieuwenhuijzen, H.; de Jager, C. 1990, A&A, 231, 134.

{% highlight fortran %}
Nieuwenhuijzen_scaling_factor = 0d0
{% endhighlight %}


<h3 id="Vink_scaling_factor">Vink_scaling_factor <a href="#Vink_scaling_factor" title="Permalink to this location">¶</a></h3>


Vink, J.S., de Koter, A., & Lamers, H.J.G.L.M., 2001, A&A, 369, 574.
"Mass-loss predictions for O and B stars as a function of metallicity"

{% highlight fortran %}
Vink_scaling_factor = 0d0
{% endhighlight %}


<h3 id="Grafener_scaling_factor">Grafener_scaling_factor <a href="#Grafener_scaling_factor" title="Permalink to this location">¶</a></h3>


Grafener, G. & Hamann, W.-R. 2008, A&A 482, 945
contributed to mesa by Nilou Afsari

{% highlight fortran %}
Grafener_scaling_factor = 0d0
{% endhighlight %}


<h3 id="Dutch_scaling_factor">Dutch_scaling_factor <a href="#Dutch_scaling_factor" title="Permalink to this location">¶</a></h3>


The "Dutch" wind scheme for massive stars combines results from several papers,
all with authors mostly from the Netherlands.

The particular combination we use is based on
Glebbeek, E., et al, A&A 497, 255-264 (2009) [more Dutch authors!]

For Teff > 1e4 and surface H > 0.4 by mass, use Vink et al 2001
Vink, J.S., de Koter, A., & Lamers, H.J.G.L.M., 2001, A&A, 369, 574.

For Teff > 1e4 and surface H < 0.4 by mass, use Nugis & Lamers 2000
Nugis, T.,& Lamers, H.J.G.L.M., 2000, A&A, 360, 227
Some folks use 0.8 for non-rotating mdoels (Maeder & Meynet, 2001).

{% highlight fortran %}
Dutch_scaling_factor = 0d0
{% endhighlight %}


<h3 id="Dutch_wind_lowT_scheme">Dutch_wind_lowT_scheme <a href="#Dutch_wind_lowT_scheme" title="Permalink to this location">¶</a></h3>


For Teff < 1e4

Use de Jager if `Dutch_wind_lowT_scheme = 'de Jager'`
de Jager, C., Nieuwenhuijzen, H., & van der Hucht, K. A. 1988, A&AS, 72, 259.

Use van Loon if `Dutch_wind_lowT_scheme = 'van Loon'`
van Loon et al. 2005, A&A, 438, 273.

Use Nieuwenhuijzen if `Dutch_wind_lowT_scheme = 'Nieuwenhuijzen'`
Nieuwenhuijzen, H.; de Jager, C. 1990, A&A, 231, 134

{% highlight fortran %}
Dutch_wind_lowT_scheme = 'de Jager'
{% endhighlight %}


<h3 id="Stern51_scaling_factor">Stern51_scaling_factor <a href="#Stern51_scaling_factor" title="Permalink to this location">¶</a></h3>


wind scheme from Stern

{% highlight fortran %}
Stern51_scaling_factor = 0d0
{% endhighlight %}


<h3 id="use_accreted_material_j">use_accreted_material_j <a href="#use_accreted_material_j" title="Permalink to this location">¶</a></h3>


Angular momentum of accreted material.

{% highlight fortran %}
use_accreted_material_j = .false.
{% endhighlight %}


If false, then accreted material is given j so that it
is rotating at the same angular velocity as the surface.
If true, then accreted material is given j = `accreted_material_j`.

{% highlight fortran %}
accreted_material_j = 0
{% endhighlight %}


<h3 id="no_wind_if_no_rotation">no_wind_if_no_rotation <a href="#no_wind_if_no_rotation" title="Permalink to this location">¶</a></h3>


Use this to delay start of wind until after have started rotation.

{% highlight fortran %}
no_wind_if_no_rotation = .false.
{% endhighlight %}


<h3 id="min_wind">min_wind <a href="#min_wind" title="Permalink to this location">¶</a></h3>


Min wind in Msun/year > 0; ignore this limit if it is <= 0.
e.g., might have low level wind even when normal scheme doesn't call for any.

{% highlight fortran %}
min_wind = 0d0
{% endhighlight %}


<h3 id="max_wind">max_wind <a href="#max_wind" title="Permalink to this location">¶</a></h3>


Max wind in Msun/year > 0; ignore this limit if it is <= 0.

{% highlight fortran %}
max_wind = 0d0
{% endhighlight %}


For critical rotation mass loss
Redo step as needed to find mdot that brings model to just below critical.
if `max_mdot_redo_cnt` > 0, and `surf_w_div_w_crit` > `surf_w_div_w_crit_limit`,
then recompute the step while increasing mdot, until
`surf_w_div_w_crit` < `surf_w_div_w_crit_limit`. Once an upper limit for mdot is found,
the solution for mdot is further refined by bisection until it is computed to a tolerance of
`surf_w_div_w_crit_tol`. During iterations, mdot is adjusted alternately by multiplication
by `mdot_revise_factor`, and by adjusting it by `implicit_mdot_boost*mdot_initial`, where
`mdot_initial` is the value of mdot at the first iteration. This is done to deal with mass
accreting stars, where mdot might need to change sign for the star to remain below critical.

{% highlight fortran %}
max_mdot_redo_cnt = 0
min_years_dt_for_redo_mdot = 0
surf_w_div_w_crit_limit = 0.99d0
surf_w_div_w_crit_tol = 0.05d0
mdot_revise_factor = 1.1d0
implicit_mdot_boost = 0.1d0
{% endhighlight %}


<h2 id="implicit_wind_computation">implicit wind computation. <a href="#implicit_wind_computation" title="Permalink to this location">¶</a></h2>


<h3 id="max_tries_for_implicit_wind">max_tries_for_implicit_wind <a href="#max_tries_for_implicit_wind" title="Permalink to this location">¶</a></h3>


The implicit method will modify the mass transfer rate and redo the step until
it either finds a solution, or the number of tries hits `max_tries_for_implicit_wind`.
If `max_tries_for_implicit_wind = 0`, the wind computation is explicit,
meaning that the value of mdot is set using values at the start of the step.
This only applies when mdot < 0.

{% highlight fortran %}
max_tries_for_implicit_wind = 0
{% endhighlight %}


<h3 id="iwind_tolerance">iwind_tolerance <a href="#iwind_tolerance" title="Permalink to this location">¶</a></h3>


Tolerance for which a solution is considered valid. 
A solution is valid if

    abs(explicit_mdot - implicit_mdot) <
           abs(implicit_mdot)*iwind_tolerance

where

    explicit_mdot = mstar_dot at start of step
    implicit_mdot = mstar_dot at end of step

{% highlight fortran %}
iwind_tolerance = 1d-3
{% endhighlight %}


<h3 id="iwind_lambda">iwind_lambda <a href="#iwind_lambda" title="Permalink to this location">¶</a></h3>


If do not satisfy tolerance, redo with a different mdot as follows:
       
        mstar_dot = explicit_mdot + &
           iwind_lambda*(implicit_mdot - explicit_mdot)

{% highlight fortran %}
iwind_lambda = 1d0
{% endhighlight %}


<h2 id="remove_H_wind">remove H wind <a href="#remove_H_wind" title="Permalink to this location">¶</a></h2>


<h3 id="remove_H_wind_mdot">remove_H_wind_mdot <a href="#remove_H_wind_mdot" title="Permalink to this location">¶</a></h3>


This wind removes surface material until reaching a target total H mass for the star.
Max rate of removal in Msun/year ; only applies if this is > 0.

{% highlight fortran %}
remove_H_wind_mdot = 0d0
{% endhighlight %}


<h3 id="remove_H_wind_H_mass_limit">remove_H_wind_H_mass_limit <a href="#remove_H_wind_H_mass_limit" title="Permalink to this location">¶</a></h3>


This wind removes surface material until reaching a target total H mass for the star.
Turn off this wind when total H mass < this limit (Msun units).

{% highlight fortran %}
remove_H_wind_H_mass_limit = 0
{% endhighlight %}


<h3 id="super_eddington_scaling_factor">super_eddington_scaling_factor <a href="#super_eddington_scaling_factor" title="Permalink to this location">¶</a></h3>


For super eddington wind we use Ledd averaged by mass to optical depth tau = `surf_avg_tau`.

{% highlight fortran %}
super_eddington_scaling_factor = 0
{% endhighlight %}


<h3 id="super_eddington_wind_Ledd_factor">super_eddington_wind_Ledd_factor <a href="#super_eddington_wind_Ledd_factor" title="Permalink to this location">¶</a></h3>


Parameter for mass loss driven by super Eddington luminosity.
Divide L by this factor when computing super Eddington wind,
e.g., if this is 2, then only get wind when L/2 > Ledd.

{% highlight fortran %}
super_eddington_wind_Ledd_factor = 1
{% endhighlight %}


<h3 id="wind_boost_full_off_L_div_Ledd">wind_boost_full_off_L_div_Ledd <a href="#wind_boost_full_off_L_div_Ledd" title="Permalink to this location">¶</a></h3>


Boost off for L/Ledd <= this (set large to disable this).
This alternative form is used when `super_eddington_scaling_factor` == 0.

{% highlight fortran %}
wind_boost_full_off_L_div_Ledd = 1.5d0
{% endhighlight %}


<h3 id="wind_boost_full_on_L_div_Ledd">wind_boost_full_on_L_div_Ledd <a href="#wind_boost_full_on_L_div_Ledd" title="Permalink to this location">¶</a></h3>


Do max boost for L/Ledd >= this.
This alternative form is used when `super_eddington_scaling_factor` == 0.

{% highlight fortran %}
wind_boost_full_on_L_div_Ledd = 5
{% endhighlight %}


<h3 id="super_eddington_wind_max_boost">super_eddington_wind_max_boost <a href="#super_eddington_wind_max_boost" title="Permalink to this location">¶</a></h3>


Multiply wind mdot by up to this amount.
This alternative form is used when `super_eddington_scaling_factor` == 0.

{% highlight fortran %}
super_eddington_wind_max_boost = 1
{% endhighlight %}


<h3 id="trace_super_eddington_wind_boost">trace_super_eddington_wind_boost <a href="#trace_super_eddington_wind_boost" title="Permalink to this location">¶</a></h3>


Send super eddington wind information to terminal.

{% highlight fortran %}
trace_super_eddington_wind_boost = .false.
{% endhighlight %}


<h3 id="mass_change_full_on_dt">mass_change_full_on_dt <a href="#mass_change_full_on_dt" title="Permalink to this location">¶</a></h3>


<h3 id="mass_change_full_off_dt">mass_change_full_off_dt <a href="#mass_change_full_off_dt" title="Permalink to this location">¶</a></h3>


These params provide the option to turn off mass change when have very small timesteps.
Between `mass_change_full_on_dt` and `mass_change_full_off_dt` mass change is gradually reduced.
Units in seconds.

{% highlight fortran %}
mass_change_full_on_dt = 1d-99
mass_change_full_off_dt = 1d-99
{% endhighlight %}


<h3 id="trace_dt_control_mass_change">trace_dt_control_mass_change <a href="#trace_dt_control_mass_change" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
trace_dt_control_mass_change = .false.
{% endhighlight %}


<h3 id="min_abs_mdot_for_change_limits">min_abs_mdot_for_change_limits <a href="#min_abs_mdot_for_change_limits" title="Permalink to this location">¶</a></h3>


Only apply limits if abs(prev mdot) > this limit.
These limit the change in mdot from one step to the next.

{% highlight fortran %}
min_abs_mdot_for_change_limits = 1d-14
{% endhighlight %}


<h3 id="max_abs_mdot_factor">max_abs_mdot_factor <a href="#max_abs_mdot_factor" title="Permalink to this location">¶</a></h3>


Only allow abs(mdot) to increase by this factor per timestep.

{% highlight fortran %}
max_abs_mdot_factor = 2
{% endhighlight %}


<h3 id="min_abs_mdot_factor">min_abs_mdot_factor <a href="#min_abs_mdot_factor" title="Permalink to this location">¶</a></h3>


Only allow abs(mdot) to decrease by this factor per timestep.

{% highlight fortran %}
min_abs_mdot_factor = 0.5d0
{% endhighlight %}


<h3 id="max_star_mass_for_gain">max_star_mass_for_gain <a href="#max_star_mass_for_gain" title="Permalink to this location">¶</a></h3>


Automatic stops for mass loss/gain
in Msun units (negative means ignore this parameter).
Turn off mass gain when star mass reaches this limit.

{% highlight fortran %}
max_star_mass_for_gain = -1
{% endhighlight %}


<h3 id="min_star_mass_for_loss">min_star_mass_for_loss <a href="#min_star_mass_for_loss" title="Permalink to this location">¶</a></h3>


Automatic stops for mass loss/gain
in Msun units (negative means ignore this parameter).
Turn off mass loss when star mass reaches this limit.

{% highlight fortran %}
min_star_mass_for_loss = -1
{% endhighlight %}


<h3 id="max_T_center_for_any_mass_loss">max_T_center_for_any_mass_loss <a href="#max_T_center_for_any_mass_loss" title="Permalink to this location">¶</a></h3>


No mass loss for T center > this.

{% highlight fortran %}
max_T_center_for_any_mass_loss = 2d9
{% endhighlight %}


<h3 id="max_T_center_for_full_mass_loss">max_T_center_for_full_mass_loss <a href="#max_T_center_for_full_mass_loss" title="Permalink to this location">¶</a></h3>


No reduction in mass loss for T center <= this.
This must be <= `max_T_center_for_full_mass_loss`.
Reduce mass loss rate to 0 as T center climbs from `max_for_full` to `max_for_any`.
The idea behind this is that during final stages of burning, there is so little time
left in the life of the star, that any mass loss to winds will be negligible,
but the inclusion of that insignificant mass loss can actually make
convergence more difficult, so you are better off without it.

{% highlight fortran %}
max_T_center_for_full_mass_loss = 1d9
{% endhighlight %}


<h3 id="wind_H_envelope_limit">wind_H_envelope_limit <a href="#wind_H_envelope_limit" title="Permalink to this location">¶</a></h3>


Winds automatically shut off when star_mass - he_core_mass mass is less than this limit.
The value of `he_core_boundary_h1_fraction` defines he_core_mass.
Mass in Msun units.   Previously called `wind_envelope_limit`.

{% highlight fortran %}
wind_H_envelope_limit = -1
{% endhighlight %}


<h3 id="wind_H_He_envelope_limit">wind_H_He_envelope_limit <a href="#wind_H_He_envelope_limit" title="Permalink to this location">¶</a></h3>


Winds automatically shut off when star_mass - c_core_mass is less than this limit.
The value of `c_core_boundary_he4_fraction` defines c_core_mass.
Mass in Msun units.

{% highlight fortran %}
wind_H_He_envelope_limit = -1
{% endhighlight %}


<h3 id="wind_He_layer_limit">wind_He_layer_limit <a href="#wind_He_layer_limit" title="Permalink to this location">¶</a></h3>


Winds automatically shut off when he_core_mass - c_core_mass is less than this limit.
Mass in Msun units.

{% highlight fortran %}
wind_He_layer_limit = -1
{% endhighlight %}


<h3 id="rlo_scaling_factor">rlo_scaling_factor <a href="#rlo_scaling_factor" title="Permalink to this location">¶</a></h3>


Amplitude of mass loss.
"rlo" wind scheme provides a simple radius-determined-wind with exponential increase.

{% highlight fortran %}
rlo_scaling_factor = 0
{% endhighlight %}


<h3 id="rlo_wind_min_L">rlo_wind_min_L <a href="#rlo_wind_min_L" title="Permalink to this location">¶</a></h3>


Only on when L > this limit. (Lsun)

{% highlight fortran %}
rlo_wind_min_L = 1d-6
{% endhighlight %}


<h3 id="rlo_wind_max_Teff">rlo_wind_max_Teff <a href="#rlo_wind_max_Teff" title="Permalink to this location">¶</a></h3>


Only on when Teff < this limit.

{% highlight fortran %}
rlo_wind_max_Teff = 1d99
{% endhighlight %}


<h3 id="rlo_wind_roche_lobe_radius">rlo_wind_roche_lobe_radius <a href="#rlo_wind_roche_lobe_radius" title="Permalink to this location">¶</a></h3>


Only on when R > this (Rsun).

{% highlight fortran %}
rlo_wind_roche_lobe_radius = 0.40d0
{% endhighlight %}


<h3 id="rlo_wind_base_mdot">rlo_wind_base_mdot <a href="#rlo_wind_base_mdot" title="Permalink to this location">¶</a></h3>


Base rate of mass loss when R = roche lobe radius (Msun/year).

{% highlight fortran %}
rlo_wind_base_mdot = 1d-3
{% endhighlight %}


<h3 id="rlo_wind_scale_height">rlo_wind_scale_height <a href="#rlo_wind_scale_height" title="Permalink to this location">¶</a></h3>


Determines exponential growth rate of mass loss (Rsun).

{% highlight fortran %}
rlo_wind_scale_height = 1d-1
{% endhighlight %}


<h3 id="roche_lobe_xfer_full_on">roche_lobe_xfer_full_on <a href="#roche_lobe_xfer_full_on" title="Permalink to this location">¶</a></h3>


Full accretion when R/RL <= this.
Limit accretion when Roche lobe is nearing full (only with `rlo_scaling_factor` > 0).

{% highlight fortran %}
roche_lobe_xfer_full_on = 0.5d0
{% endhighlight %}


<h3 id="roche_lobe_xfer_full_off">roche_lobe_xfer_full_off <a href="#roche_lobe_xfer_full_off" title="Permalink to this location">¶</a></h3>


No accretion when R/RL >= this.

{% highlight fortran %}
roche_lobe_xfer_full_off = 1.0d0
{% endhighlight %}


<h3 id="nova_scaling_factor">nova_scaling_factor <a href="#nova_scaling_factor" title="Permalink to this location">¶</a></h3>


Amplitude of wind.
"nova" wind is scheme used in Kato and Hachisu, ApJ 437:802-826, 1994. (eqn 23).
This only applies when `nova_scaling_factor` > 0.

{% highlight fortran %}
nova_scaling_factor = 0
{% endhighlight %}


<h3 id="nova_wind_b">nova_wind_b <a href="#nova_wind_b" title="Permalink to this location">¶</a></h3>


Wind parameter

{% highlight fortran %}
nova_wind_b = 0
{% endhighlight %}


<h3 id="nova_wind_max_Teff">nova_wind_max_Teff <a href="#nova_wind_max_Teff" title="Permalink to this location">¶</a></h3>


Only on when Teff < this limit.

{% highlight fortran %}
nova_wind_max_Teff = 0
{% endhighlight %}


<h3 id="nova_wind_min_L">nova_wind_min_L <a href="#nova_wind_min_L" title="Permalink to this location">¶</a></h3>


only on when L > this limit. (Lsun)

{% highlight fortran %}
nova_wind_min_L = 0
{% endhighlight %}


<h3 id="nova_min_Teff_for_accretion">nova_min_Teff_for_accretion <a href="#nova_min_Teff_for_accretion" title="Permalink to this location">¶</a></h3>


When `nova_scaling_factor /= 0` and `Teff < this` and `L > nova_wind_min_L`, no accretion.

{% highlight fortran %}
nova_min_Teff_for_accretion = 0
{% endhighlight %}


<h3 id="nova_roche_lobe_radius">nova_roche_lobe_radius <a href="#nova_roche_lobe_radius" title="Permalink to this location">¶</a></h3>


units in Rsun

{% highlight fortran %}
nova_roche_lobe_radius = 0
{% endhighlight %}


<h3 id="nova_RLO_mdot">nova_RLO_mdot <a href="#nova_RLO_mdot" title="Permalink to this location">¶</a></h3>


roche lobe overflow mdot, Msun/year

{% highlight fortran %}
nova_RLO_mdot = 0
{% endhighlight %}


<h3 id="flash_wind_mdot">flash_wind_mdot <a href="#flash_wind_mdot" title="Permalink to this location">¶</a></h3>


Rate of mass ejection in Msun/year.
"flash" wind is scheme used in Kato, Saio, and Hachisu, ApJ 340:509-517, 1989.
This only applies when `flash_wind_mdot` > 0.

{% highlight fortran %}
flash_wind_mdot = -1
{% endhighlight %}


<h3 id="flash_wind_starts">flash_wind_starts <a href="#flash_wind_starts" title="Permalink to this location">¶</a></h3>


Wind starts when R >= this limit (Rsun units).

{% highlight fortran %}
flash_wind_starts = -1
{% endhighlight %}


<h3 id="flash_wind_declines">flash_wind_declines <a href="#flash_wind_declines" title="Permalink to this location">¶</a></h3>


Wind starts to decline when R <= this limit (Rsun units).

{% highlight fortran %}
flash_wind_declines = -1
{% endhighlight %}


<h3 id="flash_wind_full_off">flash_wind_full_off <a href="#flash_wind_full_off" title="Permalink to this location">¶</a></h3>


Wind full off when R <= this limit (Rsun units).

{% highlight fortran %}
flash_wind_full_off = -1
{% endhighlight %}


<h2 id="controls_for_adjust_mass">controls for adjust_mass <a href="#controls_for_adjust_mass" title="Permalink to this location">¶</a></h2>


<h3 id="max_logT_for_k_below_const_q">max_logT_for_k_below_const_q <a href="#max_logT_for_k_below_const_q" title="Permalink to this location">¶</a></h3>


<h3 id="max_q_for_k_below_const_q">max_q_for_k_below_const_q <a href="#max_q_for_k_below_const_q" title="Permalink to this location">¶</a></h3>


<h3 id="min_q_for_k_below_const_q">min_q_for_k_below_const_q <a href="#min_q_for_k_below_const_q" title="Permalink to this location">¶</a></h3>


Move `k_below_const_q` inward from surface until `q(k) <= max_q`.
Then continue moving inward until reach `logT(k) >= max_logT` or `q(k) <= min_q`.

{% highlight fortran %}
max_logT_for_k_below_const_q = 5
max_q_for_k_below_const_q = 1.0d0
min_q_for_k_below_const_q = 0.999d0
{% endhighlight %}


<h3 id="max_logT_for_k_const_mass">max_logT_for_k_const_mass <a href="#max_logT_for_k_const_mass" title="Permalink to this location">¶</a></h3>


<h3 id="max_q_for_k_const_mass">max_q_for_k_const_mass <a href="#max_q_for_k_const_mass" title="Permalink to this location">¶</a></h3>


<h3 id="min_q_for_k_const_mass">min_q_for_k_const_mass <a href="#min_q_for_k_const_mass" title="Permalink to this location">¶</a></h3>


Move `k_below_const_q` inward from `k_below_const_q+1` until `q(k) <= max_q`.
Then continue moving inward until reach `logT(k) >= max_logT` or `q(k) <= min_q`.

{% highlight fortran %}
max_logT_for_k_const_mass = 6
max_q_for_k_const_mass = 1.0d0
min_q_for_k_const_mass = 0.995d0
{% endhighlight %}

<h1 id="composition_controls">composition controls <a href="#composition_controls" title="Permalink to this location">¶</a></h1>


<h3 id="accrete_same_as_surface">accrete_same_as_surface <a href="#accrete_same_as_surface" title="Permalink to this location">¶</a></h3>


If true, composition of accreted material is identical to the current surface composition.
If false, then the composition is determined by `accrete_given_mass_fractions`.

The actual mass accretion rate can be set up using the `mass_change` option.

{% highlight fortran %}
accrete_same_as_surface = .true.
{% endhighlight %}


<h3 id="accrete_given_mass_fractions">accrete_given_mass_fractions <a href="#accrete_given_mass_fractions" title="Permalink to this location">¶</a></h3>


If true, use `accrete_given_mass_fractions`, `num_accretion_species`,
`accretion_species_id` and `accretion_species_xa` to determine composition
of accreted material -- they must add to 1.0.

If false, then the composition is determined using `accretion_h1`, `accretion_h2`,
`accretion_he3`, `accretion_he4` and `accretion_zfracs`.

The actual mass accretion rate can be set up using the `mass_change` option.

Note that this control is ignored if `accrete_same_as_surface` is true.

{% highlight fortran %}
accrete_given_mass_fractions = .false.
{% endhighlight %}


<h3 id="num_accretion_species">num_accretion_species <a href="#num_accretion_species" title="Permalink to this location">¶</a></h3>


<h3 id="accretion_species_id">accretion_species_id <a href="#accretion_species_id" title="Permalink to this location">¶</a></h3>


<h3 id="accretion_species_xa">accretion_species_xa <a href="#accretion_species_xa" title="Permalink to this location">¶</a></h3>


If accrete_same_as_surface is false and accrete_given_mass_fractions is true,
then composition of accreted material is determined by these options.
The actual mass accretion rate can be set up using the `mass_change` option.

`num_accretion_species` can be up to `s% max_num_accretion_species`, see
`star/public/star_def.inc` for the value of this parameter.

For each of `num_accretion_species`, the id for the isotope needs to be specified
by `accretion_species_id` as defined in `chem/public/chem_def.f90`.

Mass fractions for each isotope are defined by `accretion_species_xa`

{% highlight fortran %}
num_accretion_species = 0
accretion_species_id(1) = ''
accretion_species_xa(1) = 0
{% endhighlight %}


<h3 id="accretion_h1">accretion_h1 <a href="#accretion_h1" title="Permalink to this location">¶</a></h3>


<h3 id="accretion_h2">accretion_h2 <a href="#accretion_h2" title="Permalink to this location">¶</a></h3>


<h3 id="accretion_he3">accretion_he3 <a href="#accretion_he3" title="Permalink to this location">¶</a></h3>


<h3 id="accretion_he4">accretion_he4 <a href="#accretion_he4" title="Permalink to this location">¶</a></h3>


If accrete_same_as_surface is false and accrete_given_mass_fractions is false,
then the mass fractions of h1, h2, he3 and h4 are determined by these options.
Mass fractions for metals are set with the `accretion_zfracs` control.
The actual mass accretion rate can be set up using the `mass_change` option.

If no h2 in current net, then it is automatically added to h1.

{% highlight fortran %}
accretion_h1 = 0
accretion_h2 = 0
accretion_he3 = 0
accretion_he4 = 0
{% endhighlight %}


<h3 id="accretion_zfracs_">accretion_zfracs = <a href="#accretion_zfracs_" title="Permalink to this location">¶</a></h3>


One of the following identifiers for different Z fractions from `chem_def`.

+ `AG89_zfracs = 1`, Anders & Grevesse 1989
+ `GN93_zfracs = 2`, Grevesse & Noels 1993
+ `GS98_zfracs = 3`, Grevesse & Sauval 1998
+ `L03_zfracs = 4`, Lodders 2003
+ `AGS05_zfracs = 5`, Asplund, Grevesse & Sauval 2005

or set `accretion_zfracs = 0` to use the following list of z fractions

{% highlight fortran %}
accretion_zfracs = -1
{% endhighlight %}


<h3 id="accretion_dump_missing_metals_into_heaviest">accretion_dump_missing_metals_into_heaviest <a href="#accretion_dump_missing_metals_into_heaviest" title="Permalink to this location">¶</a></h3>


this controls the treatment metals that are not included in the current net.
if this flag is true, then the mass fractions of missing metals are added
to the mass fraction of the most massive metal included in the net.
if this flag is false, then the mass fractions of the metals in the net
are renormalized to make up for the total mass fraction of missing metals.

{% highlight fortran %}
accretion_dump_missing_metals_into_heaviest = .true.
{% endhighlight %}


Special list of z fractions.
If you use these, they must add to 1.0.

{% highlight fortran %}
z_fraction_li = 0
z_fraction_be = 0
z_fraction_b = 0
z_fraction_c = 0
z_fraction_n = 0
z_fraction_o = 0
z_fraction_f = 0
z_fraction_ne = 0
z_fraction_na = 0
z_fraction_mg = 0
z_fraction_al = 0
z_fraction_si = 0
z_fraction_p = 0
z_fraction_s = 0
z_fraction_cl = 0
z_fraction_ar = 0
z_fraction_k = 0
z_fraction_ca = 0
z_fraction_sc = 0
z_fraction_ti = 0
z_fraction_v = 0
z_fraction_cr = 0
z_fraction_mn = 0
z_fraction_fe = 0
z_fraction_co = 0
z_fraction_ni = 0
z_fraction_cu = 0
z_fraction_zn = 0
{% endhighlight %}


<h3 id="lgT_lo_for_set_new_abundances">lgT_lo_for_set_new_abundances <a href="#lgT_lo_for_set_new_abundances" title="Permalink to this location">¶</a></h3>


<h3 id="lgT_hi_for_set_new_abundances">lgT_hi_for_set_new_abundances <a href="#lgT_hi_for_set_new_abundances" title="Permalink to this location">¶</a></h3>


Composition controls for `set_new_abundances`.

{% highlight fortran %}
lgT_lo_for_set_new_abundances = 5.2d0
lgT_hi_for_set_new_abundances = 5.5d0
{% endhighlight %}


<h3 id="pure_fe56_limit">pure_fe56_limit <a href="#pure_fe56_limit" title="Permalink to this location">¶</a></h3>


Pure fe56 for base of ns envelope.
If mass fraction of fe56 > this, convert cell to pure fe56.

{% highlight fortran %}
pure_fe56_limit = 0.999999d0
{% endhighlight %}

<h1 id="mesh_adjustment">mesh adjustment <a href="#mesh_adjustment" title="Permalink to this location">¶</a></h1>


<h3 id="max_allowed_nz">max_allowed_nz <a href="#max_allowed_nz" title="Permalink to this location">¶</a></h3>


Maximum number of grid points allowed.

{% highlight fortran %}
max_allowed_nz = 8000
{% endhighlight %}


<h3 id="remesh_max_allowed_logT">remesh_max_allowed_logT <a href="#remesh_max_allowed_logT" title="Permalink to this location">¶</a></h3>


Turn off remesh if any cell has logT > this.

{% highlight fortran %}
remesh_max_allowed_logT = 1d99
{% endhighlight %}


<h3 id="mesh_max_allowed_ratio">mesh_max_allowed_ratio <a href="#mesh_max_allowed_ratio" title="Permalink to this location">¶</a></h3>


Must be >= 2.5.
Max ratio for mass of adjacent cells.
If have ratio exceeding this, split the larger cell.

{% highlight fortran %}
mesh_max_allowed_ratio = 2.5d0
{% endhighlight %}


<h3 id="max_delta_x_for_merge">max_delta_x_for_merge <a href="#max_delta_x_for_merge" title="Permalink to this location">¶</a></h3>


Don't merge neighboring cells if any abundance differs by more than this.

{% highlight fortran %}
max_delta_x_for_merge = 0.1d0
{% endhighlight %}


<h3 id="mesh_delta_coeff">mesh_delta_coeff <a href="#mesh_delta_coeff" title="Permalink to this location">¶</a></h3>


A larger value increases the max allowed deltas and decreases the number of grid points.
and a smaller does the opposite.
E.g., you'll roughly double the number of grid points if you cut `mesh_delta_coeff` in half.
Don't expect it to exacly double the number however since other parameters in addition to
gradients also influence the details of the grid spacing.

{% highlight fortran %}
mesh_delta_coeff = 1.0d0
{% endhighlight %}


<h3 id="mesh_delta_coeff_for_highT">mesh_delta_coeff_for_highT <a href="#mesh_delta_coeff_for_highT" title="Permalink to this location">¶</a></h3>


Use different `mesh_delta_coeff` at higher temperatures.

{% highlight fortran %}
mesh_delta_coeff_for_highT = 3.0d0
{% endhighlight %}


<h3 id="logT_max_for_standard_mesh_delta_coeff">logT_max_for_standard_mesh_delta_coeff <a href="#logT_max_for_standard_mesh_delta_coeff" title="Permalink to this location">¶</a></h3>


Use `mesh_delta_coeff` for center logT <= this.  This value
should be less than `logT_min_for_highT_mesh_delta_coeff`.

{% highlight fortran %}
logT_max_for_standard_mesh_delta_coeff = 9.0d0
{% endhighlight %}


<h3 id="logT_min_for_highT_mesh_delta_coeff">logT_min_for_highT_mesh_delta_coeff <a href="#logT_min_for_highT_mesh_delta_coeff" title="Permalink to this location">¶</a></h3>


Use `mesh_delta_coeff_for_highT` for center logT >= this.
Linearly interpolate in logT for intermediate center temperatures.

{% highlight fortran %}
logT_min_for_highT_mesh_delta_coeff = 9.5d0
{% endhighlight %}


<h3 id="mesh_Pgas_div_P_exponent">mesh_Pgas_div_P_exponent <a href="#mesh_Pgas_div_P_exponent" title="Permalink to this location">¶</a></h3>


Multiply `mesh_delta_coeff` by (Pgas/Ptotal) to this power.

{% highlight fortran %}
mesh_Pgas_div_P_exponent = 0
{% endhighlight %}


<h3 id="mesh_delta_coeff_pre_ms">mesh_delta_coeff_pre_ms <a href="#mesh_delta_coeff_pre_ms" title="Permalink to this location">¶</a></h3>


Multiply `mesh_delta_coeff` by this when center XH > 0.5 and `lg_LH < lg_L - 1`.

{% highlight fortran %}
mesh_delta_coeff_pre_ms = 1
{% endhighlight %}


<h3 id="max_dq">max_dq <a href="#max_dq" title="Permalink to this location">¶</a></h3>


Max size for cell as fraction of total mass.

{% highlight fortran %}
max_dq = 1d-2
{% endhighlight %}


<h3 id="min_dq">min_dq <a href="#min_dq" title="Permalink to this location">¶</a></h3>


Min size for cell as fraction of total mass.

{% highlight fortran %}
min_dq = 1d-14
{% endhighlight %}


Min size for cell to be split.

{% highlight fortran %}
min_dq_for_split = 1d-14
{% endhighlight %}


<h3 id="min_dq_for_xa">min_dq_for_xa <a href="#min_dq_for_xa" title="Permalink to this location">¶</a></h3>


Min size for splitting because of composition gradient.
only for non-convective regions if have set min_dq_for_xa_convective > 0.

{% highlight fortran %}
min_dq_for_xa = 1d-14
{% endhighlight %}


<h3 id="min_dq_for_xa_convective">min_dq_for_xa_convective <a href="#min_dq_for_xa_convective" title="Permalink to this location">¶</a></h3>


Min size for splitting because of composition gradient in convective regions.
if <= 0, then use min_dq_for_xa instead of this.

{% highlight fortran %}
min_dq_for_xa_convective = 1d-6
{% endhighlight %}


<h3 id="mesh_min_dlnR">mesh_min_dlnR <a href="#mesh_min_dlnR" title="Permalink to this location">¶</a></h3>


Limit on difference in lnR across cell for mesh refinement.
Do not make this smaller than about 1d-14 or will fail with numerical problems.

{% highlight fortran %}
mesh_min_dlnR = 1d-9
{% endhighlight %}


<h3 id="merge_if_dlnR_too_small">merge_if_dlnR_too_small <a href="#merge_if_dlnR_too_small" title="Permalink to this location">¶</a></h3>


If true, mesh adjustment will force merge if difference in lnR across cell is too small.

{% highlight fortran %}
merge_if_dlnR_too_small = .false.
{% endhighlight %}


<h3 id="mesh_min_dr_div_dRstar">mesh_min_dr_div_dRstar <a href="#mesh_min_dr_div_dRstar" title="Permalink to this location">¶</a></h3>


Limit on relative radial extent for mesh refinement.
dRstar = s% r(1) - s% R_center
Don't split if dr/dRstar would drop below this limit.

{% highlight fortran %}
mesh_min_dr_div_dRstar = -1
{% endhighlight %}


<h3 id="merge_if_dr_div_dRstar_too_small">merge_if_dr_div_dRstar_too_small <a href="#merge_if_dr_div_dRstar_too_small" title="Permalink to this location">¶</a></h3>


If true, mesh adjustment will force merge if `dr_div_dRstar` too small.

{% highlight fortran %}
merge_if_dr_div_dRstar_too_small = .true.
{% endhighlight %}


<h3 id="mesh_min_dr_div_cs">mesh_min_dr_div_cs <a href="#mesh_min_dr_div_cs" title="Permalink to this location">¶</a></h3>


Limit (in seconds) on sound crossing time for mesh refinement.
Don't split if sound crossing time would drop below this limit.

{% highlight fortran %}
mesh_min_dr_div_cs = -1
{% endhighlight %}


<h3 id="merge_if_dr_div_cs_too_small">merge_if_dr_div_cs_too_small <a href="#merge_if_dr_div_cs_too_small" title="Permalink to this location">¶</a></h3>


If true, mesh adjustment will force merge if `dr_div_cs` too small.

{% highlight fortran %}
merge_if_dr_div_cs_too_small = .true.
{% endhighlight %}


<h3 id="max_center_cell_dq">max_center_cell_dq <a href="#max_center_cell_dq" title="Permalink to this location">¶</a></h3>


Largest allowed dq at center.

{% highlight fortran %}
max_center_cell_dq = 1d-7
{% endhighlight %}


<h3 id="max_surface_cell_dq">max_surface_cell_dq <a href="#max_surface_cell_dq" title="Permalink to this location">¶</a></h3>


Largest allowed dq at surface.

{% highlight fortran %}
max_surface_cell_dq = 1d-12
{% endhighlight %}


<h3 id="max_num_subcells">max_num_subcells <a href="#max_num_subcells" title="Permalink to this location">¶</a></h3>


Limits number of new cells from 1 old one.

{% highlight fortran %}
max_num_subcells = 2
{% endhighlight %}


<h3 id="max_num_merge_cells">max_num_merge_cells <a href="#max_num_merge_cells" title="Permalink to this location">¶</a></h3>


Limits number of old cells to merge into 1 new one.

{% highlight fortran %}
max_num_merge_cells = 2
{% endhighlight %}


<h3 id="mesh_adjust_use_quadratic">mesh_adjust_use_quadratic <a href="#mesh_adjust_use_quadratic" title="Permalink to this location">¶</a></h3>


Linear or quadratic reconstruction polynomials for mesh adjustments.

{% highlight fortran %}
mesh_adjust_use_quadratic = .true.
{% endhighlight %}


<h3 id="mesh_adjust_get_T_from_E">mesh_adjust_get_T_from_E <a href="#mesh_adjust_get_T_from_E" title="Permalink to this location">¶</a></h3>


If true, then use internal energy conservation to set new temperature.
If false, just use average temperature based on reconstruction polynomials.

{% highlight fortran %}
mesh_adjust_get_T_from_E = .true.
{% endhighlight %}


<h3 id="mesh_ok_to_merge">mesh_ok_to_merge <a href="#mesh_ok_to_merge" title="Permalink to this location">¶</a></h3>


<h3 id="mesh_max_k_old_for_split">mesh_max_k_old_for_split <a href="#mesh_max_k_old_for_split" title="Permalink to this location">¶</a></h3>


<h3 id="mesh_min_k_old_for_split">mesh_min_k_old_for_split <a href="#mesh_min_k_old_for_split" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
mesh_ok_to_merge = .true.
mesh_max_k_old_for_split = 999999999
mesh_min_k_old_for_split = 0
{% endhighlight %}


<h3 id="E_function_weight">E_function_weight <a href="#E_function_weight" title="Permalink to this location">¶</a></h3>


internal energy gradient, `E_function = E_function_weight*max(E_function_param,log10(energy))`.

{% highlight fortran %}
E_function_weight = 0
E_function_param = 16d0
{% endhighlight %}


<h3 id="P_function_weight">P_function_weight <a href="#P_function_weight" title="Permalink to this location">¶</a></h3>


Pressure gradient, `P_function = P_function_weight*log10(P)`.

{% highlight fortran %}
P_function_weight = 40
{% endhighlight %}


<h3 id="T_function1_weight">T_function1_weight <a href="#T_function1_weight" title="Permalink to this location">¶</a></h3>


Temperature gradient, `T_function1 = T_function1_weight*log10(T)`.
NOTE: The T gradient mesh controls below  seems to be necessary to allow burning that starts off center
to be able to reach the center.  You can see this in the `pre_zahb` `test_suite` case if you
try running it without the T function.   The center temperature will fail to rise.

{% highlight fortran %}
T_function1_weight = 110
{% endhighlight %}


<h3 id="T_function2_weight">T_function2_weight <a href="#T_function2_weight" title="Permalink to this location">¶</a></h3>


<h3 id="T_function2_param">T_function2_param <a href="#T_function2_param" title="Permalink to this location">¶</a></h3>


    T_function2 = T_function2_weight*log10(T / (T + T_function2_param))

Largest change in `T_function2` happens around `T = T_function2_param`.
Default value puts this in the envelope ionization region.

{% highlight fortran %}
T_function2_weight = 0
T_function2_param = 2d4
{% endhighlight %}


<h3 id="R_function_weight">R_function_weight <a href="#R_function_weight" title="Permalink to this location">¶</a></h3>


<h3 id="R_function_param">R_function_param <a href="#R_function_param" title="Permalink to this location">¶</a></h3>


log radius gradient

    R_function = R_function_weight*log10(1 + (r/Rsun)/R_function_param)

{% highlight fortran %}
R_function_weight = 0
R_function_param = 1d-4
{% endhighlight %}


<h3 id="R_function2_weight">R_function2_weight <a href="#R_function2_weight" title="Permalink to this location">¶</a></h3>


<h3 id="R_function2_param1">R_function2_param1 <a href="#R_function2_param1" title="Permalink to this location">¶</a></h3>


<h3 id="R_function2_param2">R_function2_param2 <a href="#R_function2_param2" title="Permalink to this location">¶</a></h3>


    R_function2 = R_function2_weight*min(R_function2_param1,max(R_function2_param2,r/Rstar))

where Rstar = radius of outer edge of model.

{% highlight fortran %}
R_function2_weight = 0
R_function2_param1 = 0.4d0
R_function2_param2 = 0
{% endhighlight %}


<h3 id="R_function3_weight">R_function3_weight <a href="#R_function3_weight" title="Permalink to this location">¶</a></h3>


radius gradient

    R_function3 = R_function3_weight*(r/Rstar)

{% highlight fortran %}
R_function3_weight = 0
{% endhighlight %}


<h3 id="M_function_weight">M_function_weight <a href="#M_function_weight" title="Permalink to this location">¶</a></h3>


<h3 id="M_function_param">M_function_param <a href="#M_function_param" title="Permalink to this location">¶</a></h3>


log mass gradient

    M_function = M_function_weight*log10(1 + (m/Msun)/M_function_param)

{% highlight fortran %}
M_function_weight = 0
M_function_param = 1d-6
{% endhighlight %}


<h3 id="gradT_function_weight">gradT_function_weight <a href="#gradT_function_weight" title="Permalink to this location">¶</a></h3>


gradT gradient, `gradT_function = gradT_function_weight*gradT`

{% highlight fortran %}
gradT_function_weight = 0
{% endhighlight %}


<h3 id="log_tau_function_weight">log_tau_function_weight <a href="#log_tau_function_weight" title="Permalink to this location">¶</a></h3>


log_tau gradient (optical depth)

    log_tau_function = log_tau_function_weight*log10(tau)

{% highlight fortran %}
log_tau_function_weight = 0
{% endhighlight %}


<h3 id="log_kap_function_weight">log_kap_function_weight <a href="#log_kap_function_weight" title="Permalink to this location">¶</a></h3>


log_kap gradient (optical depth)

    log_kap_function = log_kap_function_weight*log10(kap)

{% highlight fortran %}
log_kap_function_weight = 0
{% endhighlight %}


<h3 id="omega_function_weight">omega_function_weight <a href="#omega_function_weight" title="Permalink to this location">¶</a></h3>


omega gradient (rotation omega in rad/sec)

    omega_function = omega_function_weight*log10(omega)

{% highlight fortran %}
omega_function_weight = 0
{% endhighlight %}


<h3 id="gam_function_weight">gam_function_weight <a href="#gam_function_weight" title="Permalink to this location">¶</a></h3>


<h3 id="gam_function_param1">gam_function_param1 <a href="#gam_function_param1" title="Permalink to this location">¶</a></h3>


<h3 id="gam_function_param2">gam_function_param2 <a href="#gam_function_param2" title="Permalink to this location">¶</a></h3>


For extra resolution around liquid/solid transition.

    gam = plasma interaction parameter
    gam_function = gam_function_weight*tanh((gam - gam_function_param1)/gam_function_param2)

{% highlight fortran %}
gam_function_weight = 0
gam_function_param1 = 170
gam_function_param2 = 20
{% endhighlight %}


<h3 id="xa_function_species">xa_function_species <a href="#xa_function_species" title="Permalink to this location">¶</a></h3>


<h3 id="xa_function_weight">xa_function_weight <a href="#xa_function_weight" title="Permalink to this location">¶</a></h3>


Mass fraction gradients.

    xa_function = xa_function_weight*log10(xa + xa_function_param),

Up to `num_xa_function` of these - see `star_def` for value of `num_xa_function`.
0 length string means skip, otherwise name of nuclide as defined in `chem_def`.
weight <= 0 means skip.

{% highlight fortran %}
xa_function_species(:) = ''
xa_function_weight(:) = 0
{% endhighlight %}


{% highlight fortran %}
xa_function_species(1) = 'he4'
xa_function_weight(1) = 30
xa_function_param(1) = 1d-2
{% endhighlight %}


<h3 id="xa_mesh_delta_coeff">xa_mesh_delta_coeff <a href="#xa_mesh_delta_coeff" title="Permalink to this location">¶</a></h3>


Useful if you want to increase `mesh_delta_coeff` during advanced burning.
If `xa_function_species(j)` has the largest atomic number in current set of species,
then multiply `mesh_delta_coeff` by `xa_mesh_delta_coeff(j)`.

{% highlight fortran %}
xa_mesh_delta_coeff(:) = 1
{% endhighlight %}


"Indirect" mesh controls work by increasing sensitivity in selected regions.
They work in the same way as `mesh_delta_coeff` -- values less than 1.0 mean
smaller allowed jumps in mesh functions and hence smaller grid points and
higher resolution.  But whereas `mesh_delta_coeff` applies uniformly to all
cells, the "extra" coefficients can vary in value from one cell to the next.

<h3 id="xtra_coef_above_xtrans">xtra_coef_above_xtrans <a href="#xtra_coef_above_xtrans" title="Permalink to this location">¶</a></h3>


<h3 id="xtra_coef_below_xtrans">xtra_coef_below_xtrans <a href="#xtra_coef_below_xtrans" title="Permalink to this location">¶</a></h3>


Multiply `mesh_delta_coeff` near any change in most abundant species by this factor.
Value < 1 gives increased resolution.

{% highlight fortran %}
xtra_coef_above_xtrans = 1
xtra_coef_below_xtrans = 1
{% endhighlight %}


<h3 id="xtra_dist_above_xtrans">xtra_dist_above_xtrans <a href="#xtra_dist_above_xtrans" title="Permalink to this location">¶</a></h3>


<h3 id="xtra_dist_below_xtrans">xtra_dist_below_xtrans <a href="#xtra_dist_below_xtrans" title="Permalink to this location">¶</a></h3>


Increase resolution up to this distance away from the abundance transition
with distance measured in units of the pressure scale height at the boundary.

{% highlight fortran %}
xtra_dist_above_xtrans = 0.2d0
xtra_dist_below_xtrans = 0.2d0
{% endhighlight %}


<h3 id="mesh_logX_species">mesh_logX_species <a href="#mesh_logX_species" title="Permalink to this location">¶</a></h3>


<h3 id="mesh_logX_min_for_extra">mesh_logX_min_for_extra <a href="#mesh_logX_min_for_extra" title="Permalink to this location">¶</a></h3>


Increase resolution at points with large abs(dlogX/dlogP); logX = log10(X mass fraction).

{% highlight fortran %}
mesh_logX_species(1) = ''
mesh_logX_min_for_extra(1) = -6
{% endhighlight %}


<h3 id="mesh_dlogX_dlogP_extra1">mesh_dlogX_dlogP_extra(1) <a href="#mesh_dlogX_dlogP_extra1" title="Permalink to this location">¶</a></h3>


<h3 id="mesh_dlogX_dlogP_full_on1">mesh_dlogX_dlogP_full_on(1) <a href="#mesh_dlogX_dlogP_full_on1" title="Permalink to this location">¶</a></h3>


<h3 id="mesh_dlogX_dlogP_full_off1">mesh_dlogX_dlogP_full_off(1) <a href="#mesh_dlogX_dlogP_full_off1" title="Permalink to this location">¶</a></h3>


Only increase resolution if `logX >= mesh_logX_min_for_extra`.
Make `mesh_dlogX_dlogP_extra < 1` for smaller allowed change in logP and hence higher resolution.
Full effect if `abs(dlogX/dlogP) >= mesh_dlogX_dlogP_full_on`.
No effect if `abs(dlogX/dlogP)) <= mesh_dlogX_dlogP_full_off`.
Up to `num_mesh_logX` of these (see `star_def` for value of `num_mesh_logX`).

{% highlight fortran %}
mesh_dlogX_dlogP_extra(1) = 1
mesh_dlogX_dlogP_full_on(1) = 2
mesh_dlogX_dlogP_full_off(1) = 1
{% endhighlight %}


Multiply `mesh_delta_coeff` near convection zone boundary (czb) by the following factors.
Value < 1 gives increased resolution.

<h3 id="xtra_coef_czb_full_on">xtra_coef_czb_full_on <a href="#xtra_coef_czb_full_on" title="Permalink to this location">¶</a></h3>


<h3 id="xtra_coef_czb_full_off">xtra_coef_czb_full_off <a href="#xtra_coef_czb_full_off" title="Permalink to this location">¶</a></h3>


The center mass fraction of he4 is used to control this extra coefficient.
The default settings limit the application to after center he4 is depleted.

+ if center he4 < `xtra_coef_czb_full_on`, then use xtra coef's
+ if center he4 > `xtra_coef_czb_full_off`, then don't use xtra coef's

a more verbose form of these names might be the following:

    xtra_coef_czb_full_on_if_center_he4_below_this
    xtra_coef_czb_full_off_if_center_he4_above_this

{% highlight fortran %}
xtra_coef_czb_full_on = 1d-4
xtra_coef_czb_full_off = 0.1d0
{% endhighlight %}


<h3 id="xtra_coef_above__below_lower__upper_nonburn__hburn__heburn__zburn_czb">xtra_coef_{above | below}_{lower | upper}_{nonburn | hburn | heburn | zburn}_czb <a href="#xtra_coef_above__below_lower__upper_nonburn__hburn__heburn__zburn_czb" title="Permalink to this location">¶</a></h3>


Make these < 1 to increase resolution.

<h3 id="xtra_dist_above__below_lower__upper_nonburn__hburn__heburn__zburn_czb">xtra_dist_{above | below}_{lower | upper}_{nonburn | hburn | heburn | zburn}_czb <a href="#xtra_dist_above__below_lower__upper_nonburn__hburn__heburn__zburn_czb" title="Permalink to this location">¶</a></h3>


Increase resolution up to this distance away from the convective zone boundary,
with distance measured in units of the pressure scale height at the boundary.

{% highlight fortran %}
xtra_coef_a_l_nb_czb = 1
xtra_dist_a_l_nb_czb = 0.2d0
xtra_coef_b_l_nb_czb = 1
xtra_dist_b_l_nb_czb = 0.2d0
{% endhighlight %}


{% highlight fortran %}
xtra_coef_a_u_nb_czb = 1
xtra_dist_a_u_nb_czb = 0.2d0
xtra_coef_b_u_nb_czb = 1
xtra_dist_b_u_nb_czb = 0.2d0
{% endhighlight %}


{% highlight fortran %}
xtra_coef_a_l_hb_czb = 1
xtra_dist_a_l_hb_czb = 0.2d0
xtra_coef_b_l_hb_czb = 1
xtra_dist_b_l_hb_czb = 0.2d0
{% endhighlight %}


{% highlight fortran %}
xtra_coef_a_u_hb_czb = 1
xtra_dist_a_u_hb_czb = 0.2d0
xtra_coef_b_u_hb_czb = 1
xtra_dist_b_u_hb_czb = 0.2d0
{% endhighlight %}


{% highlight fortran %}
xtra_coef_a_l_heb_czb = 1
xtra_dist_a_l_heb_czb = 0.2d0
xtra_coef_b_l_heb_czb = 1
xtra_dist_b_l_heb_czb = 0.2d0
{% endhighlight %}


{% highlight fortran %}
xtra_coef_a_u_heb_czb = 1
xtra_dist_a_u_heb_czb = 0.2d0
xtra_coef_b_u_heb_czb = 1
xtra_dist_b_u_heb_czb = 0.2d0
{% endhighlight %}


{% highlight fortran %}
xtra_coef_a_l_zb_czb = 1
xtra_dist_a_l_zb_czb = 0.2d0
xtra_coef_b_l_zb_czb = 1
xtra_dist_b_l_zb_czb = 0.2d0
{% endhighlight %}


{% highlight fortran %}
xtra_coef_a_u_zb_czb = 1
xtra_dist_a_u_zb_czb = 0.2d0
xtra_coef_b_u_zb_czb = 1
xtra_dist_b_u_zb_czb = 0.2d0
{% endhighlight %}


<h3 id="xtra_coef_scz_above_nonburn__hburn__heburn__zburn_cz">xtra_coef_scz_above_{nonburn | hburn | heburn | zburn}_cz <a href="#xtra_coef_scz_above_nonburn__hburn__heburn__zburn_cz" title="Permalink to this location">¶</a></h3>


Make these < 1 to increase resolution in semiconvective region adjacent to convective region.
e.g., `xtra_coef_scz_above_nb_cz` is extra coef for semiconvectize zone above a non-burn convective zone.

{% highlight fortran %}
xtra_coef_scz_above_nb_cz = 1
xtra_coef_scz_above_hb_cz = 1
xtra_coef_scz_above_heb_cz = 1
xtra_coef_scz_above_zb_cz = 1
{% endhighlight %}


Multiply `mesh_delta_coeff` in overshooting regions by the following factors.
Value < 1 gives increased resolution.

<h3 id="xtra_coef_os_full_on">xtra_coef_os_full_on <a href="#xtra_coef_os_full_on" title="Permalink to this location">¶</a></h3>


<h3 id="xtra_coef_os_full_off">xtra_coef_os_full_off <a href="#xtra_coef_os_full_off" title="Permalink to this location">¶</a></h3>


The center mass fraction of he4 is used to control this extra coefficient.
The default settings limit the application to after center he4 is depleted.

+ if center he4 < `xtra_coef_os_full_on`, then use `xtra_coef` coef's
+ if center he4 > `xtra_coef_os_full_off`, then don't use `xtra_coef` coef's

{% highlight fortran %}
xtra_coef_os_full_on = 1d-4
xtra_coef_os_full_off = 0.1d0
{% endhighlight %}


<h3 id="xtra_coef_os_above__below_nonburn__hburn__heburn__zburn">xtra_coef_os_{above | below}_{nonburn | hburn | heburn | zburn} <a href="#xtra_coef_os_above__below_nonburn__hburn__heburn__zburn" title="Permalink to this location">¶</a></h3>


Make these < 1 to increase resolution.

{% highlight fortran %}
xtra_coef_os_above_nonburn = 1
xtra_coef_os_below_nonburn = 1
xtra_coef_os_above_burn_h = 1
xtra_coef_os_below_burn_h = 1
xtra_coef_os_above_burn_he = 1
xtra_coef_os_below_burn_he = 1
xtra_coef_os_above_burn_z = 1
xtra_coef_os_below_burn_z = 1
{% endhighlight %}


<h3 id="xtra_dist_os_above__below_nonburn__hburn__heburn__zburn">xtra_dist_os_{above | below}_{nonburn | hburn | heburn | zburn} <a href="#xtra_dist_os_above__below_nonburn__hburn__heburn__zburn" title="Permalink to this location">¶</a></h3>


Continue to increase resolution for this distance beyond
the edge of the overshooting region, with distance measured in units
of the pressure scale height at the edge of the overshooting region.
This applies to both edges of the overshooting region.

{% highlight fortran %}
xtra_dist_os_above_nonburn = 0.2d0
xtra_dist_os_below_nonburn = 0.2d0
xtra_dist_os_above_burn_h = 0.2d0
xtra_dist_os_below_burn_h = 0.2d0
xtra_dist_os_above_burn_he = 0.2d0
xtra_dist_os_below_burn_he = 0.2d0
xtra_dist_os_above_burn_z = 0.2d0
xtra_dist_os_below_burn_z = 0.2d0
{% endhighlight %}


Increase resolution at points with large `abs(dlog_eps/dlogP)` for nuclear power eps (ergs/g/sec).
At any particular location, only use eps nuc category with max local value
e.g., only use `mesh_dlog_pp_dlogP_extra` at points where pp is the max burn source.

<h3 id="mesh_dlog_eps_min_for_extra">mesh_dlog_eps_min_for_extra <a href="#mesh_dlog_eps_min_for_extra" title="Permalink to this location">¶</a></h3>


Only increase resolution if `log_eps >= mesh_dlog_eps_min_for_extra`.

{% highlight fortran %}
mesh_dlog_eps_min_for_extra = -2
{% endhighlight %}


<h3 id="mesh_dlog_eps_dlogP_full_on">mesh_dlog_eps_dlogP_full_on <a href="#mesh_dlog_eps_dlogP_full_on" title="Permalink to this location">¶</a></h3>


Full effect if `abs(dlog_eps/dlogP) >= mesh_dlog_eps_dlogP_full_on`.

{% highlight fortran %}
mesh_dlog_eps_dlogP_full_on = 4
{% endhighlight %}


<h3 id="mesh_dlog_eps_dlogP_full_off">mesh_dlog_eps_dlogP_full_off <a href="#mesh_dlog_eps_dlogP_full_off" title="Permalink to this location">¶</a></h3>


No effect if `abs(dlog_eps/dlogP)) <= mesh_dlog_eps_dlogP_full_off`.

{% highlight fortran %}
mesh_dlog_eps_dlogP_full_off = 1
{% endhighlight %}


Multiply the allowed change between adjacent cells by the following factors;
(small factor => smaller allowed change => more cells).

pp and cno burning

{% highlight fortran %}
mesh_dlog_pp_dlogP_extra = 0.25d0
mesh_dlog_cno_dlogP_extra = 0.25d0
{% endhighlight %}


triple alpha, c, n, and o burning

{% highlight fortran %}
mesh_dlog_3alf_dlogP_extra = 0.25d0
mesh_dlog_burn_c_dlogP_extra = 0.25d0
mesh_dlog_burn_n_dlogP_extra = 0.25d0
mesh_dlog_burn_o_dlogP_extra = 0.25d0
{% endhighlight %}


ne, na, and mg burning

{% highlight fortran %}
mesh_dlog_burn_ne_dlogP_extra = 0.25d0
mesh_dlog_burn_na_dlogP_extra = 0.25d0
mesh_dlog_burn_mg_dlogP_extra = 0.25d0
{% endhighlight %}


c12+c12. c12+o16, and o16+o16 burning

{% highlight fortran %}
mesh_dlog_cc_dlogP_extra = 0.25d0
mesh_dlog_co_dlogP_extra = 0.25d0
mesh_dlog_oo_dlogP_extra = 0.25d0
{% endhighlight %}


si to iron alog alpha chain burning

{% highlight fortran %}
mesh_dlog_burn_si_dlogP_extra = 0.25d0
mesh_dlog_burn_s_dlogP_extra = 0.25d0
mesh_dlog_burn_ar_dlogP_extra = 0.25d0
mesh_dlog_burn_ca_dlogP_extra = 0.25d0
mesh_dlog_burn_ti_dlogP_extra = 0.25d0
mesh_dlog_burn_cr_dlogP_extra = 0.25d0
mesh_dlog_burn_fe_dlogP_extra = 0.25d0
{% endhighlight %}


photodisintegration burning

{% highlight fortran %}
mesh_dlog_pnhe4_dlogP_extra = 0.25d0
mesh_dlog_other_dlogP_extra = 0.25d0
mesh_dlog_photo_dlogP_extra = 1
{% endhighlight %}


<h3 id="convective_bdy_weight">convective_bdy_weight <a href="#convective_bdy_weight" title="Permalink to this location">¶</a></h3>


<h3 id="convective_bdy_dq_limit">convective_bdy_dq_limit <a href="#convective_bdy_dq_limit" title="Permalink to this location">¶</a></h3>


<h3 id="convective_bdy_min_dt_yrs">convective_bdy_min_dt_yrs <a href="#convective_bdy_min_dt_yrs" title="Permalink to this location">¶</a></h3>


Mesh function to enhance resolution near convective boundaries
including regions that are newly nonconvective because of moving boundary.
EXPERIMENTAL

{% highlight fortran %}
convective_bdy_weight = 0
convective_bdy_dq_limit = 1d-4
convective_bdy_min_dt_yrs = 1d-3
{% endhighlight %}


<h3 id="max_rel_delta_IE_for_mesh_total_energy_balance">max_rel_delta_IE_for_mesh_total_energy_balance <a href="#max_rel_delta_IE_for_mesh_total_energy_balance" title="Permalink to this location">¶</a></h3>


remeshing can adjust internal energy of cell by this fraction
in order to maintain total internal + potential + kinetic energy.

{% highlight fortran %}
max_rel_delta_IE_for_mesh_total_energy_balance = 0.05d0
{% endhighlight %}


<h3 id="trace_mesh_adjust_error_in_conservation">trace_mesh_adjust_error_in_conservation <a href="#trace_mesh_adjust_error_in_conservation" title="Permalink to this location">¶</a></h3>


If true, report relative errors for total PE, KE, and IE.
(potential, kinetic, internal).

{% highlight fortran %}
trace_mesh_adjust_error_in_conservation = .false.
{% endhighlight %}


<h3 id="okay_to_remesh">okay_to_remesh <a href="#okay_to_remesh" title="Permalink to this location">¶</a></h3>


If false, then no remeshing.

{% highlight fortran %}
okay_to_remesh = .true.
{% endhighlight %}


<h3 id="remesh_dt_limit">remesh_dt_limit <a href="#remesh_dt_limit" title="Permalink to this location">¶</a></h3>


No remesh if `dt < remesh_dt_limit`, in seconds.

{% highlight fortran %}
remesh_dt_limit = -1
{% endhighlight %}


<h3 id="remesh_log_L_nuc_burn_min">remesh_log_L_nuc_burn_min <a href="#remesh_log_L_nuc_burn_min" title="Permalink to this location">¶</a></h3>


No mesh adjustments when `log10(L_nuc_burn_total)` is less than this.
By default, this turns off mesh changes during the early pre-MS.

{% highlight fortran %}
remesh_log_L_nuc_burn_min = -50
{% endhighlight %}


<h3 id="use_split_merge_amr">use_split_merge_amr <a href="#use_split_merge_amr" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
use_split_merge_amr = .false.
{% endhighlight %}


<h3 id="split_merge_amr_logtau_zoning">split_merge_amr_logtau_zoning <a href="#split_merge_amr_logtau_zoning" title="Permalink to this location">¶</a></h3>


<h3 id="split_merge_amr_log_zoning">split_merge_amr_log_zoning <a href="#split_merge_amr_log_zoning" title="Permalink to this location">¶</a></h3>


if split_merge_amr_logtau_zoning, target is even grid spacing in logtau
else if split_merge_amr_log_zoning, target is even grid spacing in logr
else target is even grid spacing in r

{% highlight fortran %}
split_merge_amr_logtau_zoning = .false.
split_merge_amr_log_zoning = .true.
{% endhighlight %}


<h3 id="split_merge_amr_nz_baseline">split_merge_amr_nz_baseline <a href="#split_merge_amr_nz_baseline" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
split_merge_amr_nz_baseline = 1000
{% endhighlight %}


<h3 id="split_merge_amr_MaxLong">split_merge_amr_MaxLong <a href="#split_merge_amr_MaxLong" title="Permalink to this location">¶</a></h3>


split cell if ratio of actual/desired size is > this; ignore if <= 0

{% highlight fortran %}
split_merge_amr_MaxLong = 1.5d0
{% endhighlight %}


<h3 id="split_merge_amr_MaxLong">split_merge_amr_MaxLong <a href="#split_merge_amr_MaxLong" title="Permalink to this location">¶</a></h3>


merge cell if ratio of desired/actual size is > this; ignore if <= 0

{% highlight fortran %}
split_merge_amr_MaxShort = 1.5d0
{% endhighlight %}


<h3 id="merge_amr_max_abs_du_div_cs">merge_amr_max_abs_du_div_cs <a href="#merge_amr_max_abs_du_div_cs" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
merge_amr_max_abs_du_div_cs = 0.1d0
{% endhighlight %}


<h3 id="merge_amr_inhibit_at_jumps">merge_amr_inhibit_at_jumps <a href="#merge_amr_inhibit_at_jumps" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
merge_amr_inhibit_at_jumps = .false.
{% endhighlight %}


<h3 id="split_merge_amr_dq_min">split_merge_amr_dq_min <a href="#split_merge_amr_dq_min" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
split_merge_amr_dq_min = 1d-14
{% endhighlight %}


<h3 id="split_merge_amr_max_iters">split_merge_amr_max_iters <a href="#split_merge_amr_max_iters" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
split_merge_amr_max_iters = 100
{% endhighlight %}


<h3 id="split_merge_amr_okay_to_split_1">split_merge_amr_okay_to_split_1 <a href="#split_merge_amr_okay_to_split_1" title="Permalink to this location">¶</a></h3>


<h3 id="split_merge_amr_okay_to_split_nz">split_merge_amr_okay_to_split_nz <a href="#split_merge_amr_okay_to_split_nz" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
split_merge_amr_okay_to_split_1 = .true.
split_merge_amr_okay_to_split_nz = .true.
{% endhighlight %}


<h3 id="equal_split_density_amr">equal_split_density_amr <a href="#equal_split_density_amr" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
equal_split_density_amr = .false.
{% endhighlight %}


<h3 id="trace_split_merge_amr">trace_split_merge_amr <a href="#trace_split_merge_amr" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
trace_split_merge_amr = .false.
{% endhighlight %}

<h1 id="nuclear_reaction_controls">nuclear reaction controls <a href="#nuclear_reaction_controls" title="Permalink to this location">¶</a></h1>


<h3 id="default_net_name">default_net_name <a href="#default_net_name" title="Permalink to this location">¶</a></h3>


Name of base reaction network.
Each net corresponds to a file in `$MESA_DIR/data/net_data/nets`.
Look in that directory to see your network options,
or learn how to create your own net.

{% highlight fortran %}
default_net_name = 'basic.net'
{% endhighlight %}


<h3 id="screening_mode">screening_mode <a href="#screening_mode" title="Permalink to this location">¶</a></h3>


+ empty string means no screening
+ `'classic'` :
DeWitt, Graboske, Cooper, "Screening Factors for Nuclear Reactions.
   I. General Theory", ApJ, 181:439-456, 1973.
Graboske, DeWitt, Grossman, Cooper, "Screening Factors for Nuclear Reactions.
   II. Intermediate Screening and Astrophysical Applications", ApJ, 181:457-474, 1973.
+ `' extended'` :
extends the Graboske method using results from Alastuey and Jancovici (1978),
along with plasma parameters from Itoh et al (1979) for strong screening.
+ `'salpeter'` :
weak screening only.  following Salpeter (1954),
with equations (4-215) and (4-221) of Clayton (1968).
+ `'chugunov'` :
based on code from Sam Jones
Implements screening from Chugunov et al (2007) for weak and strong screening
MESA versions <=11435 used extended as the default value

{% highlight fortran %}
screening_mode = 'chugunov'
{% endhighlight %}


<h3 id="net_logTcut_lo">net_logTcut_lo <a href="#net_logTcut_lo" title="Permalink to this location">¶</a></h3>


strong rates are zero `logT < logTcut_lo`
use default from net if this is <= 0

{% highlight fortran %}
net_logTcut_lo = -1
{% endhighlight %}


<h3 id="net_logTcut_lim">net_logTcut_lim <a href="#net_logTcut_lim" title="Permalink to this location">¶</a></h3>


strong rates cutoff smoothly for `logT < logTcut_lim`
use default from net if this is <= 0

{% highlight fortran %}
net_logTcut_lim = -1
{% endhighlight %}


<h3 id="max_abar_for_burning">max_abar_for_burning <a href="#max_abar_for_burning" title="Permalink to this location">¶</a></h3>


if abar > this, suppress all burning
e.g., if want an "inert" core heavy elements, set this to 55
or, if want to turn off the net, set this to -1

{% highlight fortran %}
max_abar_for_burning = 199
{% endhighlight %}


<h3 id="dxdt_nuc_factor">dxdt_nuc_factor <a href="#dxdt_nuc_factor" title="Permalink to this location">¶</a></h3>


Control for abundance changes by burning.
Changes `dxdt_nuc` (rate of change of abundances)
without changing the rates or `eps_nuc` (rate of energy generation).

{% highlight fortran %}
dxdt_nuc_factor = 1
{% endhighlight %}


<h3 id="weak_rate_factor">weak_rate_factor <a href="#weak_rate_factor" title="Permalink to this location">¶</a></h3>


all weak rates are multiplied by this factor

{% highlight fortran %}
weak_rate_factor = 1
{% endhighlight %}


<h3 id="reaction_neuQs_factor">reaction_neuQs_factor <a href="#reaction_neuQs_factor" title="Permalink to this location">¶</a></h3>


all neutrino Q factors are multiplied by this factor

{% highlight fortran %}
reaction_neuQs_factor = 1
{% endhighlight %}


<h3 id="nonlocal_NiCo_kap_gamma">nonlocal_NiCo_kap_gamma <a href="#nonlocal_NiCo_kap_gamma" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
nonlocal_NiCo_kap_gamma = 0
{% endhighlight %}


<h3 id="nonlocal_NiCo_decay_heat">nonlocal_NiCo_decay_heat <a href="#nonlocal_NiCo_decay_heat" title="Permalink to this location">¶</a></h3>


if true, do non-local deposition of gamma-ray energy from Ni56 and Co56 decays.
only for approx nets including co56.
intended for use with stripped envelope supernovae.

{% highlight fortran %}
nonlocal_NiCo_decay_heat = .false.
{% endhighlight %}


<h3 id="dtau_gamma_NiCo_decay_heat">dtau_gamma_NiCo_decay_heat <a href="#dtau_gamma_NiCo_decay_heat" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
dtau_gamma_NiCo_decay_heat = 1d0
{% endhighlight %}


<h3 id="max_logT_for_net">max_logT_for_net <a href="#max_logT_for_net" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
max_logT_for_net = 10.2d0
{% endhighlight %}

<h1 id="element_diffusion">element diffusion <a href="#element_diffusion" title="Permalink to this location">¶</a></h1>


gravitational settling and chemical diffusion.

<h3 id="show_diffusion_info">show_diffusion_info <a href="#show_diffusion_info" title="Permalink to this location">¶</a></h3>


terminal output for diffusion

{% highlight fortran %}
show_diffusion_info = .false.
{% endhighlight %}


<h3 id="show_diffusion_substep_info">show_diffusion_substep_info <a href="#show_diffusion_substep_info" title="Permalink to this location">¶</a></h3>


terminal output for diffusion

{% highlight fortran %}
show_diffusion_substep_info = .false.
{% endhighlight %}


<h3 id="show_diffusion_timing">show_diffusion_timing <a href="#show_diffusion_timing" title="Permalink to this location">¶</a></h3>


show time for each call on diffusion

{% highlight fortran %}
show_diffusion_timing = .false.
{% endhighlight %}


<h3 id="do_element_diffusion">do_element_diffusion <a href="#do_element_diffusion" title="Permalink to this location">¶</a></h3>


determines whether or not we do element diffusion

{% highlight fortran %}
do_element_diffusion = .false.
{% endhighlight %}


<h3 id="diffusion_dt_limit">diffusion_dt_limit <a href="#diffusion_dt_limit" title="Permalink to this location">¶</a></h3>


no element diffusion if dt < this limit (in seconds)

{% highlight fortran %}
diffusion_dt_limit = 3.15d7
{% endhighlight %}


<h3 id="diffusion_use_paquette">diffusion_use_paquette <a href="#diffusion_use_paquette" title="Permalink to this location">¶</a></h3>


if true, use atomic diffusion coefficients according to Paquette et al. (1986).
if false, use Stanton & Murillo (2016) for diffusion coefficients.
(Paquette coefficients still used for electron-ion because Stanton & Murillo
did not do calculations for attractive potentials.)

{% highlight fortran %}
diffusion_use_paquette = .false.
{% endhighlight %}


<h3 id="diffusion_use_iben_macdonald">diffusion_use_iben_macdonald <a href="#diffusion_use_iben_macdonald" title="Permalink to this location">¶</a></h3>


if true, use diffusion coefficients similar to Iben & MacDonald (1985).
if false, use Stanton & Murillo (2016) for diffusion coefficients.
this was previously called `diffusion_use_pure_coulomb`.

{% highlight fortran %}
diffusion_use_iben_macdonald = .false.
{% endhighlight %}


<h3 id="diffusion_use_cgs_solver">diffusion_use_cgs_solver <a href="#diffusion_use_cgs_solver" title="Permalink to this location">¶</a></h3>


if false, solve the system of equations descibed by Thoul et al. (1994)
if true, solve the unmodified Burgers equations in cgs units

{% highlight fortran %}
diffusion_use_cgs_solver = .true.
{% endhighlight %}


<h3 id="cgs_thermal_diffusion_eta_full_on">cgs_thermal_diffusion_eta_full_on <a href="#cgs_thermal_diffusion_eta_full_on" title="Permalink to this location">¶</a></h3>


<h3 id="cgs_thermal_diffusion_eta_full_off">cgs_thermal_diffusion_eta_full_off <a href="#cgs_thermal_diffusion_eta_full_off" title="Permalink to this location">¶</a></h3>


When `diffusion_use_cgs_solver = .true.`
for `eta < cgs_thermal_diffusion_eta_full_on`,
includes the heat flow vector terms in the Burgers equations.
Then smoothly turns off use of these terms so that they are not included
for `eta > cgs_thermal_diffusion_eta_full_off`, since these terms are
problematic when distribution function become non-Maxwellian.

{% highlight fortran %}
cgs_thermal_diffusion_eta_full_on = 0d0
cgs_thermal_diffusion_eta_full_off = 2d0
{% endhighlight %}


<h3 id="do_Ne22_sedimentation_heating">do_Ne22_sedimentation_heating <a href="#do_Ne22_sedimentation_heating" title="Permalink to this location">¶</a></h3>


if true, include heating from sedimentation of Ne22 when element diffusion is on.
Your net must include Ne22 for this to work.
For best results, Ne22 should be treated as its own diffusion class.
This will affect white dwarf cooling times.
See also `eps_Ne22_sedimentation_factor`

{% highlight fortran %}
do_Ne22_sedimentation_heating = .false.
{% endhighlight %}


<h3 id="diffusion_min_dq_at_surface">diffusion_min_dq_at_surface <a href="#diffusion_min_dq_at_surface" title="Permalink to this location">¶</a></h3>


treat at least this much at surface as a single cell for purposes of diffusion

{% highlight fortran %}
diffusion_min_dq_at_surface = 1d-9
{% endhighlight %}


<h3 id="diffusion_min_T_at_surface">diffusion_min_T_at_surface <a href="#diffusion_min_T_at_surface" title="Permalink to this location">¶</a></h3>


treat cells cells at surface with T < this as a single cell for purposes of diffusion
default should be large enough to ensure hydrogen ionization

{% highlight fortran %}
diffusion_min_T_at_surface = 1d4
{% endhighlight %}


<h3 id="diffusion_min_dq_ratio_at_surface">diffusion_min_dq_ratio_at_surface <a href="#diffusion_min_dq_ratio_at_surface" title="Permalink to this location">¶</a></h3>


combine cells at surface until have total mass >= this factor times the next cell below them
this helps with surface boundary condition for diffusion by putting large cell at surface

{% highlight fortran %}
diffusion_min_dq_ratio_at_surface = 10
{% endhighlight %}


<h3 id="diffusion_dt_div_timescale">diffusion_dt_div_timescale <a href="#diffusion_dt_div_timescale" title="Permalink to this location">¶</a></h3>


dt is at most this fraction of timescale.
Each stellar evolution step can be divided into many substeps for diffusion.
The substep timescale is set by rates of flow in and out for each species in each cell.
The substep size, dt, is initially set to `timescale*diffusion_dt_div_timescale`.

{% highlight fortran %}
diffusion_dt_div_timescale = 1
{% endhighlight %}


<h3 id="diffusion_min_num_substeps">diffusion_min_num_substeps <a href="#diffusion_min_num_substeps" title="Permalink to this location">¶</a></h3>


Max substep dt is total time divided by this.

{% highlight fortran %}
diffusion_min_num_substeps = 1
{% endhighlight %}


<h3 id="diffusion_max_iters_per_substep">diffusion_max_iters_per_substep <a href="#diffusion_max_iters_per_substep" title="Permalink to this location">¶</a></h3>


If the substep requires too many iterations, the substep time is decreased for a retry.

{% highlight fortran %}
diffusion_max_iters_per_substep = 10
{% endhighlight %}


<h3 id="diffusion_max_retries_per_substep">diffusion_max_retries_per_substep <a href="#diffusion_max_retries_per_substep" title="Permalink to this location">¶</a></h3>


If the substep requires too many retries, diffusion fails and forces a retry for the star.

{% highlight fortran %}
diffusion_max_retries_per_substep = 10
{% endhighlight %}


<h3 id="diffusion_tol_correction_max">diffusion_tol_correction_max <a href="#diffusion_tol_correction_max" title="Permalink to this location">¶</a></h3>


<h3 id="diffusion_tol_correction_norm">diffusion_tol_correction_norm <a href="#diffusion_tol_correction_norm" title="Permalink to this location">¶</a></h3>


Tolerances for newton iterations.
Corrections smaller will be treated as converged.
Corrections larger will cause another newton iteration.

{% highlight fortran %}
diffusion_tol_correction_max = 1d-1
diffusion_tol_correction_norm = 1d-3
{% endhighlight %}


<h3 id="diffusion_min_X_hard_limit">diffusion_min_X_hard_limit <a href="#diffusion_min_X_hard_limit" title="Permalink to this location">¶</a></h3>


tolerance for negative mass fraction errors
errors larger will cause retry; errors smaller will be corrected.

{% highlight fortran %}
diffusion_min_X_hard_limit = -1d-3
{% endhighlight %}


<h3 id="diffusion_X_total_atol">diffusion_X_total_atol <a href="#diffusion_X_total_atol" title="Permalink to this location">¶</a></h3>


<h3 id="diffusion_X_total_rtol">diffusion_X_total_rtol <a href="#diffusion_X_total_rtol" title="Permalink to this location">¶</a></h3>


tolerances for errors in total species conservation
errors larger will cause retry; errors smaller will be corrected.

{% highlight fortran %}
diffusion_X_total_atol = 1d-9
diffusion_X_total_rtol = 1d-6
{% endhighlight %}


<h3 id="diffusion_upwind_abs_v_limit">diffusion_upwind_abs_v_limit <a href="#diffusion_upwind_abs_v_limit" title="Permalink to this location">¶</a></h3>


switch to upwind for i at face k if abs(v(i,k)) > this limit
mainly for use with radiative levitation where get very much higher velocities

{% highlight fortran %}
diffusion_upwind_abs_v_limit = 1d99
{% endhighlight %}


<h3 id="diffusion_v_max">diffusion_v_max <a href="#diffusion_v_max" title="Permalink to this location">¶</a></h3>


Max velocity (cm/sec).
We can get extremely large velocities in the extreme outer envelope
that cause problems numerically without really effecting the results,
so we allow a max for the velocities that should help the numerics
without changing the results.
Note: change `diffusion_v_max` to at least 1d-2 when using radiative levitation.

{% highlight fortran %}
diffusion_v_max = 1d-3
{% endhighlight %}


<h3 id="D_mix_ignore_diffusion">D_mix_ignore_diffusion <a href="#D_mix_ignore_diffusion" title="Permalink to this location">¶</a></h3>


Diffusion is turned off in core and surface convection zones,
since it is overwhelmed by other mixing there.
D_mix_ignore_diffusion roughly defines the mixing coefficient
below which diffusion is included again. The code finds the
location where D_mix falls to this value, backs up some,
and turns on diffusion from there onward.

{% highlight fortran %}
D_mix_ignore_diffusion = 1d5
{% endhighlight %}


<h3 id="diffusion_gamma_full_off">diffusion_gamma_full_off <a href="#diffusion_gamma_full_off" title="Permalink to this location">¶</a></h3>


<h3 id="diffusion_gamma_full_on">diffusion_gamma_full_on <a href="#diffusion_gamma_full_on" title="Permalink to this location">¶</a></h3>


`gamma_full_on <= gamma_full_off`
Shut off diffusion for large gamma (i.e. for `gamma >= gamma_full_off`).
Gradually decrease diffusion as gamma increases from `full_on` to `full_off`.
Allow normal diffusion for `gamma <= gamma_full_on`.
Default is diffusion off when get well into liquid regime.

{% highlight fortran %}
diffusion_gamma_full_off = 175
diffusion_gamma_full_on = 150
{% endhighlight %}


<h3 id="diffusion_T_full_on">diffusion_T_full_on <a href="#diffusion_T_full_on" title="Permalink to this location">¶</a></h3>


<h3 id="diffusion_T_full_off">diffusion_T_full_off <a href="#diffusion_T_full_off" title="Permalink to this location">¶</a></h3>


`T_full_on >= T_full_off`
Shut off diffusion for small T (i.e., for `T <= T_full_off`)
Gradually decrease diffusion as T decreases from `T_full_on` to `T_full_off`.
Allow normal diffusion for `T >= T_full_on`.

{% highlight fortran %}
diffusion_T_full_on = 1d3
diffusion_T_full_off = 1d3
{% endhighlight %}


<h3 id="diffusion_calculates_ionization">diffusion_calculates_ionization <a href="#diffusion_calculates_ionization" title="Permalink to this location">¶</a></h3>


If `diffusion_calculates_ionization` is false, MESA uses
typical charges for a set of representative species as
defined in `diffusion_class_typical_charge` and
`diffusion_class_representative` for all points rather than
calculating the ionization from the local conditions.

{% highlight fortran %}
diffusion_calculates_ionization = .true.
{% endhighlight %}


<h3 id="diffusion_nsmooth_typical_charge">diffusion_nsmooth_typical_charge <a href="#diffusion_nsmooth_typical_charge" title="Permalink to this location">¶</a></h3>


smoothing over charge

{% highlight fortran %}
diffusion_nsmooth_typical_charge = 10
{% endhighlight %}


<h3 id="diffusion_SIG_factor">diffusion_SIG_factor <a href="#diffusion_SIG_factor" title="Permalink to this location">¶</a></h3>


<h3 id="diffusion_GT_factor">diffusion_GT_factor <a href="#diffusion_GT_factor" title="Permalink to this location">¶</a></h3>


factors for playing with SIG and GT terms for concentration diffusion and advection

{% highlight fortran %}
diffusion_SIG_factor = 1d0
diffusion_GT_factor = 1d0
{% endhighlight %}


<h3 id="diffusion_AD_dm_full_on">diffusion_AD_dm_full_on <a href="#diffusion_AD_dm_full_on" title="Permalink to this location">¶</a></h3>


<h3 id="diffusion_AD_dm_full_off">diffusion_AD_dm_full_off <a href="#diffusion_AD_dm_full_off" title="Permalink to this location">¶</a></h3>


<h3 id="diffusion_AD_boost_factor">diffusion_AD_boost_factor <a href="#diffusion_AD_boost_factor" title="Permalink to this location">¶</a></h3>


artificial concentration diffusion near surface (mainly for radiative levitation)
Msun units for `full_on` and `full_off`
boost only used if > 0

{% highlight fortran %}
diffusion_AD_dm_full_on = -1
diffusion_AD_dm_full_off = -1
diffusion_AD_boost_factor = 0
{% endhighlight %}


<h3 id="diffusion_Vlimit_dm_full_on">diffusion_Vlimit_dm_full_on <a href="#diffusion_Vlimit_dm_full_on" title="Permalink to this location">¶</a></h3>


<h3 id="diffusion_Vlimit_dm_full_off">diffusion_Vlimit_dm_full_off <a href="#diffusion_Vlimit_dm_full_off" title="Permalink to this location">¶</a></h3>


in Msun units
artificial velocity limitation near surface (mainly for radiative levitation)

{% highlight fortran %}
diffusion_Vlimit_dm_full_on = -1
diffusion_Vlimit_dm_full_off = -1
{% endhighlight %}


<h3 id="diffusion_Vlimit">diffusion_Vlimit <a href="#diffusion_Vlimit" title="Permalink to this location">¶</a></h3>


In units of local cell crossing velocity (only used if > 0).
When full on, limit `abs(v) <= Vlimit*dr/dt`, cell size dr, substep time dt.

{% highlight fortran %}
diffusion_Vlimit = 0
{% endhighlight %}


<h3 id="diffusion_min_T_for_radaccel">diffusion_min_T_for_radaccel <a href="#diffusion_min_T_for_radaccel" title="Permalink to this location">¶</a></h3>


<h3 id="diffusion_max_T_for_radaccel">diffusion_max_T_for_radaccel <a href="#diffusion_max_T_for_radaccel" title="Permalink to this location">¶</a></h3>


If T between these limits, then include radiative levitation at that location.
Calculation of radiative levitation is costly, so only use it where necessary.
Note: change `diffusion_v_max` to at least 1d-2 when using radiative levitation.

Note that radiative levitation requires OP calculations
of g_rad for each class, and only 17 elements are supported
(H, He, C, N, O, Ne, Na, Mg, Al, Si, S, Ar, Ca, Cr, Mn, Fe, Ni).
If you want to include radiative levitation, your options are:
+ Define diffusion classes such that all class representatives are among the 17 elements listed above.
+ Use a net with only elements from the 17 above, and set diffusion_use_full_net = .true.

{% highlight fortran %}
diffusion_min_T_for_radaccel = 0
diffusion_max_T_for_radaccel = 0
{% endhighlight %}


<h3 id="diffusion_min_Z_for_radaccel">diffusion_min_Z_for_radaccel <a href="#diffusion_min_Z_for_radaccel" title="Permalink to this location">¶</a></h3>


<h3 id="diffusion_max_Z_for_radaccel">diffusion_max_Z_for_radaccel <a href="#diffusion_max_Z_for_radaccel" title="Permalink to this location">¶</a></h3>


If Z between these limits, then include radiative levitation for that element.
Calculation of radiative levitation is costly, so only use it where necessary.
e.g., limit to Fe and Ni by `min_Z = 26` and `max_Z = 28`

{% highlight fortran %}
diffusion_min_Z_for_radaccel = 0
diffusion_max_Z_for_radaccel = 1000
{% endhighlight %}


<h3 id="diffusion_screening_for_radaccel">diffusion_screening_for_radaccel <a href="#diffusion_screening_for_radaccel" title="Permalink to this location">¶</a></h3>


Include screening for radiative levitation.

{% highlight fortran %}
diffusion_screening_for_radaccel = .true.
{% endhighlight %}


<h3 id="diffusion_use_full_net">diffusion_use_full_net <a href="#diffusion_use_full_net" title="Permalink to this location">¶</a></h3>


If true, don't lump elements into classes for diffusion.
Instead, each isotope in the network is treated as its own separate class.
This can cause significant slowdowns for large nets, so it is off by default.
This works for nets with up to 100 isotopes; larger nets require lumping into
classes.

{% highlight fortran %}
diffusion_use_full_net = .false.
{% endhighlight %}


<h3 id="diffusion_num_classes">diffusion_num_classes <a href="#diffusion_num_classes" title="Permalink to this location">¶</a></h3>


Number of representative classes of species for diffusion calculations.
(maximum of 100)

{% highlight fortran %}
diffusion_num_classes = 5
{% endhighlight %}


<h3 id="diffusion_class_representative">diffusion_class_representative(:) <a href="#diffusion_class_representative" title="Permalink to this location">¶</a></h3>


isotope names for diffusion representatives

{% highlight fortran %}
diffusion_class_representative(1) = 'h1'
diffusion_class_representative(2) = 'he3'
diffusion_class_representative(3) = 'he4'
diffusion_class_representative(4) = 'o16'
diffusion_class_representative(5) = 'fe56'
{% endhighlight %}


<h3 id="diffusion_class_A_max">diffusion_class_A_max(:) <a href="#diffusion_class_A_max" title="Permalink to this location">¶</a></h3>


atomic number A. in ascending order.  species goes into 1st class with `A_max` >= species A

{% highlight fortran %}
diffusion_class_A_max(1) = 2
diffusion_class_A_max(2) = 3
diffusion_class_A_max(3) = 4
diffusion_class_A_max(4) = 16
diffusion_class_A_max(5) = 10000
{% endhighlight %}


<h3 id="diffusion_class_typical_charge">diffusion_class_typical_charge(:) <a href="#diffusion_class_typical_charge" title="Permalink to this location">¶</a></h3>


Typical charges for use if `diffusion_calculates_ionization` is false
Use charge 21 for Fe in the sun, from
Thoul, Bahcall, and Loeb (1994), ApJ, 421, 828.

{% highlight fortran %}
diffusion_class_typical_charge(1) = 1
diffusion_class_typical_charge(2) = 2
diffusion_class_typical_charge(3) = 2
diffusion_class_typical_charge(4) = 8
diffusion_class_typical_charge(5) = 21
{% endhighlight %}


<h3 id="diffusion_class_factor">diffusion_class_factor(:) <a href="#diffusion_class_factor" title="Permalink to this location">¶</a></h3>


Arbitrarily enhance or inhibit diffusion effects by class.

{% highlight fortran %}
diffusion_class_factor(:) = 1d0
{% endhighlight %}


<h2 id="parameters_for_ionization_solver">parameters for ionization solver <a href="#parameters_for_ionization_solver" title="Permalink to this location">¶</a></h2>


<h3 id="diffusion_use_isolve">diffusion_use_isolve <a href="#diffusion_use_isolve" title="Permalink to this location">¶</a></h3>


Activate iterative solver.

{% highlight fortran %}
diffusion_use_isolve = .false.
{% endhighlight %}


<h3 id="diffusion_rtol_for_isolve">diffusion_rtol_for_isolve <a href="#diffusion_rtol_for_isolve" title="Permalink to this location">¶</a></h3>


<h3 id="diffusion_atol_for_isolve">diffusion_atol_for_isolve <a href="#diffusion_atol_for_isolve" title="Permalink to this location">¶</a></h3>


Relative and absolute error parameters for iterative solver.

{% highlight fortran %}
diffusion_rtol_for_isolve = 1d-4
diffusion_atol_for_isolve = 1d-5
{% endhighlight %}


<h3 id="diffusion_maxsteps_for_isolve">diffusion_maxsteps_for_isolve <a href="#diffusion_maxsteps_for_isolve" title="Permalink to this location">¶</a></h3>


Maximum number of steps to take in iterative solver.

{% highlight fortran %}
diffusion_maxsteps_for_isolve = 1000
{% endhighlight %}


<h3 id="diffusion_isolve_solver">diffusion_isolve_solver <a href="#diffusion_isolve_solver" title="Permalink to this location">¶</a></h3>


Which ode solver to use for iterative.

Options include:

+ `'ros2_solver'`
+ `'rose2_solver'`
+ `'ros3p_solver'`
+ `'ros3pl_solver'`
+ `'rodas3_solver'`
+ `'rodas4_solver'`
+ `'rodasp_solver'`

{% highlight fortran %}
diffusion_isolve_solver = 'ros2_solver'
{% endhighlight %}


<h3 id="diffusion_dump_call_number">diffusion_dump_call_number <a href="#diffusion_dump_call_number" title="Permalink to this location">¶</a></h3>


debugging info of diffusion at call number

{% highlight fortran %}
diffusion_dump_call_number = -1
{% endhighlight %}

<h1 id="eos_controls">eos controls <a href="#eos_controls" title="Permalink to this location">¶</a></h1>


more eos controls can be found in `star_job.defaults`

<h3 id="use_eosDT_ideal_gas">use_eosDT_ideal_gas <a href="#use_eosDT_ideal_gas" title="Permalink to this location">¶</a></h3>


if true, then eos is ideal gas eos as implemented by HELMEOS

{% highlight fortran %}
use_eosDT_ideal_gas = .false.
{% endhighlight %}


<h3 id="use_eosDT_HELMEOS">use_eosDT_HELMEOS <a href="#use_eosDT_HELMEOS" title="Permalink to this location">¶</a></h3>


if true, then eos is as implemented by HELMEOS alone; no blending.

{% highlight fortran %}
use_eosDT_HELMEOS = .false.
{% endhighlight %}


<h3 id="eosDT_HELMEOS_include_radiation">eosDT_HELMEOS_include_radiation <a href="#eosDT_HELMEOS_include_radiation" title="Permalink to this location">¶</a></h3>


if `use_eosDT_HELMEOS`, then this flag is passed as arg
to control whether include radiation.

{% highlight fortran %}
eosDT_HELMEOS_include_radiation = .true.
{% endhighlight %}


<h3 id="eosDT_HELMEOS_always_skip_elec_pos">eosDT_HELMEOS_always_skip_elec_pos <a href="#eosDT_HELMEOS_always_skip_elec_pos" title="Permalink to this location">¶</a></h3>


if `use_eosDT_HELMEOS`, then this flag is passed as arg
to control whether skip electrons and positrons.
if true, then always skip them
else skip only for low T, low density situations

{% highlight fortran %}
eosDT_HELMEOS_always_skip_elec_pos = .false.
{% endhighlight %}


<h3 id="eosDT_HELMEOS_always_include_elec_pos">eosDT_HELMEOS_always_include_elec_pos <a href="#eosDT_HELMEOS_always_include_elec_pos" title="Permalink to this location">¶</a></h3>


if `use_eosDT_HELMEOS`, then this flag is passed as arg
to control whether skip electrons and positrons.
if true, then always include them
else include only for low T, low density situations

{% highlight fortran %}
eosDT_HELMEOS_always_include_elec_pos = .false.
{% endhighlight %}


<h3 id="report_eos_settings_at_start_of_run">report_eos_settings_at_start_of_run <a href="#report_eos_settings_at_start_of_run" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
report_eos_settings_at_start_of_run = .false.
{% endhighlight %}


<h3 id="use_eosPTEH_for_low_density">use_eosPTEH_for_low_density <a href="#use_eosPTEH_for_low_density" title="Permalink to this location">¶</a></h3>


<h3 id="use_eosPTEH_for_high_Z">use_eosPTEH_for_high_Z <a href="#use_eosPTEH_for_high_Z" title="Permalink to this location">¶</a></h3>


<h3 id="Z_for_all_PTEH">Z_for_all_PTEH <a href="#Z_for_all_PTEH" title="Permalink to this location">¶</a></h3>


<h3 id="Z_for_any_PTEH">Z_for_any_PTEH <a href="#Z_for_any_PTEH" title="Permalink to this location">¶</a></h3>


<h3 id="logRho_min_for_all_OPAL">logRho_min_for_all_OPAL <a href="#logRho_min_for_all_OPAL" title="Permalink to this location">¶</a></h3>


<h3 id="logRho_min_for_any_OPAL">logRho_min_for_any_OPAL <a href="#logRho_min_for_any_OPAL" title="Permalink to this location">¶</a></h3>


overwrite the control of same name in the `Eos_General_Info` structure

if use_eosPTEH_for_low_density is true, 
for logT < 3.7, use PTEH for logRho < about 7.5
for higher logT, use PTEH for logRho < logRho_min_for_any_OPAL
and do blend of OPAL and PTEH for logRho < logRho_min_for_any_OPAL.

if use_eosPTEH_for_high_Z is true.
use PTEH in place of HELM for Z above OPAL/SCVH range
Z >= Z_for_all_PTEH, then use pure PTEH with no blend
Z < Z_for_any_PTEH, then do not use PTEH
blend with PTEH for intermediate Z.
if use_eosDT2, blend with DT2.
else blend with OPAL/SCVH data.

{% highlight fortran %}
use_eosPTEH_for_low_density = .true.
use_eosPTEH_for_high_Z = .true.
Z_for_all_PTEH = 0.040d0
Z_for_any_PTEH = 0.039d0
logRho_min_for_all_OPAL = -9.1d0
logRho_min_for_any_OPAL = -9.2d0
{% endhighlight %}


<h3 id="use_eosDT2">use_eosDT2 <a href="#use_eosDT2" title="Permalink to this location">¶</a></h3>


<h3 id="max_logT_for_max_logQ_eosDT2">max_logT_for_max_logQ_eosDT2 <a href="#max_logT_for_max_logQ_eosDT2" title="Permalink to this location">¶</a></h3>


<h3 id="max_logQ_for_use_eosDT2">max_logQ_for_use_eosDT2 <a href="#max_logQ_for_use_eosDT2" title="Permalink to this location">¶</a></h3>


<h3 id="logRho_max_for_all_PTEH_or_DT2">logRho_max_for_all_PTEH_or_DT2 <a href="#logRho_max_for_all_PTEH_or_DT2" title="Permalink to this location">¶</a></h3>


<h3 id="logRho_max_for_any_PTEH_or_DT2">logRho_max_for_any_PTEH_or_DT2 <a href="#logRho_max_for_any_PTEH_or_DT2" title="Permalink to this location">¶</a></h3>


<h3 id="logQ_max_for_low_Z_PTEH_or_DT2">logQ_max_for_low_Z_PTEH_or_DT2 <a href="#logQ_max_for_low_Z_PTEH_or_DT2" title="Permalink to this location">¶</a></h3>


<h3 id="logQ_max_for_high_Z_PTEH_or_DT2">logQ_max_for_high_Z_PTEH_or_DT2 <a href="#logQ_max_for_high_Z_PTEH_or_DT2" title="Permalink to this location">¶</a></h3>


does not apply when lnPgas_flag is true.
does not apply when use_eosPTEH_for_high_Z is false.
does not apply if there any cell has logT <= max_logT and logQ > max_logQ
    where logQ = logRho - 2*logT + 12
otherwise, use DT2 in place of OPAL/SCVH for cases with Z < Z_for_all_PTEH

{% highlight fortran %}
use_eosDT2 = .true.
{% endhighlight %}


{% highlight fortran %}
max_logT_for_max_logQ_eosDT2 = 5.5d0
max_logQ_for_use_eosDT2 = 2.9d0
{% endhighlight %}


{% highlight fortran %}
logRho_max_for_all_PTEH_or_DT2 = 2.97d0
logRho_max_for_any_PTEH_or_DT2 = 3.12d0
{% endhighlight %}


{% highlight fortran %}
logQ_max_for_low_Z_PTEH_or_DT2 = 4d0
logQ_max_for_high_Z_PTEH_or_DT2 = -0.4d0
{% endhighlight %}


<h3 id="use_eosELM">use_eosELM <a href="#use_eosELM" title="Permalink to this location">¶</a></h3>


<h3 id="logT_max_for_ELM">logT_max_for_ELM <a href="#logT_max_for_ELM" title="Permalink to this location">¶</a></h3>


<h3 id="logQ_min_for_ELM">logQ_min_for_ELM <a href="#logQ_min_for_ELM" title="Permalink to this location">¶</a></h3>


<h3 id="check_elm_abar_zbar">check_elm_abar_zbar <a href="#check_elm_abar_zbar" title="Permalink to this location">¶</a></h3>


if use_eosELM is true,
then use ELM in high Rho and T regions where otherwise use HELM.
don't use ELM for cells with logT > logT_max_for_ELM
or with logQ < logQ_min_for_ELM.
Don't use ELM if abar and/or zbar fall outside of tabulated ranges.

{% highlight fortran %}
use_eosELM = .true.
logT_max_for_ELM = 10d0
logQ_min_for_ELM = -12.5d0
check_elm_abar_zbar = .false.
{% endhighlight %}


<h3 id="logQ_max_OPAL_SCVH">logQ_max_OPAL_SCVH <a href="#logQ_max_OPAL_SCVH" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
logQ_max_OPAL_SCVH = 5.3d0
{% endhighlight %}


<h3 id="use_fixed_XZ_for_eos">use_fixed_XZ_for_eos <a href="#use_fixed_XZ_for_eos" title="Permalink to this location">¶</a></h3>


for debugging

{% highlight fortran %}
use_fixed_XZ_for_eos = .false.
{% endhighlight %}


<h3 id="fixed_X_for_eos">fixed_X_for_eos <a href="#fixed_X_for_eos" title="Permalink to this location">¶</a></h3>


if `use_fixed_XZ_for_eos`, then pass this value to eos instead of actual X.

{% highlight fortran %}
fixed_X_for_eos = -1
{% endhighlight %}


<h3 id="fixed_Z_for_eos">fixed_Z_for_eos <a href="#fixed_Z_for_eos" title="Permalink to this location">¶</a></h3>


if `use_fixed_XZ_for_eos`, then pass this value to eos instead of actual Z.

{% highlight fortran %}
fixed_Z_for_eos = -1
{% endhighlight %}


<h3 id="tiny_fuzz_for_eos">tiny_fuzz_for_eos <a href="#tiny_fuzz_for_eos" title="Permalink to this location">¶</a></h3>


Z < this gets clipped to 0 in the eos
can reduce to 1d-10 or smaller if needed. 

{% highlight fortran %}
tiny_fuzz_for_eos = 1d-6
{% endhighlight %}

<h1 id="opacity_controls">opacity controls <a href="#opacity_controls" title="Permalink to this location">¶</a></h1>


more opacity controls can be found in `star_job.defaults`

<h3 id="cubic_interpolation_in_X">cubic_interpolation_in_X <a href="#cubic_interpolation_in_X" title="Permalink to this location">¶</a></h3>


type of interpolation in X

{% highlight fortran %}
cubic_interpolation_in_X = .false.
{% endhighlight %}


<h3 id="cubic_interpolation_in_Z">cubic_interpolation_in_Z <a href="#cubic_interpolation_in_Z" title="Permalink to this location">¶</a></h3>


type of interpolation in Z

{% highlight fortran %}
cubic_interpolation_in_Z = .false.
{% endhighlight %}


<h3 id="include_electron_conduction">include_electron_conduction <a href="#include_electron_conduction" title="Permalink to this location">¶</a></h3>


add conduction opacities to radiative opacities

{% highlight fortran %}
include_electron_conduction = .true.
{% endhighlight %}


<h3 id="use_simple_es_for_kap">use_simple_es_for_kap <a href="#use_simple_es_for_kap" title="Permalink to this location">¶</a></h3>


for experiments with simple electron scattering
if true, `opacity = 0.2*(1 + x)`

{% highlight fortran %}
use_simple_es_for_kap = .false.
{% endhighlight %}


<h3 id="use_Type2_opacities">use_Type2_opacities <a href="#use_Type2_opacities" title="Permalink to this location">¶</a></h3>


Type2 opacities for extra C/O during and after He burning.  To use Type2
opacities one needs to specify a base metallicity, Zbase, which gives the metal
abundances previous to any CO enhancement. In regions where central hydrogen is
above a given threshold, or the metallicity is not significantly higher than
Zbase, Type1 tables are used instead, with blending regions to smoothly
transition from one to the other.  Why not just use Type2 all the time?  Is it
a performance reason to still support Type1s?

No -- the Type1 tables cover a wider range of X and have a higher resolution in
Z for each X.

The Type1 tables are for (X,Z) pairs from the following sets:

The 10 Type1 X's are 0.0, 0.1, 0.2, 0.35, 0.5, 0.7, 0.8, 0.9, 0.95, 1-Z The 13
Type1 Z's are 0.0, 1e-4, 3e-4, 1e-3, 2e-3, 4e-3, 1e-2, 2e-2, 3e-2, 4e-2, 6e-2,
8e-1, 1e-1

The Type2 tables are for (X,Z) pairs from the following more limits sets: The 5
Type2 X's are 0.0, 0.03, 0.10, 0.35, 0.70 The 8 Type2 Z's are 0.00, 0.001,
0.004, 0.01, 0.02, 0.03, 0.05, 0.1

There are 130 (X,Z) combinations for Type1 and only 40 for Type2.  So Type2
gives you C/O enhancement at a cost of lower resolution in (X,Z).  The Type1
tables also cover the full possible range of X from 0.0 to 1-Z, whereas the
Type2 tables stop at a max X of 0.70.  Extrapolating the Type2 tables to higher
X is not reliable, so we switch over to using Type1 data instead. In this case,
Type1 opacities are computed using Zbase instead of the actual metallicity.

{% highlight fortran %}
use_Type2_opacities = .false.
{% endhighlight %}


<h3 id="Zbase">Zbase <a href="#Zbase" title="Permalink to this location">¶</a></h3>


the base metallicity for the Type2 kap evaluations
and/or for lowT opacities via kapCN or AESOPUS

{% highlight fortran %}
Zbase = -1
{% endhighlight %}


<h3 id="use_Zbase_for_Type1_blend">use_Zbase_for_Type1_blend <a href="#use_Zbase_for_Type1_blend" title="Permalink to this location">¶</a></h3>


If true, then if `use_Type2_opacities = .true.` Type1 opacities will be computed
using Zbase instead of Z. Ignored if `use_Type2_opacities = .false.`

{% highlight fortran %}
use_Zbase_for_Type1_blend = .true.
{% endhighlight %}


<h3 id="kap_Type2_full_off_X">kap_Type2_full_off_X <a href="#kap_Type2_full_off_X" title="Permalink to this location">¶</a></h3>


<h3 id="kap_Type2_full_on_X">kap_Type2_full_on_X <a href="#kap_Type2_full_on_X" title="Permalink to this location">¶</a></h3>


switch to Type1 if X too large
Type2 is full off for `X >= kap_Type2_full_off_X`
Type2 can be full on for `X <= kap_Type2_full_on_X`

{% highlight fortran %}
kap_Type2_full_off_X = 0.71d0
kap_Type2_full_on_X = 0.70d0
{% endhighlight %}


<h3 id="kap_Type2_full_off_dZ">kap_Type2_full_off_dZ <a href="#kap_Type2_full_off_dZ" title="Permalink to this location">¶</a></h3>


<h3 id="kap_Type2_full_on_dZ">kap_Type2_full_on_dZ <a href="#kap_Type2_full_on_dZ" title="Permalink to this location">¶</a></h3>


switch to Type1 if dZ too small `(dZ = Z - Zbase)`
Type2 is full off for `dZ <= kap_Type2_full_off_dZ`
Type2 can be full on for `dZ >= kap_Type2_full_on_dZ`.

{% highlight fortran %}
kap_Type2_full_off_dZ = 0.001d0
kap_Type2_full_on_dZ = 0.01d0
{% endhighlight %}


X and dZ terms are multiplied to get actual fraction of Type2.
The fraction of Type2 is calculated for each cell depending on the X and dZ for that cell.
So you can be using Type1 in cells where X is large or dZ is small,
while at the same time you can be using Type2 where X is small and dZ is large.
When `frac_Type2` is > 0 and < 1, then both Type1 and Type2 are evaluated and
combined linearly as `(1-frac_Type2)*kap_type1 + frac_Type2*kap_type2`.
Add `kap_frac_Type2` to your profile columns list to see `frac_Type2` for each cell.

<h3 id="opacity_max">opacity_max <a href="#opacity_max" title="Permalink to this location">¶</a></h3>


limit opacities to this value (ignore this is value is < 0)

{% highlight fortran %}
opacity_max = -1
{% endhighlight %}


<h3 id="opacity_factor">opacity_factor <a href="#opacity_factor" title="Permalink to this location">¶</a></h3>


opacities are multiplied by this value

{% highlight fortran %}
opacity_factor = 1
{% endhighlight %}


<h3 id="min_logT_for_opacity_factor_off">min_logT_for_opacity_factor_off <a href="#min_logT_for_opacity_factor_off" title="Permalink to this location">¶</a></h3>


<h3 id="min_logT_for_opacity_factor_on__and">min_logT_for_opacity_factor_on  and <a href="#min_logT_for_opacity_factor_on__and" title="Permalink to this location">¶</a></h3>


<h3 id="max_logT_for_opacity_factor_on">max_logT_for_opacity_factor_on <a href="#max_logT_for_opacity_factor_on" title="Permalink to this location">¶</a></h3>


<h3 id="max_logT_for_opacity_factor_off">max_logT_for_opacity_factor_off <a href="#max_logT_for_opacity_factor_off" title="Permalink to this location">¶</a></h3>


temperature controls for where the `opacity_factor` is applied
if, for example, you only want the opacity factor to apply in the iron bump region
you can give a logT range such as

    min_logT_for_opacity_factor_off = 5.2
    min_logT_for_opacity_factor_on = 5.3
    max_logT_for_opacity_factor_on = 5.7
    max_logT_for_opacity_factor_off = 5.8

ignore these if < 0.

{% highlight fortran %}
min_logT_for_opacity_factor_off = -1
min_logT_for_opacity_factor_on = -1
max_logT_for_opacity_factor_on = -1
max_logT_for_opacity_factor_off = -1
{% endhighlight %}


if you need cell-by-cell control of opacity factor,
set the vector "`extra_opacity_factor`" using the routine "`other_opacity_factor`"

<h2 id="OP_mono_opacities">OP mono opacities <a href="#OP_mono_opacities" title="Permalink to this location">¶</a></h2>


The `OP_mono` opacities use data and code from the OP website
as modified by Haili Hu.  Since the tar.gz file is large (656 MB),
it is not included in the standard mesa download.

You can get `OP4STARS_1.3.tar.gz` [here](http://sourceforge.net/projects/mesa/files)

Put it any place you want on your disk.

    gunzip OP4STARS_1.3.tar.gz
    tar -xvf OP4STARS_1.3.tar

Set the inlist controls for the "mono" directory with the data files.
For example, in my case it looks like the following, but you can put
the directory anywhere you like -- it doesn't need to be in the mesa/data
directory. And the cache file doesn't need to be in the mono directory.

    op_mono_data_path = '/Users/bpaxton/OP4STARS_1.3/mono'
    op_mono_data_cache_filename = '/Users/bpaxton/OP4STARS_1.3/mono/op_mono_cache.bin'

<h3 id="op_mono_data_path">op_mono_data_path <a href="#op_mono_data_path" title="Permalink to this location">¶</a></h3>


if this path is set to the empty string, '', then it defaults to the
environment variable `$(MESA_OP_MONO_DATA_PATH)`

{% highlight fortran %}
op_mono_data_path = ''
{% endhighlight %}


<h3 id="op_mono_data_cache_filename">op_mono_data_cache_filename <a href="#op_mono_data_cache_filename" title="Permalink to this location">¶</a></h3>


if this is set to the empty string, '', then it defaults to the
environment variable `$(MESA_OP_MONO_DATA_CACHE_FILENAME)`

{% highlight fortran %}
op_mono_data_cache_filename = ''
{% endhighlight %}


<h3 id="high_logT_op_mono_full_off">high_logT_op_mono_full_off <a href="#high_logT_op_mono_full_off" title="Permalink to this location">¶</a></h3>


<h3 id="high_logT_op_mono_full_on">high_logT_op_mono_full_on <a href="#high_logT_op_mono_full_on" title="Permalink to this location">¶</a></h3>


<h3 id="low_logT_op_mono_full_off">low_logT_op_mono_full_off <a href="#low_logT_op_mono_full_off" title="Permalink to this location">¶</a></h3>


<h3 id="low_logT_op_mono_full_on">low_logT_op_mono_full_on <a href="#low_logT_op_mono_full_on" title="Permalink to this location">¶</a></h3>


you can select a range of log10T for using `op_mono` opacities
outside that range, the code will use standard opacity tables.
for example, you might only use high T limits so that `op_mono`
is only used in the envelope, or you might set both low and
high T limits so that `op_mono` is used around the Fe peak logT
but not for other locations in the star.

    high_logT_op_mono_full_off >= high_logT_op_mono_full_on
    high_logT_op_mono_full_on >= low_logT_op_mono_full_on
    low_logT_op_mono_full_on >= low_logT_op_mono_full_off

    op_mono opacities full on if
    log10T <= high_logT_op_mono_full_on
    and
    log10T >= low_logT_op_mono_full_on

    op_mono opacities full off if
    log10T >= high_logT_op_mono_full_off
    or
    log10T <= low_logT_op_mono_full_off

partially on for other cases

{% highlight fortran %}
high_logT_op_mono_full_off = -1d99
high_logT_op_mono_full_on = -1d99
{% endhighlight %}


{% highlight fortran %}
low_logT_op_mono_full_off = -1d99
low_logT_op_mono_full_on = -1d99
{% endhighlight %}


<h3 id="op_mono_min_X_to_include">op_mono_min_X_to_include <a href="#op_mono_min_X_to_include" title="Permalink to this location">¶</a></h3>


skip iso if mass fraction < this

{% highlight fortran %}
op_mono_min_X_to_include = 1d-20
{% endhighlight %}


<h3 id="use_op_mono_alt_get_kap">use_op_mono_alt_get_kap <a href="#use_op_mono_alt_get_kap" title="Permalink to this location">¶</a></h3>


if true, call the `op_mono_alt_get_kap` routine instead of `op_mono_get_kap`.
see `mesa/kap/public/kap_lib.f` for details about these routines.

{% highlight fortran %}
use_op_mono_alt_get_kap = .false.
{% endhighlight %}


<h3 id="kap_phot_factor_for_kap_floor">kap_phot_factor_for_kap_floor <a href="#kap_phot_factor_for_kap_floor" title="Permalink to this location">¶</a></h3>


<h3 id="kap_phot_step_factor">kap_phot_step_factor <a href="#kap_phot_step_factor" title="Permalink to this location">¶</a></h3>


<h3 id="min_kap_floor_step_factor">min_kap_floor_step_factor <a href="#min_kap_floor_step_factor" title="Permalink to this location">¶</a></h3>


<h3 id="min_for_kap_floor">min_for_kap_floor <a href="#min_for_kap_floor" title="Permalink to this location">¶</a></h3>


<h3 id="tau_use_kap_floor">tau_use_kap_floor <a href="#tau_use_kap_floor" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
kap_phot_factor_for_kap_floor = 1d0
kap_phot_step_factor = 0.05d0
min_kap_floor_step_factor = 0.333d0
min_for_kap_floor = 1d-4
tau_use_kap_floor = .false.
{% endhighlight %}


<h3 id="ignore_kap_min">ignore_kap_min <a href="#ignore_kap_min" title="Permalink to this location">¶</a></h3>


<h3 id="kap_min_Z_0pt02">kap_min_Z_0pt02 <a href="#kap_min_Z_0pt02" title="Permalink to this location">¶</a></h3>


<h3 id="kap_min_Z_1pt0">kap_min_Z_1pt0 <a href="#kap_min_Z_1pt0" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
ignore_kap_min = .false.
kap_min_Z_0pt02 = 1d-20
kap_min_Z_1pt0 = 1d-20
{% endhighlight %}


<h3 id="kap_fac_X_lo">kap_fac_X_lo <a href="#kap_fac_X_lo" title="Permalink to this location">¶</a></h3>


<h3 id="kap_fac_X_lo_fac">kap_fac_X_lo_fac <a href="#kap_fac_X_lo_fac" title="Permalink to this location">¶</a></h3>


<h3 id="kap_fac_X_hi">kap_fac_X_hi <a href="#kap_fac_X_hi" title="Permalink to this location">¶</a></h3>


<h3 id="kap_fac_X_hi_fac">kap_fac_X_hi_fac <a href="#kap_fac_X_hi_fac" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
kap_fac_X_lo = -1
kap_fac_X_lo_fac = -1
kap_fac_X_hi = -1
kap_fac_X_hi_fac = -1
{% endhighlight %}

<h1 id="asteroseismology_controls">asteroseismology controls <a href="#asteroseismology_controls" title="Permalink to this location">¶</a></h1>


<h3 id="get_delta_nu_from_scaled_solar">get_delta_nu_from_scaled_solar <a href="#get_delta_nu_from_scaled_solar" title="Permalink to this location">¶</a></h3>


use scaled solar values

{% highlight fortran %}
get_delta_nu_from_scaled_solar = .false.
{% endhighlight %}


<h3 id="nu_max_sun">nu_max_sun <a href="#nu_max_sun" title="Permalink to this location">¶</a></h3>


solar value of `nu_max`

{% highlight fortran %}
nu_max_sun = 3100d0
{% endhighlight %}


<h3 id="delta_nu_sun">delta_nu_sun <a href="#delta_nu_sun" title="Permalink to this location">¶</a></h3>


solar value of `delta_nu`

{% highlight fortran %}
delta_nu_sun = 135d0
{% endhighlight %}


<h3 id="Teff_sun">Teff_sun <a href="#Teff_sun" title="Permalink to this location">¶</a></h3>


solar value of Teff

{% highlight fortran %}
Teff_sun = 5777d0
{% endhighlight %}


<h3 id="delta_Pg_mode_freq">delta_Pg_mode_freq <a href="#delta_Pg_mode_freq" title="Permalink to this location">¶</a></h3>


uHz. if <=0, use nu_max from scaled solar value

{% highlight fortran %}
delta_Pg_mode_freq = 0d0
{% endhighlight %}


<h2 id="Brunt_controls">Brunt controls <a href="#Brunt_controls" title="Permalink to this location">¶</a></h2>


<h3 id="calculate_Brunt_N2">calculate_Brunt_N2 <a href="#calculate_Brunt_N2" title="Permalink to this location">¶</a></h3>


Only calculate `Brunt_N2` if this is true.

{% highlight fortran %}
calculate_Brunt_N2 = .true.
{% endhighlight %}


<h3 id="brunt_N2_coefficient">brunt_N2_coefficient <a href="#brunt_N2_coefficient" title="Permalink to this location">¶</a></h3>


Standard N2 is multiplied by this value.

{% highlight fortran %}
brunt_N2_coefficient = 1
{% endhighlight %}


<h3 id="num_cells_for_smooth_brunt_B">num_cells_for_smooth_brunt_B <a href="#num_cells_for_smooth_brunt_B" title="Permalink to this location">¶</a></h3>


Number of cells on either side to use in weighted smoothing of `brunt_B`.

{% highlight fortran %}
num_cells_for_smooth_brunt_B = 2
{% endhighlight %}


<h3 id="threshold_for_smooth_brunt_B">threshold_for_smooth_brunt_B <a href="#threshold_for_smooth_brunt_B" title="Permalink to this location">¶</a></h3>


Threshold for weighted smoothing of `brunt_B`. Only apply smoothing (controlled
by `num_cells_for_smooth_bruntB`) for contiguous regions where |bruntB| exceeds
this threshold. Might be useful for preventing narrow peaks from being excessively
broadened by smoothing

{% highlight fortran %}
threshold_for_smooth_brunt_B = 0d0
{% endhighlight %}


<h3 id="use_brunt_gradmuX_form">use_brunt_gradmuX_form <a href="#use_brunt_gradmuX_form" title="Permalink to this location">¶</a></h3>


For comparison to older codes.
Assumes ideal gas plus radiation for `brunt_B`.
Uses hydrogren mass fraction to estimate dlnmu = dX/(X + 0.6).

{% highlight fortran %}
use_brunt_gradmuX_form = .false.
{% endhighlight %}


<h3 id="interpolate_rho_for_pulsation_info">interpolate_rho_for_pulsation_info <a href="#interpolate_rho_for_pulsation_info" title="Permalink to this location">¶</a></h3>


If true, then get `rho_face` by interpolating rho at cell center.
If false, then calculate `rho_face` by `dm/(4*pi*r^2*dr)`.

{% highlight fortran %}
interpolate_rho_for_pulsation_info = .true.
{% endhighlight %}


<h3 id="min_magnitude_brunt_B">min_magnitude_brunt_B <a href="#min_magnitude_brunt_B" title="Permalink to this location">¶</a></h3>


If set `brunt_B` to 0 if absolute value is < this.

{% highlight fortran %}
min_magnitude_brunt_B = -1d99
{% endhighlight %}

<h1 id="structure_equations">structure equations <a href="#structure_equations" title="Permalink to this location">¶</a></h1>


<h3 id="velocity_q_upper_bound">velocity_q_upper_bound <a href="#velocity_q_upper_bound" title="Permalink to this location">¶</a></h3>


Local override for global `v_flag`.
If local q > this bound, local `v_flag` is set false,
else local `v_flag` is set to global `v_flag`.
this lets you force v = 0 in outer envelope.

{% highlight fortran %}
velocity_q_upper_bound = 1d99
{% endhighlight %}


<h3 id="velocity_logT_lower_bound">velocity_logT_lower_bound <a href="#velocity_logT_lower_bound" title="Permalink to this location">¶</a></h3>


Local override for global `v_flag`.
If local logT < this bound, local `v_flag` is set false,
else local `v_flag` is set to global `v_flag`.
this lets you force v = 0 in outer envelope.

{% highlight fortran %}
velocity_logT_lower_bound = -1d99
{% endhighlight %}


<h3 id="sponge_max_q_full_on">sponge_max_q_full_on <a href="#sponge_max_q_full_on" title="Permalink to this location">¶</a></h3>


<h3 id="sponge_min_q_full_off">sponge_min_q_full_off <a href="#sponge_min_q_full_off" title="Permalink to this location">¶</a></h3>


"sponge" soaks up velocities; full on mean velocities forced to zero.
sponge full on for `q >= sponge_max_q_full_on`  (== velocities full off)
sponge full off for `q <= sponge_min_q_full_off`
`sponge_min_q_full_off < sponge_max_q_full_on`

only applies if either v_flag or u_flag true.
note that currently, this only impacts velocity without adding energy to match.
see also drag_per_step and drag_per_second controls.

{% highlight fortran %}
sponge_max_q_full_on = -1d99
sponge_min_q_full_off = -1d99
{% endhighlight %}


<h3 id="max_dt_yrs_for_velocity_logT_lower_bound">max_dt_yrs_for_velocity_logT_lower_bound <a href="#max_dt_yrs_for_velocity_logT_lower_bound" title="Permalink to this location">¶</a></h3>


Only apply `velocity_logT_lower_bound` when timestep < this limit.

{% highlight fortran %}
max_dt_yrs_for_velocity_logT_lower_bound = 1d99
{% endhighlight %}


<h3 id="use_dP_dm_rotation_correction">use_dP_dm_rotation_correction <a href="#use_dP_dm_rotation_correction" title="Permalink to this location">¶</a></h3>


With rotation, multiply dP/dm by `fp_rot` if this flag is true.

{% highlight fortran %}
use_dP_dm_rotation_correction = .true.
{% endhighlight %}


<h3 id="use_mass_corrections">use_mass_corrections <a href="#use_mass_corrections" title="Permalink to this location">¶</a></h3>


Gravitational vs baryonic mass corrections.
If false, then no distinction between gravitational and baryonic mass.
If true, then gravitational mass is calculated using mass corrections.
Note: may need to wait for pre-ms model to converged before turning this on.

{% highlight fortran %}
use_mass_corrections = .false.
{% endhighlight %}


<h3 id="use_sr_sound_speed">use_sr_sound_speed <a href="#use_sr_sound_speed" title="Permalink to this location">¶</a></h3>


SR correction for sound speed.

{% highlight fortran %}
use_sr_sound_speed = .false.
{% endhighlight %}


<h3 id="use_gr_factors">use_gr_factors <a href="#use_gr_factors" title="Permalink to this location">¶</a></h3>


GR corrections.  Currently just for pressure equation.

{% highlight fortran %}
use_gr_factors = .false.
{% endhighlight %}


<h3 id="use_ODE_var_eqn_pairing">use_ODE_var_eqn_pairing <a href="#use_ODE_var_eqn_pairing" title="Permalink to this location">¶</a></h3>


changes the pairing of equations and variables
helps with numerical issues in hydro matrix solves

{% highlight fortran %}
use_ODE_var_eqn_pairing = .false.
{% endhighlight %}


<h3 id="use_dvdt_form_of_momentum_eqn">use_dvdt_form_of_momentum_eqn <a href="#use_dvdt_form_of_momentum_eqn" title="Permalink to this location">¶</a></h3>


if true, use dv/dt = ... form of momentum equation.
this replaces the default pressure gradient form.
only when v_flag is true.

{% highlight fortran %}
use_dvdt_form_of_momentum_eqn = .false.
{% endhighlight %}


<h3 id="use_Paczynski_term_in_dvdt_eqn">use_Paczynski_term_in_dvdt_eqn <a href="#use_Paczynski_term_in_dvdt_eqn" title="Permalink to this location">¶</a></h3>


if true, then the dv/dt = ... form of momentum equation.
includes Paczynski correction term in optically thin regions.
B. Paczynski, 1969, Acta Astr., vol. 19

{% highlight fortran %}
use_Paczynski_term_in_dvdt_eqn = .false.
{% endhighlight %}


<h3 id="use_dedt_form_of_energy_eqn">use_dedt_form_of_energy_eqn <a href="#use_dedt_form_of_energy_eqn" title="Permalink to this location">¶</a></h3>


if true, use de/dt = ... form of energy equation.
this replaces the default dL/dm and eps_grav form.

{% highlight fortran %}
use_dedt_form_of_energy_eqn = .false.
{% endhighlight %}


<h3 id="use_dsdt_form_of_energy_eqn">use_dsdt_form_of_energy_eqn <a href="#use_dsdt_form_of_energy_eqn" title="Permalink to this location">¶</a></h3>


if true, use ds/dt = ... form of energy equation.
this replaces the default dL/dm and eps_grav form.

{% highlight fortran %}
use_dsdt_form_of_energy_eqn = .false.
{% endhighlight %}


<h3 id="use_eps_correction_for_KE_plus_PE_in_dLdm_eqn">use_eps_correction_for_KE_plus_PE_in_dLdm_eqn <a href="#use_eps_correction_for_KE_plus_PE_in_dLdm_eqn" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
use_eps_correction_for_KE_plus_PE_in_dLdm_eqn = .false.
{% endhighlight %}


<h3 id="min_energy_for_dedt_form_of_energy_eqn">min_energy_for_dedt_form_of_energy_eqn <a href="#min_energy_for_dedt_form_of_energy_eqn" title="Permalink to this location">¶</a></h3>


if energy(k) < this,
punt to dLdm form of energy conservation equation for cell k

{% highlight fortran %}
min_energy_for_dedt_form_of_energy_eqn = 0d0
{% endhighlight %}


<h3 id="min_cell_energy_fraction_for_dedt_form">min_cell_energy_fraction_for_dedt_form <a href="#min_cell_energy_fraction_for_dedt_form" title="Permalink to this location">¶</a></h3>


if energy(k)*dm(k)/total_internal_energy < this,
punt to dLdm form of energy conservation equation for cell k

{% highlight fortran %}
min_cell_energy_fraction_for_dedt_form = 1d-10
{% endhighlight %}


<h3 id="dedt_eqn_r_scale">dedt_eqn_r_scale <a href="#dedt_eqn_r_scale" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
dedt_eqn_r_scale = 1d8
{% endhighlight %}


<h3 id="use_ODE_form_of_density_eqn">use_ODE_form_of_density_eqn <a href="#use_ODE_form_of_density_eqn" title="Permalink to this location">¶</a></h3>


if true, use ODE dlnd/dt = ...
if false, use algebraic relation `rho = cell_mass/cell_vol`

{% highlight fortran %}
use_ODE_form_of_density_eqn = .false.
{% endhighlight %}


<h3 id="non_nuc_neu_factor">non_nuc_neu_factor <a href="#non_nuc_neu_factor" title="Permalink to this location">¶</a></h3>


Multiplies power from non-nuclear reaction neutrinos.
i.e., thermal neutrinos such as computed by mesa/neu.

{% highlight fortran %}
non_nuc_neu_factor = 1
{% endhighlight %}


<h3 id="eps_nuc_factor">eps_nuc_factor <a href="#eps_nuc_factor" title="Permalink to this location">¶</a></h3>


Multiplies `eps_nuc` without changing rates or `dxdt_nuc`.
Thus controls energy production without modifying the amount of change in abundances.

{% highlight fortran %}
eps_nuc_factor = 1
{% endhighlight %}


<h3 id="eps_Ne22_sedimentation_factor">eps_Ne22_sedimentation_factor <a href="#eps_Ne22_sedimentation_factor" title="Permalink to this location">¶</a></h3>


This controls energy production from element diffusion sedimentation of Ne22.

{% highlight fortran %}
eps_Ne22_sedimentation_factor = 1
{% endhighlight %}


<h3 id="max_abs_eps_nuc">max_abs_eps_nuc <a href="#max_abs_eps_nuc" title="Permalink to this location">¶</a></h3>


Limit magnitude of eps_nuc to this.

{% highlight fortran %}
max_abs_eps_nuc = 1d99
{% endhighlight %}


<h3 id="fe56ec_fake_factor">fe56ec_fake_factor <a href="#fe56ec_fake_factor" title="Permalink to this location">¶</a></h3>


<h3 id="min_T_for_fe56ec_fake_factor">min_T_for_fe56ec_fake_factor <a href="#min_T_for_fe56ec_fake_factor" title="Permalink to this location">¶</a></h3>


Multiplier on ni56 electron capture rate to take isotopes in hardwired networks
to more neutron rich isotopes.

{% highlight fortran %}
fe56ec_fake_factor = 1d-7
min_T_for_fe56ec_fake_factor = 3d9
{% endhighlight %}


<h2 id="eps_grav">eps_grav <a href="#eps_grav" title="Permalink to this location">¶</a></h2>


In mesa, "`eps_grav`" means `-T*dS/dt` which is equivalent to `-(dE/dt + P*dV/dt)`
where S is specific entropy, E is specific internal energy, and `V = 1/rho`.
There are several options for how `eps_grav` is calculated.
These alternatives are equivalently from the "ideal" physics viewpoint,
but they can be very different numerically depending on the situation.

The standard default forms are used if you don't set any of the following flags.
The default when using lnd instead of lnPgas as primary variable is

    eps_grav = -T*cp*((1-grada)*chiT*dlnT_dt - grada*chiRho*dlnd_dt)

When using lnPgas instead of lnd, the default is

    eps_grav = -T*cp((1-grada*4*Prad/P)*dlnT_dt - grada*Pgas/P*dlnPgas_dt)

<h3 id="use_lnS_for_eps_grav">use_lnS_for_eps_grav <a href="#use_lnS_for_eps_grav" title="Permalink to this location">¶</a></h3>


If true, use `eps_grav = -T*DS/Dt`.
Note: while this seems like the obvious way to go, it has problems numerically.
lnS is not a basic variable in the way that lnT and lnd (or lnPgas) are.
I.e., we get lnT and lnd from the newton solver directly,
but we get lnS by calling the eos using lnT and lnd as args.
Also, in many cases, the cell mass coordinates don't change for the step,
making it possible to use the solver value for the increment in the lnT or lnd
directly in estimating the Lagrangian time derivative
(e.g., DlnT/dt = <increment in lnT>/dt instead of = (new lnT - old lnT)/dt).
By avoiding the roundoff error in this way, we also get a boost numerically.
With lnS we cannot do that -- we're stuck with DlnS/Dt = (new lnS - old lnS)/dt.
In a perfect world with infinite precision, none of this would matter.
But in practice, it turns out to make a significant difference, so
unless there are strong reasons otherwise, you should use one of the other
schemes for getting `eps_grav`.   One situation where you need to use the lnS
version is deep in a white dwarf where you can have a phase transition
that the lnS form will take care of but the others won't.
That particular case is handled using `Gamma_lnS_eps_grav_full_off`/on.

{% highlight fortran %}
use_lnS_for_eps_grav = .false.
{% endhighlight %}


<h3 id="include_composition_in_eps_grav">include_composition_in_eps_grav <a href="#include_composition_in_eps_grav" title="Permalink to this location">¶</a></h3>


in forms of eps_grav that do not include a total energy
derivative one must explicitly include contributions
associated with changes in composition

It is often okay to neglect these terms (at least it is a
common practice), but for high T, high density situations,
you should include the full form.  The default behavior is
to not include them.  If you know you cannot neglect these terms,
set `include_composition_in_eps_grav` to true.

there are two composition terms included:

one term in `eps_grav` is associated with ideal gases.

by default, it is evaluated as `-dE_dmu*dmu_dt`
with mu approximated by `abar/(1 + zbar)` corresponding to complete ionization
and `dE_dmu` approximated by `-3/2*cgas*T/mu^2`   (cgas = ideal gas constant; erg/K/mole)
where `dmu_dt` is 1st order approximation Lagrangian time derivative, `(mu - mu_start)/dt`.

alternatively, it is evaluated as `-dE_dmuinv*dmuinv_dt` with muinv=1/mu
approximated by `(1+zbar)/abar` corresponding to complete ionization and
`dE_dmuinv` approximated by `1.5*cgas*T` (cgas = ideal gas constant; erg/K/mole).

the other term in eps_grav associated with the degenerate electron gas.
it is '-dE_dYe*dYe_dt', where this is evaluated as avo * mue * dYedt,
where avo is Avogadro's number, mue is the electron chemical potential,
and dYedt is the time rate of change of the electron fraction.
in releases of MESA r10398 and earlier, this term was present,
but was evaluated in the net/rates modules and included in eps_nuc.
this term is only evaluated in degenerate regions.

{% highlight fortran %}
include_composition_in_eps_grav = .false.
{% endhighlight %}


<h3 id="Gamma_lnS_eps_grav_full_off">Gamma_lnS_eps_grav_full_off <a href="#Gamma_lnS_eps_grav_full_off" title="Permalink to this location">¶</a></h3>


<h3 id="Gamma_lnS_eps_grav_full_on">Gamma_lnS_eps_grav_full_on <a href="#Gamma_lnS_eps_grav_full_on" title="Permalink to this location">¶</a></h3>


Automatic switch to lnS form for regions with high Gamma (plasma interaction parameter).
Set `use_lnS_for_eps_grav` false to use these controls.
These are ignored when `use_lnS_for_eps_grav` is true.

{% highlight fortran %}
Gamma_lnS_eps_grav_full_on = 150d0
Gamma_lnS_eps_grav_full_off = 120d0
{% endhighlight %}


<h3 id="eps_grav_factor">eps_grav_factor <a href="#eps_grav_factor" title="Permalink to this location">¶</a></h3>


multiply eps_grav by this factor

{% highlight fortran %}
eps_grav_factor = 1
{% endhighlight %}


<h3 id="eps_grav_dt_use_start_values">eps_grav_dt_use_start_values <a href="#eps_grav_dt_use_start_values" title="Permalink to this location">¶</a></h3>


set true if must use values for lnT, lnd, or lnP from start of step in d_dt.
e.g., if have made significant changes in abundance profiles in diffusion.

{% highlight fortran %}
eps_grav_dt_use_start_values = .false.
{% endhighlight %}


<h3 id="eps_grav_time_deriv_separation">eps_grav_time_deriv_separation <a href="#eps_grav_time_deriv_separation" title="Permalink to this location">¶</a></h3>


Separation (in grid cells) over which eps_grav can be time-differenced when Mstar changes
The mesh has two major regions - an interior region where the cells are
Lagrangian and an outer region where they are homologous (constant dq =dm/M).
There is also a small transition region between these two.  In the Lagrangian
region Ds/dt is evaluated with a Lagrangian finite difference in time, while in the
homologous region Ds/dt is evaluated with a finite difference in time at constant q
plus an advection-like term accounting for the movement of the q boundaries in mass.
In the transition region, these two derivatives are combined.  This means that at
the edges of the transition region, finite differences may cross cell boundaries.
This control determines how the mesh for the end of the current timestep is
placed to ensure that finite differences cross no more than this many cell
boundaries.

{% highlight fortran %}
eps_grav_time_deriv_separation = 1.5d0
{% endhighlight %}


<h3 id="zero_eps_grav_in_just_added_material">zero_eps_grav_in_just_added_material <a href="#zero_eps_grav_in_just_added_material" title="Permalink to this location">¶</a></h3>


If true, set `eps_grav(k) = 0` for `k < k_below_just_added`.
NOTE: this does not mean that Ds/Dt is forced to be 0 in cell k.
Instead it simply means we ignore Ds/Dt in the cell's energy calculation.

{% highlight fortran %}
zero_eps_grav_in_just_added_material = .false.
{% endhighlight %}


<h3 id="min_dxm_Eulerian_div_dxm_removed">min_dxm_Eulerian_div_dxm_removed <a href="#min_dxm_Eulerian_div_dxm_removed" title="Permalink to this location">¶</a></h3>


Controls for Eulerian or Lagrangian forms of `eps_grav`.
Only for mass loss.
Specifies a minimum value for the ratio of
the mass layer at the surface using Eulerian `eps_grav` (`dxm_Eulerian`)
divided by the mass removed in the current step.

{% highlight fortran %}
min_dxm_Eulerian_div_dxm_removed = 2
{% endhighlight %}


<h3 id="min_dxm_Eulerian_div_dxm_added">min_dxm_Eulerian_div_dxm_added <a href="#min_dxm_Eulerian_div_dxm_added" title="Permalink to this location">¶</a></h3>


Controls for Eulerian or Lagrangian forms of `eps_grav`.
Only for mass gain.
Specifies a minimum value for the ratio of
the mass layer at the surface using Eulerian `eps_grav` (`dxm_Eulerian`)
divided by the mass added in the current step.

{% highlight fortran %}
min_dxm_Eulerian_div_dxm_added = 5
{% endhighlight %}


<h3 id="min_cells_for_Eulerian_to_Lagrangian_transition">min_cells_for_Eulerian_to_Lagrangian_transition <a href="#min_cells_for_Eulerian_to_Lagrangian_transition" title="Permalink to this location">¶</a></h3>


Width of eulerian to lagrangian transition region.

{% highlight fortran %}
min_cells_for_Eulerian_to_Lagrangian_transition = 10
{% endhighlight %}


<h3 id="fix_eps_grav_transition_to_grid">fix_eps_grav_transition_to_grid <a href="#fix_eps_grav_transition_to_grid" title="Permalink to this location">¶</a></h3>


If true, fix the transition region for the computation of `eps_grav`
to the transition from Lagrangian to constant in q of the grid.

{% highlight fortran %}
fix_eps_grav_transition_to_grid = .false.
{% endhighlight %}


<h3 id="min_del_T_div_dt">min_del_T_div_dt <a href="#min_del_T_div_dt" title="Permalink to this location">¶</a></h3>


Controls for Lagrangian time derivatives in newly added material
only applies to cells with `k < k_below_just_added`.
If `del_t_for_just_added(k)/dt < this limit`,
then `set del_t_for_just_added(k) = dt*this limit`.

{% highlight fortran %}
min_del_T_div_dt = 1d-10
{% endhighlight %}


<h3 id="max_num_surf_revisions">max_num_surf_revisions <a href="#max_num_surf_revisions" title="Permalink to this location">¶</a></h3>


Max number of forced reconverges for changes in `surf_lnS`.

{% highlight fortran %}
max_num_surf_revisions = 1
{% endhighlight %}


<h3 id="max_abs_rel_change_surf_lnS">max_abs_rel_change_surf_lnS <a href="#max_abs_rel_change_surf_lnS" title="Permalink to this location">¶</a></h3>


Force newton reconverge if surf_lnS changed more than this.

{% highlight fortran %}
max_abs_rel_change_surf_lnS = 5d-4
{% endhighlight %}


<h3 id="alt_eps_grav_he_burn_limit">alt_eps_grav_he_burn_limit <a href="#alt_eps_grav_he_burn_limit" title="Permalink to this location">¶</a></h3>


use start-of-step eos values when power_he_burn > this and center He4 mass fraction > 0.8
this eliminates problems with lack of partials of grada, etc wrt composition
and allows better convergence

{% highlight fortran %}
alt_eps_grav_he_burn_limit = 1d7
{% endhighlight %}


<h3 id="alt_eps_grav_T_center_limit">alt_eps_grav_T_center_limit <a href="#alt_eps_grav_T_center_limit" title="Permalink to this location">¶</a></h3>


use start-of-step eos values in eps_grav when T(nz) > this

{% highlight fortran %}
alt_eps_grav_T_center_limit = 3d9
{% endhighlight %}


<h3 id="trace_force_another_iteration">trace_force_another_iteration <a href="#trace_force_another_iteration" title="Permalink to this location">¶</a></h3>


If true, report when force another itereration in newton solver.

{% highlight fortran %}
trace_force_another_iteration = .false.
{% endhighlight %}


<h3 id="accel_factor">accel_factor <a href="#accel_factor" title="Permalink to this location">¶</a></h3>


coefficient for acceleration term in the momentum equation

{% highlight fortran %}
accel_factor = 1
{% endhighlight %}


<h3 id="extra_power_source">extra_power_source <a href="#extra_power_source" title="Permalink to this location">¶</a></h3>


erg/g/sec applied uniformly throughout the model
This can be used to push a pre-ms model up the track to lower center temperatures.
Can be used simultaneously with `inject_extra_ergs_sec` and `inject_uniform_extra_heat`

{% highlight fortran %}
extra_power_source = 0
{% endhighlight %}


<h3 id="inject_uniform_extra_heat">inject_uniform_extra_heat <a href="#inject_uniform_extra_heat" title="Permalink to this location">¶</a></h3>


extra heat in erg g^-1 s^-1
Added to cells in range `min_q_for_uniform_extra_heat` to max.
Can be used simultaneously with `inject_extra_ergs_sec` and `extra_power_source`.

{% highlight fortran %}
inject_uniform_extra_heat = 0
{% endhighlight %}


<h3 id="min_q_for_uniform_extra_heat">min_q_for_uniform_extra_heat <a href="#min_q_for_uniform_extra_heat" title="Permalink to this location">¶</a></h3>


sets bottom of region for `inject_uniform_extra_heat`

{% highlight fortran %}
min_q_for_uniform_extra_heat = 0
{% endhighlight %}


<h3 id="max_q_for_uniform_extra_heat">max_q_for_uniform_extra_heat <a href="#max_q_for_uniform_extra_heat" title="Permalink to this location">¶</a></h3>


sets top of region for `inject_uniform_extra_heat`

{% highlight fortran %}
max_q_for_uniform_extra_heat = 1
{% endhighlight %}


<h3 id="inject_extra_ergs_sec">inject_extra_ergs_sec <a href="#inject_extra_ergs_sec" title="Permalink to this location">¶</a></h3>


added to mass equal to `grams_for_inject_extra_core_ergs_sec`
can be used simultaneously with `extra_power_source` and `inject_uniform_extra_heat`

{% highlight fortran %}
inject_extra_ergs_sec = 0
{% endhighlight %}


<h3 id="base_of_inject_extra_ergs_sec">base_of_inject_extra_ergs_sec <a href="#base_of_inject_extra_ergs_sec" title="Permalink to this location">¶</a></h3>


(units: Msun) sets bottom of region for `inject_extra_ergs_sec`
note: actual base is at max of this and the center of the model

{% highlight fortran %}
base_of_inject_extra_ergs_sec = 0
{% endhighlight %}


<h3 id="total_mass_for_inject_extra_ergs_sec">total_mass_for_inject_extra_ergs_sec <a href="#total_mass_for_inject_extra_ergs_sec" title="Permalink to this location">¶</a></h3>


(units: Msun) sets size of region for `inject_extra_ergs_sec`

{% highlight fortran %}
total_mass_for_inject_extra_ergs_sec = 0
{% endhighlight %}


<h3 id="start_time_for_inject_extra_ergs_sec">start_time_for_inject_extra_ergs_sec <a href="#start_time_for_inject_extra_ergs_sec" title="Permalink to this location">¶</a></h3>


(units: sec) start time for injecting extra ergs/s

{% highlight fortran %}
start_time_for_inject_extra_ergs_sec = -1d99
{% endhighlight %}


<h3 id="duration_for_inject_extra_ergs_sec">duration_for_inject_extra_ergs_sec <a href="#duration_for_inject_extra_ergs_sec" title="Permalink to this location">¶</a></h3>


(units: sec) length of time for injecting extra ergs/s
set to negative value to keep injecting indefinitely or until reach target

{% highlight fortran %}
duration_for_inject_extra_ergs_sec = -1
{% endhighlight %}


<h3 id="inject_until_reach_model_with_total_energy">inject_until_reach_model_with_total_energy <a href="#inject_until_reach_model_with_total_energy" title="Permalink to this location">¶</a></h3>


(units: ergs) target for model total energy
usually want to set `duration_for_inject_extra_ergs_sec = -1` for this option.
see also: `inject_until_reach_delta_total_energy`
continue injecting until total energy of model reaches min of
`inject_until_reach_model_with_total_energy`, and
`inject_until_reach_delta_total_energy + initial total energy`

{% highlight fortran %}
inject_until_reach_model_with_total_energy = 1d99
{% endhighlight %}


<h3 id="inject_until_reach_delta_total_energy">inject_until_reach_delta_total_energy <a href="#inject_until_reach_delta_total_energy" title="Permalink to this location">¶</a></h3>


(units: ergs) target for change in total energy
stop injecting when `total_energy - total_energy_initial > this`.
usually want to set `duration_for_inject_extra_ergs_sec = -1` for this option.
see also: `inject_until_reach_model_with_total_energy`
continue injecting until total energy of model reaches min of
`inject_until_reach_model_with_total_energy`, and
`inject_until_reach_delta_total_energy + initial total energy`

{% highlight fortran %}
inject_until_reach_delta_total_energy = 1d99
{% endhighlight %}


<h3 id="max_inject_velocity_km_per_sec">max_inject_velocity_km_per_sec <a href="#max_inject_velocity_km_per_sec" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
max_inject_velocity_km_per_sec = 0
{% endhighlight %}


<h3 id="theta_P">theta_P <a href="#theta_P" title="Permalink to this location">¶</a></h3>


for time weighting P in energy and momentum equations

    <P> = theta_P*P + (1 - theta_P)*P_start

{% highlight fortran %}
theta_P = 1d0
{% endhighlight %}


<h3 id="use_porosity_with_dPrad_dm_form">use_porosity_with_dPrad_dm_form <a href="#use_porosity_with_dPrad_dm_form" title="Permalink to this location">¶</a></h3>


<h3 id="min_porosity_factor">min_porosity_factor <a href="#min_porosity_factor" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
use_porosity_with_dPrad_dm_form = .false.
min_porosity_factor = 1d0
{% endhighlight %}


<h3 id="qmax_zero_non_radiative_luminosity">qmax_zero_non_radiative_luminosity <a href="#qmax_zero_non_radiative_luminosity" title="Permalink to this location">¶</a></h3>


<h3 id="m_force_radiative_core">m_force_radiative_core <a href="#m_force_radiative_core" title="Permalink to this location">¶</a></h3>


<h3 id="qmin_freeze_non_radiative_luminosity">qmin_freeze_non_radiative_luminosity <a href="#qmin_freeze_non_radiative_luminosity" title="Permalink to this location">¶</a></h3>


<h3 id="use_dPrad_dm_form_of_T_gradient_eqn">use_dPrad_dm_form_of_T_gradient_eqn <a href="#use_dPrad_dm_form_of_T_gradient_eqn" title="Permalink to this location">¶</a></h3>


<h3 id="use_gradT_form_of_T_gradient_eqn">use_gradT_form_of_T_gradient_eqn <a href="#use_gradT_form_of_T_gradient_eqn" title="Permalink to this location">¶</a></h3>


<h3 id="use_flux_limiting_with_dPrad_dm_form">use_flux_limiting_with_dPrad_dm_form <a href="#use_flux_limiting_with_dPrad_dm_form" title="Permalink to this location">¶</a></h3>


These are for alternatives ways to determine the T gradient.
The standard form of the equation is

    dT/dm = dP/dm * T/P * grad_T, grad_T = dlnT/dlnP from MLT.

use hydrostatic value for dP/dm in this.
this is because of limitations of MLT for calculating grad_T.
(MLT assumes hydrostatic equilibrium)
see comment in K&W chpt 9.1.

The alternatives forms are for dynamic situations where
the use of hydrostatic dP/dm is inappropriate.
In order of priority,

    if q(k) > qmin_freeze_non_radiative_luminosity then
        use L_conv from start of step to get L_rad = L - L_conv_start
    else if q(k) <= qmax_zero_non_radiative_luminosity then
        simply use L_rad = L
    else if (use_dPrad_dm_form_of_T_gradient_eqn)
        if (gradT < gradr) then
           use L_rad = L*gradT/gradr (see, e.g., Cox&Giuli 14.109)
        else
           use L_rad = L

With the resulting `L_rad`, determine the expected dT/dm by

    d_Prad/dm = -kap*L_rad/(clight*area^2) -- see, e.g., K&W (5.12)

{% highlight fortran %}
qmax_zero_non_radiative_luminosity = 0d0
m_force_radiative_core = 0d0
qmin_freeze_non_radiative_luminosity = 1d0
use_dPrad_dm_form_of_T_gradient_eqn = .false.
use_gradT_form_of_T_gradient_eqn = .false.
use_flux_limiting_with_dPrad_dm_form = .false.
{% endhighlight %}


<h3 id="center_energy_pulses">center_energy_pulses <a href="#center_energy_pulses" title="Permalink to this location">¶</a></h3>


<h3 id="pulse_step_inteval">pulse_step_inteval <a href="#pulse_step_inteval" title="Permalink to this location">¶</a></h3>


<h3 id="pulse_max_step">pulse_max_step <a href="#pulse_max_step" title="Permalink to this location">¶</a></h3>


<h3 id="pulse_ergs_even_steps">pulse_ergs_even_steps <a href="#pulse_ergs_even_steps" title="Permalink to this location">¶</a></h3>


<h3 id="pulse_ergs_odd_steps">pulse_ergs_odd_steps <a href="#pulse_ergs_odd_steps" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
center_energy_pulses = .false.
pulse_step_inteval = 11
pulse_max_step = 1000
pulse_ergs_even_steps = 1d20
pulse_ergs_odd_steps = -1d20
{% endhighlight %}


for hydro comparison tests (e.g., Sedov)

<h3 id="gamma_law_hydro">gamma_law_hydro <a href="#gamma_law_hydro" title="Permalink to this location">¶</a></h3>


off as long as value is <= 0

{% highlight fortran %}
gamma_law_hydro = 0d0
{% endhighlight %}


<h3 id="zero_gravity">zero_gravity <a href="#zero_gravity" title="Permalink to this location">¶</a></h3>


if true, then set G to zero

{% highlight fortran %}
zero_gravity = .false.
{% endhighlight %}


<h3 id="disable_riemann_reconstruction">disable_riemann_reconstruction <a href="#disable_riemann_reconstruction" title="Permalink to this location">¶</a></h3>


if true, then set just use bounding cell average P and u at face

{% highlight fortran %}
disable_riemann_reconstruction = .false.
{% endhighlight %}


<h3 id="use_2nd_order_riemann_reconstruction">use_2nd_order_riemann_reconstruction <a href="#use_2nd_order_riemann_reconstruction" title="Permalink to this location">¶</a></h3>


only applies when reconstruction_flag = .true.

{% highlight fortran %}
use_2nd_order_riemann_reconstruction = .true.
{% endhighlight %}


<h3 id="constant_L">constant_L <a href="#constant_L" title="Permalink to this location">¶</a></h3>


if true, then L(k) = L_center for all k.  disable dlnTdm equation.
by default, this implies the boundary conditions `use_zero_dLdm_outer_BC`
and `use_zero_Pgas_outer_BC`.  The only other currently available boundary
condition compatible with this option is `use_fixed_vsurf_outer_BC`.

{% highlight fortran %}
constant_L = .false.
{% endhighlight %}


<h3 id="drag_per_step">drag_per_step <a href="#drag_per_step" title="Permalink to this location">¶</a></h3>


<h3 id="drag_per_second">drag_per_second <a href="#drag_per_second" title="Permalink to this location">¶</a></h3>


only when v_flag.  adjusts both v and energy transfer from kinetic to thermal.

{% highlight fortran %}
drag_per_step = -1d0
drag_per_second = -1d0
{% endhighlight %}


<h3 id="v_drag_factor">v_drag_factor <a href="#v_drag_factor" title="Permalink to this location">¶</a></h3>


<h3 id="v_drag">v_drag <a href="#v_drag" title="Permalink to this location">¶</a></h3>


<h3 id="q_for_v_drag_full_off">q_for_v_drag_full_off <a href="#q_for_v_drag_full_off" title="Permalink to this location">¶</a></h3>


<h3 id="q_for_v_drag_full_on">q_for_v_drag_full_on <a href="#q_for_v_drag_full_on" title="Permalink to this location">¶</a></h3>


Implemented only for u_flag right now. Adds a pseudo drag term of the form
-v_drag_factor*(v-v_drag)^2/r, can be used damp velocities in outer layers
of a star. Effect is full on for q>q_for_v_drag_full_on and full off for
q < q_for_v_drag_full_off.

{% highlight fortran %}
v_drag_factor = 0d0
v_drag = 0d0
q_for_v_drag_full_off = 0.95d0
q_for_v_drag_full_on = 0.96d0
{% endhighlight %}


<h3 id="RayleighTaylor_Instability">Rayleigh-Taylor Instability <a href="#RayleighTaylor_Instability" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_A">RTI_A <a href="#RTI_A" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_B">RTI_B <a href="#RTI_B" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_C">RTI_C <a href="#RTI_C" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_D">RTI_D <a href="#RTI_D" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_C_X_factor">RTI_C_X_factor <a href="#RTI_C_X_factor" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_C_X0">RTI_C_X0 <a href="#RTI_C_X0" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_max_alpha">RTI_max_alpha <a href="#RTI_max_alpha" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_min_dm_behind_shock_for_full_on">RTI_min_dm_behind_shock_for_full_on <a href="#RTI_min_dm_behind_shock_for_full_on" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_dm_for_center_alpha_nondecreasing">RTI_dm_for_center_alpha_nondecreasing <a href="#RTI_dm_for_center_alpha_nondecreasing" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_energy_floor">RTI_energy_floor <a href="#RTI_energy_floor" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_D_mix_floor">RTI_D_mix_floor <a href="#RTI_D_mix_floor" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_min_m_for_D_mix_floor">RTI_min_m_for_D_mix_floor <a href="#RTI_min_m_for_D_mix_floor" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_log_max_boost">RTI_log_max_boost <a href="#RTI_log_max_boost" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_m_full_boost">RTI_m_full_boost <a href="#RTI_m_full_boost" title="Permalink to this location">¶</a></h3>


<h3 id="RTI_m_no_boost">RTI_m_no_boost <a href="#RTI_m_no_boost" title="Permalink to this location">¶</a></h3>


Note that these parameters are not exactly the same
as used by Paul Duffell.
His calibrated D is 2, where mesa has default D = 3 (see mesaIV paper).
Users should try various values since the choice is not clear cut.

{% highlight fortran %}
RTI_A = 1d-3
RTI_B = 2.5d0
RTI_C = 0.2d0
RTI_D = 3d0
{% endhighlight %}


{% highlight fortran %}
RTI_C_X0_frac = 0.9d0
RTI_C_X_factor = 0d0
{% endhighlight %}


{% highlight fortran %}
RTI_max_alpha = 0.5d0
RTI_min_dm_behind_shock_for_full_on = 0d0
RTI_dm_for_center_eta_nondecreasing = 0.02d0
RTI_energy_floor = 0d0
RTI_D_mix_floor = 0d0
RTI_min_m_for_D_mix_floor = 0d0
{% endhighlight %}


{% highlight fortran %}
RTI_log_max_boost = 3d0
RTI_m_full_boost = 4d0
RTI_m_no_boost = 5d0
{% endhighlight %}

<h1 id="convection_velocity_equation">convection velocity equation <a href="#convection_velocity_equation" title="Permalink to this location">¶</a></h1>


<h3 id="conv_vel_D">conv_vel_D <a href="#conv_vel_D" title="Permalink to this location">¶</a></h3>


<h3 id="conv_vel_siglimit">conv_vel_siglimit <a href="#conv_vel_siglimit" title="Permalink to this location">¶</a></h3>


<h3 id="conv_vel_v0">conv_vel_v0 <a href="#conv_vel_v0" title="Permalink to this location">¶</a></h3>


To avoid following tiny convective velocities to high precision
as well as accounting for several orders-of-magnitude changes of
conv_vel in individual steps, the variable included in the newton
solver is not conv_vel, but instead ln(conv_vel + v0). v0 (in cm/s)
then determines at which point relative errors in ln(conv_vel + v0)
are small (TODO: explain better).

{% highlight fortran %}
conv_vel_D = 0d0
conv_vel_siglimit = 1d99
conv_vel_v0 = 1d0
{% endhighlight %}


<h3 id="min_q_for_normal_mlt_gradT_full_off">min_q_for_normal_mlt_gradT_full_off <a href="#min_q_for_normal_mlt_gradT_full_off" title="Permalink to this location">¶</a></h3>


<h3 id="max_q_for_normal_mlt_gradT_full_on">max_q_for_normal_mlt_gradT_full_on <a href="#max_q_for_normal_mlt_gradT_full_on" title="Permalink to this location">¶</a></h3>


Switches from the gradT given by standard MLT rather than conv_vel in the outer layers
gradT is smoothly blend between this range in q

{% highlight fortran %}
min_q_for_normal_mlt_gradT_full_off = 1d99
max_q_for_normal_mlt_gradT_full_on = 1d99
{% endhighlight %}


<h3 id="conv_vel_ignore_thermohaline">conv_vel_ignore_thermohaline <a href="#conv_vel_ignore_thermohaline" title="Permalink to this location">¶</a></h3>


<h3 id="conv_vel_ignore_semiconvection">conv_vel_ignore_semiconvection <a href="#conv_vel_ignore_semiconvection" title="Permalink to this location">¶</a></h3>


If false, then mlt will consider a convective velocity given by 3*D/Lambda
as an additional source for the conv_vel equation (can be set for either
thermohaline or semiconvective mixing). Thermohaline mixing can change
a lot, and its inclusion makes things unstable, so by default we only keep
semiconvection. It true, then the corresponding mixing coefficient is calculated
in the regular way and added up to the final mixing coefficient.

{% highlight fortran %}
conv_vel_ignore_thermohaline = .true.
conv_vel_ignore_semiconvection = .false.
{% endhighlight %}


<h3 id="conv_vel_fully_lagrangian">conv_vel_fully_lagrangian <a href="#conv_vel_fully_lagrangian" title="Permalink to this location">¶</a></h3>


<h3 id="conv_vel_include_homologous_term">conv_vel_include_homologous_term <a href="#conv_vel_include_homologous_term" title="Permalink to this location">¶</a></h3>


If conv_vel_fully_lagrangian is true, then time derivatives for convective
velocities are computed fully lagrangian, using values from the previous step
at constant mass. Otherwise, on the outer layers of the star the term time
derivative is computed using a time derivative at fixed mass
ratio q (so-called non-homologous term), and the derivative with respect to q
(so-called homologous term).
if conv_vel_include_homologous_term is false, then the homologous term is
ignored.

{% highlight fortran %}
conv_vel_fully_lagrangian = .false.
conv_vel_include_homologous_term = .true.
{% endhighlight %}


<h3 id="conv_vel_use_mlt_vc_start">conv_vel_use_mlt_vc_start <a href="#conv_vel_use_mlt_vc_start" title="Permalink to this location">¶</a></h3>


If true, then the value of the convective velocity from mlt is used
throughout all newton iterations rather than being updated at each.

{% highlight fortran %}
conv_vel_use_mlt_vc_start = .true.
{% endhighlight %}

<h1 id="solver_controls">solver controls <a href="#solver_controls" title="Permalink to this location">¶</a></h1>


the following is from a response on mesa-users to a question about controls
for solver tolerances:

The "residual" is the left over difference between the left and right hand sides
of the equation we are trying to solve.  We do iterations to reduce that, but we
are limited by the non-linearity of the problem and the quality of the estimates
for the derivatives.

The "correction" is the change in the primary variable that is calculated using
good-old Newton's rule in multiple dimensions --- so Jacobian and residuals give
a correction that would make the next residual vanish if the problem were linear
and the Jacobian was exact, neither of which are true.  So the best we can hope
for is that the corrections will get smaller next time.

The "norm" is the average; the "max" is the max.  Sometimes you mainly care about
the norm and will accept a few outliers.  But sometimes you don't want any really
bad outliers, so you want to set a low limit for the max residual or correction
as well as the norm.

You might want to try for several iterations with strict tolerances, and then
relax them if things are still not converged.  For example, you might be willing
to live with the larger tolerances, but you'd like to give it a good try at the
smaller ones before switching.  Also, you might be willing to settle for any-old
residual if the corrections have become small enough.  You can do that too by
relaxing the residual tolerances after a few iterations.

Hope that at least helps with the nomenclature.

I agree with Frank that you should consider the effects of smaller timesteps and
more grid points as your main technique --- tightening up the tolerances for the
solver won't help if you are taking timesteps that are too large or if you have
inadequate grid resolution.

<h3 id="tol_correction_norm">tol_correction_norm <a href="#tol_correction_norm" title="Permalink to this location">¶</a></h3>


<h3 id="tol_max_correction">tol_max_correction <a href="#tol_max_correction" title="Permalink to this location">¶</a></h3>


"Correction" for variable x(i,k) is scaled change, dx(i,k)/xscale(i,k).
these tolerances are for the magnitude of the scaled corrections.

{% highlight fortran %}
tol_correction_norm = 3d-5
tol_max_correction = 3d-3
{% endhighlight %}


<h3 id="tol_correction_high_T_limit">tol_correction_high_T_limit <a href="#tol_correction_high_T_limit" title="Permalink to this location">¶</a></h3>


For very late stages of massive star evolution, need to relax tolerances.
If max T >= this limit, switch scaling factors.

{% highlight fortran %}
tol_correction_high_T_limit = 1d9
{% endhighlight %}


<h3 id="tol_correction_norm_high_T">tol_correction_norm_high_T <a href="#tol_correction_norm_high_T" title="Permalink to this location">¶</a></h3>


<h3 id="tol_max_correction_high_T">tol_max_correction_high_T <a href="#tol_max_correction_high_T" title="Permalink to this location">¶</a></h3>


Above `tol_correction_high_T_limit` use these scaling factors.

{% highlight fortran %}
tol_correction_norm_high_T = 3d-3
tol_max_correction_high_T = 3d-1
{% endhighlight %}


<h3 id="tol_correction_extreme_T_limit">tol_correction_extreme_T_limit <a href="#tol_correction_extreme_T_limit" title="Permalink to this location">¶</a></h3>


For very late stages of massive star evolution, need to relax tolerances.
If center T >= this limit, switch scaling factors.

{% highlight fortran %}
tol_correction_extreme_T_limit = 6d9
{% endhighlight %}


<h3 id="tol_correction_norm_extreme_T">tol_correction_norm_extreme_T <a href="#tol_correction_norm_extreme_T" title="Permalink to this location">¶</a></h3>


<h3 id="tol_max_correction_extreme_T">tol_max_correction_extreme_T <a href="#tol_max_correction_extreme_T" title="Permalink to this location">¶</a></h3>


For very late stages of massive star evolution, need to relax tolerances.
If center T >= this limit, switch scaling factors.

{% highlight fortran %}
tol_correction_norm_extreme_T = 8d-3
tol_max_correction_extreme_T = 8d-1
{% endhighlight %}


<h3 id="tol_bad_max_correction">tol_bad_max_correction <a href="#tol_bad_max_correction" title="Permalink to this location">¶</a></h3>


if `max_correction > tol_max_correction` and no more iterations allowed,
then still accept the solution if `max_correction <= tol_bad_max_correction`.
but if `max_correction > tol_bad_max_correction`, then reject the solution.

{% highlight fortran %}
tol_bad_max_correction = 0d0
{% endhighlight %}


<h3 id="bad_max_correction_series_limit">bad_max_correction_series_limit <a href="#bad_max_correction_series_limit" title="Permalink to this location">¶</a></h3>


If have this many steps in a row with `max_correction > tol_max_correction`,
then do a retry with a smaller timestep.

{% highlight fortran %}
bad_max_correction_series_limit = 2
{% endhighlight %}


<h3 id="relax_use_gold_tolerances">relax_use_gold_tolerances <a href="#relax_use_gold_tolerances" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
relax_use_gold_tolerances = .false.
{% endhighlight %}


<h3 id="relax_newton_iterations_limit">relax_newton_iterations_limit <a href="#relax_newton_iterations_limit" title="Permalink to this location">¶</a></h3>


<h3 id="relax_newton_iterations_hard_limit_________">relax_newton_iterations_hard_limit          <a href="#relax_newton_iterations_hard_limit_________" title="Permalink to this location">¶</a></h3>


<h3 id="relax_tol_correction_norm">relax_tol_correction_norm <a href="#relax_tol_correction_norm" title="Permalink to this location">¶</a></h3>


<h3 id="relax_tol_max_correction_________">relax_tol_max_correction          <a href="#relax_tol_max_correction_________" title="Permalink to this location">¶</a></h3>


<h3 id="relax_tol_residual_norm1">relax_tol_residual_norm1 <a href="#relax_tol_residual_norm1" title="Permalink to this location">¶</a></h3>


<h3 id="relax_tol_max_residual1">relax_tol_max_residual1 <a href="#relax_tol_max_residual1" title="Permalink to this location">¶</a></h3>


<h3 id="relax_iter_for_resid_tol2_________">relax_iter_for_resid_tol2          <a href="#relax_iter_for_resid_tol2_________" title="Permalink to this location">¶</a></h3>


<h3 id="relax_tol_residual_norm2">relax_tol_residual_norm2 <a href="#relax_tol_residual_norm2" title="Permalink to this location">¶</a></h3>


<h3 id="relax_tol_max_residual2">relax_tol_max_residual2 <a href="#relax_tol_max_residual2" title="Permalink to this location">¶</a></h3>


<h3 id="relax_iter_for_resid_tol3_________">relax_iter_for_resid_tol3          <a href="#relax_iter_for_resid_tol3_________" title="Permalink to this location">¶</a></h3>


<h3 id="relax_tol_residual_norm3">relax_tol_residual_norm3 <a href="#relax_tol_residual_norm3" title="Permalink to this location">¶</a></h3>


<h3 id="relax_tol_max_residual3">relax_tol_max_residual3 <a href="#relax_tol_max_residual3" title="Permalink to this location">¶</a></h3>


<h3 id="relax_maxT_for_gold_tolerances">relax_maxT_for_gold_tolerances <a href="#relax_maxT_for_gold_tolerances" title="Permalink to this location">¶</a></h3>


<h3 id="relax_max_eosPC_frac_for_gold_tolerances">relax_max_eosPC_frac_for_gold_tolerances <a href="#relax_max_eosPC_frac_for_gold_tolerances" title="Permalink to this location">¶</a></h3>


For use during relax operations.   Only used if /= 0.

{% highlight fortran %}
relax_newton_iterations_limit = 0
relax_newton_iterations_hard_limit = 0
{% endhighlight %}


{% highlight fortran %}
relax_tol_correction_norm = 0d0
relax_tol_max_correction = 0d0
{% endhighlight %}


{% highlight fortran %}
relax_tol_residual_norm1 = 0d0
relax_tol_max_residual1 = 0d0
relax_iter_for_resid_tol2 = 3
{% endhighlight %}


{% highlight fortran %}
relax_tol_residual_norm2 = 0d0
relax_tol_max_residual2 = 0d0
relax_iter_for_resid_tol3 = 0
{% endhighlight %}


{% highlight fortran %}
relax_tol_residual_norm3 = 0d0
relax_tol_max_residual3 = 0d0
relax_maxT_for_gold_tolerances = -1d0
relax_max_eosPC_frac_for_gold_tolerances = 0d0
{% endhighlight %}


<h3 id="include_L_in_error_est">include_L_in_error_est <a href="#include_L_in_error_est" title="Permalink to this location">¶</a></h3>


<h3 id="include_v_in_error_est">include_v_in_error_est <a href="#include_v_in_error_est" title="Permalink to this location">¶</a></h3>


<h3 id="include_u_in_error_est">include_u_in_error_est <a href="#include_u_in_error_est" title="Permalink to this location">¶</a></h3>


Some variables can be excluded from calculation of correction norm and max.

{% highlight fortran %}
include_L_in_error_est = .false.
include_v_in_error_est = .false.
include_u_in_error_est = .false.
{% endhighlight %}


<h3 id="tol_correction_norm_alt">tol_correction_norm_alt <a href="#tol_correction_norm_alt" title="Permalink to this location">¶</a></h3>


<h3 id="tol_max_correction_alt">tol_max_correction_alt <a href="#tol_max_correction_alt" title="Permalink to this location">¶</a></h3>


If you have several backups in a row, your run is having a near death experience.
So as a last hope, try relaxing the correction tolerances.  It might help.
The code will use these tolerances after 3 or more backups in a row.
Once there is a step without a backup, it goes back to the normal tolerances.

{% highlight fortran %}
tol_correction_norm_alt = 1d-3
tol_max_correction_alt = 1d-2
{% endhighlight %}


<h3 id="correction_xa_limit">correction_xa_limit <a href="#correction_xa_limit" title="Permalink to this location">¶</a></h3>


Ignore correction to abundance when calculating correction norm and max
if current mass fraction is less than this limit.

{% highlight fortran %}
correction_xa_limit = 5d-3
{% endhighlight %}


<h3 id="xa_scale">xa_scale <a href="#xa_scale" title="Permalink to this location">¶</a></h3>


Scaling for abundance variables is `max(xa_scale, current mass fraction)`.

{% highlight fortran %}
xa_scale = 1d-5
{% endhighlight %}


<h3 id="tol_residual_norm1">tol_residual_norm1 <a href="#tol_residual_norm1" title="Permalink to this location">¶</a></h3>


<h3 id="tol_max_residual1">tol_max_residual1 <a href="#tol_max_residual1" title="Permalink to this location">¶</a></h3>


<h3 id="iter_for_resid_tol2">iter_for_resid_tol2 <a href="#iter_for_resid_tol2" title="Permalink to this location">¶</a></h3>


"residual" for equation is the difference between left and right sides
use `tol_residual_norm1` & `tol_max_residual1`
at iteration number `iter_for_resid_tol2`, switch to next tolerances.

{% highlight fortran %}
tol_residual_norm1 = 1d-10
tol_max_residual1 = 1d-9
iter_for_resid_tol2 = 6
{% endhighlight %}


<h3 id="tol_residual_norm2">tol_residual_norm2 <a href="#tol_residual_norm2" title="Permalink to this location">¶</a></h3>


<h3 id="tol_max_residual2">tol_max_residual2 <a href="#tol_max_residual2" title="Permalink to this location">¶</a></h3>


<h3 id="iter_for_resid_tol3">iter_for_resid_tol3 <a href="#iter_for_resid_tol3" title="Permalink to this location">¶</a></h3>


Use `tol_residual_norm2` & `tol_max_residual2`
these apply starting at iteration number `iter_for_resid_tol2`.
at iteration number `iter_for_resid_tol3`, switch to next tolerances.

{% highlight fortran %}
tol_residual_norm2 = 1d99
tol_max_residual2 = 1d99
iter_for_resid_tol3 = 15
{% endhighlight %}


<h3 id="tol_residual_norm3">tol_residual_norm3 <a href="#tol_residual_norm3" title="Permalink to this location">¶</a></h3>


<h3 id="tol_max_residual3">tol_max_residual3 <a href="#tol_max_residual3" title="Permalink to this location">¶</a></h3>


Use `tol_residual_norm3` & `tol_max_residual3`
these apply starting at iteration number `iter_for_resid_tol3`.

{% highlight fortran %}
tol_residual_norm3 = 1d99
tol_max_residual3 = 1d99
{% endhighlight %}


If things get worse from one iteration to next, give up.
The following are the limits that define "getting worse enough to stop".

<h3 id="corr_norm_jump_limit">corr_norm_jump_limit <a href="#corr_norm_jump_limit" title="Permalink to this location">¶</a></h3>


If correction norm increases by this factor or more, quit.

{% highlight fortran %}
corr_norm_jump_limit = 1d99
{% endhighlight %}


<h3 id="max_corr_jump_limit">max_corr_jump_limit <a href="#max_corr_jump_limit" title="Permalink to this location">¶</a></h3>


If correction max increases by this factor or more, quit.

{% highlight fortran %}
max_corr_jump_limit = 1d6
{% endhighlight %}


<h3 id="resid_norm_jump_limit">resid_norm_jump_limit <a href="#resid_norm_jump_limit" title="Permalink to this location">¶</a></h3>


If residual norm increases by this factor or more, quit.

{% highlight fortran %}
resid_norm_jump_limit = 1d99
{% endhighlight %}


<h3 id="max_resid_jump_limit">max_resid_jump_limit <a href="#max_resid_jump_limit" title="Permalink to this location">¶</a></h3>


If residual max increases by this factor or more, quit.

{% highlight fortran %}
max_resid_jump_limit = 1d6
{% endhighlight %}


<h3 id="max_iterations_for_jacobian">max_iterations_for_jacobian <a href="#max_iterations_for_jacobian" title="Permalink to this location">¶</a></h3>


EXPERIEMENTAL: not working at present.  leave at 1.
Jacobian is always created fresh for 1st iteration.
If this param > 1, then will try to reuse jacobian.
After use jacobian this many times, remake it.
E.g., if = 2, then will make a new jacobian for every other iteration.
This is automatically = 1 immediately following a backup.

{% highlight fortran %}
max_iterations_for_jacobian = 1
{% endhighlight %}


<h3 id="convergence_ignore_equL_residuals">convergence_ignore_equL_residuals <a href="#convergence_ignore_equL_residuals" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
convergence_ignore_equL_residuals = .false.
{% endhighlight %}


<h3 id="convergence_separate_equ_conv_vel_residuals">convergence_separate_equ_conv_vel_residuals <a href="#convergence_separate_equ_conv_vel_residuals" title="Permalink to this location">¶</a></h3>


<h3 id="conv_vel_residual_tol">conv_vel_residual_tol <a href="#conv_vel_residual_tol" title="Permalink to this location">¶</a></h3>


if convergence_separate_equ_conv_vel_residuals is .true., when
using convective velocity variables the residuals of the
convective velocity equation are treated separetely. In this
case only the max residual is checked against
conv_vel_max_residual_tol. The low precision is due to double
precision float limitations, which do not allow arbitrary precision.
However, despite the relaxed tolerance on the equations, the actual
value of the convective velocity can be solved down to machine precision.

{% highlight fortran %}
convergence_separate_equ_conv_vel_residuals = .true.
conv_vel_tol_max_residual = 5d-2
{% endhighlight %}


<h3 id="convergence_separate_equ_conv_vel_corrections">convergence_separate_equ_conv_vel_corrections <a href="#convergence_separate_equ_conv_vel_corrections" title="Permalink to this location">¶</a></h3>


<h3 id="conv_vel_correction_tol">conv_vel_correction_tol <a href="#conv_vel_correction_tol" title="Permalink to this location">¶</a></h3>


Similar to convergence_separate_equ_conv_vel_residuals, separates
correction for conv_vel and only applies the conv_vel_max_correction_tol
criteria for a solution. It also allows to define a different scaling for the
correction that takes into account just the changes in the convective velocity
variable, conv_vel_scale_max_correction. Note that the correction represents
changes on the variable ln(conv_vel + s% conv_vel_v0) rather than the actual
convective velocity.

{% highlight fortran %}
convergence_separate_equ_conv_vel_corrections = .true.
conv_vel_tol_max_correction = 1d-3
conv_vel_min_correction_to_ignore_residual = 1d-8
conv_vel_scale_max_correction = 5d0
{% endhighlight %}


<h3 id="conv_vel_newton_itermin_until_reduce_min_corr_coeff">conv_vel_newton_itermin_until_reduce_min_corr_coeff <a href="#conv_vel_newton_itermin_until_reduce_min_corr_coeff" title="Permalink to this location">¶</a></h3>


<h3 id="conv_vel_corr_coeff_limit">conv_vel_corr_coeff_limit <a href="#conv_vel_corr_coeff_limit" title="Permalink to this location">¶</a></h3>


When using conv_vel, use this value instead of
newton_itermin_until_reduce_min_corr_coeff
and corr_coeff_limit

{% highlight fortran %}
conv_vel_newton_itermin_until_reduce_min_corr_coeff = 15
conv_vel_corr_coeff_limit = 0.05d0
{% endhighlight %}


<h3 id="trace_newton_damping">trace_newton_damping <a href="#trace_newton_damping" title="Permalink to this location">¶</a></h3>


Send newton damping data to screen.

{% highlight fortran %}
trace_newton_damping = .false.
{% endhighlight %}


<h3 id="hydro_decsol_switch">hydro_decsol_switch <a href="#hydro_decsol_switch" title="Permalink to this location">¶</a></h3>


<h3 id="small_mtx_decsol">small_mtx_decsol <a href="#small_mtx_decsol" title="Permalink to this location">¶</a></h3>


<h3 id="large_mtx_decsol">large_mtx_decsol <a href="#large_mtx_decsol" title="Permalink to this location">¶</a></h3>


If current `nvar <= hydro_decsol_switch`,  (recall `nvar = nvar_hydro + species`)
then use `small_mtx_decsol` for current step, else use `large_mtx_decsol`.

Options for `small_mtx_decsol` are `'block_thomas_dble'` or `'bcyclic_dble'`.

Options for `large_mtx_decsol` are `'bcyclic_klu'`.

{% highlight fortran %}
hydro_decsol_switch = 99999999
small_mtx_decsol = 'bcyclic_dble'
large_mtx_decsol = 'bcyclic_klu'
{% endhighlight %}


<h3 id="star_bcyclic_do_pivot">star_bcyclic_do_pivot <a href="#star_bcyclic_do_pivot" title="Permalink to this location">¶</a></h3>


Controls whether or not do pivoting in matrix solves in star bcyclic.

{% highlight fortran %}
star_bcyclic_do_pivot = .true.
{% endhighlight %}


<h3 id="max_tries">max_tries <a href="#max_tries" title="Permalink to this location">¶</a></h3>


Max number newton iterations before give up.

{% highlight fortran %}
max_tries = 25
{% endhighlight %}


<h3 id="max_tries1">max_tries1 <a href="#max_tries1" title="Permalink to this location">¶</a></h3>


Max tries on 1st model.

{% highlight fortran %}
max_tries1 = 250
{% endhighlight %}


<h3 id="max_tries_for_retry">max_tries_for_retry <a href="#max_tries_for_retry" title="Permalink to this location">¶</a></h3>


Normal number of retries.

{% highlight fortran %}
max_tries_for_retry = 25
{% endhighlight %}


<h3 id="max_tries_after_5_retries">max_tries_after_5_retries <a href="#max_tries_after_5_retries" title="Permalink to this location">¶</a></h3>


Increase number of tries after 5 failed ones.

{% highlight fortran %}
max_tries_after_5_retries = 35
{% endhighlight %}


<h3 id="max_tries_after_10_retries">max_tries_after_10_retries <a href="#max_tries_after_10_retries" title="Permalink to this location">¶</a></h3>


Increase number of tries after 10 failed ones.

{% highlight fortran %}
max_tries_after_10_retries = 50
{% endhighlight %}


<h3 id="max_tries_after_20_retries">max_tries_after_20_retries <a href="#max_tries_after_20_retries" title="Permalink to this location">¶</a></h3>


Increase number of tries after 20 failed ones.

{% highlight fortran %}
max_tries_after_20_retries = 75
{% endhighlight %}


<h3 id="max_tries_after_backup">max_tries_after_backup <a href="#max_tries_after_backup" title="Permalink to this location">¶</a></h3>


Max tries after first backup.

{% highlight fortran %}
max_tries_after_backup = 25
{% endhighlight %}


<h3 id="max_tries_after_backup2">max_tries_after_backup2 <a href="#max_tries_after_backup2" title="Permalink to this location">¶</a></h3>


Max tries after second backup.

{% highlight fortran %}
max_tries_after_backup2 = 25
{% endhighlight %}


<h3 id="retry_limit">retry_limit <a href="#retry_limit" title="Permalink to this location">¶</a></h3>


Only use if > 0.
In case the solver fails for some reason, it will retry with a smaller timestep.
It does up to this many retries for the current step
before doing a backup to the previous step.

{% highlight fortran %}
retry_limit = 2
{% endhighlight %}


<h3 id="redo_limit">redo_limit <a href="#redo_limit" title="Permalink to this location">¶</a></h3>


Only use if > 0.
Do up to this many redo's for the current step
before doing a backup to the previous step.

{% highlight fortran %}
redo_limit = 100
{% endhighlight %}


<h3 id="newton_itermin">newton_itermin <a href="#newton_itermin" title="Permalink to this location">¶</a></h3>


Use at least this many iterations in newton for hydro solve.

{% highlight fortran %}
newton_itermin = 2
{% endhighlight %}


<h3 id="newton_itermin_until_reduce_min_corr_coeff">newton_itermin_until_reduce_min_corr_coeff <a href="#newton_itermin_until_reduce_min_corr_coeff" title="Permalink to this location">¶</a></h3>


Use at least this many iterations in newton
before try using small `min_corr_coeff`

{% highlight fortran %}
newton_itermin_until_reduce_min_corr_coeff = 8
{% endhighlight %}


<h3 id="newton_reduced_min_corr_coeff">newton_reduced_min_corr_coeff <a href="#newton_reduced_min_corr_coeff" title="Permalink to this location">¶</a></h3>


For use with `newton_itermin_for_reduce_min_corr_coeff`.

{% highlight fortran %}
newton_reduced_min_corr_coeff = 0.1d0
{% endhighlight %}


<h3 id="tiny_corr_coeff_limit">tiny_corr_coeff_limit <a href="#tiny_corr_coeff_limit" title="Permalink to this location">¶</a></h3>


<h3 id="scale_correction_norm">scale_correction_norm <a href="#scale_correction_norm" title="Permalink to this location">¶</a></h3>


<h3 id="corr_param_factor">corr_param_factor <a href="#corr_param_factor" title="Permalink to this location">¶</a></h3>


<h3 id="scale_max_correction">scale_max_correction <a href="#scale_max_correction" title="Permalink to this location">¶</a></h3>


<h3 id="ignore_too_large_correction">ignore_too_large_correction <a href="#ignore_too_large_correction" title="Permalink to this location">¶</a></h3>


<h3 id="corr_coeff_limit">corr_coeff_limit <a href="#corr_coeff_limit" title="Permalink to this location">¶</a></h3>


<h3 id="tiny_corr_factor">tiny_corr_factor <a href="#tiny_corr_factor" title="Permalink to this location">¶</a></h3>


<h3 id="ignore_species_in_max_correction">ignore_species_in_max_correction <a href="#ignore_species_in_max_correction" title="Permalink to this location">¶</a></h3>


see star/private/star_newton for info about these

{% highlight fortran %}
tiny_corr_coeff_limit = 5
scale_correction_norm = 0.1
corr_param_factor = 10
scale_max_correction = 1d99
ignore_too_large_correction = .false.
corr_coeff_limit = 1d-2
tiny_corr_factor = 2
ignore_species_in_max_correction = .false.
{% endhighlight %}


<h3 id="min_xa_hard_limit">min_xa_hard_limit <a href="#min_xa_hard_limit" title="Permalink to this location">¶</a></h3>


<h3 id="min_xa_hard_limit_for_highT">min_xa_hard_limit_for_highT <a href="#min_xa_hard_limit_for_highT" title="Permalink to this location">¶</a></h3>


If solver produces mass fraction < this limit,
then reject the trial solution.
Can optionally relax this limit at high T.

{% highlight fortran %}
min_xa_hard_limit = -1d-5
min_xa_hard_limit_for_highT = -3d-5
{% endhighlight %}


<h3 id="logT_max_for_xa_hard_limit">logT_max_for_xa_hard_limit <a href="#logT_max_for_xa_hard_limit" title="Permalink to this location">¶</a></h3>


Use `min_xa_hard_limit` for center logT <= this.

{% highlight fortran %}
logT_max_for_min_xa_hard_limit = 9.49d0
{% endhighlight %}


<h3 id="logT_min_for_xa_hard_limit_for_highT">logT_min_for_xa_hard_limit_for_highT <a href="#logT_min_for_xa_hard_limit_for_highT" title="Permalink to this location">¶</a></h3>


Use `min_xa_hard_limit_for_highT` for center logT >= this.
Linear interpolate in logT for intermediate center temperatures.

{% highlight fortran %}
logT_min_for_min_xa_hard_limit_for_highT = 9.51d0
{% endhighlight %}


<h3 id="sum_xa_hard_limit">sum_xa_hard_limit <a href="#sum_xa_hard_limit" title="Permalink to this location">¶</a></h3>


<h3 id="sum_xa_hard_limit_for_highT">sum_xa_hard_limit_for_highT <a href="#sum_xa_hard_limit_for_highT" title="Permalink to this location">¶</a></h3>


If solver produces any cell with abs(sum(xa)-1) > this limit,
then reject the trial solution.
Can optionally relax this limit at high T.

{% highlight fortran %}
sum_xa_hard_limit = 5d-4
sum_xa_hard_limit_for_highT = 1d-3
{% endhighlight %}


<h3 id="logT_max_for_sum_xa_hard_limit">logT_max_for_sum_xa_hard_limit <a href="#logT_max_for_sum_xa_hard_limit" title="Permalink to this location">¶</a></h3>


Use `sum_xa_hard_limit` for center logT <= this.

{% highlight fortran %}
logT_max_for_sum_xa_hard_limit = 9.40d0
{% endhighlight %}


<h3 id="logT_min_for_sum_xa_hard_limit_for_highT">logT_min_for_sum_xa_hard_limit_for_highT <a href="#logT_min_for_sum_xa_hard_limit_for_highT" title="Permalink to this location">¶</a></h3>


Use `sum_xa_hard_limit_for_highT` for center logT >= this.
Linear interpolate in logT for intermediate center temperatures.

{% highlight fortran %}
logT_min_for_sum_xa_hard_limit_for_highT = 9.44d0
{% endhighlight %}


<h3 id="do_newton_damping_for_neg_xa">do_newton_damping_for_neg_xa <a href="#do_newton_damping_for_neg_xa" title="Permalink to this location">¶</a></h3>


If true, uniformly reduce newton corrections if necessary to avoid neg abundances.

{% highlight fortran %}
do_newton_damping_for_neg_xa = .true.
{% endhighlight %}


<h3 id="min_logT_for_quad">min_logT_for_quad <a href="#min_logT_for_quad" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
min_logT_for_quad = 99
{% endhighlight %}


<h3 id="min_chem_eqn_scale">min_chem_eqn_scale <a href="#min_chem_eqn_scale" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
min_chem_eqn_scale = 1d0
{% endhighlight %}


<h3 id="hydro_mtx_max_allowed_absdlogT___dlogRho__dlogPgas__logT__logRho__logPgas">hydro_mtx_max_allowed_{abs}{dlogT  | dlogRho | dlogPgas | logT | logRho | logPgas} <a href="#hydro_mtx_max_allowed_absdlogT___dlogRho__dlogPgas__logT__logRho__logPgas" title="Permalink to this location">¶</a></h3>


Force retry with smaller timestep if hydro solves change T, Rho, or Pgas by too much
or make them too large.

{% highlight fortran %}
hydro_mtx_max_allowed_abs_dlogT = 99d0
hydro_mtx_max_allowed_abs_dlogE = 99d0
hydro_mtx_max_allowed_abs_dlogRho = 99d0
hydro_mtx_max_allowed_abs_dlogPgas = 99d0
min_logT_for_hydro_mtx_max_allowed = -1d99
hydro_mtx_max_allowed_logT = 12d0
hydro_mtx_max_allowed_logRho = 12d0
hydro_mtx_max_allowed_logE = 99d0
hydro_mtx_max_allowed_logPgas = 99d0
{% endhighlight %}


{% highlight fortran %}
hydro_mtx_min_allowed_logT = 1d0
hydro_mtx_min_allowed_logRho = -1d2
{% endhighlight %}


<h3 id="solver_clip_dlogT">solver_clip_dlogT <a href="#solver_clip_dlogT" title="Permalink to this location">¶</a></h3>


<h3 id="solver_clip_dlogRho">solver_clip_dlogRho <a href="#solver_clip_dlogRho" title="Permalink to this location">¶</a></h3>


<h3 id="solver_clip_dlogPgas">solver_clip_dlogPgas <a href="#solver_clip_dlogPgas" title="Permalink to this location">¶</a></h3>


<h3 id="solver_clip_dlogR">solver_clip_dlogR <a href="#solver_clip_dlogR" title="Permalink to this location">¶</a></h3>


Limit magnitude of relative changes per iteration in solver.
Ignore if limit is <= 0.

{% highlight fortran %}
solver_clip_dlogT = -1d0
solver_clip_dlogRho = -1d0
solver_clip_dlogPgas = -1d0
solver_clip_dlogR = -1d0
{% endhighlight %}


gold tolerances for newton solver

<h3 id="use_gold_tolerances">use_gold_tolerances <a href="#use_gold_tolerances" title="Permalink to this location">¶</a></h3>


<h3 id="steps_before_use_gold_tolerances">steps_before_use_gold_tolerances <a href="#steps_before_use_gold_tolerances" title="Permalink to this location">¶</a></h3>


<h3 id="gold_newton_iterations_limit">gold_newton_iterations_limit <a href="#gold_newton_iterations_limit" title="Permalink to this location">¶</a></h3>


<h3 id="gold_newton_iterations_hard_limit">gold_newton_iterations_hard_limit <a href="#gold_newton_iterations_hard_limit" title="Permalink to this location">¶</a></h3>


<h3 id="maxT_for_gold_tolerances">maxT_for_gold_tolerances <a href="#maxT_for_gold_tolerances" title="Permalink to this location">¶</a></h3>


<h3 id="max_eosPC_frac_for_gold_tolerances">max_eosPC_frac_for_gold_tolerances <a href="#max_eosPC_frac_for_gold_tolerances" title="Permalink to this location">¶</a></h3>


<h3 id="gold_tol_residual_norm1">gold_tol_residual_norm1 <a href="#gold_tol_residual_norm1" title="Permalink to this location">¶</a></h3>


<h3 id="gold_iter_for_resid_tol2">gold_iter_for_resid_tol2 <a href="#gold_iter_for_resid_tol2" title="Permalink to this location">¶</a></h3>


<h3 id="gold_tol_residual_norm2">gold_tol_residual_norm2 <a href="#gold_tol_residual_norm2" title="Permalink to this location">¶</a></h3>


<h3 id="gold_tol_max_residual2">gold_tol_max_residual2 <a href="#gold_tol_max_residual2" title="Permalink to this location">¶</a></h3>


<h3 id="gold_iter_for_resid_tol3">gold_iter_for_resid_tol3 <a href="#gold_iter_for_resid_tol3" title="Permalink to this location">¶</a></h3>


<h3 id="gold_tol_residual_norm3">gold_tol_residual_norm3 <a href="#gold_tol_residual_norm3" title="Permalink to this location">¶</a></h3>


<h3 id="gold_tol_max_residual3______">gold_tol_max_residual3       <a href="#gold_tol_max_residual3______" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
use_gold_tolerances = .true.
{% endhighlight %}


{% highlight fortran %}
steps_before_use_gold_tolerances = -1
{% endhighlight %}


if >= 0, then after this many steps in run, act as if use_gold_tolerances true
this allows a delay before turning on gold tolerances
may be useful in case making big parameter changes at start

{% highlight fortran %}
maxT_for_gold_tolerances = 1d99
max_eosPC_frac_for_gold_tolerances = -1d0
{% endhighlight %}


only use gold if frac of eosPC for inner cell is <= this.

{% highlight fortran %}
gold_tol_residual_norm1 = 1d-11
gold_tol_max_residual1 = 1d-9
gold_iter_for_resid_tol2 = 5
gold_tol_residual_norm2 = 1d-8
gold_tol_max_residual2 = 1d-6
gold_iter_for_resid_tol3 = 10
gold_tol_residual_norm3 = 1d-6
gold_tol_max_residual3 = 1d-4
{% endhighlight %}


{% highlight fortran %}
gold_newton_iterations_limit = 14
gold_newton_iterations_hard_limit = -1
{% endhighlight %}


<h3 id="include_rotation_in_total_energy">include_rotation_in_total_energy <a href="#include_rotation_in_total_energy" title="Permalink to this location">¶</a></h3>


<h3 id="previously_called_include_rotation_in_energy_error_report">previously called `include_rotation_in_energy_error_report` <a href="#previously_called_include_rotation_in_energy_error_report" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
include_rotation_in_total_energy = .false.
{% endhighlight %}


<h3 id="quad_eval1_non_Riemann_energy_flux">quad_eval1_non_Riemann_energy_flux <a href="#quad_eval1_non_Riemann_energy_flux" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
quad_eval1_non_Riemann_energy_flux = .true.
{% endhighlight %}


artificial viscosity

<h3 id="eps_visc_factor">eps_visc_factor <a href="#eps_visc_factor" title="Permalink to this location">¶</a></h3>


multiply the eps_visc term in energy equation by this factor.

{% highlight fortran %}
eps_visc_factor = 1d0
{% endhighlight %}


<h3 id="dvdt_visc_factor">dvdt_visc_factor <a href="#dvdt_visc_factor" title="Permalink to this location">¶</a></h3>


multiply the dvdt_visc term in momentum equation by this factor.

{% highlight fortran %}
dvdt_visc_factor = 1d0
{% endhighlight %}


<h3 id="use_artificial_viscosity">use_artificial_viscosity <a href="#use_artificial_viscosity" title="Permalink to this location">¶</a></h3>


artificial viscosity -- only applies when using velocity variables

{% highlight fortran %}
use_artificial_viscosity = .false.
{% endhighlight %}


<h3 id="artificial_viscosity_Q_shift">artificial_viscosity_Q_shift <a href="#artificial_viscosity_Q_shift" title="Permalink to this location">¶</a></h3>


    Qvisc = min(0d0, Qvisc + artificial_viscosity_Q_shift)

This serves to filter out use of artificial viscosity in low compression regions.
e.g., try `artificial_viscosity_Q_shift = 1d34`.

{% highlight fortran %}
artificial_viscosity_Q_shift = -1
{% endhighlight %}


<h3 id="post_shock_viscosity_decay_factor">post_shock_viscosity_decay_factor <a href="#post_shock_viscosity_decay_factor" title="Permalink to this location">¶</a></h3>


Exponential decrease in artificial viscosity inward from Mach 1 location.
The value of Qvisc is multiplied by `exp(-dist_to_Mach1/Hq)`
where Hq = this factor times the local radius
and `dist_to_Mach1` is the distance at the start of the current step
outward to the nearest Mach 1 location
if using both pre and post shock decay, use the closer Mach1

{% highlight fortran %}
post_shock_viscosity_decay_factor = -1
{% endhighlight %}


<h3 id="pre_shock_viscosity_decay_factor">pre_shock_viscosity_decay_factor <a href="#pre_shock_viscosity_decay_factor" title="Permalink to this location">¶</a></h3>


Exponential decrease in artificial viscosity outward from Mach 1 location.
The value of Qvisc is multiplied by `exp(-dist_to_Mach1/Hq)`
where Hq = this factor times the local radius
and `dist_to_Mach1` is the distance at the start of the current step
inward to the nearest Mach 1 location
if using both pre and post shock decay, use the closer Mach1

{% highlight fortran %}
pre_shock_viscosity_decay_factor = -1
{% endhighlight %}


<h3 id="shock_spread_quadratic">shock_spread_quadratic <a href="#shock_spread_quadratic" title="Permalink to this location">¶</a></h3>


the artificial viscosity coefficient includes a quadratic term that is
proportional to `(shock_spread_quadratic * r)^2`
where r is the local radius.

{% highlight fortran %}
shock_spread_quadratic = 1d-3
{% endhighlight %}


<h3 id="shock_spread_linear">shock_spread_linear <a href="#shock_spread_linear" title="Permalink to this location">¶</a></h3>


the artificial viscosity coefficient includes a linear term that is
proportional to `(shock_spread_linear * r * cs)`
where cs is the local sound speed and r is the local radius.

{% highlight fortran %}
shock_spread_linear = 0
{% endhighlight %}


<h3 id="art_visc_full_on_logRho_ge_this">art_visc_full_on_logRho_ge_this <a href="#art_visc_full_on_logRho_ge_this" title="Permalink to this location">¶</a></h3>


<h3 id="art_visc_full_off_logRho_le_this">art_visc_full_off_logRho_le_this <a href="#art_visc_full_off_logRho_le_this" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
art_visc_full_on_logRho_ge_this = -99
art_visc_full_off_logRho_le_this = -99
{% endhighlight %}

<h1 id="split_mixing">split mixing <a href="#split_mixing" title="Permalink to this location">¶</a></h1>


<h3 id="split_mixing_choice">split_mixing_choice <a href="#split_mixing_choice" title="Permalink to this location">¶</a></h3>


+  0 = no split = mixing coupled to burn and structure.
+ -1 = mix for full dt before burn+struct
+ -2 = mix for full dt after burn+struct
+ -3 = mix for dt/2 before and dt/2 after

{% highlight fortran %}
split_mixing_choice = 0
{% endhighlight %}


<h3 id="reset_mixing_info_before_final_mix">reset_mixing_info_before_final_mix <a href="#reset_mixing_info_before_final_mix" title="Permalink to this location">¶</a></h3>


Relevant for `split_mixing_choice` options -2 and -3.

{% highlight fortran %}
reset_mixing_info_before_final_mix = .true.
{% endhighlight %}


<h3 id="op_split_mix_atol">op_split_mix_atol <a href="#op_split_mix_atol" title="Permalink to this location">¶</a></h3>


<h3 id="op_split_mix_rtol">op_split_mix_rtol <a href="#op_split_mix_rtol" title="Permalink to this location">¶</a></h3>


Abolute and relative error tolerances.

{% highlight fortran %}
op_split_mix_atol = 1d-5
op_split_mix_rtol = 1d-6
{% endhighlight %}


controls related to split mixing for timesteps

<h3 id="max_fixup_for_mix_limit">max_fixup_for_mix_limit <a href="#max_fixup_for_mix_limit" title="Permalink to this location">¶</a></h3>


If `split_mix_fixup` is bigger than this, reduce the next timestep.

{% highlight fortran %}
max_fixup_for_mix_limit = 1d-3
{% endhighlight %}


<h3 id="max_fixup_for_mix_hard_limit">max_fixup_for_mix_hard_limit <a href="#max_fixup_for_mix_hard_limit" title="Permalink to this location">¶</a></h3>


If `split_mix_fixup` is bigger than this, retry.

{% highlight fortran %}
max_fixup_for_mix_hard_limit = 1d99
{% endhighlight %}


<h3 id="op_split_mix_trace">op_split_mix_trace <a href="#op_split_mix_trace" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
op_split_mix_trace = .false.
{% endhighlight %}


<h3 id="op_split_burn">op_split_burn <a href="#op_split_burn" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
op_split_burn = .false.
{% endhighlight %}


<h3 id="op_split_burn_min_T">op_split_burn_min_T <a href="#op_split_burn_min_T" title="Permalink to this location">¶</a></h3>


<h3 id="op_split_burn_min_T_for_variable_T_solver">op_split_burn_min_T_for_variable_T_solver <a href="#op_split_burn_min_T_for_variable_T_solver" title="Permalink to this location">¶</a></h3>


<h3 id="op_split_burn_eps">op_split_burn_eps <a href="#op_split_burn_eps" title="Permalink to this location">¶</a></h3>


<h3 id="op_split_burn_odescal">op_split_burn_odescal <a href="#op_split_burn_odescal" title="Permalink to this location">¶</a></h3>


Only do op_split_burn in cells with T >= this limit at start of step.

{% highlight fortran %}
op_split_burn_min_T = 2d9
op_split_burn_min_T_for_variable_T_solver = 1d99
op_split_burn_eps = 1d-5
op_split_burn_odescal = 1d-5
{% endhighlight %}


<h3 id="op_split_burn_eps_nuc_infall_limit">op_split_burn_eps_nuc_infall_limit <a href="#op_split_burn_eps_nuc_infall_limit" title="Permalink to this location">¶</a></h3>


turn off `op_split_burn` nuclear burning if max infall speed exceeds this limit (cm/s).

{% highlight fortran %}
op_split_burn_eps_nuc_infall_limit = 1d99
{% endhighlight %}

<h1 id="timestep_controls">timestep controls <a href="#timestep_controls" title="Permalink to this location">¶</a></h1>


The terminal output during evolution includes a short string for the `dt_limit`.
This is to give you some indication of what is limiting the time steps.
Here's a dictionary mapping those terminal strings to the corresponding control parameters.
(There is a similar table in `mesa/binary/defaults/binary_controls.defaults`.)

          terminal output       related parameter
         'burn steps'           burn_steps_limit
         'CpT_absMdot_div_L'    CpT_absMdot_div_L_limit
         'Lnuc'                 delta_lgL_nuc_limit
         'Lnuc_cat'             delta_lgL_nuc_cat_limit
         'Lnuc_H'               delta_lgL_H_limit
         'Lnuc_He'              delta_lgL_He_limit
         'Lnuc_photo'           delta_lgL_photo_limit
         'Lnuc_z'               delta_lgL_z_limit
         'bad_X_sum'            (solver found bad mass sum)
         'dH'                   dH_limit
         'dH/H'                 dH_div_H_limit
         'dHe'                  dHe_limit
         'dHe/He'               dHe_div_He_limit
         'dHe3'                 dHe3_limit
         'dHe3/He3'             dHe3_div_He3_limit
         'dL/L'                 dL_div_L_limit
         'dX'                   dX_limit
         'dX/X'                 dX_div_X_limit
         'dX_burn'              dX_nuc_drop_limit
         'd_delR_grow'          d_deltaR_grow_limit
         'd_delR_shrink'        d_deltaR_shrink_limit
         'delta Ye'             delta_Ye_limit
         'delta mdot'           delta_mdot_limit
         'delta total J'        delta_lg_total_J_limit
         'delta_HR'             delta_HR_limit
         'delta_mstar'          delta_lg_star_mass_limit
         'diff iters'           diffusion_iters_limit
         'diff steps'           diffusion_steps_limit
         'min_dr_div_cs'        dt_div_min_dr_div_cs_limit
         'dt_acoustic'          dt_div_dt_acoustic_limit
         'dt_collapse'          dt_div_dt_cell_collapse_limit
         'dt_dynamic'           dt_div_dt_dynamic_limit
         'dt_mass_loss'         dt_div_dt_mass_loss_limit
         'dt_thermal'           dt_div_dt_thermal_limit
         'eps_nuc_cntr'         delta_log_eps_nuc_cntr_limit
         'error rate'           limit_for_log_rel_rate_in_energy_conservation
         'highT del Ye'         delta_Ye_highT_limit
         'hold'                 (recent backup, so no increase in dt)
         'lgL'                  delta_lgL_limit
         'lgL_phot'             delta_lgL_phot_limit
         'lgP'                  delta_lgP_limit
         'lgP_cntr'             delta_lgP_cntr_limit
         'lgR'                  delta_lgR_limit
         'lgRho'                delta_lgRho_limit
         'lgRho_cntr'           delta_lgRho_cntr_limit
         'lgRho_max'            delta_lgRho_max_limit
         'lgT'                  delta_lgT_limit
         'lgT_cntr'             delta_lgT_cntr_limit
         'lgT_max'              delta_lgT_max_limit
         'lgTeff'               delta_lgTeff_limit
         'lg_XC_cntr'           delta_lg_XC_cntr_limit
         'lg_XH_cntr'           delta_lg_XH_cntr_limit
         'lg_XHe_cntr'          delta_lg_XHe_cntr_limit
         'lg_XNe_cntr'          delta_lg_XNe_cntr_limit
         'lg_XO_cntr'           delta_lg_XO_cntr_limit
         'lg_XSi_cntr'          delta_lg_XSi_cntr_limit
         'log_eps_nuc'          delta_log_eps_nuc_limit
         'max E resid'          limit_for_max_E_residual
         'max_dt'               max_years_for_timestep
         'max dt change'        max_timestep_factor
         'min dt change'        min_timestep_factor
         'neg_mass_frac'        (solver found neg mass frac)
         'newton iters'         newton_iterations_limit
         'rel_E_err'            limit_for_rel_error_in_energy_conservation
         'rotation steps'       rotation_steps_limit
         'v/v_crit'             v_div_v_crit_limit
         'varcontrol'           varcontrol_target
         'b_****'               see binary/defaults/binary_controls.defaults

<h3 id="max_timestep">max_timestep <a href="#max_timestep" title="Permalink to this location">¶</a></h3>


In seconds.  `max_timestep <= 0` means no upper limit.

{% highlight fortran %}
max_timestep = 0
{% endhighlight %}


<h3 id="max_years_for_timestep">max_years_for_timestep <a href="#max_years_for_timestep" title="Permalink to this location">¶</a></h3>


`max_years_for_timestep <= 0` means no upper limit.
Note: `max_timestep` is the control that is used by most of the code.
`max_years_for_timestep` is just provided as a convenience.
At the start of each step, the evolve routine checks to see if `max_years_for_timestep > 0`,
and if so, it sets `max_timestep = max_years_for_timestep*secyer`.

{% highlight fortran %}
max_years_for_timestep = 0
{% endhighlight %}


<h3 id="max_timestep_hi_T_limit">max_timestep_hi_T_limit <a href="#max_timestep_hi_T_limit" title="Permalink to this location">¶</a></h3>


If `max T >= this`, then switch to `hi_T_max_years_for_timestep`.
Ignore if <= 0.

{% highlight fortran %}
max_timestep_hi_T_limit = -1
{% endhighlight %}


<h3 id="hi_T_max_years_for_timestep">hi_T_max_years_for_timestep <a href="#hi_T_max_years_for_timestep" title="Permalink to this location">¶</a></h3>


Max years for timestep if `max_timestep_hi_T_limit` is active.

{% highlight fortran %}
hi_T_max_years_for_timestep = 0
{% endhighlight %}


<h3 id="min_timestep_factor">min_timestep_factor <a href="#min_timestep_factor" title="Permalink to this location">¶</a></h3>


Lower limit for ratio of new timestep to previous timestep.
i.e., allow dt to get smaller by no more than this factor -- 0 means no limit.

{% highlight fortran %}
min_timestep_factor = 0.8d0
{% endhighlight %}


<h3 id="force_timestep_min">force_timestep_min <a href="#force_timestep_min" title="Permalink to this location">¶</a></h3>


In seconds.  `force_timestep_min <= 0` means no forced lower limit.

{% highlight fortran %}
force_timestep_min = 0
{% endhighlight %}


<h3 id="force_timestep_min_years">force_timestep_min_years <a href="#force_timestep_min_years" title="Permalink to this location">¶</a></h3>


`force_timestep_min_years <= 0` means no forced lower limit.
Note: `force_timestep_min` is the control that is used by most of the code.
`force_timestep_min_years` is just provided as a convenience.
At the start of each step, the evolve routine checks if `force_timestep_min_years > 0`,
and if so, it sets `force_timestep_min = force_timestep_min_years*secyer`.

{% highlight fortran %}
force_timestep_min_years = 0
{% endhighlight %}


<h3 id="force_timestep_min_factor">force_timestep_min_factor <a href="#force_timestep_min_factor" title="Permalink to this location">¶</a></h3>


If dt is < `force_timestep_min`, then
replace dt by `min(dt*force_timestep_min_factor, force_timestep_min)`

{% highlight fortran %}
force_timestep_min_factor = 2d0
{% endhighlight %}


<h3 id="max_timestep_factor">max_timestep_factor <a href="#max_timestep_factor" title="Permalink to this location">¶</a></h3>


Upper limit for ratio of new timestep to previous timestep.
i.e., allow dt to get larger by no more than this factor -- 0 means no limit.

{% highlight fortran %}
max_timestep_factor = 1.2d0
{% endhighlight %}


<h3 id="timestep_factor_for_retries">timestep_factor_for_retries <a href="#timestep_factor_for_retries" title="Permalink to this location">¶</a></h3>


Before retry, decrease dt by this.

{% highlight fortran %}
timestep_factor_for_retries = 0.5d0
{% endhighlight %}


<h3 id="timestep_factor_for_backups">timestep_factor_for_backups <a href="#timestep_factor_for_backups" title="Permalink to this location">¶</a></h3>


Before backup, decrease dt by this (or more if multiple backups in a row).

{% highlight fortran %}
timestep_factor_for_backups = 0.5d0
{% endhighlight %}


<h3 id="backup_hold">backup_hold <a href="#backup_hold" title="Permalink to this location">¶</a></h3>


No increases in timestep for `backup_hold` steps after a backup.

{% highlight fortran %}
backup_hold = 2
{% endhighlight %}


<h3 id="retry_hold">retry_hold <a href="#retry_hold" title="Permalink to this location">¶</a></h3>


No increases in timestep for `retry_hold` steps after a retry.

{% highlight fortran %}
retry_hold = 1
{% endhighlight %}


<h3 id="neg_mass_fraction_hold">neg_mass_fraction_hold <a href="#neg_mass_fraction_hold" title="Permalink to this location">¶</a></h3>


No increases in timestep for `neg_mass_fraction_hold` steps after
a retry or backup caused by a negative mass fraction.

{% highlight fortran %}
neg_mass_fraction_hold = 2
{% endhighlight %}


<h3 id="timestep_dt_factor__09">timestep_dt_factor = 0.9 <a href="#timestep_dt_factor__09" title="Permalink to this location">¶</a></h3>


dt reduction factor exceed timestep limits.

{% highlight fortran %}
timestep_dt_factor = 0.9d0
{% endhighlight %}


<h3 id="dt_limit_ratio_target">dt_limit_ratio_target <a href="#dt_limit_ratio_target" title="Permalink to this location">¶</a></h3>


Aim for this ratio on dt limited timesteps.

{% highlight fortran %}
dt_limit_ratio_target = 1d0
{% endhighlight %}


<h3 id="use_dt_low_pass_controller">use_dt_low_pass_controller <a href="#use_dt_low_pass_controller" title="Permalink to this location">¶</a></h3>


Enable low pass filter for smoother timestep variations.

{% highlight fortran %}
use_dt_low_pass_controller = .true.
{% endhighlight %}


<h3 id="varcontrol_target">varcontrol_target <a href="#varcontrol_target" title="Permalink to this location">¶</a></h3>


This is the target value for relative variation in the structure from one model to the next.
The default timestep adjustment is to increase or reduce the timestep depending on whether
the actual variation was smaller or greater than this value.

{% highlight fortran %}
varcontrol_target = 1d-4
{% endhighlight %}


<h3 id="varcontrol_dt_limit_ratio_hard_max">varcontrol_dt_limit_ratio_hard_max <a href="#varcontrol_dt_limit_ratio_hard_max" title="Permalink to this location">¶</a></h3>


`varcontrol_dt_limit_ratio` is the actual varcontrol value divided by the target.
if that ratio exceeds this limit, then retry with a smaller timestep.
this let's you prevent large changes from happening in a single step.

{% highlight fortran %}
varcontrol_dt_limit_ratio_hard_max = 1d99
{% endhighlight %}


<h3 id="relax_hard_limits_after_backup">relax_hard_limits_after_backup <a href="#relax_hard_limits_after_backup" title="Permalink to this location">¶</a></h3>


If true, then don't enforce hard limits immediately after a backup.

{% highlight fortran %}
relax_hard_limits_after_backup = .true.
{% endhighlight %}


<h3 id="relax_hard_limits_after_retry">relax_hard_limits_after_retry <a href="#relax_hard_limits_after_retry" title="Permalink to this location">¶</a></h3>


If true, then don't enforce hard limits immediately after a retry.

{% highlight fortran %}
relax_hard_limits_after_retry = .true.
{% endhighlight %}


limits based on iterations required by various solvers

<h3 id="newton_iterations_limit">newton_iterations_limit <a href="#newton_iterations_limit" title="Permalink to this location">¶</a></h3>


If newton solve uses more `newton_iterations` than this, reduce the next timestep.
NOTE: when using gold tolerances, set gold_newton_iterations_limit.  

{% highlight fortran %}
newton_iterations_limit = 7
{% endhighlight %}


<h3 id="newton_iterations_hard_limit">newton_iterations_hard_limit <a href="#newton_iterations_hard_limit" title="Permalink to this location">¶</a></h3>


If uses more iterations than this, retry.

{% highlight fortran %}
newton_iterations_hard_limit = -1
{% endhighlight %}


<h3 id="rotation_steps_limit">rotation_steps_limit <a href="#rotation_steps_limit" title="Permalink to this location">¶</a></h3>


If rotation solver uses more steps than this, reduce the next timestep.

{% highlight fortran %}
rotation_steps_limit = 500
{% endhighlight %}


<h3 id="rotation_steps_hard_limit">rotation_steps_hard_limit <a href="#rotation_steps_hard_limit" title="Permalink to this location">¶</a></h3>


If rotation solver uses more steps than this, retry.

{% highlight fortran %}
rotation_steps_hard_limit = 700
{% endhighlight %}


<h3 id="burn_steps_limit">burn_steps_limit <a href="#burn_steps_limit" title="Permalink to this location">¶</a></h3>


If burn solver uses more steps than this, reduce the next timestep.

{% highlight fortran %}
burn_steps_limit = 10000
{% endhighlight %}


<h3 id="burn_steps_hard_limit">burn_steps_hard_limit <a href="#burn_steps_hard_limit" title="Permalink to this location">¶</a></h3>


If burn solver uses more steps than this, retry.

{% highlight fortran %}
burn_steps_hard_limit = 20000
{% endhighlight %}


<h3 id="diffusion_steps_limit">diffusion_steps_limit <a href="#diffusion_steps_limit" title="Permalink to this location">¶</a></h3>


If diffusion solver uses more steps than this, reduce the next timestep.

{% highlight fortran %}
diffusion_steps_limit = 500
{% endhighlight %}


<h3 id="diffusion_steps_hard_limit">diffusion_steps_hard_limit <a href="#diffusion_steps_hard_limit" title="Permalink to this location">¶</a></h3>


If diffusion solver uses more steps than this, retry.

{% highlight fortran %}
diffusion_steps_hard_limit = 700
{% endhighlight %}


<h3 id="diffusion_iters_limit">diffusion_iters_limit <a href="#diffusion_iters_limit" title="Permalink to this location">¶</a></h3>


If use a total number of iters > this, reduce the next timestep.

{% highlight fortran %}
diffusion_iters_limit = 600
{% endhighlight %}


<h3 id="diffusion_iters_hard_limit">diffusion_iters_hard_limit <a href="#diffusion_iters_hard_limit" title="Permalink to this location">¶</a></h3>


If use a total number of iters > this, retry.

{% highlight fortran %}
diffusion_iters_hard_limit = 800
{% endhighlight %}


limits based on max decrease in mass fraction at any location in star

<h3 id="dX_mix_dist_limit">dX_mix_dist_limit <a href="#dX_mix_dist_limit" title="Permalink to this location">¶</a></h3>


Option to ignore decreases in abundance in non-mixed cells near mixing boundaries.
Ignore abundance changes if nearest mixing boundary is closer than this in Msun units.
This applies to `dH`, `dH_div_H`, `dHe`, `dHe_d_He`, `dX`, and `dX_div_X` limits.

{% highlight fortran %}
dX_mix_dist_limit = 1d-4
{% endhighlight %}


Limit on magnitude of decrease in any cell hydrogen abundance during a single timestep.
dH here is `abs(xa(h1,k) - xa_old(h1,k))` for any cell k.
Considers all cells except where have convective mixing.

<h3 id="dH_limit_min_H">dH_limit_min_H <a href="#dH_limit_min_H" title="Permalink to this location">¶</a></h3>


dH limits only apply where xa(h1,k) >= this limit.

{% highlight fortran %}
dH_limit_min_H = 1d99
{% endhighlight %}


<h3 id="dH_limit">dH_limit <a href="#dH_limit" title="Permalink to this location">¶</a></h3>


If max dH is greater than this, reduce the next timestep by `dH_limit/max_dH`.

{% highlight fortran %}
dH_limit = 1d99
{% endhighlight %}


<h3 id="dH_hard_limit">dH_hard_limit <a href="#dH_hard_limit" title="Permalink to this location">¶</a></h3>


If max dH is greater than this, retry with smaller timestep.

{% highlight fortran %}
dH_hard_limit = 1d99
{% endhighlight %}


<h3 id="dH_decreases_only">dH_decreases_only <a href="#dH_decreases_only" title="Permalink to this location">¶</a></h3>


If true, then only consider decreases in abundance.

{% highlight fortran %}
dH_decreases_only = .true.
{% endhighlight %}


Limit on magnitude of relative decrease in any cell hydrogen abundance.
`dH_div_H` here is `abs(xa(h1,k) - xa_old(h1,k))/xa(h1,k)`
considers all cells except where have convective mixing.
`dH_decreases_only` applies to `dH_div_H` also.

<h3 id="dH_div_H_limit_min_H">dH_div_H_limit_min_H <a href="#dH_div_H_limit_min_H" title="Permalink to this location">¶</a></h3>


`dH_div_H` limits only apply where xa(h1,k) >= this limit.

{% highlight fortran %}
dH_div_H_limit_min_H = 1d-3
{% endhighlight %}


<h3 id="dH_div_H_limit">dH_div_H_limit <a href="#dH_div_H_limit" title="Permalink to this location">¶</a></h3>


If max `dH_div_H` is greater than this, reduce the next timestep by `dH_limit/max_dH`.

{% highlight fortran %}
dH_div_H_limit = 0.9d0
{% endhighlight %}


<h3 id="dH_div_H_hard_limit">dH_div_H_hard_limit <a href="#dH_div_H_hard_limit" title="Permalink to this location">¶</a></h3>


If max `dH_div_H` is greater than this, retry with smaller timestep.

{% highlight fortran %}
dH_div_H_hard_limit = 1d99
{% endhighlight %}


Limit on magnitude of decrease in any cell helium abundance during a single timestep.
dHe here is `abs(xa(he4,k) - xa_old(he4,k))` for any cell k.
Considers all cells except where have convective mixing.

<h3 id="dHe_limit_min_He">dHe_limit_min_He <a href="#dHe_limit_min_He" title="Permalink to this location">¶</a></h3>


dHe limits only apply where xa(he4,k) >= this limit.

{% highlight fortran %}
dHe_limit_min_He = 1d99
{% endhighlight %}


<h3 id="dHe_limit__1d99">dHe_limit = 1d99 <a href="#dHe_limit__1d99" title="Permalink to this location">¶</a></h3>


If max dHe is greater than this, reduce the next timestep by `dHe_limit/max_dHe`.

{% highlight fortran %}
dHe_limit = 1d99
{% endhighlight %}


<h3 id="dHe_hard_limit">dHe_hard_limit <a href="#dHe_hard_limit" title="Permalink to this location">¶</a></h3>


If max dHe is greater than this, retry with smaller timestep.

{% highlight fortran %}
dHe_hard_limit = 1d99
{% endhighlight %}


<h3 id="dHe_decreases_only">dHe_decreases_only <a href="#dHe_decreases_only" title="Permalink to this location">¶</a></h3>


If true, then only consider decreases in abundance.
`dHe_decreases_only` applies to `dHe_div_He` also.

{% highlight fortran %}
dHe_decreases_only = .true.
{% endhighlight %}


Limit on magnitude of relative decrease in any cell helium abundance.
`dHe_div_He` here is `abs(xa(he4,k) - xa_old(he4,k))/xa(he4,k)`.
Considers all cells except where have convective mixing.

<h3 id="dHe_div_He_limit_min_He">dHe_div_He_limit_min_He <a href="#dHe_div_He_limit_min_He" title="Permalink to this location">¶</a></h3>


`dHe_div_He` limits only apply where xa(he4,k) >= this limit.

{% highlight fortran %}
dHe_div_He_limit_min_He = 1d-3
{% endhighlight %}


<h3 id="dHe_div_He_limit">dHe_div_He_limit <a href="#dHe_div_He_limit" title="Permalink to this location">¶</a></h3>


If max `dHe_div_He` is greater than this, reduce the next timestep by `dHe_limit/max_dHe`.

{% highlight fortran %}
dHe_div_He_limit = 0.9d0
{% endhighlight %}


<h3 id="dHe_div_He_hard_limit">dHe_div_He_hard_limit <a href="#dHe_div_He_hard_limit" title="Permalink to this location">¶</a></h3>


If max `dHe_div_He` is greater than this, retry with smaller timestep.

{% highlight fortran %}
dHe_div_He_hard_limit = 1d99
{% endhighlight %}


Limit on magnitude of decrease in any cell helium abundance during a single timestep.
dHe3 here is `abs(xa(he4,k) - xa_old(he3,k))` for any cell k.
Considers all cells except where have convective mixing.

<h3 id="dHe3_limit_min_He3">dHe3_limit_min_He3 <a href="#dHe3_limit_min_He3" title="Permalink to this location">¶</a></h3>


dHe3 limits only apply where xa(he3,k) >= this limit.

{% highlight fortran %}
dHe3_limit_min_He3 = 1d99
{% endhighlight %}


<h3 id="dHe3_limit">dHe3_limit <a href="#dHe3_limit" title="Permalink to this location">¶</a></h3>


If max dHe3 is greater than this, reduce the next timestep by `dHe3_limit/max_dHe3`.

{% highlight fortran %}
dHe3_limit = 1d99
{% endhighlight %}


<h3 id="dHe3_hard_limit">dHe3_hard_limit <a href="#dHe3_hard_limit" title="Permalink to this location">¶</a></h3>


If max dHe3 is greater than this, retry with smaller timestep.

{% highlight fortran %}
dHe3_hard_limit = 1d99
{% endhighlight %}


<h3 id="dHe3_decreases_only">dHe3_decreases_only <a href="#dHe3_decreases_only" title="Permalink to this location">¶</a></h3>


If true, then only consider decreases in abundance.
`dHe3_decreases_only` applies to `dHe3_div_He3` also.

{% highlight fortran %}
dHe3_decreases_only = .true.
{% endhighlight %}


Limit on magnitude of relative decrease in any cell helium abundance.
`dHe3_div_He3` here is `abs(xa(he3,k) - xa_old(he3,k))/xa(he3,k)`.
Considers all cells except where have convective mixing.

<h3 id="dHe3_div_He3_limit_min_He3">dHe3_div_He3_limit_min_He3 <a href="#dHe3_div_He3_limit_min_He3" title="Permalink to this location">¶</a></h3>


`dHe3_div_He3` limits only apply where xa(he3,k) >= this limit.

{% highlight fortran %}
dHe3_div_He3_limit_min_He3 = 1d99
{% endhighlight %}


<h3 id="dHe3_div_He3_limit">dHe3_div_He3_limit <a href="#dHe3_div_He3_limit" title="Permalink to this location">¶</a></h3>


if max `dHe3_div_He3` is greater than this, reduce the next timestep by `dHe3_limit/max_dHe3`.

{% highlight fortran %}
dHe3_div_He3_limit = 1d99
{% endhighlight %}


<h3 id="dHe3_div_He3_hard_limit">dHe3_div_He3_hard_limit <a href="#dHe3_div_He3_hard_limit" title="Permalink to this location">¶</a></h3>


If max `dHe3_div_He3` is greater than this, retry with smaller timestep.

{% highlight fortran %}
dHe3_div_He3_hard_limit = 1d99
{% endhighlight %}


Limit on magnitude of decrease in any cell nonH, nonHe abundance.
dX here is `abs(xa(j,k) - xa_old(j,k))`
for any cell k and any species j other except hydrogen or helium.
Considers all cells except where have convective mixing.

<h3 id="dX_limit_min_X">dX_limit_min_X <a href="#dX_limit_min_X" title="Permalink to this location">¶</a></h3>


dX limits only apply where xa(j,k) >= this limit.

{% highlight fortran %}
dX_limit_min_X = 1d99
{% endhighlight %}


<h3 id="dX_limit">dX_limit <a href="#dX_limit" title="Permalink to this location">¶</a></h3>


If max dX is greater than this,
reduce the next timestep by `dX_limit`/`max_dX`.

{% highlight fortran %}
dX_limit = 1d99
{% endhighlight %}


<h3 id="dX_hard_limit">dX_hard_limit <a href="#dX_hard_limit" title="Permalink to this location">¶</a></h3>


If max dX is greater than this, retry with smaller timestep.

{% highlight fortran %}
dX_hard_limit = 1d99
{% endhighlight %}


<h3 id="dX_decreases_only">dX_decreases_only <a href="#dX_decreases_only" title="Permalink to this location">¶</a></h3>


If true, then only consider decreases in abundance.
`dX_decreases_only` applies to `dX_div_X` also.

{% highlight fortran %}
dX_decreases_only = .true.
{% endhighlight %}


Limit on magnitude of relative decrease in any cell nonH, nonHe abundance.
`dX_div_X` here is abs(xa(j,k) - xa_old(j,k))/xa(j,k)
   for any cell k and any species j other except hydrogen or helium.
Considers all cells except where have convective mixing.

<h3 id="dX_div_X_limit_min_X">dX_div_X_limit_min_X <a href="#dX_div_X_limit_min_X" title="Permalink to this location">¶</a></h3>


`dX_div_X` limits only apply where xa(j,k) >= this limit.

{% highlight fortran %}
dX_div_X_limit_min_X = 1d99
{% endhighlight %}


<h3 id="dX_div_X_limit">dX_div_X_limit <a href="#dX_div_X_limit" title="Permalink to this location">¶</a></h3>


If max `dX_div_X` is greater than this,
reduce the next timestep by `dX_limit/max_dX`.

{% highlight fortran %}
dX_div_X_limit = 1d99
{% endhighlight %}


<h3 id="dX_div_X_hard_limit">dX_div_X_hard_limit <a href="#dX_div_X_hard_limit" title="Permalink to this location">¶</a></h3>


If max `dX_div_X` is greater than this, retry with smaller timestep.

{% highlight fortran %}
dX_div_X_hard_limit = 1d99
{% endhighlight %}


Limits on max drop in abundance mass fraction from burning with possible mixing inflow.
This considers both nuclear reactions and offsetting effect of mixing inflow.

<h3 id="dX_nuc_drop_min_X_limit">dX_nuc_drop_min_X_limit <a href="#dX_nuc_drop_min_X_limit" title="Permalink to this location">¶</a></h3>


`dX_nuc_drop_limit` only for `X > dX_nuc_drop_min_X_limit`.

{% highlight fortran %}
dX_nuc_drop_min_X_limit = 1d-4
{% endhighlight %}


<h3 id="dX_nuc_drop_max_A_limit">dX_nuc_drop_max_A_limit <a href="#dX_nuc_drop_max_A_limit" title="Permalink to this location">¶</a></h3>


`dX_nuc_drop_limit` only for species with `A <= dX_nuc_drop_max_A_limit`.

{% highlight fortran %}
dX_nuc_drop_max_A_limit = 52
{% endhighlight %}


<h3 id="dX_nuc_drop_limit_at_high_T">dX_nuc_drop_limit_at_high_T <a href="#dX_nuc_drop_limit_at_high_T" title="Permalink to this location">¶</a></h3>


Negative means use value for `dX_nuc_drop_limit`,
else use this limit when center logT > 9.45.

{% highlight fortran %}
dX_nuc_drop_limit_at_high_T = -1
{% endhighlight %}


<h3 id="dX_nuc_drop_limit">dX_nuc_drop_limit <a href="#dX_nuc_drop_limit" title="Permalink to this location">¶</a></h3>


If max `dX_nuc_drop` is greater than `dX_nuc_drop_limit`,
reduce the next timestep by `dX_nuc_drop_limit`/`max_dX_nuc_drop`.

{% highlight fortran %}
dX_nuc_drop_limit = 5d-2
{% endhighlight %}


<h3 id="dX_nuc_drop_hard_limit">dX_nuc_drop_hard_limit <a href="#dX_nuc_drop_hard_limit" title="Permalink to this location">¶</a></h3>


If max `dX_nuc_drop` is greater than `dX_nuc_drop_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
dX_nuc_drop_hard_limit = 1d99
{% endhighlight %}


<h3 id="dX_nuc_drop_min_yrs_for_dt">dX_nuc_drop_min_yrs_for_dt <a href="#dX_nuc_drop_min_yrs_for_dt" title="Permalink to this location">¶</a></h3>


Don't let `dX_nuc_drop` change dt to smaller than this.

{% highlight fortran %}
dX_nuc_drop_min_yrs_for_dt = 1d-9
{% endhighlight %}


<h2 id="limits_based_on_relative_changes_in_variables_L_P_Rho_T_R_eps_nuc">limits based on relative changes in variables L, P, Rho, T, R, eps_nuc <a href="#limits_based_on_relative_changes_in_variables_L_P_Rho_T_R_eps_nuc" title="Permalink to this location">¶</a></h2>


limit on magnitude of relative change in L at any grid point

    dL_div_L = abs(L(k) - L_old(k))/L(k)

<h3 id="dL_div_L_limit">dL_div_L_limit <a href="#dL_div_L_limit" title="Permalink to this location">¶</a></h3>


If max abs `dL_div_L` is greater than this, reduce the next timestep.

{% highlight fortran %}
dL_div_L_limit = -1
{% endhighlight %}


<h3 id="dL_div_L_hard_limit">dL_div_L_hard_limit <a href="#dL_div_L_hard_limit" title="Permalink to this location">¶</a></h3>


If max abs `dL_div_L` is greater than this, retry with smaller timestep.

{% highlight fortran %}
dL_div_L_hard_limit = -1
{% endhighlight %}


<h3 id="dL_div_L_limit_min_L">dL_div_L_limit_min_L <a href="#dL_div_L_limit_min_L" title="Permalink to this location">¶</a></h3>


In Lsun units.
`dL_div_L` limits only apply where `L(k) >= Lsun*dL_limit_min_L`

{% highlight fortran %}
dL_div_L_limit_min_L = 1d99
{% endhighlight %}


<h3 id="delta_lgP_limit">delta_lgP_limit <a href="#delta_lgP_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of max change in log10 total pressure in any cell.

{% highlight fortran %}
delta_lgP_limit = 1
{% endhighlight %}


<h3 id="delta_lgP_hard_limit">delta_lgP_hard_limit <a href="#delta_lgP_hard_limit" title="Permalink to this location">¶</a></h3>


If max `delta_lgP` is greater than `delta_lgP_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lgP_hard_limit = -1
{% endhighlight %}


<h3 id="delta_lgP_limit_min_lgP">delta_lgP_limit_min_lgP <a href="#delta_lgP_limit_min_lgP" title="Permalink to this location">¶</a></h3>


`delta_lgP_limit` limits only apply where `log10_P(k) >= delta_lgP_limit_min_lgP`

{% highlight fortran %}
delta_lgP_limit_min_lgP = 1d99
{% endhighlight %}


<h3 id="delta_lgRho_limit">delta_lgRho_limit <a href="#delta_lgRho_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of max change in log10 density in any cell.

{% highlight fortran %}
delta_lgRho_limit = 1
{% endhighlight %}


<h3 id="delta_lgRho_hard_limit__1">delta_lgRho_hard_limit = -1 <a href="#delta_lgRho_hard_limit__1" title="Permalink to this location">¶</a></h3>


If max `delta_lgRho` is greater than `delta_lgRho_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lgRho_hard_limit = -1
{% endhighlight %}


<h3 id="delta_lgRho_limit_min_lgRho">delta_lgRho_limit_min_lgRho <a href="#delta_lgRho_limit_min_lgRho" title="Permalink to this location">¶</a></h3>


`delta_lgRho_limit` limits only apply where `log10_Rho(k) >= delta_lgRho_limit_min_lgRho`.

{% highlight fortran %}
delta_lgRho_limit_min_lgRho = 1d99
{% endhighlight %}


<h3 id="delta_lgT_limit">delta_lgT_limit <a href="#delta_lgT_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of max change in log10 temperature in any cell.

{% highlight fortran %}
delta_lgT_limit = 0.5d0
{% endhighlight %}


<h3 id="delta_lgT_hard_limit">delta_lgT_hard_limit <a href="#delta_lgT_hard_limit" title="Permalink to this location">¶</a></h3>


If max `delta_lgT` is greater than `delta_lgT_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lgT_hard_limit = -1
{% endhighlight %}


<h3 id="delta_lgT_limit_min_lgT">delta_lgT_limit_min_lgT <a href="#delta_lgT_limit_min_lgT" title="Permalink to this location">¶</a></h3>


`delta_lgT_limit` limits only apply where `log10_T(k) >= delta_lgT_limit_min_lgT`.

{% highlight fortran %}
delta_lgT_limit_min_lgT = 1d99
{% endhighlight %}


<h3 id="delta_lgE_limit">delta_lgE_limit <a href="#delta_lgE_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of max change in log10 internal energy in any cell.

{% highlight fortran %}
delta_lgE_limit = 0.1d0
{% endhighlight %}


<h3 id="delta_lgE_hard_limit">delta_lgE_hard_limit <a href="#delta_lgE_hard_limit" title="Permalink to this location">¶</a></h3>


If max `delta_lgE` is greater than `delta_lgE_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lgE_hard_limit = -1
{% endhighlight %}


<h3 id="delta_lgE_limit_min_lgE">delta_lgE_limit_min_lgE <a href="#delta_lgE_limit_min_lgE" title="Permalink to this location">¶</a></h3>


`delta_lgE_limit` limits only apply where `log10(E(k)) >= delta_lgE_limit_min_lgE`.

{% highlight fortran %}
delta_lgE_limit_min_lgE = 1d99
{% endhighlight %}


<h3 id="delta_lgR_limit">delta_lgR_limit <a href="#delta_lgR_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of max change in log10 radius at any cell boundary.

{% highlight fortran %}
delta_lgR_limit = 0.5d0
{% endhighlight %}


<h3 id="delta_lgR_hard_limit">delta_lgR_hard_limit <a href="#delta_lgR_hard_limit" title="Permalink to this location">¶</a></h3>


If max `delta_lgR` is greater than `delta_lgR_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lgR_hard_limit = -1
{% endhighlight %}


<h3 id="delta_lgR_limit_min_lgR">delta_lgR_limit_min_lgR <a href="#delta_lgR_limit_min_lgR" title="Permalink to this location">¶</a></h3>


`delta_lgR_limit` limits only apply where `log10_R(k) >= delta_lgR_limit_min_lgR`.

{% highlight fortran %}
delta_lgR_limit_min_lgR = 1d99
{% endhighlight %}


<h3 id="delta_Ye_limit">delta_Ye_limit <a href="#delta_Ye_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of max change in Ye in any cell.

{% highlight fortran %}
delta_Ye_limit = 1
{% endhighlight %}


<h3 id="delta_Ye_hard_limit">delta_Ye_hard_limit <a href="#delta_Ye_hard_limit" title="Permalink to this location">¶</a></h3>


If max `delta_Ye` is greater than `delta_Ye_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_Ye_hard_limit = -1
{% endhighlight %}


<h3 id="delta_Ye_highT_limit">delta_Ye_highT_limit <a href="#delta_Ye_highT_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of max change in Ye in high T cells.

{% highlight fortran %}
delta_Ye_highT_limit = 99
{% endhighlight %}


Limit testing for max `delta_ye` to cells with `T >= minT_for_highT_Ye_limit`
If this high T max `delta_Ye` is greater than `delta_Ye_highT_limit`,
reduce the next timestep by `delta_Ye_highT_limit`/`max_delta_Ye`.

{% highlight fortran %}
delta_Ye_highT_hard_limit = -1
{% endhighlight %}


<h3 id="minT_for_highT_Ye_limit">minT_for_highT_Ye_limit <a href="#minT_for_highT_Ye_limit" title="Permalink to this location">¶</a></h3>


Limit testing for max `delta_ye` to cells with `T >= minT_for_highT_Ye_limit`.
If this high T max `delta_Ye` is greater than `delta_Ye_highT_limit`,
retry with smaller timestep.

{% highlight fortran %}
minT_for_highT_Ye_limit = 7d9
{% endhighlight %}


<h3 id="delta_log_eps_nuc_limit">delta_log_eps_nuc_limit <a href="#delta_log_eps_nuc_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of max change in log10 `eps_nuc` in any cell.
Only applies to increases in non-convective zones.

{% highlight fortran %}
delta_log_eps_nuc_limit = -1
{% endhighlight %}


<h3 id="delta_log_eps_nuc_hard_limit">delta_log_eps_nuc_hard_limit <a href="#delta_log_eps_nuc_hard_limit" title="Permalink to this location">¶</a></h3>


If max `delta_log_eps_nuc` is greater than `delta_log_eps_nuc_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_log_eps_nuc_hard_limit = -1
{% endhighlight %}


<h3 id="d_deltaR_shrink_limit">d_deltaR_shrink_limit <a href="#d_deltaR_shrink_limit" title="Permalink to this location">¶</a></h3>


Limit for relative decrease in radial thickness of any zone.

{% highlight fortran %}
d_deltaR_shrink_limit = -1
{% endhighlight %}


<h3 id="d_deltaR_shrink_hard_limit">d_deltaR_shrink_hard_limit <a href="#d_deltaR_shrink_hard_limit" title="Permalink to this location">¶</a></h3>


If max `d_deltaR_shrink` is greater than `d_deltaR_shrink_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
d_deltaR_shrink_hard_limit = -1
{% endhighlight %}


<h3 id="d_deltaR_grow_limit">d_deltaR_grow_limit <a href="#d_deltaR_grow_limit" title="Permalink to this location">¶</a></h3>


Limit for relative increase in radial thickness of any zone.

{% highlight fortran %}
d_deltaR_grow_limit = -1
{% endhighlight %}


<h3 id="d_deltaR_grow_hard_limit">d_deltaR_grow_hard_limit <a href="#d_deltaR_grow_hard_limit" title="Permalink to this location">¶</a></h3>


If max `d_deltaR_grow` is greater than `d_deltaR_grow_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
d_deltaR_grow_hard_limit = -1
{% endhighlight %}


<h2 id="limits_based_on_integrated_power_at_each_point_for_each_category_of_nuclear_reaction">limits based on integrated power at each point for each category of nuclear reaction <a href="#limits_based_on_integrated_power_at_each_point_for_each_category_of_nuclear_reaction" title="Permalink to this location">¶</a></h2>


`lgL_nuc_cat` = nuclear reaction energy release for a particular category of reaction (Lsun units).
Energy release here excludes neutrinos.

<h3 id="delta_lgL_nuc_cat_limit">delta_lgL_nuc_cat_limit <a href="#delta_lgL_nuc_cat_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of change in `lgL_nuc` for category.

{% highlight fortran %}
delta_lgL_nuc_cat_limit = -1
{% endhighlight %}


<h3 id="delta_lgL_nuc_cat_hard_limit">delta_lgL_nuc_cat_hard_limit <a href="#delta_lgL_nuc_cat_hard_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lgL_nuc_cat_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lgL_nuc_cat_hard_limit = -1
{% endhighlight %}


<h3 id="lgL_nuc_cat_burn_min">lgL_nuc_cat_burn_min <a href="#lgL_nuc_cat_burn_min" title="Permalink to this location">¶</a></h3>


Ignore changes in `lgL_nuc` for category if value is less than this.

{% highlight fortran %}
lgL_nuc_cat_burn_min = -1
{% endhighlight %}


<h3 id="lgL_nuc_mix_dist_limit">lgL_nuc_mix_dist_limit <a href="#lgL_nuc_mix_dist_limit" title="Permalink to this location">¶</a></h3>


Ignore if nearest boundary is closer than this.
Ignore changes in lgL in cells near mixing boundaries.

{% highlight fortran %}
lgL_nuc_mix_dist_limit = 1d-6
{% endhighlight %}


<h3 id="check_deltalgL_burning_category">check_deltalgL_{burning_category} <a href="#check_deltalgL_burning_category" title="Permalink to this location">¶</a></h3>


Flags determining which reaction categories are considered.

{% highlight fortran %}
check_delta_lgL_pp = .true.
check_delta_lgL_cno = .true.
check_delta_lgL_3alf = .true.
check_delta_lgL_burn_c = .true.
check_delta_lgL_burn_n = .true.
check_delta_lgL_burn_o = .true.
check_delta_lgL_burn_ne = .true.
check_delta_lgL_burn_na = .true.
check_delta_lgL_burn_mg = .true.
check_delta_lgL_burn_si = .true.
check_delta_lgL_burn_s = .true.
check_delta_lgL_burn_ar = .true.
check_delta_lgL_burn_ca = .true.
check_delta_lgL_burn_ti = .true.
check_delta_lgL_burn_cr = .true.
check_delta_lgL_burn_fe = .true.
{% endhighlight %}


c12 + c12, c12 + o16, and o16 + o16

{% highlight fortran %}
check_delta_lgL_cc = .true.
check_delta_lgL_co = .true.
check_delta_lgL_oo = .true.
{% endhighlight %}


`L_H_burn` = integrated power at surface from PP and CNO (in Lsun units)

values for `lgL_H` are `log10(max(1, L_H_burn))`

<h3 id="delta_lgL_H_limit">delta_lgL_H_limit <a href="#delta_lgL_H_limit" title="Permalink to this location">¶</a></h3>


limit for magnitude of change in `lgL_H`

{% highlight fortran %}
delta_lgL_H_limit = -1
{% endhighlight %}


<h3 id="delta_lgL_H_hard_limit">delta_lgL_H_hard_limit <a href="#delta_lgL_H_hard_limit" title="Permalink to this location">¶</a></h3>


if max delta is greater than `delta_lgL_H_hard_limit`,
retry with smaller timestep

{% highlight fortran %}
delta_lgL_H_hard_limit = -1
{% endhighlight %}


<h3 id="lgL_H_burn_min">lgL_H_burn_min <a href="#lgL_H_burn_min" title="Permalink to this location">¶</a></h3>


ignore changes in `lgL_H` if value is less than this

{% highlight fortran %}
lgL_H_burn_min = 1.5d0
{% endhighlight %}


<h3 id="lgL_H_drop_factor">lgL_H_drop_factor <a href="#lgL_H_drop_factor" title="Permalink to this location">¶</a></h3>


when `L_H` is dropping, multiply limits by this factor

{% highlight fortran %}
lgL_H_drop_factor = 1
{% endhighlight %}


<h3 id="lgL_H_burn_relative_limit">lgL_H_burn_relative_limit <a href="#lgL_H_burn_relative_limit" title="Permalink to this location">¶</a></h3>


ignore changes in `lgL_H` if `max(lgL_He,lgL_z) - lgL_H > this`

{% highlight fortran %}
lgL_H_burn_relative_limit = 3
{% endhighlight %}


`L_He_burn` = integrated power at surface from triple alpha (in Lsun units)

values for `lgL_He` are `log10(max(1, L_He_burn))`

<h3 id="delta_lgL_He_limit">delta_lgL_He_limit <a href="#delta_lgL_He_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of change in lgL_He.

{% highlight fortran %}
delta_lgL_He_limit = 0.025d0
{% endhighlight %}


<h3 id="delta_lgL_He_hard_limit">delta_lgL_He_hard_limit <a href="#delta_lgL_He_hard_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lgL_He_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lgL_He_hard_limit = -1
{% endhighlight %}


<h3 id="lgL_He_burn_min">lgL_He_burn_min <a href="#lgL_He_burn_min" title="Permalink to this location">¶</a></h3>


Ignore changes in `lgL_He` if value is less than this.

{% highlight fortran %}
lgL_He_burn_min = 2.5d0
{% endhighlight %}


<h3 id="lgL_He_drop_factor">lgL_He_drop_factor <a href="#lgL_He_drop_factor" title="Permalink to this location">¶</a></h3>


When `L_He` is dropping, multiply limits by this factor.

{% highlight fortran %}
lgL_He_drop_factor = 1
{% endhighlight %}


<h3 id="lgL_He_burn_relative_limit">lgL_He_burn_relative_limit <a href="#lgL_He_burn_relative_limit" title="Permalink to this location">¶</a></h3>


Ignore changes in `lgL_He` if `max(lgL_H,lgL_z) - lgL_He > this`.

{% highlight fortran %}
lgL_He_burn_relative_limit = 3
{% endhighlight %}


`L_z_burn` = integrated power at surface from nuclear burning other than H, He, or C (in Lsun units)
excluding photodistintegrations

values for `lgL_z` are `log10(max(1, L_z_burn))`

<h3 id="delta_lgL_z_limit">delta_lgL_z_limit <a href="#delta_lgL_z_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of change in `lgL_z`.

{% highlight fortran %}
delta_lgL_z_limit = -1
{% endhighlight %}


<h3 id="delta_lgL_z_hard_limit">delta_lgL_z_hard_limit <a href="#delta_lgL_z_hard_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lgL_z_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lgL_z_hard_limit = -1
{% endhighlight %}


<h3 id="lgL_z_burn_min">lgL_z_burn_min <a href="#lgL_z_burn_min" title="Permalink to this location">¶</a></h3>


Ignore changes in `lgL_z` if value is less than this.

{% highlight fortran %}
lgL_z_burn_min = 2.5d0
{% endhighlight %}


<h3 id="lgL_z_drop_factor">lgL_z_drop_factor <a href="#lgL_z_drop_factor" title="Permalink to this location">¶</a></h3>


When `L_z` is dropping, multiply limits by this factor.

{% highlight fortran %}
lgL_z_drop_factor = 1
{% endhighlight %}


<h3 id="lgL_z_burn_relative_limit">lgL_z_burn_relative_limit <a href="#lgL_z_burn_relative_limit" title="Permalink to this location">¶</a></h3>


Ignore changes in `lgL_z` if `max(lgL_H,lgL_He) - lgL_z > this`.

{% highlight fortran %}
lgL_z_burn_relative_limit = 3
{% endhighlight %}


`L_photo_burn` = magnitude of integrated power at surface from photodistintegrations

values for `lgL_photo` are based on `L_by_category(iphoto)`

<h3 id="delta_lgL_photo_limit">delta_lgL_photo_limit <a href="#delta_lgL_photo_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of change in `lgL_photo`.

{% highlight fortran %}
delta_lgL_photo_limit = -1
{% endhighlight %}


<h3 id="delta_lgL_photo_hard_limit">delta_lgL_photo_hard_limit <a href="#delta_lgL_photo_hard_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lgL_photo_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lgL_photo_hard_limit = -1
{% endhighlight %}


<h3 id="lgL_photo_burn_min">lgL_photo_burn_min <a href="#lgL_photo_burn_min" title="Permalink to this location">¶</a></h3>


Ignore changes in `lgL_photo` if value is less than this.

{% highlight fortran %}
lgL_photo_burn_min = 2.5d0
{% endhighlight %}


<h3 id="lgL_photo_drop_factor">lgL_photo_drop_factor <a href="#lgL_photo_drop_factor" title="Permalink to this location">¶</a></h3>


When `L_photo` is dropping, multiply limits by this factor.

{% highlight fortran %}
lgL_photo_drop_factor = 1
{% endhighlight %}


<h2 id="limits_based_on_total_integrated_power_at_surface_for_all_nuclear_reactions">limits based on total integrated power at surface for all nuclear reactions <a href="#limits_based_on_total_integrated_power_at_surface_for_all_nuclear_reactions" title="Permalink to this location">¶</a></h2>


excluding photodistintegrations

`L_nuc` = nuclear reaction total energy release for all nuclear reactions (Lsun units)

<h3 id="delta_lgL_nuc_limit">delta_lgL_nuc_limit <a href="#delta_lgL_nuc_limit" title="Permalink to this location">¶</a></h3>


limit for magnitude of change in `lgL_nuc`

{% highlight fortran %}
delta_lgL_nuc_limit = -1
{% endhighlight %}


<h3 id="delta_lgL_nuc_hard_limit">delta_lgL_nuc_hard_limit <a href="#delta_lgL_nuc_hard_limit" title="Permalink to this location">¶</a></h3>


if max delta is greater than `delta_lgL_nuc_hard_limit`,
retry with smaller timestep

{% highlight fortran %}
delta_lgL_nuc_hard_limit = -1
{% endhighlight %}


<h3 id="lgL_nuc_burn_min">lgL_nuc_burn_min <a href="#lgL_nuc_burn_min" title="Permalink to this location">¶</a></h3>


ignore changes in `lgL_nuc` if value is less than this

{% highlight fortran %}
lgL_nuc_burn_min = 0.5d0
{% endhighlight %}


<h3 id="lgL_nuc_drop_factor">lgL_nuc_drop_factor <a href="#lgL_nuc_drop_factor" title="Permalink to this location">¶</a></h3>


When `L_nuc` is dropping, multiply limits by this factor.

{% highlight fortran %}
lgL_nuc_drop_factor = 1
{% endhighlight %}


limits based on changes at photosphere

<h3 id="delta_lgTeff_limit">delta_lgTeff_limit <a href="#delta_lgTeff_limit" title="Permalink to this location">¶</a></h3>


<h3 id="delta_lgTeff_hard_limit">delta_lgTeff_hard_limit <a href="#delta_lgTeff_hard_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of max change in log10 temperature at photosphere.

{% highlight fortran %}
delta_lgTeff_limit = 0.01d0
delta_lgTeff_hard_limit = -1
{% endhighlight %}


<h3 id="delta_lgL_limit_L_min">delta_lgL_limit_L_min <a href="#delta_lgL_limit_L_min" title="Permalink to this location">¶</a></h3>


<h3 id="delta_lgL_limit">delta_lgL_limit <a href="#delta_lgL_limit" title="Permalink to this location">¶</a></h3>


<h3 id="delta_lgL_hard_limit">delta_lgL_hard_limit <a href="#delta_lgL_hard_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of change in log10(L_surf/Lsun).
Only apply this limit when `L_surf` >= `delta_lgL_limit_L_min` (in Lsun units).

{% highlight fortran %}
delta_lgL_limit_L_min = -100
delta_lgL_limit = 0.1d0
delta_lgL_hard_limit = -1
{% endhighlight %}


<h3 id="delta_lgL_phot_limit_L_min">delta_lgL_phot_limit_L_min <a href="#delta_lgL_phot_limit_L_min" title="Permalink to this location">¶</a></h3>


<h3 id="delta_lgL_phot_limit">delta_lgL_phot_limit <a href="#delta_lgL_phot_limit" title="Permalink to this location">¶</a></h3>


<h3 id="delta_lgL_phot_hard_limit">delta_lgL_phot_hard_limit <a href="#delta_lgL_phot_hard_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of change in log10(`L_phot`/Lsun).
Only apply this limit when `L_phot` >= `delta_lgL_phot_limit_L_min` (in Lsun units).

{% highlight fortran %}
delta_lgL_phot_limit_L_min = -100
delta_lgL_phot_limit = 0.1d0
delta_lgL_phot_hard_limit = -1
{% endhighlight %}


<h3 id="v_div_v_crit_limit">v_div_v_crit_limit <a href="#v_div_v_crit_limit" title="Permalink to this location">¶</a></h3>


<h3 id="v_div_v_crit_hard_limit">v_div_v_crit_hard_limit <a href="#v_div_v_crit_hard_limit" title="Permalink to this location">¶</a></h3>


Limit surface rotational velocity div critical velocity (`v_div_v_crit_avg_surf`).

{% highlight fortran %}
v_div_v_crit_limit = -1
v_div_v_crit_hard_limit = -1
{% endhighlight %}


<h3 id="dt_div_dt_thermal_limit">dt_div_dt_thermal_limit <a href="#dt_div_dt_thermal_limit" title="Permalink to this location">¶</a></h3>


<h3 id="dt_div_dt_thermal_hard_limit">dt_div_dt_thermal_hard_limit <a href="#dt_div_dt_thermal_hard_limit" title="Permalink to this location">¶</a></h3>


limit for dt compared to thermal timescale (negative means no limit)

    dt_thermal = (3/4)*G*M^2/(R*L); Kelvin-Helmholtz time

{% highlight fortran %}
dt_div_dt_thermal_limit = -1
dt_div_dt_thermal_hard_limit = -1
{% endhighlight %}


<h3 id="dt_div_dt_dynamic_limit">dt_div_dt_dynamic_limit <a href="#dt_div_dt_dynamic_limit" title="Permalink to this location">¶</a></h3>


<h3 id="dt_div_dt_dynamic_hard_limit">dt_div_dt_dynamic_hard_limit <a href="#dt_div_dt_dynamic_hard_limit" title="Permalink to this location">¶</a></h3>


limit for dt compared to dynamic timescale (negative means no limit)

    dt_dynamic =  2*Pi*sqrt(R^3/(G*M))

{% highlight fortran %}
dt_div_dt_dynamic_limit = -1
dt_div_dt_dynamic_hard_limit = -1
{% endhighlight %}


<h3 id="dt_div_dt_acoustic_limit">dt_div_dt_acoustic_limit <a href="#dt_div_dt_acoustic_limit" title="Permalink to this location">¶</a></h3>


<h3 id="dt_div_dt_acoustic_hard_limit">dt_div_dt_acoustic_hard_limit <a href="#dt_div_dt_acoustic_hard_limit" title="Permalink to this location">¶</a></h3>


limit for dt compared to dt_acoustic (negative means no limit)

dt_acoustic = time for sound from center to photosphere
 = sum over shells of local sound crossing time dr/csound.

{% highlight fortran %}
dt_div_dt_acoustic_limit = -1
dt_div_dt_acoustic_hard_limit = -1
{% endhighlight %}


<h3 id="dt_div_dt_mass_loss_limit">dt_div_dt_mass_loss_limit <a href="#dt_div_dt_mass_loss_limit" title="Permalink to this location">¶</a></h3>


<h3 id="dt_div_dt_mass_loss_hard_limit">dt_div_dt_mass_loss_hard_limit <a href="#dt_div_dt_mass_loss_hard_limit" title="Permalink to this location">¶</a></h3>


limit for dt compared to mass loss timescale (negative means no limit)

    dt_mass_loss = -M/Mdot; only applies when Mdot < 0

{% highlight fortran %}
dt_div_dt_mass_loss_limit = -1
dt_div_dt_mass_loss_hard_limit = -1
{% endhighlight %}


<h3 id="dt_div_min_dr_div_cs_limit">dt_div_min_dr_div_cs_limit <a href="#dt_div_min_dr_div_cs_limit" title="Permalink to this location">¶</a></h3>


<h3 id="dt_div_min_dr_div_cs_hard_limit">dt_div_min_dr_div_cs_hard_limit <a href="#dt_div_min_dr_div_cs_hard_limit" title="Permalink to this location">¶</a></h3>


limit for dt compared to explicit solver timescale (negative means no limit)

    min_dr_div_cs = min over all cells of dr/csound (seconds)

{% highlight fortran %}
dt_div_min_dr_div_cs_limit = -1
dt_div_min_dr_div_cs_hard_limit = -1
{% endhighlight %}


<h3 id="min_k_for_dt_div_min_dr_div_cs_limit">min_k_for_dt_div_min_dr_div_cs_limit <a href="#min_k_for_dt_div_min_dr_div_cs_limit" title="Permalink to this location">¶</a></h3>


<h3 id="min_q_for_dt_div_min_dr_div_cs_limit">min_q_for_dt_div_min_dr_div_cs_limit <a href="#min_q_for_dt_div_min_dr_div_cs_limit" title="Permalink to this location">¶</a></h3>


<h3 id="max_q_for_dt_div_min_dr_div_cs_limit">max_q_for_dt_div_min_dr_div_cs_limit <a href="#max_q_for_dt_div_min_dr_div_cs_limit" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
min_k_for_dt_div_min_dr_div_cs_limit = 20
min_q_for_dt_div_min_dr_div_cs_limit = 0.005d0
max_q_for_dt_div_min_dr_div_cs_limit = 0.995d0
{% endhighlight %}


<h3 id="min_abs_du_div_cs_for_dt_div_min_dr_div_cs_limit">min_abs_du_div_cs_for_dt_div_min_dr_div_cs_limit <a href="#min_abs_du_div_cs_for_dt_div_min_dr_div_cs_limit" title="Permalink to this location">¶</a></h3>


only use `dt_div_min_dr_div_cs_limit` at cells where
`abs_du_div_cs` > this limit.
allow focus on regions near shock face.

{% highlight fortran %}
min_abs_du_div_cs_for_dt_div_min_dr_div_cs_limit = 0.01d0
{% endhighlight %}


<h3 id="dt_div_dt_cell_collapse_limit">dt_div_dt_cell_collapse_limit <a href="#dt_div_dt_cell_collapse_limit" title="Permalink to this location">¶</a></h3>


<h3 id="dt_div_dt_cell_collapse_hard_limit">dt_div_dt_cell_collapse_hard_limit <a href="#dt_div_dt_cell_collapse_hard_limit" title="Permalink to this location">¶</a></h3>


limit for dt compared to cell_collapse timescale (negative means no limit)

    dt_cell_collapse = min over shells k that have v(k+1) > v(k) of
    (r(k)-r(k+1))/(v(k+1)-v(k)), the time for the cell to collapse
    to zero thickness at current velocities.

{% highlight fortran %}
dt_div_dt_cell_collapse_limit = -1
dt_div_dt_cell_collapse_hard_limit = -1
{% endhighlight %}


limits based on changes in location on HR diagram

<h3 id="delta_HR_ds_L">delta_HR_ds_L <a href="#delta_HR_ds_L" title="Permalink to this location">¶</a></h3>


<h3 id="delta_HR_ds_Teff">delta_HR_ds_Teff <a href="#delta_HR_ds_Teff" title="Permalink to this location">¶</a></h3>


    dlgL = log10(L/L_prev)
    dlgTeff = log10(Teff/Teff_prev)

{% highlight fortran %}
delta_HR_ds_L = 1
delta_HR_ds_Teff = 1
{% endhighlight %}


<h3 id="delta_HR_limit">delta_HR_limit <a href="#delta_HR_limit" title="Permalink to this location">¶</a></h3>


<h3 id="delta_HR_hard_limit">delta_HR_hard_limit <a href="#delta_HR_hard_limit" title="Permalink to this location">¶</a></h3>


limit for dHR (negative means no limit)

    dHR = sqrt((delta_HR_ds_L*dlgL)**2 + (delta_HR_ds_Teff*dlgTeff)**2)

{% highlight fortran %}
delta_HR_limit = -1
delta_HR_hard_limit = -1
{% endhighlight %}


limits based on change in max temperature or density

<h3 id="delta_lgT_max_limit">delta_lgT_max_limit <a href="#delta_lgT_max_limit" title="Permalink to this location">¶</a></h3>


<h3 id="delta_lgT_max_hard_limit">delta_lgT_max_hard_limit <a href="#delta_lgT_max_hard_limit" title="Permalink to this location">¶</a></h3>


limit for magnitude of change in log10 max temperature

{% highlight fortran %}
delta_lgT_max_limit = -1
delta_lgT_max_hard_limit = -1
{% endhighlight %}


<h3 id="delta_lgRho_max_limit">delta_lgRho_max_limit <a href="#delta_lgRho_max_limit" title="Permalink to this location">¶</a></h3>


<h3 id="delta_lgRho_max_hard_limit">delta_lgRho_max_hard_limit <a href="#delta_lgRho_max_hard_limit" title="Permalink to this location">¶</a></h3>


limit for magnitude of change in log10 max density

{% highlight fortran %}
delta_lgRho_max_limit = -1
delta_lgRho_max_hard_limit = -1
{% endhighlight %}


limits based on changes at center

<h3 id="delta_lgT_cntr_limit">delta_lgT_cntr_limit <a href="#delta_lgT_cntr_limit" title="Permalink to this location">¶</a></h3>


<h3 id="delta_lgT_cntr_hard_limit">delta_lgT_cntr_hard_limit <a href="#delta_lgT_cntr_hard_limit" title="Permalink to this location">¶</a></h3>


limit for magnitude of change in log10 temperature at center

{% highlight fortran %}
delta_lgT_cntr_limit = 0.01d0
delta_lgT_cntr_hard_limit = -1
{% endhighlight %}


<h3 id="delta_lgP_cntr_limit">delta_lgP_cntr_limit <a href="#delta_lgP_cntr_limit" title="Permalink to this location">¶</a></h3>


<h3 id="delta_lgP_cntr_hard_limit">delta_lgP_cntr_hard_limit <a href="#delta_lgP_cntr_hard_limit" title="Permalink to this location">¶</a></h3>


limit for magnitude of change in log10 pressure at center

{% highlight fortran %}
delta_lgP_cntr_limit = -1
delta_lgP_cntr_hard_limit = -1
{% endhighlight %}


<h3 id="delta_lgRho_cntr_limit">delta_lgRho_cntr_limit <a href="#delta_lgRho_cntr_limit" title="Permalink to this location">¶</a></h3>


<h3 id="delta_lgRho_cntr_hard_limit">delta_lgRho_cntr_hard_limit <a href="#delta_lgRho_cntr_hard_limit" title="Permalink to this location">¶</a></h3>


limit for magnitude of change in log10 density at center

{% highlight fortran %}
delta_lgRho_cntr_limit = 0.05d0
delta_lgRho_cntr_hard_limit = -1
{% endhighlight %}


<h3 id="delta_log_eps_nuc_cntr_limit">delta_log_eps_nuc_cntr_limit <a href="#delta_log_eps_nuc_cntr_limit" title="Permalink to this location">¶</a></h3>


<h3 id="delta_log_eps_nuc_cntr_hard_limit">delta_log_eps_nuc_cntr_hard_limit <a href="#delta_log_eps_nuc_cntr_hard_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of change in log10 `eps_nuc` at center.
Only applies to increase in `eps_nuc` in non-convective core..
This can help to catch the start of core convection..

{% highlight fortran %}
delta_log_eps_nuc_cntr_limit = 1
delta_log_eps_nuc_cntr_hard_limit = -1
{% endhighlight %}


`lg_XH_cntr` is log10(h1 mass fraction at center).
Small timesteps as the center hydrogen is exhausted.

<h3 id="delta_lg_XH_cntr_min">delta_lg_XH_cntr_min <a href="#delta_lg_XH_cntr_min" title="Permalink to this location">¶</a></h3>


Ignore changes in `lg_XH_cntr` if value is less than this.

{% highlight fortran %}
delta_lg_XH_cntr_min = -6
{% endhighlight %}


<h3 id="delta_lg_XH_cntr_max">delta_lg_XH_cntr_max <a href="#delta_lg_XH_cntr_max" title="Permalink to this location">¶</a></h3>


Ignore changes in `lg_XH_cntr` if value is more than this.

{% highlight fortran %}
delta_lg_XH_cntr_max = -3
{% endhighlight %}


<h3 id="delta_lg_XH_cntr_limit">delta_lg_XH_cntr_limit <a href="#delta_lg_XH_cntr_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than this,
reduce the next timestep by `delta_lg_XH_cntr_limit`/`max_delta`.

{% highlight fortran %}
delta_lg_XH_cntr_limit = 0.05d0
{% endhighlight %}


<h3 id="delta_lg_XH_cntr_hard_limit">delta_lg_XH_cntr_hard_limit <a href="#delta_lg_XH_cntr_hard_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lg_XH_cntr_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lg_XH_cntr_hard_limit = -1
{% endhighlight %}


`lg_XHe_cntr` is log10(he4 mass fraction at center)
small timesteps as the center helium is exausted.

<h3 id="delta_lg_XHe_cntr_min">delta_lg_XHe_cntr_min <a href="#delta_lg_XHe_cntr_min" title="Permalink to this location">¶</a></h3>


Ignore changes in `lg_XHe_cntr` if value is less than this.

{% highlight fortran %}
delta_lg_XHe_cntr_min = -6
{% endhighlight %}


<h3 id="delta_lg_XHe_cntr_max">delta_lg_XHe_cntr_max <a href="#delta_lg_XHe_cntr_max" title="Permalink to this location">¶</a></h3>


Ignore changes in `lg_XHe_cntr` if value is more than this.

{% highlight fortran %}
delta_lg_XHe_cntr_max = -3
{% endhighlight %}


<h3 id="delta_lg_XHe_cntr_limit">delta_lg_XHe_cntr_limit <a href="#delta_lg_XHe_cntr_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lg_XHe_cntr_limit`,
reduce the next timestep by `delta_lg_XHe_cntr_limit`/`max_delta`.

{% highlight fortran %}
delta_lg_XHe_cntr_limit = 0.1d0
{% endhighlight %}


<h3 id="delta_lg_XHe_cntr_hard_limit">delta_lg_XHe_cntr_hard_limit <a href="#delta_lg_XHe_cntr_hard_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lg_XHe_cntr_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lg_XHe_cntr_hard_limit = -1
{% endhighlight %}


`lg_XC_cntr` is log10(c12 mass fraction at center).
Small timesteps as the center carbon is exausted.

<h3 id="delta_lg_XC_cntr_min">delta_lg_XC_cntr_min <a href="#delta_lg_XC_cntr_min" title="Permalink to this location">¶</a></h3>


Ignore changes in `lg_XC_cntr` if value is less than this.

{% highlight fortran %}
delta_lg_XC_cntr_min = -5
{% endhighlight %}


<h3 id="delta_lg_XC_cntr_max">delta_lg_XC_cntr_max <a href="#delta_lg_XC_cntr_max" title="Permalink to this location">¶</a></h3>


Ignore changes in `lg_XC_cntr` if value is more than this.

{% highlight fortran %}
delta_lg_XC_cntr_max = -3
{% endhighlight %}


<h3 id="delta_lg_XC_cntr_limit">delta_lg_XC_cntr_limit <a href="#delta_lg_XC_cntr_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lg_XC_cntr_limit`,
reduce the next timestep by `delta_lg_XC_cntr_limit`/`max_delta`.

{% highlight fortran %}
delta_lg_XC_cntr_limit = 0.1d0
{% endhighlight %}


<h3 id="delta_lg_XC_cntr_hard_limit">delta_lg_XC_cntr_hard_limit <a href="#delta_lg_XC_cntr_hard_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lg_XC_cntr_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lg_XC_cntr_hard_limit = -1
{% endhighlight %}


`lg_XNe_cntr` is log10(ne20 mass fraction at center)
Small timesteps as the center neon is exausted.

<h3 id="delta_lg_XNe_cntr_min">delta_lg_XNe_cntr_min <a href="#delta_lg_XNe_cntr_min" title="Permalink to this location">¶</a></h3>


Ignore changes in `lg_XNe_cntr` if value is less than this.

{% highlight fortran %}
delta_lg_XNe_cntr_min = -5
{% endhighlight %}


<h3 id="delta_lg_XNe_cntr_max">delta_lg_XNe_cntr_max <a href="#delta_lg_XNe_cntr_max" title="Permalink to this location">¶</a></h3>


Ignore changes in `lg_XNe_cntr` if value is more than this.

{% highlight fortran %}
delta_lg_XNe_cntr_max = 0
{% endhighlight %}


<h3 id="delta_lg_XNe_cntr_limit">delta_lg_XNe_cntr_limit <a href="#delta_lg_XNe_cntr_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lg_XNe_cntr_limit`,
reduce the next timestep by `delta_lg_XNe_cntr_limit`/`max_delta`.

{% highlight fortran %}
delta_lg_XNe_cntr_limit = 1d99
{% endhighlight %}


<h3 id="delta_lg_XNe_cntr_hard_limit">delta_lg_XNe_cntr_hard_limit <a href="#delta_lg_XNe_cntr_hard_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lg_XNe_cntr_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lg_XNe_cntr_hard_limit = -1
{% endhighlight %}


`lg_XO_cntr` is log10(o16 mass fraction at center)
Small timesteps as the center oxygen is exausted.

<h3 id="delta_lg_XO_cntr_min">delta_lg_XO_cntr_min <a href="#delta_lg_XO_cntr_min" title="Permalink to this location">¶</a></h3>


Ignore changes in `lg_XO_cntr` if value is less than this.

{% highlight fortran %}
delta_lg_XO_cntr_min = -5
{% endhighlight %}


<h3 id="delta_lg_XO_cntr_max">delta_lg_XO_cntr_max <a href="#delta_lg_XO_cntr_max" title="Permalink to this location">¶</a></h3>


Ignore changes in `lg_XO_cntr` if value is more than this.

{% highlight fortran %}
delta_lg_XO_cntr_max = 0
{% endhighlight %}


<h3 id="delta_lg_XO_cntr_limit">delta_lg_XO_cntr_limit <a href="#delta_lg_XO_cntr_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lg_XO_cntr_limit`,
reduce the next timestep by `delta_lg_XO_cntr_limit`/`max_delta`.

{% highlight fortran %}
delta_lg_XO_cntr_limit = 1d99
{% endhighlight %}


<h3 id="delta_lg_XO_cntr_hard_limit">delta_lg_XO_cntr_hard_limit <a href="#delta_lg_XO_cntr_hard_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lg_XO_cntr_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lg_XO_cntr_hard_limit = -1
{% endhighlight %}


`lg_XSi_cntr` is log10(si28 mass fraction at center)
Small timesteps as the center silicon is exausted.

<h3 id="delta_lg_XSi_cntr_min">delta_lg_XSi_cntr_min <a href="#delta_lg_XSi_cntr_min" title="Permalink to this location">¶</a></h3>


Ignore changes in `lg_XSi_cntr` if value is less than this.

{% highlight fortran %}
delta_lg_XSi_cntr_min = -5
{% endhighlight %}


<h3 id="delta_lg_XSi_cntr_max">delta_lg_XSi_cntr_max <a href="#delta_lg_XSi_cntr_max" title="Permalink to this location">¶</a></h3>


Ignore changes in `lg_XSi_cntr` if value is more than this.

{% highlight fortran %}
delta_lg_XSi_cntr_max = 0
{% endhighlight %}


<h3 id="delta_lg_XSi_cntr_limit">delta_lg_XSi_cntr_limit <a href="#delta_lg_XSi_cntr_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lg_XSi_cntr_limit`,
reduce the next timestep by `delta_lg_XSi_cntr_limit`/`max_delta`.

{% highlight fortran %}
delta_lg_XSi_cntr_limit = 1d99
{% endhighlight %}


<h3 id="delta_lg_XSi_cntr_hard_limit">delta_lg_XSi_cntr_hard_limit <a href="#delta_lg_XSi_cntr_hard_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lg_XSi_cntr_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lg_XSi_cntr_hard_limit = -1
{% endhighlight %}


<h2 id="limits_based_on_changes_in_mass_of_the_star">limits based on changes in mass of the star <a href="#limits_based_on_changes_in_mass_of_the_star" title="Permalink to this location">¶</a></h2>


<h3 id="delta_lg_star_mass_limit">delta_lg_star_mass_limit <a href="#delta_lg_star_mass_limit" title="Permalink to this location">¶</a></h3>


<h3 id="delta_lg_star_mass_hard_limit">delta_lg_star_mass_hard_limit <a href="#delta_lg_star_mass_hard_limit" title="Permalink to this location">¶</a></h3>


Limit for magnitude of change in log10(M/Msun).

{% highlight fortran %}
delta_lg_star_mass_limit = 5d-3
delta_lg_star_mass_hard_limit = -1
{% endhighlight %}


limit for change in mdot in Msun/yr
+ `delta_mdot_atol` tolerance for absolute changes
+ `delta_mdot_rtol` tolerance for relative changes

{% highlight fortran %}
delta_mdot_atol = 1d-3
delta_mdot_rtol = 0.5d0
{% endhighlight %}


<h3 id="delta_mdot_limit">delta_mdot_limit <a href="#delta_mdot_limit" title="Permalink to this location">¶</a></h3>


<h3 id="delta_mdot_hard_limit">delta_mdot_hard_limit <a href="#delta_mdot_hard_limit" title="Permalink to this location">¶</a></h3>


    delta_mot = abs(mdot - mdot_old)/ (delta_mdot_atol*Msun/secyer + &
       delta_mdot_rtol*max(abs(mdot),abs(mdot_old)))

ignore if < 0

{% highlight fortran %}
delta_mdot_limit = -1
delta_mdot_hard_limit = -1
{% endhighlight %}


<h3 id="factor_for_test_CpT_absMdot_div_L">factor_for_test_CpT_absMdot_div_L <a href="#factor_for_test_CpT_absMdot_div_L" title="Permalink to this location">¶</a></h3>


Limit on ratio `Cp(k)*T(k)*abs(mstar_dot)/L(k)` at `k = k_for_CpT_absMdot_div_L`.
Cell index `k_for_CpT_absMdot_div_L` is set by the `adjust_mass` routine as follows:
Let `delta_m` be `mdot*dt`, the change in mass for this step.
Let `delta_m_for_limit = abs(delta_m)*factor_for_test_CpT_absMdot_div_L`.
Then `k_for_CpT_absMdot_div_L` is the outermost cell boundary k,
where the mass exterior to k is >= `delta_m_for_limit`.

{% highlight fortran %}
factor_for_test_CpT_absMdot_div_L = 1
{% endhighlight %}


<h3 id="CpT_absMdot_div_L_limit">CpT_absMdot_div_L_limit <a href="#CpT_absMdot_div_L_limit" title="Permalink to this location">¶</a></h3>


Only use if > 0.
Reduce next timestep if ratio is greater than this limit.

{% highlight fortran %}
CpT_absMdot_div_L_limit = -1
{% endhighlight %}


<h3 id="CpT_absMdot_div_L_hard_limit">CpT_absMdot_div_L_hard_limit <a href="#CpT_absMdot_div_L_hard_limit" title="Permalink to this location">¶</a></h3>


Only use if > 0.
Retry if ratio exceeds this limit.

{% highlight fortran %}
CpT_absMdot_div_L_hard_limit = -1
{% endhighlight %}


<h2 id="limits_based_on_changes_in_log_total_angular_momentum">limits based on changes in log total angular momentum <a href="#limits_based_on_changes_in_log_total_angular_momentum" title="Permalink to this location">¶</a></h2>


<h3 id="delta_lg_total_J_limit">delta_lg_total_J_limit <a href="#delta_lg_total_J_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lg_total_J_limit`,
reduce the next timestep by `delta_lg_total_J_limit`/`max_delta`.

{% highlight fortran %}
delta_lg_total_J_limit = 0.1d0
{% endhighlight %}


<h3 id="delta_lg_total_J_hard_limit">delta_lg_total_J_hard_limit <a href="#delta_lg_total_J_hard_limit" title="Permalink to this location">¶</a></h3>


If max delta is greater than `delta_lg_total_J_hard_limit`,
retry with smaller timestep.

{% highlight fortran %}
delta_lg_total_J_hard_limit = 0.5d0
{% endhighlight %}


<h3 id="limit_for_rel_error_in_energy_conservation">limit_for_rel_error_in_energy_conservation <a href="#limit_for_rel_error_in_energy_conservation" title="Permalink to this location">¶</a></h3>


<h3 id="hard_limit_for_rel_error_in_energy_conservation">hard_limit_for_rel_error_in_energy_conservation <a href="#hard_limit_for_rel_error_in_energy_conservation" title="Permalink to this location">¶</a></h3>


    rel_error_in_energy_conservation = abs(error_in_energy_conservation/total_energy)

{% highlight fortran %}
limit_for_rel_error_in_energy_conservation = 1d99
hard_limit_for_rel_error_in_energy_conservation = 1d99
{% endhighlight %}


<h3 id="limit_for_rel_rate_in_energy_conservation">limit_for_rel_rate_in_energy_conservation <a href="#limit_for_rel_rate_in_energy_conservation" title="Permalink to this location">¶</a></h3>


<h3 id="hard_limit_for_rel_rate_in_energy_conservation">hard_limit_for_rel_rate_in_energy_conservation <a href="#hard_limit_for_rel_rate_in_energy_conservation" title="Permalink to this location">¶</a></h3>


    rel_rate_in_energy_conservation = abs(error_in_energy_conservation/total_energy)/dt
with dt in seconds.

{% highlight fortran %}
limit_for_rel_rate_in_energy_conservation = 1d99
hard_limit_for_rel_rate_in_energy_conservation = 1d99
{% endhighlight %}


<h3 id="limit_for_avg_v_residual">limit_for_avg_v_residual <a href="#limit_for_avg_v_residual" title="Permalink to this location">¶</a></h3>


<h3 id="hard_limit_for_avg_v_residual">hard_limit_for_avg_v_residual <a href="#hard_limit_for_avg_v_residual" title="Permalink to this location">¶</a></h3>


    avg_v_residual = abs(dot_product(s% dq(1:s% nz),s% v_residual(1:s% nz)))

{% highlight fortran %}
limit_for_avg_v_residual = 1d99
hard_limit_for_avg_v_residual = 1d99
{% endhighlight %}


<h3 id="limit_for_max_abs_v_residual">limit_for_max_abs_v_residual <a href="#limit_for_max_abs_v_residual" title="Permalink to this location">¶</a></h3>


<h3 id="hard_limit_for_max_abs_v_residual">hard_limit_for_max_abs_v_residual <a href="#hard_limit_for_max_abs_v_residual" title="Permalink to this location">¶</a></h3>


    max_abs_v_residual = maxval(abs(s% v_residual(1:s% nz)))

{% highlight fortran %}
limit_for_max_abs_v_residual = 1d99
hard_limit_for_max_abs_v_residual = 1d99
{% endhighlight %}


<h3 id="limit_for_abs_rel_E_err">limit_for_abs_rel_E_err <a href="#limit_for_abs_rel_E_err" title="Permalink to this location">¶</a></h3>


<h3 id="hard_limit_for_abs_rel_E_err">hard_limit_for_abs_rel_E_err <a href="#hard_limit_for_abs_rel_E_err" title="Permalink to this location">¶</a></h3>


    abs_rel_E_err = maxval(abs(s% rel_E_err(1:s% nz)))

{% highlight fortran %}
limit_for_abs_rel_E_err = 1d99
hard_limit_for_abs_rel_E_err = 1d99
{% endhighlight %}


<h3 id="limit_for_max_E_residual">limit_for_max_E_residual <a href="#limit_for_max_E_residual" title="Permalink to this location">¶</a></h3>


<h3 id="hard_limit_for_max_E_residual">hard_limit_for_max_E_residual <a href="#hard_limit_for_max_E_residual" title="Permalink to this location">¶</a></h3>


    max_E_residual = maxval(abs(s% E_residual(1:s% nz)))

{% highlight fortran %}
limit_for_max_E_residual = 1d99
hard_limit_for_max_E_residual = 1d99
{% endhighlight %}


<h3 id="report_why_dt_limits">report_why_dt_limits <a href="#report_why_dt_limits" title="Permalink to this location">¶</a></h3>


If true, produce terminal output about choice of timestep.

{% highlight fortran %}
report_why_dt_limits = .false.
{% endhighlight %}


<h3 id="report_all_dt_limits">report_all_dt_limits <a href="#report_all_dt_limits" title="Permalink to this location">¶</a></h3>


If true, produce terminal output about all influences for choice of timestep.

{% highlight fortran %}
report_all_dt_limits = .false.
{% endhighlight %}


<h3 id="report_hydro_dt_info">report_hydro_dt_info <a href="#report_hydro_dt_info" title="Permalink to this location">¶</a></h3>


If true, produce terminal output about choice of timestep based on `varcontrol_target`.

{% highlight fortran %}
report_hydro_dt_info = .false.
{% endhighlight %}


<h3 id="report_dX_nuc_drop_dt_limits">report_dX_nuc_drop_dt_limits <a href="#report_dX_nuc_drop_dt_limits" title="Permalink to this location">¶</a></h3>


If true, report timestep limits from drop in abundance from nuclear reactions.

{% highlight fortran %}
report_dX_nuc_drop_dt_limits = .false.
{% endhighlight %}

<h1 id="debugging_controls">debugging controls <a href="#debugging_controls" title="Permalink to this location">¶</a></h1>


<h3 id="report_hydro_solver_progress">report_hydro_solver_progress <a href="#report_hydro_solver_progress" title="Permalink to this location">¶</a></h3>


Set true to see info about newton iterations.

{% highlight fortran %}
report_hydro_solver_progress = .false.
{% endhighlight %}


<h3 id="report_ierr">report_ierr <a href="#report_ierr" title="Permalink to this location">¶</a></h3>


If true, produce terminal output when have some internal error.

{% highlight fortran %}
report_ierr = .false.
{% endhighlight %}


<h3 id="report_bad_negative_xa">report_bad_negative_xa <a href="#report_bad_negative_xa" title="Permalink to this location">¶</a></h3>


If true, produce terminal output when have bad negative mass fraction error.

{% highlight fortran %}
report_bad_negative_xa = .false.
{% endhighlight %}


<h3 id="stop_for_bad_nums">stop_for_bad_nums <a href="#stop_for_bad_nums" title="Permalink to this location">¶</a></h3>


If true and report_ierr is also true, then stop for bad numbers (NaNs or infinity).
this replaces old control stop_for_NaNs

{% highlight fortran %}
stop_for_bad_nums = .false.
{% endhighlight %}


<h3 id="trace_newton_bcyclic_solve_input">trace_newton_bcyclic_solve_input <a href="#trace_newton_bcyclic_solve_input" title="Permalink to this location">¶</a></h3>


Input is "B" j k iter B(j,k).

{% highlight fortran %}
trace_newton_bcyclic_solve_input = .false.
{% endhighlight %}


<h3 id="trace_newton_bcyclic_solve_output">trace_newton_bcyclic_solve_output <a href="#trace_newton_bcyclic_solve_output" title="Permalink to this location">¶</a></h3>


Output is "X" j k iter X(j,k).

{% highlight fortran %}
trace_newton_bcyclic_solve_output = .false.
{% endhighlight %}


<h3 id="trace_newton_bcyclic_matrix_input">trace_newton_bcyclic_matrix_input <a href="#trace_newton_bcyclic_matrix_input" title="Permalink to this location">¶</a></h3>


Matrix before factor.

{% highlight fortran %}
trace_newton_bcyclic_matrix_input = .false.
{% endhighlight %}


<h3 id="trace_newton_bcyclic_matrix_output">trace_newton_bcyclic_matrix_output <a href="#trace_newton_bcyclic_matrix_output" title="Permalink to this location">¶</a></h3>


Matrix after factor.

{% highlight fortran %}
trace_newton_bcyclic_matrix_output = .false.
{% endhighlight %}


<h3 id="trace_newton_bcyclic_steplo">trace_newton_bcyclic_steplo <a href="#trace_newton_bcyclic_steplo" title="Permalink to this location">¶</a></h3>


1st model number to trace.

{% highlight fortran %}
trace_newton_bcyclic_steplo = 1
{% endhighlight %}


<h3 id="trace_newton_bcyclic_stephi">trace_newton_bcyclic_stephi <a href="#trace_newton_bcyclic_stephi" title="Permalink to this location">¶</a></h3>


Last model number to trace.

{% highlight fortran %}
trace_newton_bcyclic_stephi = -1
{% endhighlight %}


<h3 id="trace_newton_bcyclic_iterlo">trace_newton_bcyclic_iterlo <a href="#trace_newton_bcyclic_iterlo" title="Permalink to this location">¶</a></h3>


1st newton iter to trace.

{% highlight fortran %}
trace_newton_bcyclic_iterlo = 1
{% endhighlight %}


<h3 id="trace_newton_bcyclic_iterhi">trace_newton_bcyclic_iterhi <a href="#trace_newton_bcyclic_iterhi" title="Permalink to this location">¶</a></h3>


Last newton iter to trace.

{% highlight fortran %}
trace_newton_bcyclic_iterhi = -1
{% endhighlight %}


<h3 id="trace_newton_bcyclic_nzlo">trace_newton_bcyclic_nzlo <a href="#trace_newton_bcyclic_nzlo" title="Permalink to this location">¶</a></h3>


1st cell to trace.

{% highlight fortran %}
trace_newton_bcyclic_nzlo = 1
{% endhighlight %}


<h3 id="trace_newton_bcyclic_nzhi">trace_newton_bcyclic_nzhi <a href="#trace_newton_bcyclic_nzhi" title="Permalink to this location">¶</a></h3>


Last cell to trace; if < 0, then use nz as nzhi.

{% highlight fortran %}
trace_newton_bcyclic_nzhi = -1
{% endhighlight %}


<h3 id="trace_newton_bcyclic_jlo">trace_newton_bcyclic_jlo <a href="#trace_newton_bcyclic_jlo" title="Permalink to this location">¶</a></h3>


1st var to trace.

{% highlight fortran %}
trace_newton_bcyclic_jlo = 1
{% endhighlight %}


<h3 id="trace_newton_bcyclic_jhi">trace_newton_bcyclic_jhi <a href="#trace_newton_bcyclic_jhi" title="Permalink to this location">¶</a></h3>


Last var to trace; if < 0, then use nvar as jhi.

{% highlight fortran %}
trace_newton_bcyclic_jhi = -1
{% endhighlight %}


To get info about the mesh set
`show_mesh_changes = .true.`.
Restart and get the `mesh_call_number` from terminal output.
Set `mesh_dump_call_number = mesh_call_number`.
Restart and it will write data files to `mesh_plot_data`.
view with `test/mesh.rb` and `test/mesh_plan.rb`.

<h3 id="show_mesh_changes">show_mesh_changes <a href="#show_mesh_changes" title="Permalink to this location">¶</a></h3>


When `show_mesh_changes` is true, the terminal output includes the `mesh_call_number`.

{% highlight fortran %}
show_mesh_changes = .false.
{% endhighlight %}


<h3 id="mesh_dump_call_number">mesh_dump_call_number <a href="#mesh_dump_call_number" title="Permalink to this location">¶</a></h3>


When `mesh_call_number == mesh_dump_call_number`, various plotting information is written..

{% highlight fortran %}
mesh_dump_call_number = -1
{% endhighlight %}


<h3 id="trace_evolve">trace_evolve <a href="#trace_evolve" title="Permalink to this location">¶</a></h3>


Send evolve output to screen.

{% highlight fortran %}
trace_evolve = .false.
{% endhighlight %}


variety of output from the hydro solver

hydro solver

{% highlight fortran %}
hydro_numerical_jacobian = .false.
hydro_jacobian_nzlo = 1
hydro_jacobian_nzhi = -1
hydro_check_everything = .false.
hydro_inspectB_flag = .false.
hydro_sizequ_flag = .false.
hydro_get_a_numerical_partial = -1d0
hydro_test_partials_k = -1
hydro_show_correction_info = .false.
hydro_save_numjac_plot_data = .false.
hydro_dump_call_number = -1
hydro_dump_iter_number = -1
hydro_epsder_struct = 1d-5
hydro_epsder_chem = 1d-5
{% endhighlight %}


<h3 id="hydro_save_photo">hydro_save_photo <a href="#hydro_save_photo" title="Permalink to this location">¶</a></h3>


Saves a photo when hydro_call_number = hydro_dump_call_number - 1

{% highlight fortran %}
hydro_save_photo = .false.
{% endhighlight %}


<h3 id="xa_clip_limit">xa_clip_limit <a href="#xa_clip_limit" title="Permalink to this location">¶</a></h3>


Abundances smaller than this limit are set to 0.

{% highlight fortran %}
xa_clip_limit = 1d-99
{% endhighlight %}


<h3 id="trace_k">trace_k <a href="#trace_k" title="Permalink to this location">¶</a></h3>


Print out trace information about cell with number = `trace_k`.

{% highlight fortran %}
trace_k = -1
{% endhighlight %}


<h3 id="fill_arrays_with_NaNs">fill_arrays_with_NaNs <a href="#fill_arrays_with_NaNs" title="Permalink to this location">¶</a></h3>


initialize arrays with NaNs to trap reads of uninitialized entries.

{% highlight fortran %}
fill_arrays_with_NaNs = .true.
{% endhighlight %}


<h3 id="zero_when_allocate">zero_when_allocate <a href="#zero_when_allocate" title="Permalink to this location">¶</a></h3>


initialize arrays with zeros.

{% highlight fortran %}
zero_when_allocate = .false.
{% endhighlight %}

<h1 id="miscellaneous_controls">miscellaneous controls <a href="#miscellaneous_controls" title="Permalink to this location">¶</a></h1>


<h3 id="warn_rates_for_high_temp">warn_rates_for_high_temp <a href="#warn_rates_for_high_temp" title="Permalink to this location">¶</a></h3>


If true then when any zone tries to evaluate a rate above `max_safe_logT_for_rates`
it generates a warning message. The code will  cap the rate at the value
for `max_safe_logT_for_rates` whether the warning is on or not.  
10d0 is a sensible default for the max temperature, as that is where the partition tables
and polynomial fits to the rates are valid until.
warning messages include the text "rates have been truncated" and "WARNING: evaluating rates".

{% highlight fortran %}
warn_rates_for_high_temp = .true.
max_safe_logT_for_rates = 10d0
{% endhighlight %}


<h3 id="warn_when_large_rel_run_E_err">warn_when_large_rel_run_E_err <a href="#warn_when_large_rel_run_E_err" title="Permalink to this location">¶</a></h3>


message includes the text "WARNING: rel_run_E_err"

rel_run_E_err = abs(cumulative_energy_error/total_energy)
you can turn off this warning message by setting this to a large number.

{% highlight fortran %}
warn_when_large_rel_run_E_err = 0.02d0
{% endhighlight %}


<h3 id="warn_when_stop_checking_residuals">warn_when_stop_checking_residuals <a href="#warn_when_stop_checking_residuals" title="Permalink to this location">¶</a></h3>


message includes the text "WARNING: have turned off residual tests for step"

{% highlight fortran %}
warn_when_stop_checking_residuals = .true.
{% endhighlight %}


<h3 id="warn_when_large_virial_thm_rel_err">warn_when_large_virial_thm_rel_err <a href="#warn_when_large_virial_thm_rel_err" title="Permalink to this location">¶</a></h3>


message includes the text "WARNING: virial_thm_rel_err"
only applies to models with no velocities and no rotation.

{% highlight fortran %}
warn_when_large_virial_thm_rel_err = 1d-3
{% endhighlight %}


<h3 id="warn_when_get_a_bad_eos_result">warn_when_get_a_bad_eos_result <a href="#warn_when_get_a_bad_eos_result" title="Permalink to this location">¶</a></h3>


message includes the text "WARNING eos:"

{% highlight fortran %}
warn_when_get_a_bad_eos_result = .true.
{% endhighlight %}


<h3 id="save_profile_and_stop_after_adjust_mass">save_profile_and_stop_after_adjust_mass <a href="#save_profile_and_stop_after_adjust_mass" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
save_profile_and_stop_after_adjust_mass = .false.
{% endhighlight %}


<h3 id="relax_dY">relax_dY <a href="#relax_dY" title="Permalink to this location">¶</a></h3>


Change Y by this amount per step when relaxing Y.

{% highlight fortran %}
relax_dY = 0.005d0
{% endhighlight %}


<h3 id="relax_dlnZ">relax_dlnZ <a href="#relax_dlnZ" title="Permalink to this location">¶</a></h3>


Change lnZ by this amount per step when relaxing Z.
Default is ln10/10.

{% highlight fortran %}
relax_dlnZ = 2.3025850929940459d-1
{% endhighlight %}


<h3 id="use_eps_mdot">use_eps_mdot <a href="#use_eps_mdot" title="Permalink to this location">¶</a></h3>


<h3 id="eps_mdot_leak_frac_factor">eps_mdot_leak_frac_factor <a href="#eps_mdot_leak_frac_factor" title="Permalink to this location">¶</a></h3>


{% highlight fortran %}
use_eps_mdot = .false.
eps_mdot_leak_frac_factor = 1d0
{% endhighlight %}


<h3 id="alpha_eps_mdot">alpha_eps_mdot <a href="#alpha_eps_mdot" title="Permalink to this location">¶</a></h3>


eps_mdot = 0 at mass levels deeper below surface than this times dt*abs(mdot)

{% highlight fortran %}
alpha_eps_mdot = 1
{% endhighlight %}


<h3 id="zams_filename">zams_filename <a href="#zams_filename" title="Permalink to this location">¶</a></h3>


Default is for Z=0.02, Y=0.28.

{% highlight fortran %}
zams_filename = 'zams_z2m2_y28.data'
{% endhighlight %}


{% highlight fortran %}
set_rho_to_dm_div_dV = .true.
{% endhighlight %}


<h3 id="use_other_hook">use_other_{hook} <a href="#use_other_hook" title="Permalink to this location">¶</a></h3>


Logicals to deploy the use_other routines.

{% highlight fortran %}
use_other_eos = .false.
use_other_kap = .false.
use_other_atm = .false.
use_other_diffusion = .false.
use_other_mlt = .false.
{% endhighlight %}


{% highlight fortran %}
use_other_adjust_net = .false.
use_other_adjust_mdot = .false.
use_other_j_for_adjust_J_lost = .false.
use_other_alpha_mlt = .false.
use_other_am_mixing = .false.
use_other_brunt = .false.
use_other_brunt_smoothing = .false.
use_other_build_initial_model = .false.
use_other_cgrav = .false.
{% endhighlight %}


{% highlight fortran %}
use_other_energy_implicit = .false.
use_other_energy = .false.
use_other_momentum = .false.
use_other_eps_grav = .false.
use_other_mesh_functions = .false.
use_other_D_mix = .false.
{% endhighlight %}


{% highlight fortran %}
use_other_neu = .false.
use_other_net_get = .false.
use_other_newton_monitor = .false.
use_other_opacity_factor = .false.
use_other_paquette_coefficients = .false.
use_other_pgstar_plots = .false.
use_other_porosity_factor = .false.
use_other_eval_fp_ft = .false.
use_other_torque = .false.
{% endhighlight %}


{% highlight fortran %}
use_other_torque_implicit = .false.
use_other_eta_visc = .false.
use_other_wind = .false.
use_other_split_mix = .false.
use_other_after_struct_burn_mix = .false.
use_other_before_struct_burn_mix = .false.
use_other_surface_PT = .false.
{% endhighlight %}


{% highlight fortran %}
use_other_export_pulse_data = .false.
use_other_get_pulse_data = .false.
use_other_edit_pulse_data = .false.
{% endhighlight %}


{% highlight fortran %}
use_other_astero_freq_corr = .false.
{% endhighlight %}


<h2 id="mixing_diffusion_coeffs">mixing diffusion coeffs <a href="#mixing_diffusion_coeffs" title="Permalink to this location">¶</a></h2>


<h3 id="sig_term_limit">sig_term_limit <a href="#sig_term_limit" title="Permalink to this location">¶</a></h3>


Limit on coefficients in convective mixing equations.
Consider a diffusion eqn of form:

    x(k) - x0(k) = c1*(x(k-1) - x(k)) - c2*(x(k) - x(k+1))

Simplify for c1=c2=c, x(k-1)=x(k+1)=x0(k)=x0, x(k)=x0+dx
Then eqn becomes

    (1+2*c)*(x0+dx) - 2*c*x0 = x0

If `2*c >> 1`, then eqn becomes ill-conditioned,
so we enforce `c <= sig_term_limit`
In physical terms c is `dt*sig/dm`, where
`sig = (4 pi r^2 rho)^2*D` and D = diffusion coeff (cm^2/s),
so c can get large when dt/dm is large.

{% highlight fortran %}
sig_term_limit = 1d13
{% endhighlight %}


<h3 id="am_sig_term_limit">am_sig_term_limit <a href="#am_sig_term_limit" title="Permalink to this location">¶</a></h3>


Limit on coefficients in angular momentum transport equations.
Necessary for numerical stability.
Plays same role as `sig_term_limit` for material mixing.

{% highlight fortran %}
am_sig_term_limit = 1d13
{% endhighlight %}


<h3 id="sig_min_factor_for_high_Tcenter">sig_min_factor_for_high_Tcenter <a href="#sig_min_factor_for_high_Tcenter" title="Permalink to this location">¶</a></h3>


High center T limit to avoid negative mass fractions.
If Tcenter >= `Tcenter_min_for_sig_min_factor_full_on`,
then okay to reduce sig by as much as this factor
as needed to prevent causing negative abundances.
Inactive when >= 1d0.

{% highlight fortran %}
sig_min_factor_for_high_Tcenter = 0.01d0
{% endhighlight %}


<h3 id="Tcenter_min_for_sig_min_factor_full_on">Tcenter_min_for_sig_min_factor_full_on <a href="#Tcenter_min_for_sig_min_factor_full_on" title="Permalink to this location">¶</a></h3>


If Tcenter >= this, factor = `sig_min_factor_for_neg_abundances`,
this should be > `Tcenter_max_for_sig_min_factor_full_off`.

{% highlight fortran %}
Tcenter_min_for_sig_min_factor_full_on = 3.2d9
{% endhighlight %}


<h3 id="Tcenter_max_for_sig_min_factor_full_off">Tcenter_max_for_sig_min_factor_full_off <a href="#Tcenter_max_for_sig_min_factor_full_off" title="Permalink to this location">¶</a></h3>


If Tcenter <= this, factor = 1, so has no effect
this should be < `Tcenter_min_for_sig_min_factor_full_on`.
For T > `full_off` and < `full_on`, factor changes linearly with Tcenter.

{% highlight fortran %}
Tcenter_max_for_sig_min_factor_full_off = 2.8d9
{% endhighlight %}


<h3 id="max_delta_m_to_bdy_for_sig_min_factor">max_delta_m_to_bdy_for_sig_min_factor <a href="#max_delta_m_to_bdy_for_sig_min_factor" title="Permalink to this location">¶</a></h3>


sig_min factor goes to 1 as distance (in Msun units)
from boundary of mixing region reaches this value

{% highlight fortran %}
max_delta_m_to_bdy_for_sig_min_factor = 0.5d0
{% endhighlight %}


<h3 id="delta_m_upper_for_sig_min_factor">delta_m_upper_for_sig_min_factor <a href="#delta_m_upper_for_sig_min_factor" title="Permalink to this location">¶</a></h3>


okay to change sig min factor to 1 for mix region larger than this

{% highlight fortran %}
delta_m_upper_for_sig_min_factor = 0.3d0
{% endhighlight %}


<h3 id="delta_m_lower_for_sig_min_factor">delta_m_lower_for_sig_min_factor <a href="#delta_m_lower_for_sig_min_factor" title="Permalink to this location">¶</a></h3>


don't change sig min factor for mix region smaller than this

{% highlight fortran %}
delta_m_lower_for_sig_min_factor = 0.1d0
{% endhighlight %}


<h3 id="Tcenter_max_for_dble_bcyclic">Tcenter_max_for_dble_bcyclic <a href="#Tcenter_max_for_dble_bcyclic" title="Permalink to this location">¶</a></h3>


if Tcenter <= this, use dble precision version of bcyclic.
if Tcenter > this, use quad precision.

{% highlight fortran %}
Tcenter_max_for_dble_bcyclic = 1d99
{% endhighlight %}


extra params as a convenience for developing new features
note: the parameter `num_x_ctrls` is defined in `star_def.inc`

{% highlight fortran %}
x_ctrl(1:num_x_ctrls) = 0d0
x_integer_ctrl(1:num_x_ctrls) = 0
x_logical_ctrl(1:num_x_ctrls) = .false.
{% endhighlight %}


One can split controls inlist into pieces using the following parameters.
BTW: it works recursively, so the extras can read extras too.

<h3 id="read_extra_controls_inlist1">read_extra_controls_inlist1 <a href="#read_extra_controls_inlist1" title="Permalink to this location">¶</a></h3>


<h3 id="extra_controls_inlist1_name">extra_controls_inlist1_name <a href="#extra_controls_inlist1_name" title="Permalink to this location">¶</a></h3>


If `read_extra_controls_inlist1` is true, then read &controls from this namelist file.

{% highlight fortran %}
read_extra_controls_inlist1 = .false.
extra_controls_inlist1_name = 'undefined'
{% endhighlight %}


If you try one of the following prebuilt extras,
you must also set `read_extra_star_job_inlist1` true
and change the `extra_star_job_inlist1_name` to match `extra_controls_inlist1_name`.

evolve 1 Msun from pre-ms to white dwarf

    read_extra_controls_inlist1 = .true.
    extra_controls_inlist1_name = 'inlist_extras_1M_lifecycle'

for debugging

    extra_controls_inlist1_name = 'inlist_debug'

<h3 id="read_extra_controls_inlist2">read_extra_controls_inlist2 <a href="#read_extra_controls_inlist2" title="Permalink to this location">¶</a></h3>


<h3 id="extra_controls_inlist2_name">extra_controls_inlist2_name <a href="#extra_controls_inlist2_name" title="Permalink to this location">¶</a></h3>


If `read_extra_controls_inlist2` is true, then read &controls from this namelist file.

{% highlight fortran %}
read_extra_controls_inlist2 = .false.
extra_controls_inlist2_name = 'undefined'
{% endhighlight %}


<h3 id="read_extra_controls_inlist1">read_extra_controls_inlist1 <a href="#read_extra_controls_inlist1" title="Permalink to this location">¶</a></h3>


<h3 id="extra_controls_inlist1_name">extra_controls_inlist1_name <a href="#extra_controls_inlist1_name" title="Permalink to this location">¶</a></h3>


If `read_extra_controls_inlist1` is true, then read &controls from this namelist file.

{% highlight fortran %}
read_extra_controls_inlist1 = .false.
extra_controls_inlist1_name = 'undefined'
{% endhighlight %}


If you try one of the following prebuilt extras,
you must also set `read_extra_star_job_inlist1` true
and change the `extra_star_job_inlist1_name` to match `extra_controls_inlist1_name`.

evolve 1 Msun from pre-ms to white dwarf

    read_extra_controls_inlist1 = .true.
    extra_controls_inlist1_name = 'inlist_extras_1M_lifecycle'

for debugging

    extra_controls_inlist1_name = 'inlist_debug'

<h3 id="read_extra_controls_inlist2">read_extra_controls_inlist2 <a href="#read_extra_controls_inlist2" title="Permalink to this location">¶</a></h3>


<h3 id="extra_controls_inlist2_name">extra_controls_inlist2_name <a href="#extra_controls_inlist2_name" title="Permalink to this location">¶</a></h3>


If `read_extra_controls_inlist2` is true, then read &controls from this namelist file.

{% highlight fortran %}
read_extra_controls_inlist2 = .false.
extra_controls_inlist2_name = 'undefined'
{% endhighlight %}


<h3 id="read_extra_controls_inlist3">read_extra_controls_inlist3 <a href="#read_extra_controls_inlist3" title="Permalink to this location">¶</a></h3>


<h3 id="extra_controls_inlist3_name">extra_controls_inlist3_name <a href="#extra_controls_inlist3_name" title="Permalink to this location">¶</a></h3>


If `read_extra_controls_inlist3` is true, then read &controls from this namelist file.

{% highlight fortran %}
read_extra_controls_inlist3 = .false.
extra_controls_inlist3_name = 'undefined'
{% endhighlight %}


<h3 id="read_extra_controls_inlist4">read_extra_controls_inlist4 <a href="#read_extra_controls_inlist4" title="Permalink to this location">¶</a></h3>


<h3 id="extra_controls_inlist4_name">extra_controls_inlist4_name <a href="#extra_controls_inlist4_name" title="Permalink to this location">¶</a></h3>


If `read_extra_controls_inlist4` is true, then read &controls from this namelist file.

{% highlight fortran %}
read_extra_controls_inlist4 = .false.
extra_controls_inlist4_name = 'undefined'
{% endhighlight %}


<h3 id="read_extra_controls_inlist5">read_extra_controls_inlist5 <a href="#read_extra_controls_inlist5" title="Permalink to this location">¶</a></h3>


<h3 id="extra_controls_inlist5_name">extra_controls_inlist5_name <a href="#extra_controls_inlist5_name" title="Permalink to this location">¶</a></h3>


If `read_extra_controls_inlist5` is true, then read &controls from this namelist file.

{% highlight fortran %}
read_extra_controls_inlist5 = .false.
extra_controls_inlist5_name = 'undefined'
{% endhighlight %}
