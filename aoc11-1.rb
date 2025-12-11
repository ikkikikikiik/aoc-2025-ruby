require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(11)

graph = {}
input.each_line do |line|
  device, outputs = line.split(':')
  graph[device] = outputs.split
end

def count_paths(graph, current, target)
  return 1 if current == target
  graph[current].sum { |neighbor| count_paths(graph, neighbor, target) }
end

path_count = count_paths(graph, "you", "out")
puts path_count