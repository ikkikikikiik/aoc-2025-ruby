require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(2)

def repeating_pattern?(number)
  s = number.to_s
  return false if s.length.odd?
  half = s.length / 2
  s[0...half] == s[half..-1]
end

invalid_numbers_sum = 0

input.split(",").each do |line|
  num1, num2 = line.split('-').map(&:to_i)
  (num1..num2).each do |number|
    invalid_numbers_sum += number if repeating_pattern?(number)
  end
end

puts invalid_numbers_sum
