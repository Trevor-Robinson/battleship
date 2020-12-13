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

    assert_equal true, game.board.cells_to_array.include?(coord)

  end

  def test_computer_can_place_ship
    game = Game.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    game.computer_place_ship(cruiser)
    game.computer_place_ship(submarine)

    # puts game.board.render(true)

    assert_equal 5, game.board.render(true).count("S")
  end

  def test_it_starts

    game = Game.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    display = Display.new
    game.player_place_ship(cruiser)
    game.player_place_ship(submarine)


    puts game.board.render(true)

    assert_equal 5, game.board.render(true).count("S")
  end
end
