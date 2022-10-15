# frozen_string_literal: true

class FilesCollection
  def initialize(options, pathname)
    p options
    @options = options
    @pathname = pathname
    @files = receive_files_in_current_directory(@options[:all], @options[:reverse], @pathname)
  end

  def receive_files_in_current_directory(options_all, options_reverse, pathname)
    if options_all
      files = Dir.foreach(pathname).to_a
    else
      files = Dir.glob('*', base: pathname)
    end
    files = files.reverse if options_reverse
    files
  end

  def output_files
    if @options[:long]
      LongOptions.new(@files).long_output
    else
      normal_output
    end
  end

  private

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

class LongOptions
  def initialize(files)
    @files = files
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

  def print_details(files)
    files_blocks = files.sum { |item| File.stat(item).blocks }
    puts "total #{files_blocks}"
    files.each do |item|
      file_status = File.stat(item)
      symbolized_file_type = symbolize_file_type(file_status.ftype)
      mode = file_status.mode.to_s(8)[-3..]
      permissions = permission(mode[0]) + permission(mode[1]) + permission(mode[2])
      hardlink = file_status.nlink.to_s
      user_name = Etc.getpwuid(file_status.uid).name
      group_name = Etc.getgrgid(file_status.gid).name
      bytesize = file_status.size.to_s.rjust(4)
      timestamp = file_status.mtime.strftime('%b %e %H:%M')
      file_name = item
      puts "#{symbolized_file_type}#{permissions} #{hardlink} #{user_name} #{group_name} #{bytesize} #{timestamp} #{file_name}"
    end
  end
end


