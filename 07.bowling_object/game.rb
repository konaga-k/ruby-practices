# frozen_string_literal: true

require_relative 'standard_frame'
require_relative 'last_frame'

class Game
  attr_reader :frames

  def initialize(result)
    @frames = convert_result_to_frames(result)
  end

  def score
    frames.map(&:score).sum
  end

  private

  def convert_result_to_frames(result)
    frames = []
    result_array = result.split(',')

    result_index = 0
    frame_count = 1

    while frame_count <= last_frame_number
      if frame_count < last_frame_number
        frame = StandardFrame.new(first_mark: result_array[result_index],
                                  second_mark: result_array[result_index + 1],
                                  third_mark: result_array[result_index + 2])
        result_index = frame.strike? ? (result_index + 1) : (result_index + 2)
      else
        frame = LastFrame.new(first_mark: result_array[result_index],
                              second_mark: result_array[result_index + 1],
                              third_mark: result_array[result_index + 2])
      end
      frame_count += 1

      frames << frame
    end

    frames
  end

  def last_frame_number
    10
  end
end
