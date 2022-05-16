#!/usr/bin/env ruby
# frozen_string_literal: true

def get_files_in_current_directory
  files = []
  Dir.foreach('.') do |item|
    next if ['.', '..'].include?(item)

    files << item
  end
  files
end

def format_files(files)
  files << '' until (files.size % COLUMN).zero?
  files.each_slice(ROW).to_a.transpose
end

# 列ごとに幅を調節するためのメソッドです
def calc_column_width(files, i)
  files.map {_1[i]}.max_by(&:length).length + 2
  # files.map{|x| x[i]}でもＯＫ
end

def print_files(files)
  files.each do |array|
    array.each_with_index do |item, i|
      print item.ljust(calc_column_width(files, i))
    end
    print "\n"
  end
end


COLUMN = 3
ROW = (get_files_in_current_directory.size.to_f / COLUMN).ceil


formatted_files = format_files(get_files_in_current_directory)
p formatted_files.map{_1[1]} # formatted_files.map{|x| x[1]}と同じ意味
p formatted_files.map{_2}
p [[1, 2], [3, 4]].map { _1}
print_files(formatted_files)
