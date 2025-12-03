require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(1)

current_position = 50
times_dial_hit_zero = 0
input.split("\n").each do |direction|
  number = direction[1..-1].to_i % 100
  if direction[0] == 'L'
    current_position -= number
    current_position = current_position + 100 if current_position < 0
  else
    current_position += number
    current_position = current_position - 100 if current_position > 99
  end
  times_dial_hit_zero += 1 if current_position == 0
end

puts times_dial_hit_zero
