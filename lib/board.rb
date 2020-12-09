class Board
  attr_reader :cells

  def initialize
    @cells = {}
    generate_cells
  end

  def generate_cells
    letters = ["A", "B", "C", "D"]
    numbers = ["1", "2", "3", "4"]
    letters.each do |letter|
      numbers.each do |number|
        input = "#{letter}#{number}"
        @cells[input] = Cell.new(input)
      end
    end
  end

  def valid_coord?(coord)
    @cells.key?(coord)
  end

  def valid_placement?(ship, coords)
    if coords.length != ship.length
      return false
    end
    coord_num, coord_letter = seperate_coords(coords)
    counter = 1
    consecutive = 1
    coord_num.each do |num|
      if num + 1 == coord_num[counter]
        consecutive += 1
      end
      counter +=1
    end
    # require 'pry'; binding.pry
    if consecutive == ship.length
      return true
    else
      return false
    end
  end

  def seperate_coords(coords)
    coord_num = []
    coord_letter = []
    coords.each do |coord|
      coord_num  << coord.slice(1).to_i
      coord_letter << coord.slice(0).ord
    end
    return coord_num, coord_letter
  end
end
