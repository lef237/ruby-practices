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
    @frames_instances.each_with_index do |frame, index|
      next unless frame.strike && index < 9

      unless @frames_instances[index + 1].strike
        @additional_points += @frames_instances[index + 1].first_shot_score + @frames_instances[index + 1].second_shot_score
      end
      @additional_points += @frames_instances[index + 1].first_shot_score + @frames_instances[index + 2].first_shot_score if @frames_instances[index + 1].strike
    end
  end

  def add_spare_points
    @frames_instances.each_with_index do |frame, index|
      @additional_points += @frames_instances[index + 1].first_shot_score if frame.spare && index < 9
    end
  end

  def make_frames_instances
    @frames.each_with_index do |_frame, index|
      @frames_instances << if !@frames[index][2].nil?
                             Frame.new(@frames[index][0], @frames[index][1], @frames[index][2])
                           elsif @frames[index][0] == 'X'
                             Frame.new(@frames[index][0])
                           else
                             Frame.new(@frames[index][0], @frames[index][1])
                           end
    end
  end

  def score
    @frames = []
    9.times do
      @frames << if @marks[0] == 'X'
                   @marks.shift(1)
                 else
                   @marks.shift(2)
                 end
    end
    @frames << @marks

    @frames_instances = []
    make_frames_instances

    @additional_points = 0
    add_strike_points
    add_spare_points

    total_frame_score = 0
    @frames_instances.each do |frame|
      total_frame_score += frame.score
    end

    total_frame_score + @additional_points
  end
end
