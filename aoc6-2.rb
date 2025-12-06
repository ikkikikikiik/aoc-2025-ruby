require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(6)

def width_of_each_problem(line_of_operators)
  length = 1
  line_of_operators.chars.each_with_object([]) do |char, widths|
    char == ' ' ? length += 1 : (widths << length if length > 0; length = 0)
  end
end

lines = input.reverse.each_line.to_a
operators_line_reversed = lines[1]
problem_widths = width_of_each_problem(operators_line_reversed)
operators = operators_line_reversed.split(' ')
problems = []

lines[2..].each do |line|
  number_start = -1
  problem_widths.each_with_index do |problem_width, problem_index|
    break if number_start >= line.length
    number_end = number_start + problem_width
    number_start += 1
    (problems[problem_index] ||= []) << line[number_start..number_end]
    number_start = number_end + 1
  end
end

grand_total = 0
problems.each_with_index do |problem, problem_index|
  grand_total += problem
                   .map(&:chars)
                   .transpose
                   .map(&:join)
                   .map(&:reverse)
                   .map(&:to_i)
                   .reduce(operators[problem_index])
end

puts grand_total
