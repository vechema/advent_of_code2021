require './day01_sonar_sweep/day01'
require './day02_dive/day02'
require './day03_binary_diagnostic/day03'

Day.subclasses.each do |day|
  day.new.display
end
