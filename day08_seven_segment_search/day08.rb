# https://adventofcode.com/2021/day/8
require_relative '../day'

class Day08 < Day
  def initialize
    super(folder: __dir__)
    @entries = @input.map { |line| Entry.new(line: line.split) }
  end

  def part_one
    @entries.sum(&:num_of_uniq_segment_numbers)
  end

  def part_two
    @entries.sum(&:output_num_value)
  end
end

class Entry
  def initialize(line:)
    delimiter_index = line.find_index('|')
    @hints = format_codes(line[0...delimiter_index])
    @output_values = format_codes(line[(delimiter_index + 1)..line.size])

    @conversion = {
      zero => 0,
      one => 1,
      two => 2,
      three => 3,
      four => 4,
      five => 5,
      six => 6,
      seven => 7,
      eight => 8,
      nine => 9
    }
  end

  def output_num_value
    @output_values.map { |x| @conversion[x] }.join.to_i
  end

  def zero
    select_by_segments(6).find { |x| !x.include?(middle_letter) }
  end

  def one
    decode(2)
  end

  def two
    select_by_segments(5).find do |x|
      x.include?(middle_letter) && !x.include?(top_left_letter) && x != three
    end
  end

  def three
    select_by_segments(5).find do |x|
      (one.chars - x.chars).empty?
    end
  end

  def four
    decode(4)
  end

  def five
    select_by_segments(5).find do |x|
      x.include?(middle_letter) && x.include?(top_left_letter) && x != three
    end
  end

  def six
    select_by_segments(6).find do |x|
      x.include?(middle_letter) && x != nine
    end
  end

  def seven
    decode(3)
  end

  def eight
    decode(7)
  end

  def nine
    select_by_segments(6).find do |x|
      x.include?(middle_letter) && (one.chars - x.chars).empty?
    end
  end

  def middle_letter
    ((three.chars & four.chars) - one.chars)[0]
  end

  def top_left_letter
    ((four.chars - one.chars - [middle_letter]))[0]
  end

  def num_of_uniq_segment_numbers
    # num 1s + num 4s + num 7s + num 8s
    num_occurances(2) + num_occurances(4) + num_occurances(3) + num_occurances(7)
  end

  private

  def num_occurances(num_segments)
    select_by_segments(num_segments, @output_values).size
  end

  def select_by_segments(num_segments, bank = @hints + @output_values)
    bank.select { |x| x.length == num_segments }
  end

  def decode(num_segments)
    (@hints + @output_values).find { |x| x.length == num_segments }
  end

  def format_codes(codes)
    codes.map { |x| x.chars.sort.join }
  end
end
