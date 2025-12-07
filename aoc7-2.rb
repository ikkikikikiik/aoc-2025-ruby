require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(7)

grid = input.each_line.map(&:chars)
current_beams = {}
current_beams[grid[0].index('S')] = 1

(0...grid.length - 1).each do |row|
  next_beams = Hash.new(0)
  current_beams.each do |column, count|
    target_cell = grid[row + 1][column]

    if target_cell == '^'
      next_beams[column - 1] += count
      next_beams[column + 1] += count
    else
      next_beams[column] += count
    end
  end
  current_beams = next_beams
end

puts current_beams.values.sum