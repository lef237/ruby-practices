#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

def main
  options = receive_options
  files = receive_files_in_current_directory(options[:all], options[:reverse])
  
  if options[:list]
    print_details(files)
  else
    print_files(files)
  end
end

def receive_options
  option_parser = OptionParser.new
  options = {}
  option_parser.on('-a') { |v| options[:all] = v }
  option_parser.on('-r') { |v| options[:reverse] = v }
  option_parser.on('-l') { |v| options[:list] = v }
  option_parser.parse!(ARGV)
  options
end

test_argument = false #テストコードではここの引数をtrueにしておく
condition = test_argument
file_path = condition ? 'test/sample_files' : '.'
TARGET_PATHNAME = file_path

def receive_files_in_current_directory(options_all, options_reverse)
  if options_all
    # files = Dir.glob('*', File::FNM_DOTMATCH, base: TARGET_PATHNAME)では「..」が出力されない

    # files = []
    # Dir.foreach(TARGET_PATHNAME) do |item|
    #   files << item
    # end

    files = Dir.foreach(TARGET_PATHNAME).to_a
  else
    files = Dir.glob('*', base: TARGET_PATHNAME)
  end
  files = files.reverse if options_reverse
  files
end

COLUMN = 3

def format_files(files)
  row = (files.size.to_f / COLUMN).ceil
  files << '' until (files.size % row).zero?
  files.each_slice(row).to_a.transpose
end

def calc_column_width(files, index)
  files.map { _1[index] }.max_by(&:length).length + 2
end

def print_files(files)
  files = format_files(files)
  files.each do |array|
    array.each_with_index do |item, i|
      print item.ljust(calc_column_width(files, i))
    end
    print "\n"
  end
end

def symbolize_file_type(file_type)
  {
    'file' => '-',
    'directory' => 'd',
    'characterSpecial' => 'c',
    'blockSpecial' => 'b',
    'fifo' => 'p',
    'link' => 'l',
    'socket' => 's'
  }[file_type]
end

def permission(mode_number)
  {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }[mode_number]
end

def print_details(files)
  files_blocks = files.sum { |item| File.stat(item).blocks }
  puts "total #{files_blocks}"
  files.each do |item|
    file_status = File.stat(item)
    symbolized_file_type = symbolize_file_type(file_status.ftype)
    mode = file_status.mode.to_s(8)[-3..]
    permissions = permission(mode[0]) + permission(mode[1]) + permission(mode[2])
    hardlink = file_status.nlink.to_s
    user_name = Etc.getpwuid(file_status.uid).name
    group_name = Etc.getgrgid(file_status.gid).name
    bytesize = file_status.size.to_s.rjust(4)
    timestamp = file_status.mtime.strftime('%b %e %H:%M')
    file_name = item
    puts "#{symbolized_file_type}#{permissions} #{hardlink} #{user_name} #{group_name} #{bytesize} #{timestamp} #{file_name}"
  end
end

main
