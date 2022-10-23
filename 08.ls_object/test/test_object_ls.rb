#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require_relative '../lib/list'

class TestObjectLs < Test::Unit::TestCase
  TARGET_PATHNAME = 'test/sample_files'

  def test_object_ls
    expected = <<~TEXT
      a       e    i     
      bbbbbb  f    jjjj  
      c       ggg        
      d       h          
    TEXT
    options = {}
    list = List.new(options, TARGET_PATHNAME)
    assert_equal expected, list.format_files
  end

  def test_object_ls_all_reverse
    expected = <<~TEXT
      jjjj  e       .k  
      i     d       ..  
      h     c       .   
      ggg   bbbbbb      
      f     a           
    TEXT
    options = { all: true, reverse: true }
    files_collection = FilesCollection.new(options, TARGET_PATHNAME)
    assert_equal expected, files_collection.output_files
  end

  def test_object_ls_long
    expected = <<~TEXT
      total 0
      -rwxrwxrwx 1 lef237 lef237    0 Oct 16 01:14 a
      -rwxrwxrwx 1 lef237 lef237    0 Oct 15 21:35 bbbbbb
      -rwxrwxrwx 1 lef237 lef237    0 Oct 15 21:35 c
      -rwxrwxrwx 1 lef237 lef237    0 Oct 15 21:35 d
      -rwxrwxrwx 1 lef237 lef237    0 Oct 15 21:35 e
      -rwxrwxrwx 1 lef237 lef237    0 Oct 15 21:35 f
      -rwxrwxrwx 1 lef237 lef237    0 Oct 15 21:35 ggg
      -rwxrwxrwx 1 lef237 lef237    0 Oct 15 21:35 h
      -rwxrwxrwx 1 lef237 lef237    0 Oct 15 21:35 i
      drwxrwxrwx 1 lef237 lef237 4096 May 15 15:39 jjjj
    TEXT
    options = { long: true }
    files_collection = FilesCollection.new(options, TARGET_PATHNAME)
    assert_equal expected, files_collection.output_files
  end
end
