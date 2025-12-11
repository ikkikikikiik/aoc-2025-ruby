require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(11)

graph = {}
input.each_line do |line|
  device, outputs = line.split(':')
  graph[device] = outputs.split
end

def count_paths(graph, current, target, visited_dac = false, visited_fft = false, memo = {})
  key = [current, visited_dac, visited_fft]
  return memo[key] if memo.key?(key)

  visited_dac = true if current == "dac"
  visited_fft = true if current == "fft"

  if current == target
    memo[key] = (visited_dac && visited_fft) ? 1 : 0
    return memo[key]
  end

  return memo[key] = 0 unless graph.key?(current)

  memo[key] = graph[current].sum do |neighbor|
    count_paths(graph, neighbor, target, visited_dac, visited_fft, memo)
  end
end

path_count = count_paths(graph, "svr", "out")
puts path_count