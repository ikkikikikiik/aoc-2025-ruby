require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(9)

tiles = input.lines
num_of_tiles = tiles.size

max_area = 0
(0...num_of_tiles).each do |i|
  (i...num_of_tiles).each do |j|
    next if i == j
    xi, yi = tiles[i].split(',').map(&:to_i)
    xj, yj = tiles[j].split(',').map(&:to_i)
    length = (xi - xj).abs + 1
    width = (yi - yj).abs + 1
    max_area = [max_area, length * width].max
  end
end

puts max_area
