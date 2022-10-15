#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require_relative '../files_collection.rb'

class TEST_OBJECT_LS < Test::Unit::TestCase

  TARGET_PATHNAME = 'test/sample_files'

  def test_object_ls
    expected = <<~TEXT.chomp
      a       e    i     
      bbbbbb  f    jjjj  
      c       ggg        
      d       h          
      
    TEXT
    #ターゲットパスを渡したらそのパスに対してlsコマンドを実行する。空のときはカレントディレクトリでlsコマンドを実行する。
    options = {}
    files_collection = FilesCollection.new(options, TARGET_PATHNAME)
    assert_equal expected, files_collection.output_files
  end

  def test_object_ls_all_reverse
    expected = <<~TEXT.chomp
      jjjj  e       .k  
      i     d       ..  
      h     c       .   
      ggg   bbbbbb      
      f     a           
      
    TEXT
    options = {:all=>true, :reverse=>true}
    files_collection = FilesCollection.new(options, TARGET_PATHNAME)
    assert_equal expected, files_collection.output_files
  end
end
