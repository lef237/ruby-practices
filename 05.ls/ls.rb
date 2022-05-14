#!/usr/bin/env ruby
# frozen_string_literal: true

COLUMN = 3

def receive_lists_and_create_array
  array = []
  Dir.foreach('.') do |item|
    next if ['.', '..'].include?(item)

    array << item
  end

  column = COLUMN
  row = (array.size.to_f / column).ceil
  array << "" until array.size % column == 0
  array = array.each_slice(row).to_a.transpose
  array
end

def print_array
  two_dimensions_array = receive_lists_and_create_array

  # defでメソッド定義をするとnest状態となりrubocopに引っ掛かるため、lambdaを使いました
  adjust_width_for_longest_directory = lambda { |array|
    array.max_by(&:length).length + 2
  }

  one_dimension_array = two_dimensions_array.flatten
  for_ljust = adjust_width_for_longest_directory.call(one_dimension_array)

  print_count = 0
  one_dimension_array.each do |y|
    print y.ljust(for_ljust)
    print_count += 1
    print "\n" if (print_count % 3).zero?
  end
end

print_array
