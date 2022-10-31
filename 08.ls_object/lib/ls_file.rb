# frozen_string_literal: true

require 'etc'

class LsFile
  attr_reader :filename, :pathname

  def initialize(filename, pathname)
    @filename = filename
    @pathname = pathname
  end

  def blocks
    status.blocks
  end

  def symbolized_file_type
    FILE_TYPE[status.ftype]
  end

  def permissions
    mode = status.mode.to_s(8)[-3..]
    permission(mode[0]) + permission(mode[1]) + permission(mode[2])
  end

  def hardlink
    status.nlink.to_s
  end

  def user_name
    Etc.getpwuid(status.uid).name
  end

  def group_name
    Etc.getgrgid(status.gid).name
  end

  def bytesize
    status.size.to_s.rjust(4)
  end

  def timestamp
    status.mtime.strftime('%b %e %H:%M')
  end

  private

  def status
    File.stat("#{@pathname}/#{@filename}")
  end

  FILE_TYPE = {
    'file' => '-',
    'directory' => 'd',
    'characterSpecial' => 'c',
    'blockSpecial' => 'b',
    'fifo' => 'p',
    'link' => 'l',
    'socket' => 's'
  }.freeze

  PERMISSION = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }.freeze

  def permission(mode_number)
    PERMISSION[mode_number]
  end
end
