#!/usr/bin/env ruby
# frozen_string_literal: true

def receive_data
  list = []
  Dir.foreach('.') do |item|
    next if ['.', '..'].include?(item)

    list << item
  end
  list
end

COLUMN = 3
ROW = (receive_data.size.to_f / COLUMN).ceil

def formatted_list(list)
  list << '' until (list.size % COLUMN).zero?
  list.each_slice(ROW).to_a.transpose
end

# 列ごとに幅を調節するためのメソッドです
def for_ljust
  list = receive_data.each_slice(ROW).to_a
  for_ljust = []
  list.each do |array|
    for_ljust << array.max_by(&:length).length + 2
  end
  for_ljust
end

def print_list(list)
  list.each do |array|
    array.each_with_index do |item, i|
      print item.ljust(for_ljust[i])
    end
    print "\n"
  end
end

list = formatted_list(receive_data)
print_list(list)
