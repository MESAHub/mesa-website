# -*- coding: utf-8 -*-
require 'parslet'

def make_anchor(s)
  String(s).gsub(' ', '_').gsub(/[^[:alnum:]_]/, '')
end

def escape_string(s)
  ss = String(s)
  # prevent material that appears in literal blocks from being escaped
  if ss.start_with?('    ') then
    ss
  else
    ss.gsub('_','\_').gsub('*','\*')
  end
end

class MarkdownTransformer < Parslet::Transform

  # for now, leave the values alone
  rule(:number => simple(:x)) { x }
  rule(:string => simple(:x)) { "'%s'" % [x] }
  rule(:string => sequence(:x)) { "''" }
  rule(:true => simple(:x)) { x }
  rule(:false => simple(:x)) { x }

  # text gets escaped
  rule(:text => simple(:x)) { escape_string(x) }

  # make the anchor
  rule(:level => simple(:l), :anchor => simple(:a)) {
    id = make_anchor(a)
    level = String(l).length
    "<h%i id=\"%s\">%s <a href=\"#%s\" title=\"Permalink to this location\">¶</a></h%i>\n" % [level, id, a, id, level]
  }

  # option goes back to looking like it did in the fortran file
  rule(:option => simple(:o),:value => simple(:v)) { '%s = %s' % [o,v] }
  rule(:default => sequence(:x)) { ["{% highlight fortran %}", x.join("\n"), "{% endhighlight %}", ""].join("\n") }

  # default values will be syntax highlighted
  rule(:default => sequence(:x)) { ["{% highlight fortran %}", x.join("\n"), "{% endhighlight %}", ""].join("\n") }

  # join comments together on adjacent lines
  rule(:comment => sequence(:x)) { x.join("\n") }

  # put a blank line between sections
  rule(:section => sequence(:x)) { x.join("\n\n") }

  # we completely drop the prelude, as we expect the information that
  # makes sense at the top of the defaults file to be sufficiently
  # different than the information that is at the top of the webpage
  rule(:prelude => sequence(:p), :sections => sequence(:s)) { s.join("\n") }

  # once we make to to the root, just return everything
  rule(:controls => simple(:x)) { x }

end
