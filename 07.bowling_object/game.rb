# frozen_string_literal: true

require_relative 'standard_frame'
require_relative 'last_frame'

class Game
  attr_reader :result

  STRIKE = 'X'

  def initialize(result)
    @result = result
  end

  def score
    frames.map(&:score).sum
  end

  private

  def frames
    marks_groups.map.with_index(1) do |marks, i|
      if i < last_frame_number
        StandardFrame.new(first_mark: marks.first_mark, second_mark: marks.second_mark,
                          next_mark: marks.next_mark, after_next_mark: marks.after_next_mark)
      else
        LastFrame.new(first_mark: marks.first_mark, second_mark: marks.second_mark, third_mark: marks.third_mark)
      end
    end
  end

  def marks_groups # rubocop:disable Metrics/MethodLength
    groups = []
    mark_index = 0
    marks = Struct.new(:first_mark, :second_mark, :third_mark, :next_mark, :after_next_mark)

    result_chars = result.split(',')
    result_chars.each_with_index do |mark, i|
      case mark_index
      when 0
        groups << marks.new(mark)
        if mark == STRIKE
          groups.last.next_mark = result_chars[i + 1]
          groups.last.after_next_mark = result_chars[i + 2]
          mark_index = groups.size == last_frame_number ? 1 : 0
          next
        end
        mark_index += 1
      when 1
        groups.last.second_mark = mark
        groups.last.next_mark = result_chars[i + 1]
        groups.last.after_next_mark = result_chars[i + 2]
        mark_index = groups.size == last_frame_number ? 2 : 0
      when 2
        groups.last.third_mark = mark
      end
    end

    groups
  end

  def last_frame_number
    10
  end
end
