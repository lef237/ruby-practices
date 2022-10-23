# frozen_string_literal: true

class File
  attr_reader :filename, :pathname

  def initialize(filename, pathname)
    @filename = filename
    @pathname = pathname
  end
end
