require './lib/board'
require './lib/ship'

class Game
  attr_reader :board
  def initialize
    @board = Board.new
  end

  def computer_get_random_coord
    coords = @board.cells_to_array
    coords.sample
  end

  def computer_place_ship
    cruiser = Ship.new("cruiser", 3)

    coords = []
    number_of_loops = cruiser.length - 1
    number_of_loops.times do |num|
      new_letter = (letter_coord.ord += num + 1).chr

      # Seperate into two helper methods: letter increment and number increment
    end
  end

  def split_random_coord
    letter_coord, num_coord = computer_get_random_coord.split('')
  end

  def get_coords_right(ship)
    letter_coord, num_coord = split_random_coord
    new_coords = ["#{letter_coord}#{num_coord}"]
    number_of_loops = ship.length - 1
    number_of_loops.times do |num|
      new_num = num_coord.to_i + num + 1
      new_coords << "#{letter_coord}#{new_num}"
    end

    return new_coords
  end

  def get_coords_left(ship)
    letter_coord, num_coord = split_random_coord
    new_coords = ["#{letter_coord}#{num_coord}"]
    number_of_loops = ship.length - 1
    number_of_loops.times do |num|
      new_num = num_coord.to_i - num - 1
      new_coords << "#{letter_coord}#{new_num}"
    end
    return new_coords
  end

  def get_coords_up(ship)
    letter_coord, num_coord = split_random_coord
    new_coords = ["#{letter_coord}#{num_coord}"]
    number_of_loops = ship.length - 1
    number_of_loops.times do |num|
      new_letter = letter_coord.ord - num - 1
      new_coords << "#{new_letter.chr}#{num_coord}"
    end
    return new_coords
  end

  def get_coords_down(ship)
    letter_coord, num_coord = split_random_coord
    new_coords = ["#{letter_coord}#{num_coord}"]
    number_of_loops = ship.length - 1
    number_of_loops.times do |num|
      new_letter = letter_coord.ord + num + 1
      new_coords << "#{new_letter.chr}#{num_coord}"
    end
    require 'pry'; binding.pry
    return new_coords
  end

end
