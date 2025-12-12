require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(12)

blocks = input.split("\n\n") || []
regions = blocks.pop.lines

shapes = []
blocks.each { |block| shapes[block.to_i] = block.count('#') }
how_many_regions_fit_all_presents = regions.count do |line|
  dimensions, counts = line.split(':')
  region_size = dimensions.split('x').map(&:to_i).reduce(:*)
  presents_size = counts.split.map.with_index { |count, i| shapes[i] * count.to_i }.sum
  region_size >= presents_size
end

puts how_many_regions_fit_all_presents
