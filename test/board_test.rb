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

  def test_valid_placement_consecutive_num?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
  end

  def test_valid_placement_consecutive_letter?
    board = Board.new
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
  end

  def test_valid_placement_diagonal?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
  end

  def test_valid_placement_true?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_valid_placement_true_for_sub?
    board = Board.new
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
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

  def test_same_coords_number
    board = Board.new
    coords = ["A1", "B1", "C1"]
    coord_num, coord_letter = board.seperate_coords(coords)

    assert_equal 3, board.check_num_same(coord_num)
  end

  def test_same_coords_letter
    board = Board.new
    coords = ["A2", "A3", "A4"]
    coord_num, coord_letter = board.seperate_coords(coords)

    assert_equal 3, board.check_letter_same(coord_letter)
  end

  def test_it_can_place_a_ship_in_cells
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    # require 'pry'; binding.pry

    assert_equal true,  board.cells["A1"].ship == board.cells["A3"].ship
  end

  def test_valid_placement_full?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end
end
