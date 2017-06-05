require 'matrix'
require_relative 'lib/compute'
require_relative 'model/cell'

init_cell_matrix = ::Cell.init_cell_matrix(10, 10)
row_count = init_cell_matrix.row_count
column_count = init_cell_matrix.column_count

while true do
  row_count.times do |row|
    column_count.times do |col |
      output = ''
      output << (init_cell_matrix[row, col].status == ::Cell::LIVE ? '■ ' : '□ ')
      output << "\n" if col == column_count - 1
      print output
    end
  end
  puts "=================================="
  next_generation = Compute.get_next_generation(init_cell_matrix)
  init_cell_matrix = next_generation
  sleep(0.1)
end
