#!/usr/bin/env ruby
# frozen_string_literal: true

array = []
Dir.foreach('.') do |item|
  next if ['.', '..'].include?(item)

  array << item
end

def round_up(big, small)
  (big.to_f / small).ceil
end

row_count = 0
col_count = 0
files_and_dirs = array.size
col = 3
row = round_up(files_and_dirs, col)

new_array = Array.new(row).map { Array.new(col, '') }

array.each do |x|
  new_array[row_count][col_count] = x
  row_count += 1
  if row == row_count
    row_count = 0
    col_count += 1
  end
end

def for_ljust(array)
  array.max_by(&:length).length + 2
end

one_d_array = new_array.flatten

for_ljust = for_ljust(one_d_array)

print_count = 0
one_d_array.each do |y|
  print y.ljust(for_ljust)
  print_count += 1
  print "\n" if (print_count % 3).zero?
end
