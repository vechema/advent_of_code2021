# https://adventofcode.com/2021/day/1
require_relative '../day'

class Day01 < Day
  def initialize
    super(folder: __dir__)
    @input = @input.map(&:to_i)
  end

  def num_increases(array:)
    array.each_with_index.count { |x, index| x > array[index - 1] unless array[index - 1].nil? }
  end

  def part_one
    num_increases(array: @input)
  end

  def part_two
    sliding_window_sum = @input.each_cons(3).map(&:sum)
    num_increases(array: sliding_window_sum)
  end
end
