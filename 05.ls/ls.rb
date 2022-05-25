#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def receive_options
  option_parser = OptionParser.new
  options = {}
  option_parser.on('-r') { |v| options[:reverse] = v }
  option_parser.parse!(ARGV)
  options
end

def receive_files_in_current_directory(options)
  files = Dir.glob('*')
  files = files.reverse if options[:reverse_files]
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

options = receive_options
files = receive_files_in_current_directory(reverse_files: options[:reverse])
COLUMN = 3
ROW = (files.size.to_f / COLUMN).ceil
formatted_files = format_files(files)
print_files(formatted_files)
