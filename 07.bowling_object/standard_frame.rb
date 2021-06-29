# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class StandardFrame < Frame
  attr_reader :next_shot, :after_next_shot

  def post_initialize(args)
    @next_shot = Shot.new(args[:next_mark])
    @after_next_shot = Shot.new(args[:after_next_mark])
  end

  def score
    basic_score = [first_shot, second_shot].map(&:score).sum
    return (basic_score + next_shot.score + after_next_shot.score) if strike?
    return (basic_score + next_shot.score) if spare?

    basic_score
  end

  private

  def strike?
    first_shot.score == full_score
  end

  def spare?
    first_shot.score < full_score && (first_shot.score + second_shot.score == full_score)
  end

  def full_score
    10
  end
end
