require './day01_sonar_sweep/day01'
require './day02_dive/day02'
require './day03_binary_diagnostic/day03'
require './day04_giant_squid/day04'
require './day05_hydrothermal_venture/day05'
require './day06_lanternfish/day06'

Day.subclasses.each do |day|
  day.new.display
end
