require_relative 'Aoc.rb'
require 'set'

input = Aoc::get_input_for_day(4)

rolls_set = Set.new
input.split("\n").each_with_index do |line, row_index|
  line.chars.each_with_index do |char, column_index|
    rolls_set.add([row_index, column_index]) if char == '@'
  end
end

accessible_rolls = 0

rolls_set.each do |(row, column)|
  adjacent_positions = [
    [row - 1, column - 1], [row - 1, column], [row - 1, column + 1],
    [row, column - 1], [row, column + 1],
    [row + 1, column - 1], [row + 1, column], [row + 1, column + 1]
  ]
  adjacent_rolls = 0
  adjacent_positions.each do |(adj_row, adj_column)|
    adjacent_rolls += 1 if rolls_set.include?([adj_row, adj_column])
  end
  accessible_rolls += 1 if adjacent_rolls < 4
end

puts accessible_rolls