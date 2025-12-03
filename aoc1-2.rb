require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(1)

current_position = 50
times_dial_hit_zero = 0
input.split("\n").each do |direction|
  number = direction[1..-1].to_i
  old_pos = current_position
  if direction[0] == 'L'
    current_position -= number
    times_dial_hit_zero += ((old_pos - 1) / 100) - ((current_position - 1) / 100)
  else
    current_position += number
    times_dial_hit_zero += (current_position / 100) - (old_pos / 100)
  end
end

puts times_dial_hit_zero
