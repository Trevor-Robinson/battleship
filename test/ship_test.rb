require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class Shiptest < Minitest::Test

  def test_it_has_name
    cruiser = Ship.new("Cruiser", 3)

    assert_equal "Cruiser", cruiser.name
  end

  def test_it_has_length
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 3, cruiser.length
  end

  def test_it_has_health
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 3, cruiser.health
  end

  def test_it_can_be_sunk
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, cruiser.sunk?
  end

  def test_it_can_be_hit
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit

    assert_equal 2, cruiser.health
  end
end
