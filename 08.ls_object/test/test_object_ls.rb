#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require_relative 'object_ls.rb'

class TEST_OBJECT_LS < Test::Unit::TestCase

  TARGET_PATHNAME = 'test/sample_files'

  def test_object_ls
    files_collection = FilesCollection.new(ARGV, test_argument: true)
    assert_equal expected, files_collection.print_files
  end
end
