# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class LastFrame < Frame
  attr_reader :second_shot, :third_shot

  def initialize(args)
    super(args)
    @second_shot = Shot.new(args[:second_mark])
    @third_shot = Shot.new(args[:third_mark])
  end

  def score
    [first_shot, second_shot, third_shot].map(&:score).sum
  end
end
