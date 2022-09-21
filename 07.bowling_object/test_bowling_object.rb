#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'
# require_relative 'bowling_object.rb'
require_relative 'game.rb'

class TestBowlingObject < Test::Unit::TestCase

  def test_shot_X
    game = Shot.new('X')
    assert_equal 10, game.score
  end

  def test_shot_7
    game = Shot.new('7')
    assert_equal 7, game.score
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

end
