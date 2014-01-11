---
layout: default
title: FAQ
permalink: faq.html
---
### How do you say MESA?

Say "MAY-sa".

### Can I use the MESA logo in an presentation?

Yes.  It is available in a variety of sizes for your convenience.

* [30 pt](/assets/logo/mesa_logo2_30pt.png)
* [60 pt](/assets/logo/mesa_logo2_60pt.png)
* [100 pt](/assets/logo/mesa_logo2_100pt.png)
* [144 pt](/assets/logo/mesa_logo2_144pt.png)
* [200 pt](/assets/logo/mesa_logo2_200pt.png)
* [400 pt](/assets/logo/mesa_logo2_400pt.png)

### What does "thread-safe" mean?

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

### What happens when an instrument paper is being written?

The picture shows the intense authors hard at work making final edits.

![writing the mesa paper](/assets/images/paper_session.jpg "Paper Session")

A late night session working on the paper around Bill's dining room
table with a projector, a makeshift screen, and ample red wine (left
to right, Frank Timmes, Aaron Dotter, Falk Herwig, Lars Bildsten, and
Bill Paxton).  Photo taken by Bill's patient wife, Kathlyn, who
deserves a great deal of credit for the existence of MESA.

### Why wasn't MESA written on punch cards?

MESA is written using advanced features of modern Fortran which make
it very different from Fortran 77 codes you might have previously seen
(or written!).  If you are not already familiar with the new and
wonderful things that have been added, there are good resources
available on the web -- here's one:
[Fortran 95 language features][Fortran].

[Fortran]:http://en.wikipedia.org/wiki/Fortran_95_language_features

### How can I use an individual MESA module?

The easiest way to get the idea is to look at a sample, and in the
MESA directory you will find a subdirectory called “sample”. Make a
copy of the sample directory anywhere you’d like and give it whatever
name you want. Follow the instructions in the README file to make and
test the sample.

### Which SVN revisions were MESA release versions?

{% include releases.html %}

