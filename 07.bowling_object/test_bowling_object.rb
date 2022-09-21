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

end
