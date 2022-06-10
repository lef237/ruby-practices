#!/usr/bin/env ruby

files = ARGV

p files
p files.size


total_lines = 0
total_words = 0
total_bytes = 0

files.each_with_index do |file_name, index|
  p file_name

# files[0]をまずは表示する
# ファイルデータ


  file_data = File.open(file_name).read
  p file_data
  # 行数
  lines = file_data.count("\n")

  # 単語数
  words = file_data.scan(/\w+/).size
  p words

  # バイト数
  bytes = file_data.size

  p "#{lines} #{words} #{bytes} #{file_name}"

  p lines

  total_lines += lines
  total_words += words
  total_bytes += bytes
  p total_lines

  if index = files.size - 1
      p "#{total_lines} #{total_words} #{total_bytes} total"
  end

end
