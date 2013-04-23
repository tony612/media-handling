require 'rubygems'
require 'mini_magick'
require 'optparse'

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = "Usage: crop.rb -x 100 -y 200 -h 300 -w 400 -d \"/path/to/*.png\"
Notice: And Please backup the pictures"

  opts.separator ""
  opts.separator "Paramter Options:"


  opts.on("-x", "--x [X]", OptionParser::DecimalNumeric, "X coordinate of origin") do |x|
    options[:x] = x
  end

  opts.on("-y", "--y [Y]", OptionParser::DecimalNumeric, "Y coordinate of origin") do |y|
    options[:y] = y
  end

  opts.on("-h", "--height HEIGHT", OptionParser::DecimalNumeric, "Height of picture") do |h|
    options[:height] = h
  end

  opts.on("-w", "--width WIDTH", OptionParser::DecimalNumeric, "Width of picture") do |w|
    options[:width] = w
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
  if !options[:height] || !options[:width] || !options[:input]
    puts option_parser
    exit
  end
end

x = options[:x] || 0
y = options[:y] || 0
height = options[:height]
width = options[:width]
input = options[:input]

files = Dir[input]

if files.empty?
  puts "No files"
  exit
end

Dir[input].each do |file_url|
  puts "Croping #{file_url}"
  img = MiniMagick::Image.open(file_url)
  img.crop("%dx%d+%d+%d" % [width, height, x, y])
  img.write(file_url)
end
