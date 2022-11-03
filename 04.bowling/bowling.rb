#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a

point = 0
frames.each.with_index(1) do |frame, count|
  point += frame.sum
  if frame[0] == 10 && count < 10
    point += if frames[count][0] == 10
               10 + frames[count + 1][0]
             else
               frames[count].sum
             end
  elsif frame.sum == 10 && count < 10
    point += frames[count][0]
  end
end
puts point
