require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(3)

joltage_sum = 0
digit_length = 12

input.split("\n").each do |line|
  joltage_values = line.chars.map(&:to_i)
  joltage_digits = []
  starting_pointer = 0
  ending_pointer = joltage_values.length - digit_length

  0.upto(digit_length - 1) do
    slice = joltage_values[starting_pointer..ending_pointer]
    biggest_value = slice.max
    starting_pointer = slice.index(biggest_value) + starting_pointer + 1
    ending_pointer = ending_pointer + 1
    joltage_digits << biggest_value
  end

  joltage_sum += joltage_digits.join.to_i
end

puts joltage_sum
