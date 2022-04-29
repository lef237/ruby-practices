#!/usr/bin/env ruby

require "date"
require 'optparse'

params = ARGV.getopts('m:y:')

month = params['m'].to_i
year = params['y'].to_i

if month == 0
  month = Date.today.mon.to_i
end
if year == 0
  year = Date.today.year.to_i
end

start_date = Date.new(year, month, 1)
end_date = Date.new(year, month, -1)

puts "       #{month}月 #{year}"
puts " 日 月 火 水 木 金 土"

print "   " * start_date.wday.to_i

(start_date..end_date).each do |d|
  if d.saturday?
    print d.mday.to_s.rjust(3)
    print "\n"
  else
    print d.mday.to_s.rjust(3)
  end
end
