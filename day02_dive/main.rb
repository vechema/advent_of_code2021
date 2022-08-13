# https://adventofcode.com/2021/day/2
require_relative '../day'

class Day02 < Day
  def initialize
    super(folder: __dir__)
    @input = @input.map(&:split).map { |x| [x[0], x[1].to_i] }
  end

  def part_one
    total_movement = {}
    @input.each do |direction, distance|
      if total_movement[direction]
        total_movement[direction] += distance
      else
        total_movement[direction] = distance
      end
    end

    (total_movement['down'] - total_movement['up']) * total_movement['forward']
  end

  def part_two
    aim = 0
    depth = 0
    position = 0

    @input.each do |direction, distance|
      case direction
      when 'forward'
        position += distance
        depth += aim * distance
      when 'up'
        aim -= distance
      when 'down'
        aim += distance
      end
    end

    depth * position
  end
end
