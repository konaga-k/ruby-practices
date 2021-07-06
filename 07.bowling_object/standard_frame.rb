# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class StandardFrame < Frame
  attr_reader :second_shot, :next_shot, :after_next_shot

  def initialize(args)
    super(args)
    @second_shot = strike? ? nil : Shot.new(args[:second_mark])
    @next_shot = strike? ? Shot.new(args[:second_mark]) : Shot.new(args[:third_mark])
    @after_next_shot = strike? ? Shot.new(args[:third_mark]) : nil
  end

  def score
    if strike?
      [first_shot, next_shot, after_next_shot].map(&:score).sum
    elsif spare?
      [first_shot, second_shot, next_shot].map(&:score).sum
    else
      [first_shot, second_shot].map(&:score).sum
    end
  end

  def strike?
    first_shot.score == full_score
  end

  private

  def spare?
    !strike? && ([first_shot, second_shot].map(&:score).sum == full_score)
  end

  def full_score
    10
  end
end
