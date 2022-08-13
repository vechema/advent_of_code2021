# https://adventofcode.com/2021/day/4
require_relative '../day'

class Day04 < Day
  def initialize
    super(folder: __dir__)
    @all_drawn_numbers = @input[0].split(',').map(&:to_i)
    board_row = 1
    @boards = []
    current_board = []
    @input[1..@input.size].each do |line|
      current_board << line.split.map(&:to_i)
      if board_row == 5
        board_row = 0
        @boards << current_board
        current_board = []
      end
      board_row += 1
    end
  end

  def play_bingo(player_win: true)
    indices_of_winning_boards = []
    # Must draw at least 4 numbers to find a winner
    (4...@all_drawn_numbers.size).each do |last_drawn_index|
      drawn_numbers = @all_drawn_numbers[0..last_drawn_index]

      @boards.each_with_index do |board, board_index|
        next if indices_of_winning_boards.include?(board_index)

        drawn_coordinates = []
        nondrawn_numbers = []
        board.each_with_index do |row, row_index|
          row.each_with_index do |value, column_index|
            if drawn_numbers.include?(value)
              drawn_coordinates << [row_index, column_index]
            else
              nondrawn_numbers << value
            end
          end
        end

        bingo_row = drawn_coordinates.map { |x| x[0] }.tally.value?(5)
        bingo_column = drawn_coordinates.map { |x| x[1] }.tally.value?(5)

        next unless bingo_row || bingo_column

        if player_win || indices_of_winning_boards.count == @boards.count - 1
          return nondrawn_numbers.sum * drawn_numbers.last
        end

        indices_of_winning_boards << board_index
      end
    end
  end

  def part_one
    play_bingo(player_win: true)
  end

  def part_two
    play_bingo(player_win: false)
  end
end
