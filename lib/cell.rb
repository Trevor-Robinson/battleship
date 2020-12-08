class Cell
    attr_reader :coord, :ship

  def initialize(coord)
    @coord = coord
    @ship
  end

  def empty?
    if @ship == nil
      return true
    else
      return false
    end
  end

  def place_ship(ship)
    @ship = ship
  end
end
