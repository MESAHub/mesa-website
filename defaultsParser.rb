# -*- coding: utf-8 -*-
require 'parslet'

class Controls < Parslet::Parser

  # the format being parsed is described in 
  # $MESA_DIR/star/defaults/FORMAT

  # simple rules that we'll reuse throught

  rule(:equals)     { space? >> str('=') >> space? }

  rule(:bang)       { str('!') }
  rule(:hash)       { str('#') }
  rule(:quote)      { str('"') | str("'") }

  rule(:space1)     { match("[ \t]") }
  rule(:space)      { space1.repeat(1) }
  rule(:space?)     { space.maybe }

  rule(:newline)    { str("\n") }
  rule(:empty)      { space? >> newline }
  rule(:empty?)     { empty.maybe }


  # rules for parsing a default
  # these look like option = value
  # option is 
  # a value is a string, number, or boolean

  rule(:option)     { match('[A-Za-z0-9_(:)]').repeat(1).as(:option) }

  rule(:digit)      { match('[0-9]') }

  rule(:number) {
    (str('-').maybe >>
      (str('0') | (match('[1-9]') >> digit.repeat)) >>
      (str('.') >> digit.repeat(1)).maybe >>
      (match('[eEdD]') >> (str('+') | str('-')).maybe >> digit.repeat(1)).maybe
     ).as(:number)
  }

  rule(:string) {
    quote >> (str('\\') >> any | quote.absent? >> any).repeat.as(:string) >> quote
  }


  rule(:value) {
    string | number |
    str('.true.').as(:true) | str('.false.').as(:false)
  }

  rule(:default) { space? >> option >> equals >> value.as(:value) >> empty }


  # a divider looks like !---- (or more)
  rule(:divider) { bang >> match('-').repeat(4) }

  # an anchor looks like !# some text
  rule(:anchor) { space? >> bang >> hash.repeat(1,3).as(:level) >> space1 >> text.as(:anchor) }

  # a regular comment looks like ! some text
  rule(:text) { match('[^\r\n]').repeat(1) }
  rule(:comment) { space? >> bang >> space1 >> text.as(:text) >> empty }


  # the whole file comes in blocks

  # a block can be:
  #   a single anchor
  #   multiple consecutive comment lines
  #   a single defaults line 

  rule(:block) { empty.repeat >> ( anchor |
                                   comment.repeat(1).as(:comment) |
                                   default.repeat(1).as(:default) ) >> empty.repeat }

  # a section is composed of multiple blocks
  rule(:section) { divider >> block.repeat(1).as(:section) >> empty? }

  # there is a special section at the start called the prelude which
  # is all comments or empty lines
  rule(:preludeline) { comment | empty }
  rule(:prelude) { preludeline.repeat(1) }

  rule(:controls) { prelude.as(:prelude) >> section.repeat(1).as(:sections) }
  root :controls

end

def make_anchor(s)
  String(s).gsub(' ', '_').gsub(/[^[:alnum:]_]/, '')
end

def escape_string(s)
  String(s).gsub('_','\_')
end

class MarkdownControls < Parslet::Transform

  # this is still a work in progress...

  # for now, leave the values alone
  rule(:number => simple(:x)) { x }
  rule(:string => simple(:x)) { "'%s'" % [x] }
  rule(:string => sequence(:x)) { "''" }
  rule(:true => simple(:x)) { x }
  rule(:false => simple(:x)) { x }

  # text gets html-escapled
  rule(:text => simple(:x)) { escape_string(x) }

  # make the anchor
  rule(:level => simple(:l), :anchor => simple(:a)) {
    id = make_anchor(a)
    level = String(l).length
    "<h%i id=\"%s\">%s <a href=\"#%s\" title=\"Permalink to this headline\">¶</a></h%i>\n" % [level, id, a, id, level]
  }

  # option goes back to looking like it did in the fortran file
  rule(:option => simple(:o),:value => simple(:v)) { '%s = %s' % [o,v] }
  rule(:default => sequence(:x)) { ["{% highlight fortran %}", x.join("\n"), "{% endhighlight %}", ""].join("\n") }


  rule(:comment => sequence(:x)) { x.join("\n") }

  rule(:summary => sequence(:x)) { "<div class=\"comment\">\n%s\n</div>\n" % x.join("\n") }

  rule(:section => sequence(:x)) { x.join("\n\n") }
  rule(:section => simple(:x)) { x }

  rule(:prelude => sequence(:p), :sections => sequence(:s)) { 
    s.join("\n")
  }

  rule(:controls => simple(:x)) { x }

end


def parse(str)
  c = Controls.new
  return c.parse(str)
rescue Parslet::ParseFailed => failure
  puts failure.cause.ascii_tree
end

file = File.open("/home/jschwab/Software/mesa-git-svn/star/defaults/star_job.defaults")

contents = file.read

tree = parse(contents)
md = MarkdownControls.new.apply(tree)

g = File.open("./_includes/star_job.md", "w")
g.write(md)
g.close


