# frozen_string_literal: true

require 'etc'

class LongOption
  def initialize(files, pathname)
    @files = files
    @pathname = pathname
  end

  def long_output
    files_blocks = @files.sum { |item| File.stat("#{@pathname}/#{item}").blocks }
    output_sentence = "total #{files_blocks}\n"
    @files.each do |item|
      file_status = File.stat("#{@pathname}/#{item}")
      symbolized_file_type = symbolize_file_type(file_status.ftype)
      mode = file_status.mode.to_s(8)[-3..]
      permissions = permission(mode[0]) + permission(mode[1]) + permission(mode[2])
      hardlink = file_status.nlink.to_s
      user_name = Etc.getpwuid(file_status.uid).name
      group_name = Etc.getgrgid(file_status.gid).name
      bytesize = file_status.size.to_s.rjust(4)
      timestamp = file_status.mtime.strftime('%b %e %H:%M')
      file_name = item
      output_sentence += "#{symbolized_file_type}#{permissions} #{hardlink} #{user_name} #{group_name} #{bytesize} #{timestamp} #{file_name}\n"
    end
    output_sentence
  end

  private

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
end
