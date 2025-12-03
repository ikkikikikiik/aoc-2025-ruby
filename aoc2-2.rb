require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(2)

def repeating_pattern?(number)
  num_s = number.to_s
  num_length = num_s.length
  return false if num_length <= 1
  1.upto(num_length / 2) do |len|
    next unless num_length % len == 0
    seed = num_s[0, len]
    expected_s = seed * (num_length / len)
    return true if num_s == expected_s
  end
  false
end

invalid_numbers_sum = 0

input.split(",").each do |line|
  num1, num2 = line.split('-').map(&:to_i)
  (num1..num2).each do |number|
    invalid_numbers_sum += number if repeating_pattern?(number)
  end
end

puts invalid_numbers_sum
