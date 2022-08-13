require './day01_sonar_sweep/main'
require './day02_dive/main'

Day.subclasses.each do |day|
  day.new.display
end
