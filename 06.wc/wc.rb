#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  opt = OptionParser.new
  params = {}
  opt.on('-l') { |v| params[:lines] = v }
  opt.parse!(ARGV)
  file_names = ARGV
  input_contents = file_names != [] ? files_open(file_names) : [$stdin.read]
  show_files(input_contents, file_names) if params.empty?
  show_lines(input_contents, file_names) if params[:lines]
end

def files_open(file_names)
  file_contents = []
  file_names.each do |file_name|
    file_contents << File.open(file_name).read
  end
  file_contents
end

def show_files(input_contents, file_names)
  total_lines = 0
  total_words = 0
  total_bytes = 0
  input_contents.each_with_index do |input_content, index|
    lines = input_content.count("\n")
    words = file_names ? input_content.scan(/\w+/).size : input_content.scan(/\s+/).size
    bytes = input_content.size
    file_name = file_names[index]
    puts "#{lines.to_s.rjust(5)} #{words.to_s.rjust(5)} #{bytes.to_s.rjust(5)} #{file_name}"
    total_lines += lines
    total_words += words
    total_bytes += bytes
    puts "#{total_lines.to_s.rjust(5)} #{total_words.to_s.rjust(5)} #{total_bytes.to_s.rjust(5)} total" if (index == input_contents.size - 1) && (input_contents.size > 1)
  end
end

def show_lines(input_contents, file_names)
    total_lines = 0
    input_contents.each_with_index do |input_content, index|
      lines = input_content.count("\n")
      file_name = file_names[index]
      puts "#{lines.to_s.rjust(5)} #{file_name}"
      total_lines += lines
      puts "#{total_lines.to_s.rjust(5)} total" if (index == input_contents.size - 1) && (input_contents.size > 1)
    end
end

main
