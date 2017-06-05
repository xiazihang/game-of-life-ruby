require_relative 'lib/compute'
require_relative 'model/cell'

Compute.get_next_generation(Cell.init_cell_matrix(10, 10))