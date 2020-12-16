require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/display'

class Gametest < Minitest::Test

  def test_computer_can_get_random_coord
    game = Game.new

    coord = game.computer_get_random_coord

    assert_equal true, game.computer_board.cells_to_array.include?(coord)
  end

  def test_computer_can_place_ship
    game = Game.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    game.computer_place_ship(cruiser)
    game.computer_place_ship(submarine)

    assert_equal 5, game.computer_board.render(true).count("S")
  end

  def test_player_can_place_ship
    game = Game.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    display = Display.new
    game.player_place_ship(cruiser)
    game.player_place_ship(submarine)

    assert_equal 5, game.player_board.render(true).count("S")
  end

  def test_player_can_fire
    game = Game.new
    game.coord_to_fire_on
    game.coord_to_fire_on

    assert_equal 2, game.computer_board.render(true).count("M")
  end

  def test_computer_fires
    game = Game.new
    game.computer_fire

    assert_equal 1, game.player_board.render(true).count("M")
  end

  def test_clear_boards
    game = Game.new
    game.computer_fire
    game.computer_fire
    game.computer_fire

    game.clear_boards

    assert_equal 0, game.player_board.render(true).count("M")
  end

  def test_create_ships_no_arg
    game = Game.new

    cruiser, submarine = game.create_ships_default

    assert_equal "Cruiser", cruiser.name
    assert_equal "Sub", submarine.name
  end

  def test_create_ship_custom
    game = Game.new

    ship = game.create_ship_custom("Ship", 2)


    assert_equal "Ship", ship.name
    assert_equal 2, ship.length
  end

  def test_end_game
    game = Game.new

    game.create_ships_default

    assert_equal false, game.computer_win_condition
  end

  def test_get_coords
    game = Game.new
    cruiser, submarine = game.create_ships_default

    assert_equal ["A2", "A3"], game.get_coords_right(submarine, "A2")
    assert_equal ["B2", "C2"], game.get_coords_down(submarine, "B2")
    assert_equal ["B2", "B1"], game.get_coords_left(submarine, "B2")
    assert_equal ["B2", "A2"], game.get_coords_up(submarine, "B2")
  end

  def test_determine_hit_miss_sunk
    game = Game.new
    ship = game.create_ship_custom("Ship", 2)

    game.player_place_ship(ship)

    game.player_board.cells["A1"].fire_upon
    game.player_board.cells["A4"].fire_upon

    assert_equal "M", game.determine_hit_miss_sunk("A4", game.player_board)
  end

  def test_get_coord
    game = Game.new

    assert_equal "A3", game.get_right("A2")
    assert_equal "A1", game.get_left("A2")
    assert_equal "B1", game.get_up("A1")
    assert_equal "B1", game.get_down("C1")
  end


  def test_surrounding_coords
    game = Game.new
    ship = game.create_ship_custom("Ship", 2)
    game.player_board.cells["C3"].fire_upon

    assert_equal ["A3", "B4", "B2"], game.surrounding_coords("B3")
  end
end
