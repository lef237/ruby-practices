# frozen_string_literal: true

class OneFile
  attr_reader :filename, :pathname

  def initialize(filename, pathname)
    @filename = filename
    @pathname = pathname
  end
end
