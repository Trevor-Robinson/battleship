require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class Celltest < Minitest::Test
  def test_has_coord
    cell = Cell.new("B4")

    assert_equal "B4", cell.coord
  end

  def test_has_ship
    cell = Cell.new("B4")

    assert_nil cell.ship
  end

  def test_is_empty_true?
    cell = Cell.new("B4")

    assert_equal true, cell.empty?
  end

  def test_is_empty_false?
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    cell.place_ship(cruiser)

    assert_equal false, cell.empty?
  end

  def test_can_place_ship
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
  end
end
