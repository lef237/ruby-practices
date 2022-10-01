#!/usr/bin/env ruby
# frozen_string_literal: true

class Game
  def initialize(argv)
    @marks = argv_split(argv)
  end

  def argv_split(argv)
    argv.split(',')
  end

  def add_strike_points
    @frames.each_with_index do |frame, index|
      next unless frame.strike && index < 9

      @additional_points += @frames[index + 1].first_shot_score + @frames[index + 1].second_shot_score unless @frames[index + 1].strike
      @additional_points += @frames[index + 1].first_shot_score + @frames[index + 2].first_shot_score if @frames[index + 1].strike
    end
  end

  def add_spare_points
    @frames.each_with_index do |frame, index|
      @additional_points += @frames[index + 1].first_shot_score if frame.spare && index < 9
    end
  end

  def parse_score_to_frames
    9.times do
      first_mark = @marks.shift
      if first_mark == 'X'
        @frames << Frame.new(first_mark)
      else
        second_mark = @marks.shift
        @frames << Frame.new(first_mark, second_mark)
      end
    end
    @frames << Frame.new(*@marks)
  end

  def calculate_total_score
    total_frame_score = @frames.sum(&:score)
    total_frame_score + @additional_points
  end

  def score
    @frames = []
    parse_score_to_frames

    @additional_points = 0
    add_strike_points
    add_spare_points

    calculate_total_score
  end
end
