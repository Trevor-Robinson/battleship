require './lib/board'
require './lib/ship'
require './lib/display'

class Game
  attr_reader :player_board,
              :computer_board,
              :computer_ships,
              :player_ships,
              :last_hit

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @display = Display.new
    @computer_ships = []
    @player_ships = []
    @last_hit = nil
    @last_shots_since_hit = []
  end

  def clear_boards
    @player_board = Board.new
    @computer_board = Board.new
  end

  def create_ships_default
      @computer_ships << Ship.new("Cruiser", 3)
      @computer_ships << Ship.new("Sub", 2)
      @player_ships << Ship.new("Cruiser", 3)
      @player_ships << Ship.new("Sub", 2)
  end

  def clear_ships
    @computer_ships.clear
    @player_ships.clear
  end

  def create_ship_custom(name, length)
    Ship.new(name, length)
  end

  def assign_custom_ships
    2.times do
      @display.custom_ship_name
      input = gets.chomp
      name = input if input.class == String
      @display.custom_ship_length
      input = gets.chomp.to_i
      length = input if input.class == Integer
      @computer_ships << create_ship_custom(name, length)
      @player_ships << create_ship_custom(name, length)
    end
  end


  def setup_game
    @display.custom_ship_question
    input = gets.chomp
    if input == "n"
      create_ships_default
      @computer_ships.each do |ship|
        computer_place_ship(ship)
      end
      @display.show_player_board_layout
      @player_ships.each do |ship|
        player_place_ship(ship)
      end
    elsif input == "y"
      assign_custom_ships
      @computer_ships.each do |ship|
        computer_place_ship(ship)
      end
      @display.show_player_board_layout
      @player_ships.each do |ship|
        player_place_ship(ship)
      end
    end
  end

  def computer_win_condition
    counter = 0
    @player_ships.each do |ship|
      if ship.sunk?
        counter += 1
      end
    end
    return true if counter == 2
    return false
  end

  def player_win_condition
    counter = 0
    @computer_ships.each do |ship|
      if ship.sunk?
        counter += 1
      end
    end
    return true if counter == 2
    return false
  end

  def play_game
    play = false
      accepted_answer = ['p']

    while play == false
      @display.main_menu
      answer = gets.chomp
      if answer == 'q'
        @display.quit_message
        exit!
      end
      play = accepted_answer.include?(answer)
      while play == true
        setup_game
        until player_win_condition || computer_win_condition
          take_turn
        end

        winner
        sleep(1)
        clear_boards
        clear_ships
        play = false
      end
    end
  end

  def winner
    if computer_win_condition
      @display.computer_wins
    elsif player_win_condition
      @display.player_wins
    end
  end

  def take_turn
    @display.computer_label
    puts @computer_board.render
    @display.player_label
    puts @player_board.render(true)
    player_shot = coord_to_fire_on
    outcome = determine_hit_miss_sunk(player_shot, @computer_board)
    ship = get_ship_name(@computer_board, player_shot)
    @display.report_player_shot(player_shot, outcome, ship)
    computer_shot = computer_fire
    update_computer_shot_info(computer_shot, @player_board)
    outcome = determine_hit_miss_sunk(computer_shot, @player_board)
    ship = get_ship_name(@player_board, computer_shot)
    @display.report_computer_shot(computer_shot, outcome, ship)
  end

  def get_ship_name(board, shot)
    if board.cells[shot].empty?
     return " "
    else
     return board.cells[shot].ship
    end
  end

  def determine_hit_miss_sunk(shot, board)
    outcome = board.cells[shot].render
  end

  def update_computer_shot_info(shot, board)
    outcome = determine_hit_miss_sunk(shot,board)

    if outcome == "H"
      @last_hit = shot
      @last_shots_since_hit.clear
    elsif outcome == "X"
      @last_hit = nil
      @last_shots_since_hit.clear
    elsif outcome == "M"
      @last_shots_since_hit << shot
    end
  end

  def coord_to_fire_on
    @display.ask_for_coord_to_fire_upon
    input = gets.chomp

    until @computer_board.valid_coord?(input) && !@computer_board.cells[input].fired_upon?
      if !@computer_board.valid_coord?(input)
        @display.invalid_coordinates
      elsif @computer_board.cells[input].fired_upon?
        @display.already_fired_on
      end
      input = gets.chomp
    end

    @computer_board.cells[input].fire_upon
    input
  end

  def computer_fire
    if @last_hit == nil
      input = computer_get_random_coord
      until !@player_board.cells[input].fired_upon?
        input = computer_get_random_coord
      end
      @player_board.cells[input].fire_upon

      return input
    else
      surrounding_coords(@last_hit).each do |coord|
        if !@last_shots_since_hit.include?(coord) && !@player_board.cells[coord].fired_upon?
          @player_board.cells[coord].fire_upon
          return coord
        end
      end
    end
  end

  def computer_get_random_coord
    @computer_board.return_valid_random_coord
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
      if @computer_board.valid_placement?(ship, coords)
        @computer_board.place(ship, coords)
        break
      end
    end
  end

  def player_place_ship(ship)
    @display.ask_for_ship_coords(ship)
    input = gets.chomp
    coords = input.split.to_a
    until @player_board.valid_placement?(ship, coords)
      @display.invalid_coordinates
      input = gets.chomp
      coords = input.split.to_a
    end
    @player_board.place(ship, coords)
  end

  def split_random_coord(coord)
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

  def get_right(coord)
    letter_coord, num_coord = split_random_coord(coord)
    right_coord = "#{letter_coord}#{num_coord.to_i + 1}"
  end

  def get_left(coord)
    letter_coord, num_coord = split_random_coord(coord)
    left_coord = "#{letter_coord}#{num_coord.to_i - 1}"
  end

  def get_up(coord)
    letter_coord, num_coord = split_random_coord(coord)
    letter_coord = letter_coord.ord + 1
    up_coord = "#{letter_coord.chr}#{num_coord}"
  end

  def get_down(coord)
    letter_coord, num_coord = split_random_coord(coord)
    letter_coord = letter_coord.ord - 1
    down_coord = "#{letter_coord.chr}#{num_coord}"
  end

  def surrounding_coords(coord)
    surrounding_coords = [get_up(coord),
                          get_down(coord),
                          get_right(coord),
                          get_left(coord)
                         ]

    surrounding_coords.map do |coord|
      if @player_board.valid_coord?(coord) == true && @player_board.cells[coord].fired_upon? == false
        coord
      end
    end.compact
  end
end
