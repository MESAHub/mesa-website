---
layout: default
title: troubleshooting
permalink: troubleshooting.html
---
# What do you do if you have problems?

This page has information about troubleshooting MESA.

## Consult the FAQ

Your first stop, especially if you're having a problem with
installation, should be to consult the [MESA Forum FAQ][faq].

[faq]:http://mesastar.org/documentation/frequently-asked-questions

## Search the mesa-users mailing list archive

Check the [mailing list archives][mla] to see if someone has had a similar
problem in the past.

[mla]:http://sourceforge.net/p/mesa/mailman/mesa-users/

## Post a question to mesa-users

Post a message to mesa-users describing the problem.  If you want a
good answer, it helps ask a good question.

Provide some information about the computer you are using, including:

+ your operating sytem (including version information)
+ which version of MESA you are using
+ which version of the MESA SDK you are using

Then, describe the problem.  Include sufficient materials
(inlist files, saved models, etc.) so that someone else can (attempt
to) reproduce your problem.

Perhaps someone else can give you some useful information -- or at
least some sympathy.

## General Advice

It is an unfortunate truth that you often have to tune the inlist
control parameters to fit the particular task you are attempting.  How
much time and effort that will require can vary from none when you are
using a proven recipe from "off the shelf", to painfully long if you
are being a pioneer and trying something that hasn't been done before.

Here are a few hints based on my experience.

Sometimes a failure to converge is simply caused by "grid starvation".
Try giving the code more points to work with by decreasing the value
of "mesh\_delta\_coeff" and restarting from a step before the
convergence problems started.

Use your favorite the visualization tools to get an idea of what's
going on -- make lots of plots! I strongly recommend using PGstar or
something like it to make on-screen plots as the run progresses.

If you can't find a recipe that works for your problem, try a
different problem.

Okay -- enough doom and gloom.  Sometimes things work great, and you'd
like to see if you can make them even better by improving the speed.
You will of course need to check that the important results aren't
impacted.

Finally, remember what Peter Eggleton told me when I was first getting
started and asked him why something I was trying failed to converge.
Peter patiently explained that with stellar evolution the only
surprise is when the code does converge!  And of course he's right.
Each step requires a root find for a highly non-linear relation
involving anywhere from a few thousand to several 100's of thousands
of variables.  It makes me tired just to think about it.

And remember that it takes time to learn how to use the code -- you'll
get better at it with experience.

