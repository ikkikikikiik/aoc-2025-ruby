require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(5)

ranges_to_merge = []
input.each_line do |range|
  ranges_to_merge << range.split('-').map(&:to_i) if range.include?('-')
  break if range.empty?
end

sorted_ranges = ranges_to_merge.sort_by(&:first)
merged_ranges = []
merged_ranges << sorted_ranges.shift

sorted_ranges.each do |current_first, current_last|
  last_merged = merged_ranges.last
  if current_first <= last_merged.last
    last_merged[1] = [last_merged.last, current_last].max
  else
    merged_ranges << [current_first, current_last]
  end
end

total_count = 0
merged_ranges.each do |first, last|
  total_count += (last - first + 1)
end

puts total_count
