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
    formatted_files = LsFormat.new(files, @options[:long])
    formatted_files.render
  end

  private

  def receive_filenames
    filenames = if @options[:all]
                  Dir.foreach(@pathname).to_a.sort
                else
                  Dir.glob('*', base: @pathname)
                end
    filenames = filenames.reverse if @options[:reverse]
    filenames
  end
end
