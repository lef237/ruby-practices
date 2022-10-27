#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require_relative '../lib/ls_list'

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
    list = LsList.new(options, TARGET_PATHNAME)
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
    list = LsList.new(options, TARGET_PATHNAME)
    assert_equal expected, list.format_files
  end

  def test_object_ls_long
    expected = <<~TEXT
      total 4
      -rwxrwxrwx 1 lef237 lef237    0 Oct 23 14:56 a
      -rwxrwxrwx 1 lef237 lef237    0 Oct 23 14:56 bbbbbb
      -rwxrw-r-- 1 lef237 lef237    0 Oct 23 14:56 c
      -rw-r--rw- 1 lef237 lef237    0 Oct 23 14:56 d
      -rw-rw-rw- 1 lef237 lef237    0 Oct 23 14:56 e
      -r--r--r-- 1 lef237 lef237    0 Oct 23 14:56 f
      -r--rw-r-- 1 lef237 lef237    0 Oct 23 14:56 ggg
      -r---w-r-- 1 lef237 lef237    0 Oct 23 14:56 h
      -rwxrwxrwx 1 lef237 lef237    0 Oct 23 14:56 i
      drw-rw-rw- 2 lef237 lef237 4096 May 15 15:39 jjjj
    TEXT
    options = { long: true }
    list = LsList.new(options, TARGET_PATHNAME)
    assert_equal expected, list.format_files
  end
end
