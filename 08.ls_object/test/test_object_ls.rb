#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require_relative '../object_ls.rb'

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
    files_collection = FilesCollection.new(TARGET_PATHNAME)
    assert_equal expected, files_collection.output_files
  end
end
