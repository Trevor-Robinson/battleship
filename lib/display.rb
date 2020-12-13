require './lib/game'

class Display
  def initialize
  end

  def main_menu
    puts "Welcome to BATTLESHIP\n
  Enter p to play. Enter q to quit."
  end

  def show_player_board_layout
  puts  "I have laid out my ships on the grid.\n" +
         "You now need to lay out your two ships.\n" +
         "The Cruiser is three units long and the Submarine is two units long.\n" +
         "  1 2 3 4\n" +
         "A . . . .\n" +
         "B . . . .\n" +
         "C . . . .\n" +
         "D . . . .\n"
  end

  def ask_for_ship_coords(ship)
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
  end

  def invalid_coordinates
    puts "Those are invalid coordinates. Please try again:"
  end

  def ask_for_coord_to_fire_upon
    puts "Choose a coord to fire on:"
  end

  def render_computer_board
    #puts @game.board.render
  end
end
