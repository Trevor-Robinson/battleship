require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
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
    board.cells_to_array

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

  def test_valid_placement_decrease?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.valid_placement?(cruiser, ["A3", "A2", "A1"])

    assert_equal true, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
  end

  def test_seperate_coords_num
    board = Board.new
    coords = ["A1", "A2", "A4"]
    coord_num, coord_letter = board.seperate_coords(coords)

    assert_equal [1, 2, 4], coord_num
  end

  def test_seperate_coords_letter
    board = Board.new
    coords = ["A1", "A2", "A4"]
    coord_num, coord_letter = board.seperate_coords(coords)

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

    assert_equal true,  board.cells["A1"].ship == board.cells["A3"].ship
  end

  def test_valid_placement_full?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_render_no_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    expected_board = "  1 2 3 4 \n" +
                     "A . . . .\n" +
                     "B . . . .\n" +
                     "C . . . .\n" +
                     "D . . . ."

      assert_equal expected_board, board.render()
  end

  def test_render_ship_invisible
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    expected_board = "  1 2 3 4 \n" +
                     "A . . . .\n" +
                     "B . . . .\n" +
                     "C . . . .\n" +
                     "D . . . ."

    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal expected_board, board.render()
  end

  def test_render_ship_visible
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    expected_board = "  1 2 3 4 \n" +
                     "A S S S .\n" +
                     "B . . . .\n" +
                     "C . . . .\n" +
                     "D . . . ."

    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal expected_board, board.render(true)
  end

  def test_board_can_be_fired_upon
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.cells["A1"].fire_upon

    expected_board = "  1 2 3 4 \n" +
                     "A H S S .\n" +
                     "B . . . .\n" +
                     "C . . . .\n" +
                     "D . . . ."
      assert_equal expected_board, board.render(true)
  end

  def test_board_can_fire_and_miss
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.cells["A1"].fire_upon
    board.cells["B1"].fire_upon

    expected_board = "  1 2 3 4 \n" +
                     "A H S S .\n" +
                     "B M . . .\n" +
                     "C . . . .\n" +
                     "D . . . ."
      assert_equal expected_board, board.render(true)
    end

    def test_it_can_display_sunk_ship
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      board.place(cruiser, ["A1", "A2", "A3"])
      board.place(submarine, ["C2", "D2"])
      board.cells["A1"].fire_upon
      board.cells["B1"].fire_upon
      board.cells["C2"].fire_upon
      board.cells["D2"].fire_upon

      expected_board = "  1 2 3 4 \n" +
                       "A H S S .\n" +
                       "B M . . .\n" +
                       "C . X . .\n" +
                       "D . X . ."

      assert_equal expected_board, board.render(true)
    end

    def test_random_coord_methods
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      random = board.return_valid_random_coord

      assert_equal true, board.cells.include?(random)
    end
end
