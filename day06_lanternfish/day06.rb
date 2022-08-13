# https://adventofcode.com/2021/day/6
require_relative '../day'

class Day06 < Day
  def initialize
    super(folder: __dir__)
    @input = @input[0].split(',').map(&:to_i)
  end

  def fish_sim(days:)
    fishes = @input.tally
    days.times do
      new_fishes = Hash.new(0)
      fishes.each do |timer, count|
        if timer.zero?
          new_fishes[6] += count
          new_fishes[8] += fishes[0]
        else
          new_fishes[timer - 1] += count
        end
      end
      fishes = new_fishes
    end
    fishes.sum { |_, v| v }
  end

  def part_one
    fish_sim(days: 80)
  end

  def part_two
    fish_sim(days: 256)
  end
end
