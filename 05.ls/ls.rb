#!/usr/bin/env ruby

array = []
Dir.foreach('.') do |item|
  next if item == '.' or item == '..'
  array << item
end

row_count = 0
col_count = 0
files_and_dirs = array.size
col = 3
row = (files_and_dirs.to_f / col).ceil

new_array = Array.new(row).map{Array.new(col, "")}

array.each do |x|
  new_array[row_count][col_count] = x
  row_count += 1
  if row == row_count
    row_count = 0
    col_count += 1
  end
end

one_d_array = new_array.flatten

for_ljust = one_d_array.max_by { |x| x.length }.length + 2

print_count = 0
one_d_array.each do |y|
  print y.ljust(for_ljust)
  print_count += 1
  if print_count % 3 == 0
    print "\n"
  end
end
