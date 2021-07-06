# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot

  def initialize(args)
    @first_shot = Shot.new(args[:first_mark])
  end

  def score
    raise NotImplementedError
  end
end
