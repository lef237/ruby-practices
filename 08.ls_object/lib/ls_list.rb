# frozen_string_literal: true

require_relative 'ls_file'
require_relative 'ls_format'

class LsList
  def initialize(options, pathname)
    @options = options
    @pathname = pathname
  end

  def format_files
    filenames = receive_filenames
    ls_files = filenames.map do |filename|
      LsFile.new(filename, @pathname)
    end
    ls_formatted_files = LsFormat.new(ls_files, @options[:long])
    ls_formatted_files.render
  end

  private

  def receive_filenames
    filenames = @options[:all] ? Dir.foreach(@pathname).to_a.sort : Dir.glob('*', base: @pathname)
    @options[:reverse] ? filenames.reverse : filenames
  end
end
