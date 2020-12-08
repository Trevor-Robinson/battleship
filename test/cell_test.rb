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

  def test_fired_upon?
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    cell.place_ship(cruiser)

    assert_equal false, cell.fired_upon?
  end

  def test_it_can_be_fired_upon
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    cell.place_ship(cruiser)
    cell.fire_upon

    assert_equal true, cell.fired_upon?
  end

  def test_render_not_fired_upon
    cell = Cell.new("B4")

    assert_equal '.', cell.render
  end

  def test_render_fired_upon_no_ship
    cell = Cell.new("B4")

    cell.fire_upon

    assert_equal 'M', cell.render
  end

  def test_render_fired_upon_with_ship
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    cell.place_ship(cruiser)

    assert_equal 'S', cell.render(true)
  end

  def test_render_fired_upon_with_ship_not_sunk
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    cell.place_ship(cruiser)
    cell.fire_upon

    assert_equal 'H', cell.render()
  end

  def test_render_fired_upon_with_ship_sunk
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    cell.place_ship(cruiser)
    cell.fire_upon
    cell.fire_upon
    cell.fire_upon

    assert_equal 'X', cell.render()
  end
end
