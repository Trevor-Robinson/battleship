require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/display'

class Gametest < Minitest::Test

  def test_computer_can_get_random_coord
    skip
    game = Game.new

    coord = game.computer_get_random_coord

    assert_equal true, game.computer_board.cells_to_array.include?(coord)

  end

  def test_computer_can_place_ship
    skip
    game = Game.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    game.computer_place_ship(cruiser)
    game.computer_place_ship(submarine)

    assert_equal 5, game.computer_board.render(true).count("S")
  end

  def test_it_starts
    skip
    game = Game.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    display = Display.new
    game.player_place_ship(cruiser)
    game.player_place_ship(submarine)

    assert_equal 5, game.player_board.render(true).count("S")
  end

  def test_player_fires
     skip
    game = Game.new
    game.coord_to_fire_on
    game.coord_to_fire_on


    puts game.computer_board.render
    assert_equal 2, game.computer_board.render(true).count("M")
  end

  def test_computer_fires
    skip
    game = Game.new
    game.computer_fire

    puts game.player_board.render
    assert_equal 1, game.player_board.render(true).count("M")
  end
  def test_take_turn
    skip
    game = Game.new
    cruiser = Ship.new("Cruiser", 3)
    game.player_board.place(cruiser, ["A1", "A2", "A3"])

    game.take_turn
  end

  def test_determine_hit_miss_sunk
    skip
    game = Game.new


    puts game.determine_hit_miss_sunk(game.computer_fire, game.player_board)

  end

  def test_it_plays_game
    game = Game.new
    game.play_game

    # puts game.computer_board.render(true)
    # puts game.player_board.render(true)

  end
end
