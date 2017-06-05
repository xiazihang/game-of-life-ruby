require 'test_helper'
class CellTest < Minitest::Test
  MATRIX_WIDTH = 10
  MATRIX_HEIGHT = 10

  def test_cell_init_status
    @cell_matrix = ::Cell.new(::Cell::LIVE)
    assert_equal ::Cell::LIVE, @cell_matrix.status
  end

  def test_generate_cell_matrix_with_random_status
    cell_matrix = Cell.init_cell_matrix(MATRIX_WIDTH, MATRIX_HEIGHT)
    assert_equal MATRIX_HEIGHT, cell_matrix.row_count
    assert_equal MATRIX_WIDTH, cell_matrix.column_count
    assert_instance_of Cell, cell_matrix[rand(MATRIX_WIDTH - 1), rand(MATRIX_HEIGHT - 1)]
  end

end