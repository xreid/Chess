module Chess
  # Represents a board in chess
  class Board
    # An array made up of Chess::Square's representing the chess board.
    attr_accessor :squares
    TOP       = "\n    A   B   C   D   E   F   G   H"\
                "\n   -------------------------------"
    BOTTOM    = "\n   -------------------------------"\
                "\n    A   B   C   D   E   F   G   H"
    SEPARATOR = "\n  |---+---+---+---+---+---+---+---|"

    def initialize
      @squares = new_board
    end

    def to_s
      draw
    end

    private

    def draw
      puts TOP
      @squares.each_with_index do |row, index|
        puts SEPARATOR unless index == 0
        print "#{8 - index} "
        row.each do |piece|
          print "| #{piece} "
        end
        print "| #{8 - index}"
      end
      puts BOTTOM
    end

    def new_board
      [
        [
          Square.new(Rook.new(:black,   [0, 0])),
          Square.new(Knight.new(:black, [0, 1])),
          Square.new(Bishop.new(:black, [0, 2])),
          Square.new(King.new(:black,   [0, 3])),
          Square.new(Queen.new(:black,  [0, 4])),
          Square.new(Bishop.new(:black, [0, 5])),
          Square.new(Knight.new(:black, [0, 6])),
          Square.new(Rook.new(:black,   [0, 7]))
        ],
        [
          Square.new(Pawn.new(:black, [1, 0])),
          Square.new(Pawn.new(:black, [1, 1])),
          Square.new(Pawn.new(:black, [1, 1])),
          Square.new(Pawn.new(:black, [1, 3])),
          Square.new(Pawn.new(:black, [1, 4])),
          Square.new(Pawn.new(:black, [1, 5])),
          Square.new(Pawn.new(:black, [1, 6])),
          Square.new(Pawn.new(:black, [1, 7]))
        ],
        [
          Square.new, Square.new, Square.new, Square.new,
          Square.new, Square.new, Square.new, Square.new
        ],
        [
          Square.new, Square.new, Square.new, Square.new,
          Square.new, Square.new, Square.new, Square.new
        ],
        [
          Square.new, Square.new, Square.new, Square.new,
          Square.new, Square.new, Square.new, Square.new
        ],
        [
          Square.new, Square.new, Square.new, Square.new,
          Square.new, Square.new, Square.new, Square.new
        ],
        [
          Square.new(Pawn.new(:white, [6, 0])),
          Square.new(Pawn.new(:white, [6, 1])),
          Square.new(Pawn.new(:white, [6, 2])),
          Square.new(Pawn.new(:white, [6, 3])),
          Square.new(Pawn.new(:white, [6, 4])),
          Square.new(Pawn.new(:white, [6, 5])),
          Square.new(Pawn.new(:white, [6, 6])),
          Square.new(Pawn.new(:white, [6, 7]))
        ],
        [
          Square.new(Rook.new(:black,   [7, 0])),
          Square.new(Knight.new(:black, [7, 1])),
          Square.new(Bishop.new(:black, [7, 2])),
          Square.new(King.new(:black,   [7, 3])),
          Square.new(Queen.new(:black,  [7, 4])),
          Square.new(Bishop.new(:black, [7, 5])),
          Square.new(Knight.new(:black, [7, 6])),
          Square.new(Rook.new(:black,   [7, 7]))
        ]
      ]
    end
  end
end
