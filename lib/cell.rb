class Cell
    attr_reader :coord, :ship

  def initialize(coord)
    @coord = coord
    @ship
    @fired = false
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

  def fired_upon?
    return @fired
  end

  def fire_upon
    @fired = true
    if empty? == false
      @ship.hit
    end

  end

  def render(ship = false)
    if @fired == false && @ship != nil && ship == true
      return 'S'
    elsif @fired == true && @ship == nil
      return 'M'
    elsif @fired == true && @ship != nil && !@ship.sunk?
      return "H"
    elsif @fired == true && @ship != nil && @ship.sunk?
      return "X"
    else
      return '.'
    end
  end
end
