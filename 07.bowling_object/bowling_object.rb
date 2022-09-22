#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'game.rb'
require_relative 'frame.rb'
require_relative 'shot.rb'

game = Game.new(ARGV[0])
puts game.score
