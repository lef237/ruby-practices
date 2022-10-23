# frozen_string_literal: true

require 'etc'
require_relative './file'
require_relative './format'

class List
  def initialize(options, pathname)
    @options = options
    @pathname = pathname
  end

  def format_files
    filenames = receive_filenames
    files = filenames.map do |filename|
      File.new(filename, @pathname)
    end
    formatted_files = Format.new(files, @options[:long])
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
