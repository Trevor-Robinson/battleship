require './lib/board'
require './lib/ship'
require './lib/display'

class Game
  attr_reader :player_board,
              :computer_board

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @display = Display.new
  end

  def clear_boards
    @player_board = Board.new
    @computer_board = Board.new
  end

  def create_ships
    cruiser = Ship.new("Cruiser", 3)
    sub = Ship.new("sub", 2)
    return cruiser, sub
  end

  def setup_game
    @computer_cruiser, @computer_sub = create_ships
    computer_place_ship(@computer_cruiser)
    computer_place_ship(@computer_sub)
    @player_cruiser, @player_sub = create_ships
    @display.show_player_board_layout
    player_place_ship(@player_cruiser)
    player_place_ship(@player_sub)
  end

  def end_game(player_cruiser, player_sub, computer_cruiser, computer_sub)
    if (player_cruiser.sunk? && player_sub.sunk?) || (computer_cruiser.sunk? && computer_sub.sunk?)
      return true
    end
  end

  # play = false
  #   accepted_answer = ['p']

  # while play == false
  #   setup_game
  #   answer = gets.chomp
  #   play = accepted_answer.include?(answer)
  # end

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
        until end_game(@player_cruiser, @player_sub, @computer_cruiser, @computer_sub)
          take_turn
        end
        winner
        clear_boards
        play = false
      end
    end
    # while play == true
    #   setup_game
    #   until end_game(@player_cruiser, @player_sub, @computer_cruiser, @computer_sub)
    #     take_turn
    #   end
    #   winner
    #   play = false
    # end
  end

  def winner
    if (@player_cruiser.sunk? && @player_sub.sunk?)
      @display.computer_wins
    elsif (@computer_cruiser.sunk? && @computer_sub.sunk?)
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
    input = computer_get_random_coord
    until !@player_board.cells[input].fired_upon?
      input = computer_get_random_coord
    end
    @player_board.cells[input].fire_upon
    input
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
        #require 'pry'; binding.pry
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
