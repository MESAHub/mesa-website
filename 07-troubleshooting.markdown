---
layout: default
title: troubleshooting
permalink: troubleshooting.html
---
# What do you do if you have problems?

This page has information about troubleshooting MESA.

## Check that your environment variables are set correctly

One of the most common issues is unset or incorrectly set environment
variables.  In the same terminal window where you are trying to run MESA,
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

Send an email message to mesa-users@lists.mesastar.org describing the
problem.  If you want a good answer, it helps ask a good question.

Provide some information about the computer you are using, including:

+ your operating system (including version information)
+ which version of MESA you are using
+ which version of the MESA SDK you are using

Then, describe the problem.  Include sufficient materials
(inlist files, saved models, etc.) so that someone else can (attempt
to) reproduce your problem.

Perhaps someone else can give you some useful information -- or at
least some sympathy.

## Some general advice from Bill

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

Use your favorite visualization tools to get an idea of what's
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

-- Bill Paxton
