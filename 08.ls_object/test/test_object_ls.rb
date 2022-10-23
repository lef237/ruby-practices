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
      total 24
      drwxr-xr-x 2 lef237 lef237 4096 May 15 15:39 jjjj
      -rw-r--r-- 1 lef237 lef237    0 Oct 23 14:56 i
      -rw-r--r-- 1 lef237 lef237    0 Oct 23 14:56 h
      -rw-r--r-- 1 lef237 lef237    0 Oct 23 14:56 ggg
      -rw-r--r-- 1 lef237 lef237    0 Oct 23 14:56 f
      -rw-r--r-- 1 lef237 lef237    0 Oct 23 14:56 e
      -rw-r--r-- 1 lef237 lef237    0 Oct 23 14:56 d
      -rw-r--r-- 1 lef237 lef237    0 Oct 23 14:56 c
      -rw-r--r-- 1 lef237 lef237    0 Oct 23 14:56 bbbbbb
      -rw-r--r-- 1 lef237 lef237    0 Oct 23 14:56 a
      -rw-r--r-- 1 lef237 lef237    0 Oct 23 14:56 .k
      drwxrwxrwx 3 lef237 lef237 4096 Oct 23 15:04 ..
      drwxr-xr-x 3 lef237 lef237 4096 Oct 23 15:04 .
    TEXT
    options = { long: true }
    list = List.new(options, TARGET_PATHNAME)
    assert_equal expected, list.format_files
  end
end
