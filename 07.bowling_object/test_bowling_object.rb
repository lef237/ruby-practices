#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require './bowling_object.rb'

class TestBowlingObject < Test::Unit::TestCase
  def test_score
      score = "6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5"
      point = calculate(score)
      assert_equal 139, point
  end
end
