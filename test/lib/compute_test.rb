require 'test_helper'
class ComputeTest < Minitest::Test
  def setup
    @current_generation = ::Matrix.build(10) { ::Cell.new(::Cell::DEAD) }
  end

  def test_cell_will_be_dead_when_less_than_two_live_cells_given_live_cell_in_normal_position
    @current_generation[2, 3].status = ::Cell::LIVE
    next_generation_cell_matrix = ::Compute.get_next_generation(@current_generation)
    assert_equal next_generation_cell_matrix[2, 3].status, ::Cell::DEAD
  end

  def test_cell_will_be_dead_when_more_than_three_live_cells_given_live_cell_in_normal_position
    @current_generation[1, 1].status = ::Cell::LIVE
    @current_generation[1, 2].status = ::Cell::LIVE
    @current_generation[1, 3].status = ::Cell::LIVE
    @current_generation[2, 1].status = ::Cell::LIVE
    @current_generation[2, 2].status = ::Cell::LIVE
    next_generation_cell_matrix = ::Compute.get_next_generation(@current_generation)

    assert_equal ::Cell::DEAD, next_generation_cell_matrix[1, 1].status
    assert_equal ::Cell::DEAD, next_generation_cell_matrix[1, 2].status
    assert_equal ::Cell::LIVE, next_generation_cell_matrix[1, 3].status
    assert_equal ::Cell::LIVE, next_generation_cell_matrix[2, 1].status
    assert_equal ::Cell::LIVE, next_generation_cell_matrix[2, 2].status

  end

  def test_cell_will_be_dead_when_less_than_two_live_cells_given_live_cell_in_border_position
    @current_generation[0, 0].status = ::Cell::LIVE
    @current_generation[0, 9].status = ::Cell::LIVE
    @current_generation[9, 0].status = ::Cell::LIVE
    @current_generation[9, 9].status = ::Cell::LIVE
    @current_generation[0, 4].status = ::Cell::LIVE
    @current_generation[9, 4].status = ::Cell::LIVE

    next_generation_cell_matrix = ::Compute.get_next_generation(@current_generation)

    assert_equal ::Cell::DEAD, next_generation_cell_matrix[0, 0].status
    assert_equal ::Cell::DEAD, next_generation_cell_matrix[0, 9].status
    assert_equal ::Cell::DEAD, next_generation_cell_matrix[9, 0].status
    assert_equal ::Cell::DEAD, next_generation_cell_matrix[9, 9].status
    assert_equal ::Cell::DEAD, next_generation_cell_matrix[0, 4].status
    assert_equal ::Cell::DEAD, next_generation_cell_matrix[9, 4].status
  end
end