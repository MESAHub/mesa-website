---
layout: default
title: MESA output
permalink: output.html
---
# What information does MESA output?

This page has information about how to use MESA to evolve a single
star.  It assumes you have already installed MESA. It tries to give
you a tour of the basic MESA features and introduce you to some "best
practices" along the way.  It is by no means a complete guide to MESA.

## Analyzing MESA Output

By default, MESA stores its data in the ./LOGS directory.  The data
files are text-based and can fed into your favorite plotting program.
You should visit the [Tools & Utilities][Tools] section of the MESA
forum and see if someone has contributed code in your language of
choice.  (There are reasonably mature routines for python, IDL, ruby
and Mathematica.)

[Tools]:http://mesastar.org/tools-utilities

In the LOGS directory, you'll find the following files.

### history.data

The history for the run is saved, one line per logged model, in the
file "history.data". The first line of history.data has column
numbers, the second line has column names, and the following lines
have the corresponding values.  In case of a backup or a restart,
lines are not removed from the history.data; instead new values are
simply appended to the end of the file.  As a result the
model\_numbers are not guaranteed to be monotonically increasing in
the log.  The code that uses the history must bear the burden of
removing lines that have been made obsolete by subsequent restarts or
backups.  This can most easily be done by storing the data into arrays
as it is read using the model_number as the array index.  That way
you'll automatically discard obsolete values by overwriting them with
the newer ones that appear later in the history file.

### profiles.index

MESA doesn't store profiles for every step (that'd take up too much
space).  This list tells you how to translate between the numbers in
the profile filenames and the MESA model numbers.  By default, MESA
will store a profile at the end of the run.

For each profile, there is a line in profiles.index giving the model
number, its priority, and its profile number.  Priority level 2 is for
models saved because of some special event in the evolution such as
the onset of helium burning.  Priority level 1 is for models saved
because the number of models since the most recent profile has reached
the currently setting of the profile_interval parameter.

### profile<n>.data

The profiles contain detailed information about a selected set of
models, one model per file. The name of the profile data file is
determined by the profile number.  For example, if the profile number
is 15, the profile data will be found in the file named
'profile15.data'.

Each profile includes both a set of global properties of the star,
such as its age, and a large set of properties for each point in the
model of the star given one line per point.  In each case, the lines
of data are preceeded by a line with column numbers
and a line with column names.

## Controlling MESA Output

The default MESA output is set by the files

    $MESA_DIR/star/defaults/history_columns.list
    $MESA_DIR/star/defaults/profile_columns.list

In order to customize the output, copy these files to your work
directory

    cp $MESA_DIR/star/defaults/history_columns.list .
    cp $MESA_DIR/star/defaults/profile_columns.list .

Then, open up history\_columns.list or profile\_columns.list in a text
editor.  The file describes the full list of the available options.
To add/remove the columns of interest, comment/uncomment any lines
('!' is the comment character).

But what if you want a history or profile quantity that isn't on the
list?  For that, you'll want to
[use run\_star\_extras.f](run_star_extras.html).
