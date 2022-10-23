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
    list = List.new(options, TARGET_PATHNAME)
    assert_equal expected, list.format_files
  end

  def test_object_ls_long
    expected = <<~TEXT
      total 4
      -rwxrwxrwx 1 lef237 lef237    0 Oct 23 14:56 a
      -rwxrwxrwx 1 lef237 lef237    0 Oct 23 14:56 bbbbbb
      -rwxrwxrwx 1 lef237 lef237    0 Oct 23 14:56 c
      -rwxrwxrwx 1 lef237 lef237    0 Oct 23 14:56 d
      -rwxrwxrwx 1 lef237 lef237    0 Oct 23 14:56 e
      -rwxrwxrwx 1 lef237 lef237    0 Oct 23 14:56 f
      -rwxrwxrwx 1 lef237 lef237    0 Oct 23 14:56 ggg
      -rwxrwxrwx 1 lef237 lef237    0 Oct 23 14:56 h
      -rwxrwxrwx 1 lef237 lef237    0 Oct 23 14:56 i
      drwxrwxrwx 2 lef237 lef237 4096 May 15 15:39 jjjj
    TEXT
    options = { long: true }
    list = List.new(options, TARGET_PATHNAME)
    assert_equal expected, list.format_files
  end
end
