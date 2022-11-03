#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
require_relative 'game'
require_relative 'frame'
require_relative 'shot'

class TestBowlingObject < Test::Unit::TestCase
  def test_shot
    shot1 = Shot.new('X')
    assert_equal 10, shot1.score

    shot2 = Shot.new('7')
    assert_equal 7, shot2.score
  end

  def test_normal_frame
    normal_frame = Frame.new('2', '3')
    assert_equal 5, normal_frame.score
  end

  def test_spare_frame
    frame_spare = Frame.new('3', '7')
    assert_equal 10, frame_spare.score
    assert_equal true, frame_spare.spare
  end

  def test_strike_frame
    frame_strike = Frame.new('X')
    assert_equal 10, frame_strike.score
    assert_equal true, frame_strike.strike
  end

  def test_final_frame
    frame_final = Frame.new('1', '2', '3')
    assert_equal 6, frame_final.score
  end

  def test_game
    game1 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    assert_equal 139, game1.score

    game2 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X')
    assert_equal 164, game2.score

    game3 = Game.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4')
    assert_equal 107, game3.score

    game4 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0')
    assert_equal 134, game4.score

    game5 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8')
    assert_equal 144, game5.score

    game6 = Game.new('X,X,X,X,X,X,X,X,X,X,X,X')
    assert_equal 300, game6.score
  end
end
