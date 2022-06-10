#!/usr/bin/env ruby

require 'optparse'



def wc_normal(files)
  if files != []
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
      if index == files.size - 1 and files.size > 1
          puts "#{total_lines.to_s.rjust(5)} #{total_words.to_s.rjust(5)} #{total_bytes.to_s.rjust(5)} total"
      end
    end
  else
    stdin_data  = $stdin.read
    lines = stdin_data.count("\n")
    words = stdin_data.scan(/\w+/).size
    bytes = stdin_data.size
    puts "#{lines.to_s.rjust(5)} #{words.to_s.rjust(5)} #{bytes.to_s.rjust(5)}"
  end
end

def wc_l_option(files)
  if files != []
    total_lines = 0
    files.each_with_index do |file_name, index|
      file_data = File.open(file_name).read
      lines = file_data.count("\n")
      puts "#{lines.to_s.rjust(5)} #{file_name}"
      total_lines += lines
      if index == files.size - 1 and files.size > 1
          puts "#{total_lines.to_s.rjust(5)} total"
      end
    end
  else
    stdin_data  = $stdin.read
    lines = stdin_data.count("\n")
    puts "#{lines.to_s.rjust(5)}"
  end
end

opt = OptionParser.new
params = {}
opt.on('-l') {|v| params[:l] = v }
opt.parse!(ARGV)
files = ARGV

if params[:l]
  wc_l_option(files)
else
  wc_normal(files)
end

