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

  def already_fired_on
    puts "Those coordinates have been fired upon already. Please try again:"
  end

  def ask_for_coord_to_fire_upon
    puts "Choose a coord to fire on:"
  end

  def computer_label
    puts "=============COMPUTER BOARD============="
  end

  def player_label
    puts "==============PLAYER BOARD=============="
  end

  def report_computer_shot(shot, outcome, ship = "")
    if outcome == 'M'
      puts "My shot on #{shot} was a miss"
    elsif outcome == 'X'
      puts "My shot on #{shot} sunk your #{ship.name}"
    elsif outcome == 'H'
      puts "My shot on #{shot} hit your #{ship.name}"
    end
  end

  def report_player_shot(shot, outcome, ship = "")
    if outcome == 'M'
      puts "Your shot on #{shot} was a miss"
    elsif outcome == 'X'
      puts "Your shot on #{shot} sunk my #{ship.name}"
    elsif outcome == 'H'
      puts "Your shot on #{shot} hit my #{ship.name}"
    end
  end

  def player_wins
    puts "You won!"
  end

  def computer_wins
    puts "I won!"
  end

  def quit_message
    puts "You quit the game."
  end  
end
