require_relative 'Aoc.rb'
require 'set'

input = Aoc::get_input_for_day(4)

rolls_set = Set.new
input.split("\n").each_with_index do |line, row_index|
  line.chars.each_with_index do |char, column_index|
    rolls_set.add([row_index, column_index]) if char == '@'
  end
end

def count_neighbors(row, column, map)
  adjacent_positions = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1], [0, 1],
    [1, -1], [1, 0], [1, 1]
  ]
  adjacent_positions.count do |delta_row, delta_column|
    map.include?([row + delta_row, column + delta_column])
  end
end

total_removable_rolls = 0
loop do
  rolls_to_keep = rolls_set.filter do |(row, column)|
    count_neighbors(row, column, rolls_set) >= 4
  end
  removable_rolls = rolls_set.size - rolls_to_keep.size
  rolls_set = Set.new(rolls_to_keep)
  break if removable_rolls == 0
  total_removable_rolls += removable_rolls
end

puts total_removable_rolls