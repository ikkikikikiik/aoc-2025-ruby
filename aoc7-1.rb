require_relative 'Aoc.rb'
require 'set'

input = Aoc::get_input_for_day(7)

grid = input.each_line.map(&:chars)
current_beams = Set.new([grid[0].index('S')])
total_splits = 0

(0...grid.length - 1).each do |row|
  next_beams = Set.new
  current_beams.each do |column|
    target_cell = grid[row + 1][column]

    if target_cell == '^'
      total_splits += 1
      next_beams += [(column - 1), (column + 1)]
    else
      next_beams << column
    end
  end
  current_beams = next_beams
end

puts total_splits