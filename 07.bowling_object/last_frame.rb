# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class LastFrame < Frame
  attr_reader :third_shot

  def post_initialize(args)
    @third_shot = Shot.new(args[:third_mark])
  end

  def score
    [first_shot, second_shot, third_shot].map(&:score).sum
  end
end
