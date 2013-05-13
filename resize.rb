require 'rubygems'
require 'mini_magick'
require 'optparse'
require './lib/string_decorator'

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = "Usage:
resize.rb [-h 300] [-w 400] -d \"/path/to/**/*.*\"
or resize.rb -p 30% -d \"/path/to/**/*.png\"
Notice: And Please backup the pictures"

  opts.separator ""
  opts.separator "Paramter Options:"

  opts.on("-h", "--height HEIGHT", OptionParser::DecimalNumeric, "Height of picture") do |h|
    options[:height] = h
  end

  opts.on("-w", "--width WIDTH", OptionParser::DecimalNumeric, "Width of picture") do |w|
    options[:width] = w
  end

  opts.on("-p", "--times TIMES", "The percent to resize") do |p|
    options[:percent] = p
  end

  opts.on("-d", "--dir DIRECTORY", "Input directory") do |d|
    options[:input] = d
  end

  opts.separator ""
  opts.separator "Common options:"

  opts.on_tail("--help", "Show the help") do
    puts opts
    exit
  end
end

# print help when options are empty
if ARGV.empty?
  puts option_parser
  exit
else
  option_parser.parse!
  if (!options[:height] && !options[:width] && !options[:percent]) || !options[:input]
    puts option_parser
    exit
  end
end

height = options[:height]
width = options[:width]
percent = options[:percent]
input = options[:input].strip

files = Dir[input]

if files.empty?
  puts "No files".red
  exit
end

Dir[input].each do |file_url|
  puts "Resizing #{file_url.green}"
  img = MiniMagick::Image.open(file_url)
  if height && width
    img.resize("#{width}x#{height}!")
  elsif width
    img.resize(width)
  elsif height
    img.resize("x#{height}")
  elsif percent
    img.resize(percent)
  end
  img.write(file_url)
end
