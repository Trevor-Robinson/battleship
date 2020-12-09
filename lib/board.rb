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
end
