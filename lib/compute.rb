require 'active_support/all'
module Compute
  PLUS = :+
  REDUCE = :-

  def self.get_next_generation(current_generation)
    row_count = current_generation.row_count
    column_count = current_generation.column_count
    row_count.times do |row|
      column_count.times do |col|
        neighbor_live_cells = (is_cell_in_normal_position?(row, col, row_count, column_count)) ?
            get_normal_neighbor_live_cells(row, col, current_generation) :
            get_border_neighbor_live_cells(row, col, row_count, column_count, current_generation)

        reset_cell_status(current_generation[row, col], neighbor_live_cells)
      end
    end
    current_generation
  end

  private

  def self.is_cell_in_normal_position?(row, col, row_count, column_count)
    row > 0 && row < row_count - 1 && col > 0 && col < column_count - 1
  end

  def self.get_border_neighbor_live_cells(row, col, row_count, column_count, current_generation)
    get_neighbor_cells(row, col, row_count,
                       column_count, current_generation).map { |cell| cell.try(:status) }
        .select { |status| status == ::Cell::LIVE }.size
  end


  def self.get_neighbor_cells(row, col, row_count, column_count, current_generation)
    if col != 0 && col != column_count-1
      operator = row == 0 ? PLUS : REDUCE
      [current_generation[row, col-1],
       current_generation[row, col+1],
       current_generation[row.send(operator.to_sym, 1), col-1],
       current_generation[row.send(operator.to_sym, 1), col],
       current_generation[row.send(operator.to_sym, 1), col+1]]
    elsif row != 0 && row != row_count-1
      operator = col == 0 ? PLUS : REDUCE
      [current_generation[row-1, col],
       current_generation[row+1, col],
       current_generation[row-1, col.send(operator, 1)],
       current_generation[row, col.send(operator, 1)],
       current_generation[row+1, col.send(operator, 1)]]
    else
      get_peak_neighbors(col, column_count, current_generation, row, row_count)
    end
  end

  def self.get_peak_neighbors(col, column_count, current_generation, row, row_count)
    {
        [0, 0] => [current_generation[row, col+1],
                   current_generation[row+1, col],
                   current_generation[row+1, col+1]],
        [0, column_count-1] => [current_generation[row, col-1],
                                  current_generation[row+1, col],
                                  current_generation[row+1, col+1]],
        [row_count-1, 0] => [current_generation[row, col+1],
                               current_generation[row-1, col],
                               current_generation[row-1, col+1]],
        [row_count-1, column_count-1] => [current_generation[row, col-1],
                                              current_generation[row-1, col],
                                              current_generation[row-1, col-1]]
    }[[row, col]]
  end

  def self.get_normal_neighbor_live_cells(row, col, current_generation)
    [current_generation[row-1, col-1],
     current_generation[row-1, col],
     current_generation[row-1, col+1],
     current_generation[row, col-1],
     current_generation[row, col+1],
     current_generation[row+1, col-1],
     current_generation[row+1, col],
     current_generation[row+1, col+1]].map { |cell| cell.try(:status) }.select { |status| status == ::Cell::LIVE }.size
  end

  def self.reset_cell_status(cell, neighbor_live_cells)
    # = 3 live
    # = 2 keep
    # < 2 > 3 dead
    if cell.status == ::Cell::LIVE
      if neighbor_live_cells < 2 || neighbor_live_cells > 3
        cell.status = ::Cell::DEAD
      end
    else
      cell.status = ::Cell::LIVE if neighbor_live_cells == 3
    end
  end
end


