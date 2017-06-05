class Cell
  LIVE = 'LIVE'
  DEAD = 'DEAD'
  attr_accessor :status

  def initialize(init_status)
    @status = init_status
  end

  def self.init_cell_matrix(width, height)
    ::Matrix.build(width, height) do
      new [LIVE, DEAD].sample
    end
  end

end