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

  def test_valid_placement_length?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)


    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])

  end

  def test_valid_placement_consecutive?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
  end

  def test_seperate_coords_num
    board = Board.new
    coords = ["A1", "A2", "A4"]
    coord_num, coord_letter = board.seperate_coords(coords)
    # require 'pry'; binding.pry

    assert_equal [1, 2, 4], coord_num
  end

  def test_seperate_coords_letter
    board = Board.new
    coords = ["A1", "A2", "A4"]
    coord_num, coord_letter = board.seperate_coords(coords)
    # require 'pry'; binding.pry

    assert_equal [65, 65, 65], coord_letter
  end
end
