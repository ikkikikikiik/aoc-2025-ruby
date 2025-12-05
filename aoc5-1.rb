require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(5)

fresh_id_ranges = []
fresh_items_count = 0
input.each_line do |id|
  if id.include?('-')
    fresh_id_ranges << id.split('-').map(&:to_i)
  else
    fresh_items_count += 1 if fresh_id_ranges.any? { |(start, finish)| id.to_i.between?(start, finish) }
  end
end

puts fresh_items_count
