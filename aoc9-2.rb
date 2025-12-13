require_relative 'Aoc.rb'
require 'set'

input = Aoc::get_input_for_day(9)

points = input.lines.map { |line| line.split(',').map(&:to_i) }

all_x = points.map(&:first)
all_y = points.map(&:last)
uniq_x = all_x.uniq.sort
uniq_y = all_y.uniq.sort

x_map = {}
y_map = {}
uniq_x.each_with_index { |x, i| x_map[x] = i }
uniq_y.each_with_index { |y, i| y_map[y] = i }

width = uniq_x.size
height = uniq_y.size
grid = Array.new(height) { Array.new(width, '.') }

red_tiles = points.map do |x, y|
  grid[y_map[y]][x_map[x]] = '#'
  [x_map[x], y_map[y]]
end

n = points.size
(0...n).each do |i|
  a = red_tiles[i]
  b = red_tiles[(i + 1) % n]

  if a[0] == b[0]
    y0, y1 = [a[1], b[1]].minmax
    (y0..y1).each { |y| grid[y][a[0]] = '#' }
  else
    x0, x1 = [a[0], b[0]].minmax
    (x0..x1).each { |x| grid[a[1]][x] = '#' }
  end
end

def find_inside_point(grid)
  height = grid.size
  width = grid[0].size

  (0...height).each do |y|
    (0...width).each do |x|
      next unless grid[y][x] == '.'

      hits_left = 0
      previous = '.'

      x.downto(0) do |i|
        current = grid[y][i]
        hits_left += 1 if current != previous
        previous = current
      end
      return [x, y] if hits_left.odd?
    end
  end
end

def flood_fill(grid, start_x, start_y)
  stack = [[start_x, start_y]]
  dirs = [[0, 1], [0, -1], [1, 0], [-1, 0]]

  until stack.empty?
    x, y = stack.pop

    next unless grid[y][x] == '.'

    grid[y][x] = 'X'

    dirs.each do |dx, dy|
      nx = x + dx
      ny = y + dy
      is_inbound = ny >= 0 && ny < grid.size && nx >= 0 && nx < grid[0].size
      stack.push([nx, ny]) if is_inbound && grid[ny][nx] == '.'
    end
  end
end

inside_point = find_inside_point(grid)
flood_fill(grid, inside_point[0], inside_point[1])

def enclosed?(a, b, grid, x_map, y_map)
  x1_index = x_map[a[0]]
  x2_index = x_map[b[0]]
  y1_index = y_map[a[1]]
  y2_index = y_map[b[1]]

  x_min, x_max = [x1_index, x2_index].sort
  y_min, y_max = [y1_index, y2_index].sort

  (x_min..x_max).each do |x|
    return false if grid[y_min][x] == '.'
  end

  (x_min..x_max).each do |x|
    return false if grid[y_max][x] == '.'
  end

  (y_min..y_max).each do |y|
    return false if grid[y][x_min] == '.'
  end

  (y_min..y_max).each do |y|
    return false if grid[y][x_max] == '.'
  end

  true
end

max_area = 0
(0...points.size).each do |i|
  (i + 1...points.size).each do |j|
    a = points[i]
    b = points[j]

    next if a[0] == b[0] || a[1] == b[1]

    if enclosed?(a, b, grid, x_map, y_map)
      width = (a[0] - b[0]).abs + 1
      height = (a[1] - b[1]).abs + 1
      area = width * height
      max_area = [area, max_area].max
    end
  end
end

puts max_area
