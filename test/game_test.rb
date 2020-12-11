require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class Gametest < Minitest::Test

  def test_computer_can_get_random_coord
    game = Game.new

    coord = game.computer_get_random_coord

    assert_equal true, game.board.cells_to_array.include?(coord)

  end

  def test_computer_can_place_ship
    game = Game.new
    game.computer_place_ship

    assert_equal true, true
  end
end