# frozen_string_literal: true

class LsFormat
  COLUMN = 3

  def initialize(ls_files, long_option_exist)
    @ls_files = ls_files
    @long_option_exist = long_option_exist
  end

  def render
    @long_option_exist ? long_format : normal_format
  end

  private

  def long_format
    files_blocks = @ls_files.sum(&:blocks) / 2
    total_blocks = "total #{files_blocks}\n"
    file_details = @ls_files.map do |file|
      "#{file.symbolized_file_type}#{file.permissions} #{file.hardlink} #{file.user_name} " \
      "#{file.group_name} #{file.bytesize.to_s.rjust(4)} #{file.mtime.strftime('%b %e %H:%M')} #{file.filename}\n"
    end.join
    total_blocks + file_details
  end

  def normal_format
    filenames = @ls_files.map(&:filename)
    calculated_column_width = calc_column_width(filenames)
    built_filename_table = build_filename_table(filenames)
    built_filename_table.map do |horizontal_line|
      horizontal_line.map do |filename|
        filename.ljust(calculated_column_width)
      end.join
    end.join("\n")
  end

  def build_filename_table(filenames)
    row = (filenames.size.to_f / COLUMN).ceil
    filenames << '' until (filenames.size % row).zero?
    filenames.each_slice(row).to_a.transpose
  end

  def calc_column_width(filenames)
    filenames.max_by(&:length).length + 2
  end
end
