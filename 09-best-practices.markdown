---
layout: default
title: best practices
permalink: bestpractices.html
---

# During the project

When you begin a new project you should generally use the most recent
MESA release.  Unless you encounter bugs that negatively impact your
work, stick with that version throughout the project.  If you're
starting from a set of input files that were designed for an older
version, we suggest you invest some time porting it to the latest
version, as if you run into any issues this will make it much easier
for the community to assist you.

Before modifying any source code in the main MESA directory, check if
these changes cannot be applied locally in your work folder using the
[hooks provided by MESA][hooks]. If you have a
use case that cannot be completed with the provided set of hooks, you
can always contact us to request a new one.

[hooks]:run_star_extras.html

The MESA test suite (`star/test_suite` and `binary/test_suite`) is a
valuable source of examples and a good first stop when setting up a
new problem with MESA.  Looking at the test suite inlists is a quick
way to familiarize yourself with the set of options relevant to your
problem.  More information is available on [how to use a test suite
case as a starting point for your own work directory][how].

[how]: starting.html#the-test-suite-as-a-source-of-examples

You should always perform some sort of convergence study to ensure
that your results are not sensitive to the time or mass resolution of
your models.

Throughout your project, the best way to solicit community help and
input is via a message to the [mesa-users@lists.mesastar.org mailing
list][list].

[list]:prereqs.html#join-the-mailing-list

# In the paper

You should provide a clear statement of which version of MESA was used
in the calculation.  We also recommend noting which version of the
MESA SDK was used to compile MESA.

## Citing MESA

You should cite all of the available MESA instrument papers at the
time of the MESA version being used, as MESA is sum of this work.
Currently, that is:

{% highlight tex %}
Modules for Experiments in Stellar Astrophysics
\citep[MESA][]{Paxton2011, Paxton2013, Paxton2015, Paxton2018, Paxton2019}.
{% endhighlight %}

MESA critically rests on the hard work of many researchers who have
generated the input microphysics data that underpins the eos, kap,
net, and neu modules.  We therefore encourage users to briefly
summarize these, including appropriate citations.

{% highlight tex %}
The MESA EOS is a blend of the OPAL \citet{Rogers}, SCVH
\citet{Saumon1995}, PTEH \citet{Pols1995}, HELM
\citet{Timmes2000}, and PC \citet{Potekhin2010} EOSes.

Radiative opacities are primarily from OPAL \citep{Iglesias1993,
Iglesias1996}, with low-temperature data from \citet{Fergusson2005}
and the high-temperature, Compton-scattering dominated regime by
\citet{Buchler1976}.  Electron conduction opacities are from
\citet{Cassisi2007}.

Nuclear reaction rates are from JINA REACLIB \citep{Cyburt2010} plus additional
tabulated weak reaction rates \citet{Fuller1985, Oda1994, Langanke2000}.
Screening is included via the prescription of \citet{Chugunov2007}.
Thermal neutrino loss rates are from \citet{Itoh1996}.
{% endhighlight %}

Note that this only summarizes the "default" capabilities.  If you are
making use of other microphysics options, or employing prescriptions
such as wind mass loss rates, please consult the documentation for
appropriate references.

A [BibTex file](assets/mesa.bib) with these references is available.

## Citing included tools

If you are making use of an instrument that is provided in MESA (e.g.,
ADIPLS, GYRE, RSP, or STELLA), please make sure to include citations
to the papers that describe it.

{% highlight tex %}
ADIPLS \citep{ChristensenDalsgaard2008}
{% endhighlight %}

{% highlight tex %}
GYRE \citep{Townsend2013, Townsend2018}
{% endhighlight %}

{% highlight tex %}
RSP \citep{Smolec2008}
{% endhighlight %}

{% highlight tex %}
STELLA \citep{Blinnikov2004, Baklanov2005, Blinnikov2006}
{% endhighlight %}

A [BibTex file](assets/tools.bib) with these references is available.

# At the end of the project

You should make all information needed for others to recreate your
MESA results publicly available.  This includes your inlists and
run\_star\_extras/run\_binary\_extras, the MESA version and the MESA
SDK version (or compiler version for non-SDK builds), as well as any
modifications to MESA that you may have made.


We recommend using [Zenodo](http://about.zenodo.org/) for this
purpose.  Zenodo assigns digital object identifiers (DOIs) for each
entry, providing an immutable way to reference an upload in a
publication. The service is also backed by the CERN data
infrastructure, ensuring the safety of data and its long-term
availability.  As Zenodo allows uploads of up to 50GB, this gives the
possibility to not only share the input files, but also your
simulation data products.  Beware that once an entry is published in
Zenodo it cannot be removed, but new versions can be included if
amendments are needed. While setting up an upload in Zenodo, or
testing the service, you can make use of the
["sandbox"](https://sandbox.zenodo.org/) first. The "sandbox" allows
you to see how a final entry would look before submitting the real
thing to the main service.

We have a created a [Zenodo
community](https://zenodo.org/communities/mesa/) with which you can
associate your Zenodo uploads. The [MESA Marketplace](mesastar.org)
will remain in use as an aggregator portal, and we request users to
inform us of new uploads so that they are highlighted there as well.
