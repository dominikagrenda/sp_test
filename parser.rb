require_relative 'lib/log_parser'

parser = LogParser.new(ARGV[0])
parser.parse

puts "Most Views"
parser.frequency

puts "Unique Views"
parser.frequency_unique