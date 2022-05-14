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
  list << "" until list.size % COLUMN == 0
  list = list.each_slice(ROW).to_a.transpose 
  list
end

# ファイル名の幅を調節するためのメソッドです
def for_ljust
  list = receive_data.each_slice(ROW).to_a
  for_ljust = []
  list.each do |array|
    for_ljust << array.max_by(&:length).length + 2
  end
  for_ljust
end

# # 列ごとに幅を調節して出力しています
# def print_list(list)
#   list.each do |array|
#     array.each_with_index do |item, i|
#       print item.ljust(for_ljust[i])
#     end
#     print "\n"
#   end
# end

# 列ごとに幅を調節して出力しています（別解）
def print_list(list)
  list.flatten.each_with_index do |item, i|
    j = i % COLUMN
    print item.ljust(for_ljust[j])
    i += 1
    print "\n" if (i % COLUMN).zero?
  end
end

list = receive_data
list = formatted_list(list)
print_list(list)
