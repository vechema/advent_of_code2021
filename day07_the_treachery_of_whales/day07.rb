# https://adventofcode.com/2021/day/7
require_relative '../day'

class Day07 < Day
  def initialize
    super(folder: __dir__)
    @input = @input[0].split(',').map(&:to_i)
  end

  def least_fuel_cost(fuel_calc:)
    least_fuel_amount = (2**(0.size * 8 - 2) - 1)
    least_fuel_position = -1
    (0..@input.max).each do |current_position|
      current_fuel_amount = 0
      @input.each do |starting_position|
        cost = fuel_calc.call(current_position, starting_position)
        current_fuel_amount += cost
      end
      if current_fuel_amount < least_fuel_amount
        least_fuel_amount = current_fuel_amount
        least_fuel_position = current_position
      end
    end

    least_fuel_amount
  end

  def part_one
    abs_diff = ->(x, y) { (x - y).abs }
    least_fuel_cost(fuel_calc: abs_diff)
  end

  def part_two
    triangular_number = lambda do |x, y|
      n = (x - y).abs
      (n * (n + 1)) / 2
    end
    least_fuel_cost(fuel_calc: triangular_number)
  end
end
