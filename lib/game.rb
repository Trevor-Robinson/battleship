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
    letter_coord, num_coord = computer_get_random_coord.split('')
    coords = []
    number_of_loops = cruiser.length - 1

     number_of_loops.times do |num|
      new_letter = (letter_coord.ord += num + 1).chr

      # Seperate into two helper methods: letter increment and number increment
    end



  end
end
