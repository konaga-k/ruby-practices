# frozen_string_literal: true

class Shot
  attr_reader :mark

  STRIKE = 'X'

  def initialize(mark)
    @mark = mark
  end

  def score
    return 10 if mark == STRIKE

    mark.to_i
  end
end
