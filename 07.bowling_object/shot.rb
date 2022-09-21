class Shot
  attr_reader :mark

  # 文字をセットする
  def initialize(mark)
    @mark = mark
  end

  # 受け取った文字を数値に変える
  def score
    return 10 if mark == 'X'

    mark.to_i
  end
end
