#!/usr/bin/env ruby
# frozen_string_literal: true

# require 'debug'



class Game
  def initialize(argv)
    @marks = argv_split(argv) # ["3", "7" , "X", "5", ..]
  end

  def argv_split(argv)
    argv.split(',')
  end

  # ゲーム全体の計算をする
  def score
    marks = @marks

    #TODO: marksを上手く処理して、フレームごとにFrameクラスに渡す
      #まずはフレームに分ける。
    frames = []

    9.times do
      if marks[0] == 'X'
        frames << marks.shift(1)
      else
        frames << marks.shift(2)
      end
    end
    frames << marks

    # framesは[[], [], [], [], [], [],]みたいな形になっているはず
    # @frames_framesにFrameクラスで作成したインスタンスを入れていく
    @frames_frames = []
    frames.each_with_index do |frame, index|
      if frames[index][0] == 'X'
        @frames_frames << Frame.new(frames[index][0])
      elsif frames[index][2] != nil
        @frames_frames << Frame.new(frames[index][0], frames[index][1], frames[index][2])
      else
        @frames_frames << Frame.new(frames[index][0], frames[index][1])
      end
    end

  # debugger


    @katen = 0

    # 加点処理をおこなう
    @frames_frames.each_with_index do |frame, index|
      if frame.strike && index < 9 #10投目以外がストライクのとき
        # 次のフレームがストライク以外のとき
        @katen += @frames_frames[index + 1].first_shot_score + @frames_frames[index + 1].second_shot_score unless @frames_frames[index + 1].strike
        # 次のフレームがストライクのとき
        @katen += @frames_frames[index + 1].first_shot_score + @frames_frames[index + 2].first_shot_score if @frames_frames[index + 1].strike
      elsif frame.spare && index < 9
        @katen += @frames_frames[index + 1].first_shot_score
      end
    end

    @total_frame_score = 0
    @frames_frames.each do |frame|
      @total_frame_score += frame.score
    end

    #TODO: トータルスコアを出す
    total_score = @total_frame_score + @katen
    total_score
  end

  # フレームごとの最初のショットを確認する

end
