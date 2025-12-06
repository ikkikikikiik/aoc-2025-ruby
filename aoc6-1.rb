require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(6)

problems = []
input.each_line do |line|
  line.split(' ').each_with_index do |number, number_index|
    (problems[number_index] ||= []) << number
  end
end

grand_total = 0
problems.each do |problem|
  operator = problem.last
  grand_total += problem[..-2].map(&:to_i).reduce(operator)
end

puts grand_total