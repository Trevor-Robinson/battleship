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

  def cells_to_array
    @cells.keys
  end

  def get_random_coord
    cells_to_array.sample
  end

  def check_random_coord(coord)
    if @cells[coord].empty? == true
      return true
    else
      return false
    end
  end

  def return_valid_random_coord
    random_coord = get_random_coord

    until check_random_coord(random_coord)
      random_coord = get_random_coord
    end
    return random_coord
  end

  def valid_coord?(coord)
    @cells.key?(coord)
  end

  def valid_placement?(ship, coords)
    return false if coords.length != ship.length

    coords.each do |coord|
      return false if !valid_coord?(coord)
      return false if !@cells[coord].empty?
    end

    coord_num, coord_letter = seperate_coords(coords)

    consecutive_num = check_consecutive_num(coord_num)
    consecutive_letter = check_consecutive_letter(coord_letter)
    consecutive_num_decrease = check_consecutive_num_decrease(coord_num)
    consecutive_letter_decrease = check_consecutive_letter_decrease(coord_letter)

    same_num = check_num_same(coord_num)
    same_letter = check_letter_same(coord_letter)

    if (consecutive_num == ship.length && same_letter == ship.length) ||
      (consecutive_letter == ship.length && same_num == ship.length) ||
      (consecutive_num_decrease == ship.length  && same_letter == ship.length) ||
      (consecutive_letter_decrease == ship.length  && same_num == ship.length)
      return true
    else
      return false
    end
  end

  def place(ship, coords)
    coords.each do |coord|
     @cells[coord].place_ship(ship)
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

  def check_consecutive_num(coord_num)
    counter = 1
    consecutive_num = 1
    coord_num.each do |num|
      if num + 1 == coord_num[counter]
        consecutive_num += 1
      end
      counter +=1
    end
    return consecutive_num
  end

  def check_consecutive_num_decrease(coord_num)
    counter = 1
    consecutive_num_decrease = 1
    coord_num.reverse!
    coord_num.each do |num|
      if num + 1 == coord_num[counter]
        consecutive_num_decrease += 1
      end
      counter +=1
    end
    return consecutive_num_decrease
  end


  def check_consecutive_letter(coord_letter)
    counter = 1
    consecutive_letter = 1
    coord_letter.each do |letter|
      if letter + 1 == coord_letter[counter]
        consecutive_letter += 1
      end
      counter +=1
    end
    return consecutive_letter
  end

  def check_consecutive_letter_decrease(coord_letter)
    counter = 1
    consecutive_letter_decrease = 1
    coord_letter.reverse!
    coord_letter.each do |letter|
      if letter + 1 == coord_letter[counter]
        consecutive_letter_decrease += 1
      end
      counter +=1
    end
    return consecutive_letter_decrease
  end

  def check_num_same(coord_num)
    counter = 1
    same_num = 1
    coord_num.each do |num|
      if num == coord_num[counter]
        same_num += 1
      end
      counter +=1
    end
    return same_num
  end

  def check_letter_same(coord_letter)
    counter = 1
    same_letter = 1
    coord_letter.each do |letter|
      if letter == coord_letter[counter]
        same_letter += 1
      end
      counter +=1
    end
    return same_letter
  end

  def render(ship=false)
    board = "  1 2 3 4 "
    counter = 0
    @cells.each do |coords, cell|
      if counter % 4 == 0
        board += "\n#{coords[0]}"
      end
      board += " " + cell.render(ship)
      counter += 1
    end

    return board
  end
end
