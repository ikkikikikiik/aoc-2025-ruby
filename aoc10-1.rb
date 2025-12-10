require_relative 'Aoc.rb'

input = Aoc::get_input_for_day(10)

input_lines = input.lines

presses = []
input_lines.map do |line|
  diagram_str = line.match(/\[(.*?)\]/)[1] || ''
  button_strs = line.scan(/\((.*?)\)/).flatten

  target = 0
  diagram_str.chars.each_with_index do |char, i|
    target |= (1 << i) if char == '#'
  end

  buttons = button_strs.map do |button|
    mask = 0
    button.split(',').each { |index| mask |= (1 << index.to_i) }
    mask
  end

  queue = [[0, 0]]
  visited = { 0 => true }

  until queue.empty?
    current_state, press_count = queue.shift
    if current_state == target
      presses << press_count
      break
    end

    buttons.each do |btn|
      next_i = current_state ^ btn
      unless visited[next_i]
        visited[next_i] = true
        queue << [next_i, press_count + 1]
      end
    end
  end
end

puts presses.sum
