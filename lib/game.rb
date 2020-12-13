require './lib/board'
require './lib/ship'

class Game
  attr_reader :board
  def initialize
    @board = Board.new
  end

  def computer_get_random_coord
    @board.return_valid_random_coord
  end

  def computer_place_ship(ship)
    rand_coord = computer_get_random_coord
    right = get_coords_right(ship, rand_coord)
    down = get_coords_down(ship, rand_coord)
    left =  get_coords_left(ship, rand_coord)
    up = get_coords_up(ship, rand_coord)
    coords_to_check = [right, down, left, up]
    coords_to_check.shuffle!

    coords_to_check.each do |coords|
      if @board.valid_placement?(ship, coords)
        #require 'pry'; binding.pry
        @board.place(ship, coords)
        break
      end
    end
  end

  def split_random_coord(coord)
    #letter_coord, num_coord = computer_get_random_coord.split('')
    letter_coord, num_coord = coord.split('')
  end

  def get_coords_right(ship, coord)
    letter_coord, num_coord = split_random_coord(coord)
    new_coords = ["#{letter_coord}#{num_coord}"]
    number_of_loops = ship.length - 1
    number_of_loops.times do |num|
      new_num = num_coord.to_i + num + 1
      new_coords << "#{letter_coord}#{new_num}"
    end

    return new_coords
  end

  def get_coords_left(ship, coord)
    letter_coord, num_coord = split_random_coord(coord)
    new_coords = ["#{letter_coord}#{num_coord}"]
    number_of_loops = ship.length - 1
    number_of_loops.times do |num|
      new_num = num_coord.to_i - num - 1
      new_coords << "#{letter_coord}#{new_num}"
    end

    return new_coords
  end

  def get_coords_up(ship, coord)
    letter_coord, num_coord = split_random_coord(coord)
    new_coords = ["#{letter_coord}#{num_coord}"]
    number_of_loops = ship.length - 1
    number_of_loops.times do |num|
      new_letter = letter_coord.ord - num - 1
      new_coords << "#{new_letter.chr}#{num_coord}"
    end

    return new_coords
  end

  def get_coords_down(ship, coord)
    letter_coord, num_coord = split_random_coord(coord)
    new_coords = ["#{letter_coord}#{num_coord}"]
    number_of_loops = ship.length - 1
    number_of_loops.times do |num|
      new_letter = letter_coord.ord + num + 1
      new_coords << "#{new_letter.chr}#{num_coord}"
    end

    return new_coords
  end
end
