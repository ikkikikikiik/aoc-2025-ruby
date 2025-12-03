require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(3)

joltage_sum = 0
input.split("\n").each do |line|
  joltage_values = line.chars.map(&:to_i)
  tens_place_index = joltage_values[0..-2].index(joltage_values[0..-2].max)
  tens_place = joltage_values[tens_place_index]
  rest_of_array_max = joltage_values[tens_place_index + 1..-1].max
  joltage_sum += tens_place * 10 + rest_of_array_max
end

puts joltage_sum
