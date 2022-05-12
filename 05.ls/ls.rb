#!/usr/bin/env ruby
# frozen_string_literal: true

COLUMN = 3

array = []
Dir.foreach('.') do |item|
  next if ['.', '..'].include?(item)

  array << item
end

array_size = array.size
column = COLUMN
row = (array_size.to_f / column).ceil
two_dimensions_array = Array.new(row).map { Array.new(column, '') }

row_count = 0
column_count = 0
array.each do |x|
  two_dimensions_array[row_count][column_count] = x
  row_count += 1
  if row == row_count
    row_count = 0
    column_count += 1
  end
end

def length_for_longest_directory(array)
  array.max_by(&:length).length + 2
end

one_dimension_array = two_dimensions_array.flatten
for_ljust = length_for_longest_directory(one_dimension_array)

print_count = 0
one_dimension_array.each do |y|
  print y.ljust(for_ljust)
  print_count += 1
  print "\n" if (print_count % 3).zero?
end
