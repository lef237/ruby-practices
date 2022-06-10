#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  opt = OptionParser.new
  params = {}
  opt.on('-l') { |v| params[:l] = v }
  opt.parse!(ARGV)
  files = ARGV
  if params[:l]
    wc_l_option(files)
  elsif files != []
    wc_normal(files)
  else
    wc_normal_stdin
  end
end

def wc_normal(files)
  total_lines = 0
  total_words = 0
  total_bytes = 0
  files.each_with_index do |file_name, index|
    file_data = File.open(file_name).read
    lines = file_data.count("\n")
    words = file_data.scan(/\w+/).size
    bytes = file_data.size
    puts "#{lines.to_s.rjust(5)} #{words.to_s.rjust(5)} #{bytes.to_s.rjust(5)} #{file_name}"
    total_lines += lines
    total_words += words
    total_bytes += bytes
    puts "#{total_lines.to_s.rjust(5)} #{total_words.to_s.rjust(5)} #{total_bytes.to_s.rjust(5)} total" if (index == files.size - 1) && (files.size > 1)
  end
end

def wc_normal_stdin
  stdin_data = $stdin.read
  lines = stdin_data.count("\n")
  words = stdin_data.scan(/\w+/).size
  bytes = stdin_data.size
  puts "#{lines.to_s.rjust(5)} #{words.to_s.rjust(5)} #{bytes.to_s.rjust(5)}"
end

def wc_l_option(files)
  if files != []
    total_lines = 0
    files.each_with_index do |file_name, index|
      file_data = File.open(file_name).read
      lines = file_data.count("\n")
      puts "#{lines.to_s.rjust(5)} #{file_name}"
      total_lines += lines
      puts "#{total_lines.to_s.rjust(5)} total" if (index == files.size - 1) && (files.size > 1)
    end
  else
    stdin_data = $stdin.read
    lines = stdin_data.count("\n")
    puts lines.to_s.rjust(5).to_s
  end
end

main
