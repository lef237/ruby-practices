#!/usr/bin/env ruby
# frozen_string_literal: true

COLUMN = 3

def receive_data
  list = []
  Dir.foreach('.') do |item|
    next if ['.', '..'].include?(item)

    list << item
  end
  list
end

def formatted_list(list)
  column = COLUMN
  row = (list.size.to_f / column).ceil
  list << "" until list.size % column == 0
  list = list.each_slice(row).to_a.transpose.flatten
  list
end

def print_list(list)
  for_ljust = list.max_by(&:length).length + 2

  list.each_with_index do |item, i|
    print item.ljust(for_ljust)
    i += 1
    print "\n" if (i % COLUMN).zero?
  end
end

list = receive_data
list = formatted_list(list)
print_list(list)
