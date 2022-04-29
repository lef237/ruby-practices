#!/usr/bin/env ruby

require "date"
require 'optparse'

params = ARGV.getopts('m:y:')

month = params['m']&.to_i || Date.today.mon
year = params['y']&.to_i || Date.today.year

start_date = Date.new(year, month, 1)
end_date = Date.new(year, month, -1)

puts "       #{month}月 #{year}"
puts " 日 月 火 水 木 金 土"

print "   " * start_date.wday

(start_date..end_date).each do |d|
  print d.mday.to_s.rjust(3)
  print "\n" if d.saturday?
end
