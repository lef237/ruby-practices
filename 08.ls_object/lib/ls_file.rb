# frozen_string_literal: true

require 'etc'

class LsFile
  attr_reader :filename, :pathname, :status, :blocks, :symbolized_file_type, :mode, :permissions, :hardlink, :user_name, :group_name, :bytesize, :timestamp

  def initialize(filename, pathname)
    @filename = filename
    @pathname = pathname
    @status = file_status
    @blocks = @status.blocks
    @symbolized_file_type = symbolize_file_type(@status.ftype)
    @mode = @status.mode.to_s(8)[-3..]
    @permissions = permission(@mode[0]) + permission(@mode[1]) + permission(@mode[2])
    @hardlink = @status.nlink.to_s
    @user_name = Etc.getpwuid(@status.uid).name
    @group_name = Etc.getgrgid(@status.gid).name
    @bytesize = @status.size.to_s.rjust(4)
    @timestamp = @status.mtime.strftime('%b %e %H:%M')
  end

  private

  def file_status
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

  def symbolize_file_type(file_type)
    FILE_TYPE[file_type]
  end

  def permission(mode_number)
    PERMISSION[mode_number]
  end
end
