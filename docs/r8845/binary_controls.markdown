<h1 id="specifications_for_starting_model">specifications for starting model <a href="#specifications_for_starting_model" title="Permalink to this location">¶</a></h1>


<h3 id="m1">m1 <a href="#m1" title="Permalink to this location">¶</a></h3>


Initial mass of star 1 in Msun units. Not used when loading a saved model.
same caveats as `initial_mass` in star/defaults/controls.defaults apply

{% highlight fortran %}
m1 = 1.0d0
{% endhighlight %}


<h3 id="m2">m2 <a href="#m2" title="Permalink to this location">¶</a></h3>


Initial mass of star 2 in Msun units. Not used when loading a saved model.
same caveats as `initial_mass` in star/defaults/controls.defaults apply

{% highlight fortran %}
m2 = 0.8d0
{% endhighlight %}


<h3 id="initial_period_in_days">initial_period_in_days <a href="#initial_period_in_days" title="Permalink to this location">¶</a></h3>


Initial orbital period in days.

{% highlight fortran %}
initial_period_in_days = 0.5d0
{% endhighlight %}


<h3 id="initial_separation_in_Rsuns">initial_separation_in_Rsuns <a href="#initial_separation_in_Rsuns" title="Permalink to this location">¶</a></h3>


Initial separation measured in Rsuns. Only used when `initial_period_in_days < 0`

{% highlight fortran %}
initial_separation_in_Rsuns = 100
{% endhighlight %}


<h3 id="initial_eccentricity">initial_eccentricity <a href="#initial_eccentricity" title="Permalink to this location">¶</a></h3>


Initial eccentricity of the system

{% highlight fortran %}
initial_eccentricity = 0.0d0
{% endhighlight %}

<h1 id="controls_for_output">controls for output <a href="#controls_for_output" title="Permalink to this location">¶</a></h1>


<h3 id="history_name">history_name <a href="#history_name" title="Permalink to this location">¶</a></h3>


Name of file for binary output

{% highlight fortran %}
history_name = 'binary_history.data'
{% endhighlight %}


<h3 id="append_to_star_history">append_to_star_history <a href="#append_to_star_history" title="Permalink to this location">¶</a></h3>


If true, then the columns from the `binary_history` are also included
in each of the stars history files.
NOTE: if .false., then pgstar cannot access binary data

{% highlight fortran %}
append_to_star_history = .true.
{% endhighlight %}


<h3 id="log_directory">log_directory <a href="#log_directory" title="Permalink to this location">¶</a></h3>


Directory for binary output

{% highlight fortran %}
log_directory = '.'
{% endhighlight %}


<h3 id="history_dbl_format">history_dbl_format <a href="#history_dbl_format" title="Permalink to this location">¶</a></h3>


<h3 id="history_int_format">history_int_format <a href="#history_int_format" title="Permalink to this location">¶</a></h3>


<h3 id="history_txt_format">history_txt_format <a href="#history_txt_format" title="Permalink to this location">¶</a></h3>


Format for double, int and text in binary output

{% highlight fortran %}
history_dbl_format = '(1pes32.16e3, 1x)'
history_int_format = '(i32, 1x)'
history_txt_format = '(a32, 1x)'
{% endhighlight %}


<h3 id="photo_interval">photo_interval <a href="#photo_interval" title="Permalink to this location">¶</a></h3>


<h3 id="photo_digits">photo_digits <a href="#photo_digits" title="Permalink to this location">¶</a></h3>


These overwrite the numbers set for `photo_interval` and `photo_digits` for each
star, so that profiles are outputted simultaneously

{% highlight fortran %}
photo_interval = 50
photo_digits = 3
{% endhighlight %}

<h1 id="timestep_controls">timestep controls <a href="#timestep_controls" title="Permalink to this location">¶</a></h1>


The terminal output during evolution includes a short string for the 'dt_limit'.
This is to give you some indication of what is limiting the time steps.
Here's a dictionary mapping those terminal strings to the corresponding control parameters.
These only include limits from binary, to see the limits from star refer to
star/default/controls.defaults

          terminal output       related parameter
         'b_companion'          timestep limited by companion
         'b_RL'                 fr
         'b_jorb'               fj
         'b_envelope'           fm
         'b_separation'         fa
         'b_eccentricity'       fe
         'b_deltam'             fdm

<h3 id="fm">fm <a href="#fm" title="Permalink to this location">¶</a></h3>


<h3 id="fa">fa <a href="#fa" title="Permalink to this location">¶</a></h3>


<h3 id="fr">fr <a href="#fr" title="Permalink to this location">¶</a></h3>


<h3 id="fj">fj <a href="#fj" title="Permalink to this location">¶</a></h3>


<h3 id="fe">fe <a href="#fe" title="Permalink to this location">¶</a></h3>


Timestep controls based on relative changes. After each step
an upper limit is set on the timestep based on changes on different
quantities. If the quantity is X and the change in one timestep dX,
then this limit is given by

    dt_next_max = dt * fX*abs(X / dX)

each of these controls deals with the following:

+ fm: envelope mass
+ fa: binary separation
+ fr: change in (r-rl)/rl
+ fj: change in orbital angular momentum
+ fe: change in orbital eccentricity

{% highlight fortran %}
fm = 0.01d0
fa = 0.01d0
fr = 0.10d0
fj = 0.001d0
fe = 0.01d0
{% endhighlight %}


<h3 id="fm_limit">fm_limit <a href="#fm_limit" title="Permalink to this location">¶</a></h3>


<h3 id="fr_limit">fr_limit <a href="#fr_limit" title="Permalink to this location">¶</a></h3>


<h3 id="fe_limit">fe_limit <a href="#fe_limit" title="Permalink to this location">¶</a></h3>


Limits to timestep controls give by fm, fr and fe.
As these three quantities evolve naturally to zero,
following strictly the timestep limit given by fX would
reduce timesteps infinetely. These fX_limit avoid this problem
by computing the limit to the timestep as

    dt_next_max = dt * fX*abs(max(abs(X),fX_limit) / dX)

If any of these `fX_limit` is smaller than zero it is ignored.

{% highlight fortran %}
fm_limit = 1d-3
fr_limit = 1d-2
fe_limit = 1d-1
{% endhighlight %}


<h3 id="fr_dt_limit">fr_dt_limit <a href="#fr_dt_limit" title="Permalink to this location">¶</a></h3>


Minimum timestep limit allowed for the fr control in years.

{% highlight fortran %}
fr_dt_limit = 10d0
{% endhighlight %}


<h3 id="fdm">fdm <a href="#fdm" title="Permalink to this location">¶</a></h3>


Limits the timestep based on the expected fractional change
of mass of the donor,

    dt_next_max = fdm * s% mstar / abs(s% star_mdot)

{% highlight fortran %}
fdm = 0.005d0
{% endhighlight %}


<h3 id="dt_softening_factor">dt_softening_factor <a href="#dt_softening_factor" title="Permalink to this location">¶</a></h3>


Weight factor to average `max_timestep` with old one (in log space) as in

    dt_next_max = 10**(dt_softening_factor*log10(dt_next_max_old) + &
        (1-dt_softening_factor)*log10(dt_next_max))

where `dt_next_max_old` is the limit used in the previous step. This is meant
to avoid large changes in dt. Values must be < 1 and >= 0.

{% highlight fortran %}
dt_softening_factor = 0.5d0
{% endhighlight %}


<h3 id="varcontrol_stage">varcontrol_{stage} <a href="#varcontrol_stage" title="Permalink to this location">¶</a></h3>


Allows binary to set `varcontrol_target` for each star depending on the
stage of evolution. Ignored if < 0. Each one controls the following stages,

+ `varcontrol_case_a` : `varcontrol_target` for both stars during mass transfer
                    from a core hydrogen burning star.
+ `varcontrol_case_b` : `varcontrol_target` for both stars during mass transfer
                    from a core hydrogen depleted star.
+ `varcontrol_ms` : `varcontrol_target` for a star that has not depleted core H.
+ `varcontrol_post_ms` : `varcontrol_target` for a star that has depleted core H.

{% highlight fortran %}
varcontrol_case_a = -1d0
varcontrol_case_b = -1d0
varcontrol_ms = -1d0
varcontrol_post_ms = -1d0
{% endhighlight %}

<h1 id="when_to_stop">when to stop <a href="#when_to_stop" title="Permalink to this location">¶</a></h1>


<h3 id="accretor_overflow_terminate">accretor_overflow_terminate <a href="#accretor_overflow_terminate" title="Permalink to this location">¶</a></h3>


terminate evolution if (r-rl)/rl is bigger than this for accretor

{% highlight fortran %}
accretor_overflow_terminate = 0.0d0
{% endhighlight %}


<h3 id="terminate_if_initial_overflow">terminate_if_initial_overflow <a href="#terminate_if_initial_overflow" title="Permalink to this location">¶</a></h3>


terminate evolution if first model of run is overflowing

{% highlight fortran %}
terminate_if_initial_overflow = .true.
{% endhighlight %}


<h3 id="terminate_if_L2_overflow">terminate_if_L2_overflow <a href="#terminate_if_L2_overflow" title="Permalink to this location">¶</a></h3>


terminate evolution if there is overflow through the second Lagrangian point
Amount of overflow needed to reach L2 implemented as in Marchant et al. (2016), A&A, 588, A50

{% highlight fortran %}
terminate_if_L2_overflow = .false.
{% endhighlight %}

<h1 id="mass_transfer_controls">mass transfer controls <a href="#mass_transfer_controls" title="Permalink to this location">¶</a></h1>


<h3 id="ignore_rlof">ignore_rlof <a href="#ignore_rlof" title="Permalink to this location">¶</a></h3>


If true, then ignore Roche lobe overflow (i.e., no mass will be transferred)

{% highlight fortran %}
ignore_rlof = .false.
{% endhighlight %}


<h3 id="mass_transfer_">mass_transfer_* <a href="#mass_transfer_" title="Permalink to this location">¶</a></h3>


Transfer efficiency controls.
alpha, beta, delta and gamma parameters as described in Tauris & van den Heuvel 2006
section 16.4.1, transfer efficiency is given by 1-alpha-beta-delta.

These only affect mass that is lost from the donor due to mass transfer, winds from each
star will carry away angular momentum from the vicinity of each even when transfer efficiency
is unity. Each of these represent the following:

+ alpha : fraction of mass lost from the vicinity of the donor as fast wind
+ beta : fraction of mass lost from the vicinity of the accretor as fast wind
+ delta : fraction of mass lost from circumbinary coplanar toroid
+ gamma : radius of the circumbinary coplanar toroid is `gamma**2 * orbital_separation`

{% highlight fortran %}
mass_transfer_alpha = 0.0d0
mass_transfer_beta = 0.0d0
mass_transfer_delta = 0.0d0
mass_transfer_gamma = 0.0d0
{% endhighlight %}


<h3 id="limit_retention_by_mdot_edd">limit_retention_by_mdot_edd <a href="#limit_retention_by_mdot_edd" title="Permalink to this location">¶</a></h3>


Limit accretion using `mdot_edd`. The current implementation is intended for use with
black hole accretors, as in e.g. Podsiadlowski, Rappaport & Han (2003), MNRAS, 341, 385.
For other accretors `mdot_edd` should be set with `use_this_for_mdot_edd`, the hook
`use_other_mdot_edd`, or by appropriately setting `use_this_for_mdot_edd_eta`.
Note: MESA versions equal or lower than 8118 used eta=1 and did not correct
the accreted mass for the energy lost by radiation.

If accreted material radiates an amount of energy equal to `L=eta*mtransfer_rate*clight**2`,
then accretion is assumed to be limited to the Eddington luminosity,
Ledd = 4*pi*cgrav*Mbh*clight/kappa
which results in the Eddington mass-accretion rate
    mdot_edd = 4*pi*cgrav*Mbh/(kappa*clight*eta)
the efficiency eta is determined by the properties of the last stable circular orbit,
and for a BH with no initial spin it can be expressed in terms of the initial BH mass Mbh0
and the current BH mass,
    eta = 1-sqrt(1-(Mbh/Mbh0)**2)
for Mbh < sqrt(6) Mbh0. For BHs with initial spins different from zero, an effective
Mbh0 can be computed, corresponding to the mass the black hole would have needed to
have with zero spin to reach the current mass and spin.

{% highlight fortran %}
limit_retention_by_mdot_edd = .true.
{% endhighlight %}


<h3 id="use_es_opacity_for_mdot_edd">use_es_opacity_for_mdot_edd <a href="#use_es_opacity_for_mdot_edd" title="Permalink to this location">¶</a></h3>


If .true., then the opacity for `mdot_edd` is computed as 0.2*(1+X)
If .false., the opacity of the outermost cell of the donor is used

{% highlight fortran %}
use_es_opacity_for_mdot_edd = .true.
{% endhighlight %}


<h3 id="use_this_for_mdot_edd_eta">use_this_for_mdot_edd_eta <a href="#use_this_for_mdot_edd_eta" title="Permalink to this location">¶</a></h3>


Fixed `mdot_edd_eta`, if negative, eta will be computed consistently as material is accreted.
Values should be between ~0.06-0.42, the minimum corresponding to a BH with spin parameter a=0, and the maximum to a=1.

{% highlight fortran %}
use_this_for_mdot_edd_eta = -1
{% endhighlight %}


<h3 id="use_radiation_corrected_transfer_rate">use_radiation_corrected_transfer_rate <a href="#use_radiation_corrected_transfer_rate" title="Permalink to this location">¶</a></h3>


If true, then reduce the increase in mass of the BH to account for the radiated energy `eta*mtransfer_rate_clight**2`
so that in a timestep
    delta_Mbh = (1-eta)*mass_transfer_rate*dt

{% highlight fortran %}
use_radiation_corrected_transfer_rate = .true.
{% endhighlight %}


<h3 id="initial_bh_spin">initial_bh_spin <a href="#initial_bh_spin" title="Permalink to this location">¶</a></h3>


Initial spin parameter of the black hole "a". Must be between 0 and 1.
Evolution of BH spin is done with eq. (6) of King & Kolb (1999), MNRAS, 305, 654

{% highlight fortran %}
initial_bh_spin = 0
{% endhighlight %}


<h3 id="use_this_for_mdot_edd">use_this_for_mdot_edd <a href="#use_this_for_mdot_edd" title="Permalink to this location">¶</a></h3>


Fixed `mdot_edd` in Msun/yr, ignored if negative

{% highlight fortran %}
use_this_for_mdot_edd = -1
{% endhighlight %}


<h3 id="mdot_scheme">mdot_scheme <a href="#mdot_scheme" title="Permalink to this location">¶</a></h3>


How to compute mass transfer. Options are:

+ "Ritter" : Ritter 1988, A&A, 202, 93
+ "Kolb" : Optically thick overflow of Kolb & Ritter 1990, A&A, 236, 385
+ "roche_lobe" : Set mass transfer rate such that the donor remains inside
               its Roche lobe. Only works implicitly.
+ "contact" : Extends the roche_lobe scheme to include contact systems as in
              Marchant et al. (2016), A&A, 588, A50

{% highlight fortran %}
mdot_scheme = 'Ritter'
{% endhighlight %}


<h2 id="explicit_mass_transfer_computation">explicit mass transfer computation. <a href="#explicit_mass_transfer_computation" title="Permalink to this location">¶</a></h2>


MESA can compute mass transfer rates either explicitly (at the beggining
of the step) or implicitly (iterating the solution until the mass transfer
rate matches the value computed at the end of the step). The explicit method
is used if `max_tries_to_achieve <= 0`.

<h3 id="cur_mdot_frac">cur_mdot_frac <a href="#cur_mdot_frac" title="Permalink to this location">¶</a></h3>


Average the explicit mass transfer rate computed with the old in order
to smooth large changes.

    mass_transfer = mass_transfer_old * cur_mdot_frac + (1-cur_mdot_frac) * mass_transfer

{% highlight fortran %}
cur_mdot_frac = 0.5d0
{% endhighlight %}


<h3 id="max_explicit_abs_mdot">max_explicit_abs_mdot <a href="#max_explicit_abs_mdot" title="Permalink to this location">¶</a></h3>


Limit the explicit mass transfer rate to `max_explicit_abs_mdot`, in Msun/secyer

{% highlight fortran %}
max_explicit_abs_mdot = 1d-7
{% endhighlight %}


<h2 id="implicit_mass_transfer_computation">implicit mass transfer computation. <a href="#implicit_mass_transfer_computation" title="Permalink to this location">¶</a></h2>


<h3 id="max_tries_to_achieve">max_tries_to_achieve <a href="#max_tries_to_achieve" title="Permalink to this location">¶</a></h3>


The implicit method will modify the mass transfer rate and redo the step until
it either finds a solution, or the number of tries goes above `max_tries_to_achieve`.
if `max_tries_to_achieve <= 0` the explicit method is used.

{% highlight fortran %}
max_tries_to_achieve = 0
{% endhighlight %}


<h3 id="implicit_scheme_tolerance">implicit_scheme_tolerance <a href="#implicit_scheme_tolerance" title="Permalink to this location">¶</a></h3>


Tolerance for which a solution is considered valid. For the Ritter and Kolb
schemes if we call mdot the mass transfer rate used for the step, and mdot_end
the one computed at the end of it, a solution is valid if

    |(mdot-mdot_end)/mdot_end| < b% implicit_scheme_tolerance

For the roche_lobe scheme, a solution will be considered valid if

    -implicit_scheme_tolerance < (r-rl)/rl < 0

When using the roche_lobe scheme smaller values of order 1d-3 or smaller are
recommended.

{% highlight fortran %}
implicit_scheme_tolerance = 5d-2
{% endhighlight %}


<h3 id="initial_change_factor">initial_change_factor <a href="#initial_change_factor" title="Permalink to this location">¶</a></h3>


<h3 id="change_factor_fraction">change_factor_fraction <a href="#change_factor_fraction" title="Permalink to this location">¶</a></h3>


<h3 id="implicit_lambda">implicit_lambda <a href="#implicit_lambda" title="Permalink to this location">¶</a></h3>


The implicit scheme works by adjusting the mass transfer rate from the previous
step until it finds a solution. If the mass transfer needs to increase/reduce after
a try, then it is multiplied/divided by `change_factor`. `initial_change_factor` provides
the initial value for this parameter, however, since at certain points the mass
transfer rate will increase steeply and at others remain mostly constant from step
to step, MESA adjusts the value of the change factor to make it easier to find
solutions. Whenever the mass transfer rate changes from the previous value, MESA
will modify the `change_factor` according to:

    if(mass_transfer_rate < mass_transfer_prev) then
       change_factor = change_factor*(1.0-implicit_lambda) &
          + implicit_lambda*(1+change_factor_fraction*(mass_transfer_rate/mass_transfer_prev-1))
    else
       change_factor = change_factor*(1.0-implicit_lambda) &
          + implicit_lambda*(1+change_factor_fraction*(mass_transfer_prev/mass_transfer_rate-1))
       change_factor = change_factor*(1.0-implicit_lambda) &
          + implicit_lambda*(1+change_factor_fraction*(mass_transfer_rate/mass_transfer_prev-1))
    end if

Choosing `implicit_lambda = 0` will keep the change factor constant.

{% highlight fortran %}
initial_change_factor = 1.5d0
change_factor_fraction = 0.9d0
implicit_lambda = 0.25d0
{% endhighlight %}


<h3 id="max_change_factor">max_change_factor <a href="#max_change_factor" title="Permalink to this location">¶</a></h3>


<h3 id="min_change_factor">min_change_factor <a href="#min_change_factor" title="Permalink to this location">¶</a></h3>


Maximum and minimum values for the `change_factor`

{% highlight fortran %}
max_change_factor = 1.5d0
min_change_factor = 1.05d0
{% endhighlight %}


<h3 id="num_tries_for_increase_change_factor">num_tries_for_increase_change_factor <a href="#num_tries_for_increase_change_factor" title="Permalink to this location">¶</a></h3>


<h3 id="change_factor_increase">change_factor_increase <a href="#change_factor_increase" title="Permalink to this location">¶</a></h3>


If after every `num_tries_for_increase_change_factor` iterations the implicit scheme does not have upper
and lower bounds for the mass transfer rate, multiply `change_factor` by `change_factor_increase`. Ignored if
`num_tries_for_increase_change_factor < 1`. Increase is limited to `max_change_factor`.

{% highlight fortran %}
num_tries_for_increase_change_factor = 20
change_factor_increase = 1.1d0
{% endhighlight %}


<h3 id="starting_mdot">starting_mdot <a href="#starting_mdot" title="Permalink to this location">¶</a></h3>


When using the `roche_lobe` scheme, if the donor overflows for the first time
use `starting_mdot` (in Msun/secyer) as an initial guess for the mass transfer rate.

{% highlight fortran %}
starting_mdot = 1d-12
{% endhighlight %}


<h3 id="roche_min_mdot">roche_min_mdot <a href="#roche_min_mdot" title="Permalink to this location">¶</a></h3>


When using the `roche_lobe` scheme, if mass transfer rate is below `roche_min_mdot`
(in Msun/secyer) and the donor is not overflowing its roche lobe, assume detachment
and stop mass transfer.

{% highlight fortran %}
roche_min_mdot = 1d-16
{% endhighlight %}


<h3 id="min_mdot_for_implicit">min_mdot_for_implicit <a href="#min_mdot_for_implicit" title="Permalink to this location">¶</a></h3>


For any choice except for the `roche_lobe` scheme mass transfer will be computed explicitly
until the explicit computation of mdot is > `min_mdot_for_implicit` (in Msun/secyer),
even if `max_tries_to_achieve` > 0. This is to avoid spending many iterations when the stars
are detached and the explicit calculation gives very low values of mdot.

{% highlight fortran %}
min_mdot_for_implicit = 1d-16
{% endhighlight %}


<h3 id="max_implicit_abs_mdot">max_implicit_abs_mdot <a href="#max_implicit_abs_mdot" title="Permalink to this location">¶</a></h3>


Limit the implicit mass transfer rate to `max_implicit_abs_mdot`, in Msun/secyer

{% highlight fortran %}
max_implicit_abs_mdot = 1d99
{% endhighlight %}


<h2 id="Tidal_wind_enhancement">Tidal wind enhancement <a href="#Tidal_wind_enhancement" title="Permalink to this location">¶</a></h2>


<h3 id="do_enhance_wind_">do_enhance_wind_* <a href="#do_enhance_wind_" title="Permalink to this location">¶</a></h3>


Use the Tout & Eggleton mechanism to tidally enhance the wind mass
loss from one or both components according to:

    Mdot_w = Mdot_w * ( 1 + B_wind * min( (R/RL)^6, 0.5^6 ) )

Tout & Eggleton 1988,MNRAS,231,823 (eq. 2)

"\_1" refers to first star, "\_2" to the second one.

{% highlight fortran %}
do_enhance_wind_1 = .false.
do_enhance_wind_2 = .false.
{% endhighlight %}


<h3 id="tout_B_wind_">tout_B_wind_* <a href="#tout_B_wind_" title="Permalink to this location">¶</a></h3>


The `B_wind` parameter from the previous equation. Default value is
taken from Tout & Eggleton 1988,MNRAS,231,823

"\_1" refers to first star, "\_2" to the second one.

{% highlight fortran %}
tout_B_wind_1 = 1d4
tout_B_wind_2 = 1d4
{% endhighlight %}


<h2 id="Wind_mass_accretion">Wind mass accretion <a href="#Wind_mass_accretion" title="Permalink to this location">¶</a></h2>


<h3 id="do_wind_mass_transfer_">do_wind_mass_transfer_* <a href="#do_wind_mass_transfer_" title="Permalink to this location">¶</a></h3>


transfer part of the mass lost due to stellar winds from the mass losing
component to its companion. Using the Bondy-Hoyle mechanism.
"\_1" refers to first star, "\_2" to the second one.

{% highlight fortran %}
do_wind_mass_transfer_1 = .false.
do_wind_mass_transfer_2 = .false.
{% endhighlight %}


<h3 id="wind_BH_alpha_">wind_BH_alpha_* <a href="#wind_BH_alpha_" title="Permalink to this location">¶</a></h3>


Bondy-Hoyle accretion parameter for each star. The default is 3/2 taken
from Hurley et al. 2002, MNRAS, 329, 897, in agreement with
Boffin & Jorissen 1988, A&A, 205, 155
"\_1" refers to first star, "\_2" to the second one.

{% highlight fortran %}
wind_BH_alpha_1 = 1.5d0
wind_BH_alpha_2 = 1.5d0
{% endhighlight %}


<h3 id="max_wind_transfer_fraction_">max_wind_transfer_fraction_* <a href="#max_wind_transfer_fraction_" title="Permalink to this location">¶</a></h3>


Upper limit on the wind transfer fraction for star *
"\_1" refers to first star, "\_2" to the second one.

{% highlight fortran %}
max_wind_transfer_fraction_1 = 0.5d0
max_wind_transfer_fraction_2 = 0.5d0
{% endhighlight %}

<h1 id="orbital_jdot_controls">orbital jdot controls <a href="#orbital_jdot_controls" title="Permalink to this location">¶</a></h1>


<h3 id="do_jdot_gr">do_jdot_gr <a href="#do_jdot_gr" title="Permalink to this location">¶</a></h3>


Include gravitational wave radiation in jdot

{% highlight fortran %}
do_jdot_gr = .true.
{% endhighlight %}


<h3 id="do_jdot_ml">do_jdot_ml <a href="#do_jdot_ml" title="Permalink to this location">¶</a></h3>


Include loss of angular momentum via mass loss. The parameters
`mass_transfer_*` determine the fractions of mass lost from the vincinity
of the donor, the accretor, or a circumbinary coplanar toroid.

{% highlight fortran %}
do_jdot_ml = .true.
{% endhighlight %}


<h3 id="do_jdot_ls">do_jdot_ls <a href="#do_jdot_ls" title="Permalink to this location">¶</a></h3>


Fix jdot such that the total angular momentum of the system is conserved,
except for loses due to other jdot mechanisms, or angular momentum loss
from winds. This is meant to take care of L-S coupling due to tides.

{% highlight fortran %}
do_jdot_ls = .true.
{% endhighlight %}


<h3 id="do_jdot_missing_wind">do_jdot_missing_wind <a href="#do_jdot_missing_wind" title="Permalink to this location">¶</a></h3>


Usually MESA computes stellar AM loss due to winds by taking the angular momentum from
the removed layers of the star. However, when mass transfer is included, wind mass
loss and mass accretion are added up, and only the remainder, if corresponding to
net mass loss, contributes to stellar AM loss. `jdot_missing_wind` compensates for this,
by removing from the orbit an amount of angular momentum equal to the mass lost
that does not contribute to stellar AM loss, times the specific angular momentum
at the surface.

{% highlight fortran %}
do_jdot_missing_wind = .false.
{% endhighlight %}


<h3 id="do_jdot_mb">do_jdot_mb <a href="#do_jdot_mb" title="Permalink to this location">¶</a></h3>


Include magnetic braking as in Rappaport, Verbunt, and Joss.  apj, 275, 713-731. 1983.

{% highlight fortran %}
do_jdot_mb = .true.
{% endhighlight %}


<h3 id="include_accretor_mb">include_accretor_mb <a href="#include_accretor_mb" title="Permalink to this location">¶</a></h3>


If true, the contribution to jdot from magnetic braking of the accretor is
also taken into account.

{% highlight fortran %}
include_accretor_mb = .false.
{% endhighlight %}


<h3 id="magnetic_braking_gamma">magnetic_braking_gamma <a href="#magnetic_braking_gamma" title="Permalink to this location">¶</a></h3>


gamma exponent for magnetic braking.

{% highlight fortran %}
magnetic_braking_gamma = 3.0d0
{% endhighlight %}


<h3 id="keep_mb_on">keep_mb_on <a href="#keep_mb_on" title="Permalink to this location">¶</a></h3>


If true keep magnetic braking even when radiative core goes away.

{% highlight fortran %}
keep_mb_on = .false.
{% endhighlight %}


<h3 id="jdot_multiplier">jdot_multiplier <a href="#jdot_multiplier" title="Permalink to this location">¶</a></h3>


Multiply total jdot by this factor.
NOTE: `jdot_ls` is not affected by this.

{% highlight fortran %}
jdot_multiplier = 1d0
{% endhighlight %}

<h1 id="rotation_and_sync_controls">rotation and sync controls <a href="#rotation_and_sync_controls" title="Permalink to this location">¶</a></h1>


<h3 id="do_j_accretion">do_j_accretion <a href="#do_j_accretion" title="Permalink to this location">¶</a></h3>


If true, compute accretion of angular momentum following A.3.3 of 
de Mink et al. 2013, ApJ, 764, 166. Otherwise, incoming  material is
assumed to have the specific angular momentum of the surface of the accretor.

{% highlight fortran %}
do_j_accretion = .false.
{% endhighlight %}


<h3 id="do_tidal_sync">do_tidal_sync <a href="#do_tidal_sync" title="Permalink to this location">¶</a></h3>


If true, apply tidal torque to the star

{% highlight fortran %}
do_tidal_sync = .false.
{% endhighlight %}


<h3 id="sync_type_">sync_type_* <a href="#sync_type_" title="Permalink to this location">¶</a></h3>


Timescale for orbital synchronisation.
"\_1" refers to first star, "\_2" to the second one.
Options are:

+ "Instantaneous" : Keep the star synced to the orbit.
+ "Orb_period" : Sync in the timescale of the orbital period.
+ "Hut_conv" : Sync timescale following Hurley et al. 2002, MNRAS, 329, 897
             for convective envelopes.
+ "Hut_rad" : Sync timescale following Hurley et al. 2002, MNRAS, 329, 897
             for radiative envelopes.
+ "None" : No sync for this star.

{% highlight fortran %}
sync_type_1 = 'Hut_conv'
sync_type_2 = 'Hut_conv'
{% endhighlight %}


<h3 id="sync_mode_">sync_mode_* <a href="#sync_mode_" title="Permalink to this location">¶</a></h3>


Where angular momentum is deposited for synchronization.
"\_1" refers to first star, "\_2" to the second one.
Options are:

+ "Uniform" : Each layer is synced independently given the sync timescale.

{% highlight fortran %}
sync_mode_1 = 'Uniform'
sync_mode_2 = 'Uniform'
{% endhighlight %}


<h3 id="Ftid_">Ftid_* <a href="#Ftid_" title="Permalink to this location">¶</a></h3>


Tidal strength factor. Synchronisation and circularisation timescales are divided by this.
"\_1" refers to first star, "\_2" to the second one.

{% highlight fortran %}
Ftid_1 = 1d0
Ftid_2 = 1d0
{% endhighlight %}


<h3 id="do_initial_orbit_sync_">do_initial_orbit_sync_* <a href="#do_initial_orbit_sync_" title="Permalink to this location">¶</a></h3>


Relax rotation of star to orbital period at the beggining of evolution.
"\_1" refers to first star, "\_2" to the second one.

{% highlight fortran %}
do_initial_orbit_sync_1 = .false.
do_initial_orbit_sync_2 = .false.
{% endhighlight %}


<h3 id="tidal_reduction">tidal_reduction <a href="#tidal_reduction" title="Permalink to this location">¶</a></h3>


`tidal_reduction` accounts for the reduction in the effectiveness of convective
damping of the equilibrium tide when the tidal forcing period is less than the
convective turnover period of the largest eddies. It corresponds to the exponent
in eq. (32) of Hurley et al. 2002, MNRAS, 329, 897

`tidal_reduction` = 1 follows Zahn(1966, 1989), while `tidal_reduction` = 2 follows
Goldreich & Nicholson (1977).

{% highlight fortran %}
tidal_reduction = 2.0d0
{% endhighlight %}

<h1 id="eccentricity_controls">eccentricity controls <a href="#eccentricity_controls" title="Permalink to this location">¶</a></h1>


<h3 id="do_tidal_circ">do_tidal_circ <a href="#do_tidal_circ" title="Permalink to this location">¶</a></h3>


If true, apply tidal circularisation

{% highlight fortran %}
do_tidal_circ = .false.
{% endhighlight %}


<h3 id="circ_type_">circ_type_* <a href="#circ_type_" title="Permalink to this location">¶</a></h3>


Mechanism for circularisation. Options are:
"\_1" refers to first star, "\_2" to the second one.

+ "Hut_conv" : Circ timescale following Hurley et al. 2002, MNRAS, 329, 897
             for convective envelopes.
+ "Hut_rad" : Circ timescale following Hurley et al. 2002, MNRAS, 329, 897
             for radiative envelopes.
+ "None" : no tidal circularisation

{% highlight fortran %}
circ_type_1 = 'Hut_conv'
circ_type_2 = 'Hut_conv'
{% endhighlight %}


<h3 id="use_eccentricity_enhancement">use_eccentricity_enhancement <a href="#use_eccentricity_enhancement" title="Permalink to this location">¶</a></h3>


Flag to turn on Soker eccentricity enhancement

{% highlight fortran %}
use_eccentricity_enhancement = .false.
{% endhighlight %}


<h3 id="max_abs_edot_tidal">max_abs_edot_tidal <a href="#max_abs_edot_tidal" title="Permalink to this location">¶</a></h3>


Maximum absolute value for tidal edot (in 1/s). If the computed tidal edot goes
above this, then it is fixed at this maximum

{% highlight fortran %}
max_abs_edot_tidal = 1d-6
{% endhighlight %}


<h3 id="max_abs_edot_enhance">max_abs_edot_enhance <a href="#max_abs_edot_enhance" title="Permalink to this location">¶</a></h3>


Maximum absolute value for eccentricity enhancement (in 1/s). If the computed edot goes
above this, then it is fixed at this maximum

{% highlight fortran %}
max_abs_edot_enhance = 1d-6
{% endhighlight %}


<h3 id="min_eccentricity">min_eccentricity <a href="#min_eccentricity" title="Permalink to this location">¶</a></h3>


If after a step `eccentricity < min_eccentricity`, then fix it at this value

{% highlight fortran %}
min_eccentricity = 0.0d0
{% endhighlight %}


<h3 id="max_eccentricity">max_eccentricity <a href="#max_eccentricity" title="Permalink to this location">¶</a></h3>


If after a step `eccentricity > max_eccentricity`, then fix it at this value

{% highlight fortran %}
max_eccentricity = 0.99d0
{% endhighlight %}

<h1 id="irradiation_controls">irradiation controls <a href="#irradiation_controls" title="Permalink to this location">¶</a></h1>


<h3 id="accretion_powered_irradiation">accretion_powered_irradiation <a href="#accretion_powered_irradiation" title="Permalink to this location">¶</a></h3>


Flag to turn on irradiation of the donor due to accretion onto a compact object.

{% highlight fortran %}
accretion_powered_irradiation = .false.
{% endhighlight %}


<h3 id="accretor_radius_for_irrad">accretor_radius_for_irrad <a href="#accretor_radius_for_irrad" title="Permalink to this location">¶</a></h3>


Radius in cm for accreting object, e.g., 10km for ns.

{% highlight fortran %}
accretor_radius_for_irrad = 1d6
{% endhighlight %}


<h3 id="col_depth_for_eps_extra">col_depth_for_eps_extra <a href="#col_depth_for_eps_extra" title="Permalink to this location">¶</a></h3>


Energy from irradiation will be deposited in the outer 
`4*Pi*R^2*col_depth_for_eps_extra` grams of the star.

{% highlight fortran %}
col_depth_for_eps_extra = -1
{% endhighlight %}


<h3 id="irrad_flux_at_std_distance">irrad_flux_at_std_distance <a href="#irrad_flux_at_std_distance" title="Permalink to this location">¶</a></h3>


<h3 id="std_distance_for_irradiation">std_distance_for_irradiation <a href="#std_distance_for_irradiation" title="Permalink to this location">¶</a></h3>


If `irrad_flux_at_std_distance > 0` then irradiation flux is computed as

    s% irradiation_flux = b% irrad_flux_at_std_distance * &
        (b% std_distance_for_irradiation/b% separation)**2

{% highlight fortran %}
irrad_flux_at_std_distance = -1
std_distance_for_irradiation = -1
{% endhighlight %}


<h3 id="max_F_irr">max_F_irr <a href="#max_F_irr" title="Permalink to this location">¶</a></h3>


Limit irradiation by this amount.

{% highlight fortran %}
max_F_irr = 5d12
{% endhighlight %}

<h1 id="miscellaneous_controls">miscellaneous controls <a href="#miscellaneous_controls" title="Permalink to this location">¶</a></h1>


<h3 id="keep_donor_fixed">keep_donor_fixed <a href="#keep_donor_fixed" title="Permalink to this location">¶</a></h3>


keep star 1 as donor, even if accretor is closer to filling roche lobe

{% highlight fortran %}
keep_donor_fixed = .true.
{% endhighlight %}


<h3 id="mdot_limit_donor_switch">mdot_limit_donor_switch <a href="#mdot_limit_donor_switch" title="Permalink to this location">¶</a></h3>


Do not change donor if mass transfer is larger than this (given in Msun/secyer).
Avoids erratic changes when both stars are filling their roche loches.

{% highlight fortran %}
mdot_limit_donor_switch = 1d-20
{% endhighlight %}


<h3 id="use_other_hook">use_other_{hook} <a href="#use_other_hook" title="Permalink to this location">¶</a></h3>


Logicals to deploy the use_other routines.

{% highlight fortran %}
use_other_rlo_mdot = .false.
use_other_tsync = .false.
use_other_mdot_edd = .false.
use_other_accreted_material_j = .false.
use_other_jdot_gr = .false.
use_other_jdot_ml = .false.
use_other_jdot_ls = .false.
use_other_jdot_missing_wind = .false.
use_other_jdot_mb = .false.
use_other_extra_jdot = .false.
use_other_binary_wind_transfer = .false.
{% endhighlight %}
