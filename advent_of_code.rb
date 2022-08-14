require './day01_sonar_sweep/day01'
require './day02_dive/day02'
require './day03_binary_diagnostic/day03'
require './day04_giant_squid/day04'
require './day05_hydrothermal_venture/day05'
require './day06_lanternfish/day06'
require './day07_the_treachery_of_whales/day07'
require './day08_seven_segment_search/day08'
require './day09_smoke_basin/day09'

Day.subclasses.each do |day|
  day.new.display
end
