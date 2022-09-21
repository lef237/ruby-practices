#!/usr/bin/env ruby
# frozen_string_literal: true

# game = Game.new(ARGV[0])
# puts game.score # => 125

class Game

  def initialize(argv)
    @scores_text = argv_split(argv) # ["3", "7" , "X", "5", ..]
  end

  def argv_split(argv)
    argv.split(',')
  end

  # ゲーム全体の計算をする
  def score
    frame = Frame.new(@scores_text)
    total_score = frame.score
    total_score
  end

  # フレームごとの最初のショットを確認する

end

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def strike
    return true if @first_shot == 10
  end

  def spare
   return true if @first_shot != 10 && @first_shot + @second_shot == 10
  end

  def score
    @first_shot + @second_shot + @third_shot
  end

end

class Shot
  attr_reader :mark
  
  def initialize(mark)
    @mark = mark
  end

  def score
    return 10 if mark == 'X'
    mark.to_i
  end
end