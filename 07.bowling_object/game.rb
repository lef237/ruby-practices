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

      unless @frames[index + 1].strike
        @additional_points += @frames[index + 1].first_shot_score + @frames[index + 1].second_shot_score
      end
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
      @frames << if @marks[0] == 'X'
                   first_mark = @marks.shift
                   Frame.new(first_mark)
                 else
                   first_mark = @marks.shift
                   second_mark = @marks.shift
                   Frame.new(first_mark, second_mark)
                 end
    end

    @frames << Frame.new(*@marks)
  end

  def score
    @frames = []
    parse_score_to_frames

    @additional_points = 0
    add_strike_points
    add_spare_points

    total_frame_score = 0
    @frames.each do |frame|
      total_frame_score += frame.score
    end

    total_frame_score + @additional_points
  end
end
