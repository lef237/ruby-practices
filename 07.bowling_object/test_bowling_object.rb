#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
# require_relative 'bowling_object.rb'
require_relative 'game.rb'

class TestBowlingObject < Test::Unit::TestCase
  # def test_all_score
  #     score = "6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5"
  #     point = calculate(score)
  #     assert_equal 139, point
  # end

  # def test_score
  #   shot = Shot.new('X')
  #   assert_equal 'X', shot.mark
  #   shot = Shot.new('7')
  #   assert_equal '7', shot.mark
  # end
  def test_all_score
    game = Game.new('scores')
  end

end
