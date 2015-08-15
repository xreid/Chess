module Chess
  # Represents a board in chess
  class Board
    # An array made up of Chess::Square's representing the chess board.
    attr_accessor :squares
    # top border for the board
    TOP       = "\n    A   B   C   D   E   F   G   H"\
                "\n   -------------------------------"
    # bottom border for the board
    BOTTOM    = "\n   -------------------------------"\
                "\n    A   B   C   D   E   F   G   H"
    # horizontal separators for the board
    SEPARATOR = "\n  |---+---+---+---+---+---+---+---|"

    def initialize
      @squares = new_board
    end

    # Moves a piece from one position to another.
    #
    # Params:
    # +position_1+:: The current position of the piece to be moved
    # +position_2+:: The position the piece will be moved to
    # +player+:: The player attempting to move the piece
    def move(position_1, position_2, player)
      fail_move_errors(position_1, position_2, player)
      row, col = position_1
      piece = @squares[row][col].contents
      piece.position = position_2
      @squares[row][col].contents = ' '
      row, col = position_2
      @squares[row][col].contents = piece
    end

    # Removes piece from the threatened attribure of any square it threatens
    def remove_threats(piece)
      picee.moves.each do |position|
        row, col = position
        @squares[row][col].threats -= [piece]
      end
    end
    # Adds piece to the threatened attribute of each square in range of piece
    def add_threats(piece)
      picee.moves.each do |position|
        row, col = position
        @squares[row][col].threats << piece
      end
    end

    def to_s
      draw
    end

    private

    # draws the chess board to the std out
    def draw
      puts TOP
      @squares.each_with_index do |row, index|
        puts SEPARATOR unless index == 0
        print "#{8 - index} " # row number on left side of board
        row.each do |piece|
          print "| #{piece} "
        end
        print "| #{8 - index}" # row number on right side of board
      end
      puts BOTTOM
    end

    # Constructs a new chess board
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
          Square.new(Rook.new(:white,   [7, 0])),
          Square.new(Knight.new(:white, [7, 1])),
          Square.new(Bishop.new(:white, [7, 2])),
          Square.new(King.new(:white,   [7, 3])),
          Square.new(Queen.new(:white,  [7, 4])),
          Square.new(Bishop.new(:white, [7, 5])),
          Square.new(Knight.new(:white, [7, 6])),
          Square.new(Rook.new(:white,   [7, 7]))
        ]
      ]
    end

    # Fails all errors fot #move
    def fail_move_errors(position_1, position_2, player)
      direction = move_direction(position_1, position_2)
      piece = (@squares[position_1[0]][position_1[1]]).contents
      fail EmptySquareError    unless piece.is_a? ChessPiece
      fail PieceOwnershipError unless piece.color == player.color
      fail IllegalMoveError    unless piece.moves.include?(position_2)
      fail_path_error(piece, direction, position_2) unless piece.is_a? Knight
      fail_pawn_move_errors(piece, position_2)          if piece.is_a? Pawn
      new_square_contents = (@squares[position_2[0]][position_2[1]]).contents
      if new_square_contents.is_a? ChessPiece
        fail TeamKillError if new_square_contents.color == piece.color
      end
    end

    def fail_pawn_move_errors(pawn, new_positoin)
      row, col = new_positoin
      if pawn.position[1] != col && (@squares[row][col]).contents == ' '
        fail IllegalMoveError
      end
    end

    def move_direction(position_1, position_2)
      row_comparison = position_2[0] - position_1[0]
      col_comparison = position_2[1] - position_1[1]
      if row_comparison > 0 && col_comparison < 0
        :bottom_left
      elsif row_comparison > 0 && col_comparison > 0
        :bottom_right
      elsif row_comparison > 0
        :bottom
      elsif row_comparison < 0 && col_comparison < 0
        :top_left
      elsif row_comparison < 0 && col_comparison > 0
        :top_right
      elsif row_comparison < 0
        :top
      elsif row_comparison == 0 && col_comparison < 0
        :left
      elsif row_comparison == 0 && col_comparison > 0
        :right
      end
    end

    def fail_path_error(piece, direction, destination)
      index = piece.moves(direction).index(destination)
      if piece.moves(direction)[0..index].any? do |position|
        next if position == destination
        @squares[position[0]][position[1]].contents.is_a? ChessPiece
      end
        fail BlockedPathError
      end
    end
  end
end
