# frozen_string_literal: true

require_relative 'long_option'

class FilesCollection
  def initialize(options, pathname)
    @options = options
    @pathname = pathname
    @files = receive_files_in_current_directory(options[:all], options[:reverse], pathname)
  end

  def output_files
    if @options[:long]
      long_options = LongOption.new(@files, @pathname).long_output
    else
      normal_output
    end
  end

  private

  def receive_files_in_current_directory(options_all, options_reverse, pathname)
    if options_all
      files = Dir.foreach(pathname).to_a
    else
      files = Dir.glob('*', base: pathname)
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

  def normal_output
    files = format_files(@files)
    output_sentence = ""
    files.each do |array|
      array.each_with_index do |item, i|
        output_sentence += item.ljust(calc_column_width(files, i))
      end
      output_sentence += "\n"
    end
    output_sentence
  end
end
