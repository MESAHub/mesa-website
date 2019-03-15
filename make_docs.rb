# -*- coding: utf-8 -*-

require_relative 'defaultsParser.rb'
require_relative 'markdownTransformer.rb'

# get the absolute path of this file
FILE_PATH=File.expand_path(File.dirname(__FILE__))

DEFAULTS_VERSIONS=['r7624', 'r8118', 'r8845', 'r9575', 'r9793', 'r10000', 'r10108', 'r10398', 'r11532', 'r11554']
DEFAULTS_VERSIONS=['r11554']
DEFAULTS_FILES=["star_job.defaults", "controls.defaults", "pgstar.defaults", "binary_controls.defaults"]

def convert_file(filename)
  contents = File.open(filename).read
  begin
    tree = DefaultsParser.new.parse(contents)
  rescue Parslet::ParseFailed => error
    puts error.parse_failure_cause.ascii_tree
  end
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

# convert FORMAT file
puts "Converting FORMAT ..." % []

markdown = convert_file(File.join(FILE_PATH, "_includes/FORMAT"))
markdown_filename = generate_filename("FORMAT")
write_file(File.join(FILE_PATH, "_includes/", markdown_filename), markdown)

# convert docs
DEFAULTS_VERSIONS.each do |defaults_version|

  defaults_path = File.join(FILE_PATH, "docs/", defaults_version)

  DEFAULTS_FILES.each do |defaults_filename|

    puts "Converting %s (%s) ..." % [defaults_filename, defaults_version]

    markdown = convert_file(File.join(defaults_path, defaults_filename))
    markdown_filename = generate_filename(defaults_filename)

    write_file(File.join(defaults_path, markdown_filename), markdown)
    
  end
end
