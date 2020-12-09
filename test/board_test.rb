require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class Boardtest < Minitest::Test

  def test_it_has_cells
    board = Board.new

    assert_equal 16, board.cells.length
  end
end
