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
  if frame[0] == 10 && count < 10
    point += 10
    point += if frames[count][0] == 10
               10 + frames[count + 1][0]
             else
               frames[count][0] + frames[count][1]
             end
  elsif frame.sum == 10 && count < 10
    point += 10 + frames[count][0]
  elsif count >= 10
    point += frame.sum
  else
    point += frame.sum
  end
end
puts point
