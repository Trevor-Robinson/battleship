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

  def test_valid_coord?
    board = Board.new

    assert_equal true, board.valid_coord?("B3")
  end

  def test_invalid_coord?
    board = Board.new

    assert_equal false, board.valid_coord?("E4")
  end
end
