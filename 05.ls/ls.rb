#!/usr/bin/env ruby
# frozen_string_literal: true

COLUMN = 3

def receive_data_and_create_array
  array = []
  Dir.foreach('.') do |item|
    next if ['.', '..'].include?(item)

    array << item
  end

  array_size = array.size
  column = COLUMN
  row = (array_size.to_f / column).ceil
  two_dimensions_array = Array.new(row).map { Array.new(column, '') }

  # 縦と横を入れ替えて２次元配列に代入します
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
  two_dimensions_array # returnの値
end

def print_array
  two_dimensions_array = receive_data_and_create_array

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
