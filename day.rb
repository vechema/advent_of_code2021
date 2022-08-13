class Day
  @subclasses = []
  class << self
    attr_reader :subclasses
  end

  def self.inherited(subclass)
    subclasses << subclass
    super
  end

  def initialize(folder:)
    @input = File.readlines("#{folder}/input", chomp: true).flat_map(&:lines)
  end

  def display
    puts self.class.name.to_s
    puts "  Part one: #{part_one}"
    puts "  Part two: #{part_two}"
  end
end
