# frozen_string_literal: true

require 'etc'

class List
  def initialize(options, pathname)
    @options = options
    @pathname = pathname
  end

  def format_files
    # パスを使ってfilenamesを集める
    filenames = receive_filenames
    # パスとfilenamesとFileクラスを使ってFileのインスタンスを集める
    files = filenames.map do |filename|
      File.new(filename, @pathname)
    end
    # FormatクラスにFilesのインスタンスたちを渡してフォーマットしてもらったものを返す
    formatted_files = Format.new(files, @options[:long])
    # フォーマットした情報を出力する
    formatted_files.render
  end

  private

  def receive_filenames
    filenames = if @options[:all]
                  Dir.foreach(@pathname).to_a
                else
                  Dir.glob('*', base: @pathname)
                end
    filenames = filenames.reverse if @options[:reverse]
    filenames
  end

end


class File
  attr_reader :filename, :pathname

  def initialize(filename, pathname)
    @filename = filename
    @pathname = pathname
  end
end


class Format
  def initialize(files, long_option)
    @files = files
    @long_option = long_option
  end

  def render
    if @long_option
      long_format
    else
      normal_format
    end
  end

  private

  def long_format
    files_blocks = @files.sum { |file| File.stat("#{file.pathname}/#{file.filename}").blocks }
    render_sentence = "total #{files_blocks}\n"
    @files.each do |file|
      file_status = File.stat("#{file.pathname}/#{file.filename}")
      symbolized_file_type = symbolize_file_type(file_status.ftype)
      mode = file_status.mode.to_s(8)[-3..]
      permissions = permission(mode[0]) + permission(mode[1]) + permission(mode[2])
      hardlink = file_status.nlink.to_s
      user_name = Etc.getpwuid(file_status.uid).name
      group_name = Etc.getgrgid(file_status.gid).name
      bytesize = file_status.size.to_s.rjust(4)
      timestamp = file_status.mtime.strftime('%b %e %H:%M')
      file_name = file.filename
      render_sentence += "#{symbolized_file_type}#{permissions} #{hardlink} #{user_name} #{group_name} #{bytesize} #{timestamp} #{file_name}\n"
    end
    render_sentence
  end

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


  def normal_format
    filenames = @files.map { |file| file.filename }
    filenames = format_filenames(filenames)
    render_sentence = ''
    filenames.each do |array|
      array.each_with_index do |item, index|
        render_sentence += item.ljust(calc_column_width(filenames, index))
      end
      render_sentence += "\n"
    end
    render_sentence
  end

  COLUMN = 3

  def format_filenames(filenames)
    row = (filenames.size.to_f / COLUMN).ceil
    filenames << '' until (filenames.size % row).zero?
    filenames.each_slice(row).to_a.transpose
  end

  def calc_column_width(filenames, index)
    filenames.map { _1[index] }.max_by(&:length).length + 2
  end

end


