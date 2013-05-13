require 'term/ansicolor'

# Use Term::ANSIColor as Mixin into String or its subclasses
#
# Usage:
#   print "clear".clear, "reset".reset, "bold".bold, "dark".dark,
#     "underscore".underscore, "blink".blink, "negative".negative,
#     "concealed".concealed, "|\n",
#     "black".black, "red".red, "green".green, "yellow".yellow,
#     "blue".blue, "magenta".magenta, "cyan".cyan, "white".white, "|\n",
#     "on_black".on_black, "on_red".on_red, "on_green".on_green,
#     "on_yellow".on_yellow, "on_blue".on_blue, "on_magenta".on_magenta,
#     "on_cyan".on_cyan, "on_white".on_white, "|\n\n"
#
# Output strings with different colors or underlines and so on.
class String
  include Term::ANSIColor
end