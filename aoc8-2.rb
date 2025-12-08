require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(8)

coordinates_x_y_z = input.lines.map { |line| line.split(',').map(&:to_i) }
num_of_coordinates = coordinates_x_y_z.length

edges = []
(0...num_of_coordinates).each do |coordinate_i|
  xi, yi, zi = coordinates_x_y_z[coordinate_i]
  (coordinate_i + 1...num_of_coordinates).each do |coordinate_j|
    xj, yj, zj = coordinates_x_y_z[coordinate_j]
    dx = xi - xj
    dy = yi - yj
    dz = zi - zj
    distance_squared = dx * dx + dy * dy + dz * dz
    edges << [distance_squared, coordinate_i, coordinate_j]
  end
end

edges = edges.sort_by { |edge| edge[0] }

parent = (0...num_of_coordinates).to_a
size = Array.new(num_of_coordinates, 1)

def find_root(parent, index)
  while parent[index] != index
    parent[index] = parent[parent[index]]
    index = parent[index]
  end
  index
end

def unite(parent, size, coordinate_i, coordinate_j)
  root_i = find_root(parent, coordinate_i)
  root_j = find_root(parent, coordinate_j)
  return false if root_i == root_j

  root_i, root_j = root_j, root_i if size[root_i] < size[root_j]
  parent[root_j] = root_i
  size[root_i] += size[root_j]
  size[root_j] = 0
  true
end

last_i, last_j = 0
count = num_of_coordinates
edges.each do |_, i, j|
  next unless unite(parent, size, i, j)
  count -= 1
  if count == 1
    last_i, last_j = i, j
    break
  end
end

puts coordinates_x_y_z[last_i][0] * coordinates_x_y_z[last_j][0]
