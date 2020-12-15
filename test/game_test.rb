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
    skip
    game = Game.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    display = Display.new
    game.player_place_ship(cruiser)
    game.player_place_ship(submarine)

    assert_equal 5, game.player_board.render(true).count("S")
  end

  def test_player_can_fire
    skip
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

  def test_create_ships
    game = Game.new

    cruiser, submarine = game.create_ships

    assert_equal "Cruiser", cruiser.name
    assert_equal "Sub", submarine.name
  end

  def test_end_game
    game = Game.new

    p_cruiser, p_submarine = game.create_ships
    h_cruiser, h_submarine = game.create_ships

    p_cruiser.hit
    p_cruiser.hit
    p_cruiser.hit
    p_submarine.hit
    p_submarine.hit

    p_cruiser.sunk?
    p_submarine.sunk?

    assert_equal true, game.end_game(p_cruiser, p_submarine, h_cruiser, h_submarine)
  end

  def test_get_coords
    game = Game.new
    cruiser, submarine = game.create_ships

    assert_equal ["A2", "A3"], game.get_coords_right(submarine, "A2")
    assert_equal ["B2", "C2"], game.get_coords_down(submarine, "B2")
    assert_equal ["B2", "B1"], game.get_coords_left(submarine, "B2")
    assert_equal ["B2", "A2"], game.get_coords_up(submarine, "B2")
  end
end
