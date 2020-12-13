require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/display'

class Displaytest < Minitest::Test

  def test_displays_correct_board
    game = Game.new
    display = Display.new

    @game.board.render
  end
end
