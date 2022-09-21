#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require_relative 'game.rb'
require_relative 'frame.rb'
require_relative 'shot.rb'

class TestBowlingObject < Test::Unit::TestCase

  def test_shot_X
    shot = Shot.new('X')
    assert_equal 10, shot.score
  end

  def test_shot_7
    shot = Shot.new('7')
    assert_equal 7, shot.score
  end

  def test_frame
    frame_total_5 = Frame.new('2', '3')
    assert_equal 5, frame_total_5.score

    frame_spare = Frame.new('3', '7')
    assert_equal 10, frame_spare.score
    assert_equal true, frame_spare.spare

    frame_strike = Frame.new('X')
    assert_equal 10, frame_spare.score
    assert_equal true, frame_strike.strike

    frame_final = Frame.new('1', '2', '3')
    assert_equal 6, frame_final.score
  end

  def test_game
    game1 = Game.new("6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5")
    assert_equal 139, game1.score
  end

end
