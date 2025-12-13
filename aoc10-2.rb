require_relative 'Aoc'

input = Aoc::get_input_for_day(10)

total_presses = 0

input.each_line do |line|
  buttons = line.scan(/\(([^)]*)\)/).flatten.map { |s| s.split(',').map(&:to_i) }
  required_joltages = line[/\{([^}]*)}/, 1].split(',').map(&:to_i)

  width = buttons.size
  height = required_joltages.size
  rows = required_joltages.each_with_index.map do |joltage, index|
    buttons.map { |button| button.include?(index) ? 1 : 0 }.append(joltage)
  end

  row = 0
  pivot_columns = []
  free_columns = []

  (0...width).each do |column|
    pivot = -1

    (row...height).each do |i|
      if rows[i][column] != 0
        pivot = i
        break
      end
    end

    if pivot == -1
      free_columns << column
      next
    end

    rows[row], rows[pivot] = rows[pivot], rows[row]

    (row + 1...height).each do |i|
      value = rows[i][column]
      next if value == 0

      pivot_value = rows[row][column]
      (column...width + 1).each do |j|
        rows[i][j] = rows[i][j] * pivot_value - rows[row][j] * value
      end
    end

    pivot_columns << column
    row += 1
  end

  free_variable_bounds = free_columns.map do |column|
    min_joltage = Float::INFINITY
    buttons[column].each do |index|
      joltage = required_joltages[index]
      min_joltage = [min_joltage, joltage].min
    end
    min_joltage + 1
  end

  free_variable_combinations = free_variable_bounds.reduce(1) { |a, b| (a * b).to_i }

  free_variables = Array.new(free_columns.size, 0)
  minimum_presses = Float::INFINITY

  free_variable_combinations.times do
    solution = Array.new(width, 0)
    free_columns.each_with_index do |col, i|
      solution[col] = free_variables[i]
    end

    valid = true

    (pivot_columns.size - 1).downto(0) do |i|
      column = pivot_columns[i]
      joltage = rows[i][width]

      (column + 1...width).each do |j|
        joltage -= rows[i][j] * solution[j]
      end

      value = rows[i][column]
      if value == 0 || joltage % value != 0
        valid = false
        break
      end

      joltage /= value
      if joltage < 0
        valid = false
        break
      end

      solution[column] = joltage
    end

    (0...free_variables.size).each do |i|
      free_variables[i] += 1
      free_variables[i] == free_variable_bounds[i] ? free_variables[i] = 0 : break
    end

    next unless valid
    minimum_presses = [minimum_presses, solution.sum].min
  end

  total_presses += minimum_presses
end

puts total_presses
