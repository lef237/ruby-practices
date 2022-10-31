# frozen_string_literal: true

class LsFormat
  def initialize(ls_files, long_option_exist)
    @ls_files = ls_files
    @long_option_exist = long_option_exist
  end

  def render
    if @long_option_exist
      long_format
    else
      normal_format
    end
  end

  private

  def long_format
    files_blocks = @ls_files.sum(&:blocks) / 2
    render_sentence = "total #{files_blocks}\n"
    @ls_files.each do |file|
      render_sentence += "#{file.symbolized_file_type}#{file.permissions} #{file.hardlink} #{file.user_name} #{file.group_name} #{file.bytesize} #{file.timestamp} #{file.filename}\n"
    end
    render_sentence
  end

  def normal_format
    filenames = @ls_files.map(&:filename)
    calculated_column_width = calc_column_width(filenames)
    rearranged_filenames = rearrange_filenames(filenames)
    render_sentence = ''
    rearranged_filenames.each do |array|
      array.each do |item|
        render_sentence += item.ljust(calculated_column_width)
      end
      render_sentence += "\n"
    end
    render_sentence
  end

  COLUMN = 3

  def rearrange_filenames(filenames)
    row = (filenames.size.to_f / COLUMN).ceil
    filenames << '' until (filenames.size % row).zero?
    filenames.each_slice(row).to_a.transpose
  end

  def calc_column_width(filenames)
    filenames.max_by(&:length).length + 2
  end
end
