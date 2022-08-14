# https://adventofcode.com/2021/day/9
require_relative '../day'

class Day09 < Day
  def initialize
    super(folder: __dir__)
    @height_map = HeightMap.new(rows: @input)
  end

  def part_one
    @height_map.low_points.map { |x| x + 1 }.sum
  end

  def part_two
    @height_map.basin_sizes.max(3).inject(:*)
  end
end

class HeightMap
  def initialize(rows:)
    @height_map = rows.map do |row|
      row.chars.map(&:to_i)
    end
  end

  def neighbor_coordinates(row:, column:)
    [
      [row + 1, column],
      [row - 1, column],
      [row, column + 1],
      [row, column - 1]
    ].select { |r, c| r >= 0 && c >= 0 }
      .select { |r, c| r < @height_map.length && c < @height_map[0].length }
  end

  def neighbors(row:, column:)
    neighbor_coordinates(row: row, column: column).map { |x, y| @height_map[x][y] }
  end

  def low_coordinates
    low_coordinates = []
    @height_map.each_with_index do |row, row_index|
      row.each_with_index do |value, column_index|
        neighbors = neighbors(row: row_index, column: column_index)
        if (neighbors + [value]).min == value && (neighbors + [value]).tally[value] == 1
          low_coordinates << [row_index, column_index]
        end
      end
    end

    low_coordinates
  end

  def low_points
    low_coordinates.map { |x, y| @height_map[x][y] }
  end

  def basin_sizes
    basin_sizes = []
    low_coordinates.each do |x, y|
      already_explored = [[x, y]]
      size = 1
      to_explore = [[x, y]]
      until to_explore.empty?
        current = to_explore.shift
        neighbor_coordinates = neighbor_coordinates(row: current[0], column: current[1])
        neighbor_coordinates.each do |neighbor_coordinate|
          if already_explored.include?(neighbor_coordinate) ||
             @height_map[neighbor_coordinate[0]][neighbor_coordinate[1]] == 9
            next
          end

          to_explore << neighbor_coordinate
          already_explored << neighbor_coordinate
          size += 1
        end
      end
      basin_sizes << size
    end

    basin_sizes
  end
end
