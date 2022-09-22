#!/usr/bin/env ruby
# frozen_string_literal: true

class Game
  def initialize(argv)
    @marks = argv_split(argv)
  end

  def argv_split(argv)
    argv.split(',')
  end

  def score
    marks = @marks

    frames = []
    9.times do
      if marks[0] == 'X'
        frames << marks.shift(1)
      else
        frames << marks.shift(2)
      end
    end
    frames << marks

    frames_instances = []
    frames.each_with_index do |frame, index|
      if frames[index][2] != nil
        frames_instances << Frame.new(frames[index][0], frames[index][1], frames[index][2])
      elsif frames[index][0] == 'X'
        frames_instances << Frame.new(frames[index][0])
      else
        frames_instances << Frame.new(frames[index][0], frames[index][1])
      end
    end

    additional_points = 0
    frames_instances.each_with_index do |frame, index|
      if frame.strike && index < 9
        additional_points += frames_instances[index + 1].first_shot_score + frames_instances[index + 1].second_shot_score unless frames_instances[index + 1].strike
        additional_points += frames_instances[index + 1].first_shot_score + frames_instances[index + 2].first_shot_score if frames_instances[index + 1].strike
      elsif frame.spare && index < 9
        additional_points += frames_instances[index + 1].first_shot_score
      end
    end

    total_frame_score = 0
    frames_instances.each do |frame|
      total_frame_score += frame.score
    end

    total_score = total_frame_score + additional_points
    total_score
  end
end
