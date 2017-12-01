<h1 id="Separators">Separators <a href="#Separators" title="Permalink to this location">¶</a></h1>


A defaults file is divided into sections.  These sections are
delimited by the section separator, which is a line beginning
with a '!' (bang) and followed by at least 4'-' (dash).

<h2 id="Prelude">Prelude <a href="#Prelude" title="Permalink to this location">¶</a></h2>


The file must not begin with a section separator, and all
content before the first section separator is treated as a
special section referred to as the Prelude.

<h2 id="Section">Section <a href="#Section" title="Permalink to this location">¶</a></h2>


Each section must begin with a top-level anchor (see
below).  From the standpoint of the parser, the section
separators are redundant, but they improve the
human-readability of the file.
<h1 id="Anchors">Anchors <a href="#Anchors" title="Permalink to this location">¶</a></h1>


Anchors are special comments which begin with a '!' (bang) and
are followed by one, two, or three '#' (hash).

Anchors delineate the structure of the document.  All material
appearing below an anchor is assumed to be at the level of
that anchor until the next anchor with an equal or lesser
level is encountered.

When exported to HTML, anchors become headings, with a level
equal to the number of hashes and an id derived from its name.

<h2 id="Level_1_Section__2_Subsection">Level 1 (Section) & 2 (Sub-section) <a href="#Level_1_Section__2_Subsection" title="Permalink to this location">¶</a></h2>


Anchors with one or two hashes are for organization and
navigation purposes.  They will be included in the table of
contents.

<h2 id="Level_3_Option">Level 3 (Option) <a href="#Level_3_Option" title="Permalink to this location">¶</a></h2>


Anchors with three hashes are reserved exclusively to
indicate an option and its accompanying documentation.
<h1 id="Comments">Comments <a href="#Comments" title="Permalink to this location">¶</a></h1>


Comment lines begin with a bang, followed by a single space,
and then have at least one non-whitespace character.  Empty
comments are treated like blank lines.

Comments should be formatted using
[Markdown](http://daringfireball.net/projects/markdown/syntax).
Plain text is valid Markdown, and most comments will probably
not make use of Markdown features.

<h2 id="Regular_Comments">Regular Comments <a href="#Regular_Comments" title="Permalink to this location">¶</a></h2>


Most comments will be paragraphs of text.

In Markdown, a paragraph is "one or more consecutive lines of
text, separated by one or more blank lines."  Each block of
comments is treated as a paragraph, and so the lengths of the
lines will not be preserved.  (This feature allow us to nicely
display much of the content in a non-fixed width font!)  For
example, the following two blocks will look similar when
rendered for the web.

This block has no line breaks.

This block
has several
line
breaks

<h2 id="Formatted_Comments">Formatted Comments <a href="#Formatted_Comments" title="Permalink to this location">¶</a></h2>


More complicated comments benefit greatly form additional
formatting.

You can trigger emphasis using *one* or __two__
_underscores_ or **asterisks**.  The use of `backquotes`
lets you put fixed-width font material inline.

It is frequently helpful to make a lists

+ foo
+ bar
+ baz

If you're writing code in your comments, then you probably
do want things to appear in a fixed-width font. Comments
which begin with with 4 spaces are treated as code.
(Remember, a comment begins a bang & space, so there will
be 5 spaces total.)

    foo =   1
    bar =  10
    baz = 100

The content of comment blocks gets passed down, so you can
even trigger syntax highlighting!

{% highlight fortran %}   
subroutine foo(bar)
  implicit none
  integer, intent(in) :: bar
  bar = bar + 1  
end subroutine foo
{% endhighlight %}

If you know where you want the line breaks to be, but don't
want to render things as code (in a fixed-width font), you
can force a line break by appending two trailing spaces to
a line.

this is line one  
this is another line
<h1 id="Options__Defaults">Options & Defaults <a href="#Options__Defaults" title="Permalink to this location">¶</a></h1>


<h2 id="Single_Options">Single Options <a href="#Single_Options" title="Permalink to this location">¶</a></h2>


Most MESA options stand alone and have their own
documentation.

<h3 id="number_option">number_option <a href="#number_option" title="Permalink to this location">¶</a></h3>


number options are great.  MESA is good at taking numbers
and making more numbers for you.  Often you'll want to set
`number_option > 0`, but sometimes you want to set
`number_option <= 0`.

{% highlight fortran %}
number_option = 1
{% endhighlight %}


<h3 id="string_option">string_option <a href="#string_option" title="Permalink to this location">¶</a></h3>


string options are great.  you can tell MESA what you want
it to do.

{% highlight fortran %}
string_option = 'make me a sandwich'
{% endhighlight %}


<h3 id="boolean_option">boolean_option <a href="#boolean_option" title="Permalink to this location">¶</a></h3>


boolean options are great.  they can take one of two values:

+ .true.
+ .false.

{% highlight fortran %}
boolean_option = .true.
{% endhighlight %}


<h2 id="Multiple_Options">Multiple Options <a href="#Multiple_Options" title="Permalink to this location">¶</a></h2>


<h3 id="xa_average_lower_limit_species">xa_average_lower_limit_species <a href="#xa_average_lower_limit_species" title="Permalink to this location">¶</a></h3>


<h3 id="xa_average_lower_limit">xa_average_lower_limit <a href="#xa_average_lower_limit" title="Permalink to this location">¶</a></h3>


Sometimes there are options that need to grouped together,
because they share documentation. If options are to be
grouped, both their anchors and their default values should
be adjacent.

{% highlight fortran %}
xa_average_lower_limit_species(1) = ''
xa_average_lower_limit(1) = 0
{% endhighlight %}

<h1 id="Whitespace_Style">Whitespace Style <a href="#Whitespace_Style" title="Permalink to this location">¶</a></h1>


An indent is 3 spaces.  No tabs are used.  Almost all
whitespace at the beginning of lines is strictly cosmetic and
is not used by the parser in determining the structure of the
file.  Whitespace at the end of lines should be avoided,
except when used to indicate the presence of line breaks.