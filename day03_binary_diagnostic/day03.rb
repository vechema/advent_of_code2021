# https://adventofcode.com/2021/day/3
require_relative '../day'

class Day03 < Day
  def initialize
    super(folder: __dir__)
  end

  def tally(index:, input: @input)
    input.map { |x| x[index] }.tally
  end

  def rate(select_by:)
    block = proc { |_, v| v }
    (0...12).map do |index|
      tally(index: index).method(select_by).call(&block)[0]
    end.join.to_i(2)
  end

  def part_one
    rate(select_by: :max_by) * rate(select_by: :min_by)
  end

  def rating(select_by:, tie_breaker:)
    rating = ''
    block = proc { |_, v| v }
    (0...12).each do |index|
      tally = tally(index: index, input: @input.select { |i| i.start_with?(rating) })
      rating += if tally['0'] == tally['1']
                  tie_breaker
                else
                  tally.method(select_by).call(&block)[0]
                end
    end
    rating.to_i(2)
  end

  def part_two
    rating(select_by: :max_by, tie_breaker: '1') * rating(select_by: :min_by, tie_breaker: '0')
  end
end
