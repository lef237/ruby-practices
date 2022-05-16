#!/usr/bin/env ruby
# frozen_string_literal: true

def receive_files_in_current_directory
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

def calc_column_width(files, index)
  files.map { _1[index] }.max_by(&:length).length + 2
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
ROW = (receive_files_in_current_directory.size.to_f / COLUMN).ceil

formatted_files = format_files(receive_files_in_current_directory)
print_files(formatted_files)
