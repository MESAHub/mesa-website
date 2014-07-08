# -*- coding: utf-8 -*-

require_relative 'defaultsParser.rb'
require_relative 'markdownTransformer.rb'

DEFAULTS_PATH="./_includes/"
DEFAULTS_FILES=["FORMAT", "star_job.defaults", "controls.defaults", "pgstar.defaults"]

OUTPUT_PATH="./_includes/"

def convert_file(filename)
  contents = File.open(filename).read
  tree = DefaultsParser.new.parse(contents)
  MarkdownTransformer.new.apply(tree)
end

def write_file(filename, contents)
  f = File.open(filename, "w")
  f.write(contents)
  f.close
end

def generate_filename(filename)
  filename.chomp(".defaults") + ".markdown"
end


DEFAULTS_FILES.each{ |defaults_filename|

  puts "Converting %s ..." % [defaults_filename]

  markdown = convert_file(File.join(DEFAULTS_PATH, defaults_filename))
  markdown_filename = generate_filename(defaults_filename)

  write_file(File.join(OUTPUT_PATH, markdown_filename), markdown)
}
  
