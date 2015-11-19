require_relative 'square'
require_relative 'exceptions'
require_relative 'chess_piece/bishop'
require_relative 'chess_piece/king'
require_relative 'chess_piece/knight'
require_relative 'chess_piece/pawn'
require_relative 'chess_piece/queen'
require_relative 'chess_piece/rook'

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

    def initialize(board = new_board)
      @squares = board
      pieces.each { |_name, piece| add_threats(piece) }
    end

    # Moves a piece from one position to another.
    #
    # Params:
    # +position_1+:: The current position of the piece to be moved
    # +position_2+:: The position the piece will be moved to
    # +player+::     The player attempting to move the piece
    def move!(position_1, position_2, player)
      fail_move_errors(position_1, position_2, player)
      row, col = position_1
      piece = @squares[row][col].contents
      piece.first_move = false if piece.is_a? Pawn
      remove_threats(piece)
      piece.position = position_2
      @squares[row][col].contents = ' '
      row, col = position_2
      if @squares[row][col].contents.is_a? ChessPiece
        remove_threats(@squares[row][col].contents)
      end
      @squares[row][col].contents = piece
      # update threats whose path may be blocked after the move is made
      @squares[row][col].threats.each do |threat|
        remove_threats(threat)
        add_threats(threat)
      end
      add_threats(piece)
    end

    # does not mutate the Board
    def move(position_1, position_2, player)
      board = Marshal.load(Marshal.dump(self))
      board.fail_move_errors(position_1, position_2, player)
      row, col = position_1
      piece = board.squares[row][col].contents
      piece.first_move = false if piece.is_a? Pawn
      board.remove_threats(piece)
      piece.position = position_2
      board.squares[row][col].contents = ' '
      row, col = position_2
      if board.squares[row][col].contents.is_a? ChessPiece
        board.remove_threats(board.squares[row][col].contents)
      end
      board.squares[row][col].contents = piece
      # update threats whose path may be blocked after the move is made
      board.squares[row][col].threats.each do |threat|
        board.remove_threats(threat)
        board.add_threats(threat)
      end
      board.add_threats(piece)
      board
    end

    def ai_move(player, ai_player)
      print 'thinking'
      start_time = Time.now
      best_piece = nil
      best_move = nil
      depth = 1
      # TODO timer should be within minimax
      until Time.now - start_time > 3
        print " . "
        result = minimax(depth, -1.0/0.0, 1.0/0.0, ai_player, player)
        best_piece = result[0]
        best_move = result[1]
        depth += 1
      end
      move!(best_piece.position, best_move, ai_player)
    end

    def checked?
      black_king = pieces['black_king']
      white_king = pieces['white_king']
      return false if black_king.nil? || white_king.nil?
      row, col = black_king.position
      return black_king if @squares[row][col].threatened?(black_king)
      row, col = white_king.position
      return white_king if @squares[row][col].threatened?(white_king)
      false
    end

    # Returns the check mated king or false if niether king is in check mate
    def check_mate?
      black_king = pieces['black_king']
      white_king = pieces['white_king']
      return false if black_king.nil? || white_king.nil?
      row, col = black_king.position
      if @squares[row][col].threatened?(black_king)
        return black_king unless safe_moves?(black_king) ||
          enclosed?(black_king) ||
          safe_from_threats?(black_king)
      end
      row, col = white_king.position
      if @squares[row][col].threatened?(white_king)
        return white_king unless safe_moves?(white_king) ||
          enclosed?(white_king) ||
          safe_from_threats?(white_king)
      end
      false
    end

    def pieces
      result = {}
      @squares.each do |row|
        row.each do |square|
          next if square.contents == ' '
          piece = square.contents
          key = "#{piece.color}_#{piece.name}#{piece.position.join unless piece.is_a? King}"
          result[key] = piece
        end
      end
      result
    end


    # TODO should be made constant instead of linear time
    def black_pieces
      pieces.select { |name, piece| name = name.include?('black')}
    end

    def white_pieces
      pieces.select { |name, piece| name = name.include?('white')}
    end

    def black_threatened
      black_pieces.select do |name, piece|
        @squares[piece.position[0]][piece.position[1]].threatened?(piece)
      end
    end

    def white_threatened
      white_pieces.select do |name, piece|
        @squares[piece.position[0]][piece.position[1]].threatened?(piece)
      end
    end

    def winner
      # pieces['black_king'].nil? ? pieces['white_king'] : pieces['black_king']
      if pieces['black_king'].nil?
        pieces['white_king']
      elsif pieces['white_king'].nil?
        pieces['black_king']
      elsif check_mate? == pieces['black_king']
        pieces['white_king']
      else
        pieces['black_king']
      end
    end

    # returns a value representing the 'goodness' of the board for the given
    # player
    def evaluate(player)
      result = 0
      if check_mate?
        result +=  100 if check_mate?.color == player.enemy_color
        result -= 100 if check_mate?.color != player.enemy_color
      elsif checked?
        result +=  50 if checked?.color == player.enemy_color
        result -= 50 if checked?.color != player.enemy_color
      elsif player.color == :black
        result +=  1 if black_threatened.size < white_threatened.size
        result += -1 if black_threatened.size > white_threatened.size
        result +=  3 if black_pieces.size    > white_pieces.size
        result += -3 if black_pieces.size    < white_pieces.size
      elsif player.color == :white
        result +=  1 if black_threatened.size > white_threatened.size
        result += -1 if black_threatened.size < white_threatened.size
        result +=  3 if black_pieces.size > white_pieces.size
        result += -3 if black_pieces.size < white_pieces.size
      end
      result
    end

    def to_s
      draw
      ''
    end

    # Returns the best piece and the best position for that piece to move to
    # +d+:: The depth at which to search.
    # +a+:: Alpha. The best value found for the max player.
    # +b+:: Beta. The best value found for the min player
    def minimax(d, a, b, max_player, min_player)
      best_score = -1.0 / 0.0
      best_piece = nil
      best_position = nil
      player_pieces = max_player.color == :black ? black_pieces : white_pieces
      player_pieces.values.each do |piece|
        piece.moves.each do |position|
          begin
            temp_board = move(piece.position, position, max_player)
          rescue MoveError
            next
          end
          score = temp_board.maximize(d - 1, a, b, max_player, min_player)
          if score > best_score
            best_score = score
            best_position = position
            best_piece = piece
          end
        end
      end
      [best_piece, best_position]
    end

    def maximize(d, a, b, max_player, min_player)
      return evaluate(max_player) if d == 0 || check_mate?
      player_pieces = max_player.color == :black ? black_pieces : white_pieces
      player_pieces.values.each do |piece|
        piece.moves.each do |position|
          begin
            temp_board = move(piece.position, position, max_player)
          rescue MoveError
            next
          end
          v = temp_board.minimize(d - 1, a, b, max_player, min_player)
          a = [a, v].max
          return a if v <= a
        end
      end
      a
    end

    def minimize(d, a, b, max_player, min_player)
      return evaluate(max_player) if d == 0 || check_mate?
      player_pieces = min_player.color == :black ? black_pieces : white_pieces
      player_pieces.values.each do |piece|
        piece.moves.each do |position|
          begin
            temp_board = move(piece.position, position, min_player)
          rescue MoveError
            next
          end
          v = temp_board.maximize(d - 1, a, b, max_player, min_player)
          b = [b, v].min
          return b if v >= b
        end
      end
      b
    end

    protected

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

    # returns true if the piece can move to an unthreatened square
    def safe_moves?(piece)
      if piece.moves.any? do |move|
        row, col = move
        square   = @squares[row][col]
        square.empty? && !(square.threatened?(piece))
      end
        return true
      end
      false
    end

    # returns true if a king is surrounded by friendly pieces
    def enclosed?(king)
      if king.moves.all? { |move| @squares[move[0]][move[1]].friendly?(king) }
        return true
      end
      false
    end

    # returns true if a threatened piece's threats can be captured
    def safe_from_threats?(king)
      king_square = @squares[king.position[0]][king.position[1]]
      return true if king_square.enemy_threats.empty?
      king.moves.all? do |position|
        square = @squares[position[0]][position[1]]
        next unless square.empty?
        square.threats.any? { |threat| threat.color == king.color }
      end
      king_square.enemy_threats.all? do |threat|
        square = @squares[threat.position[0]][threat.position[1]]
        square.threats.any? { |t| t.color == king.color}
      end
    end

    # Adds piece to the threats attribute of each square in range of piece
    def add_threats(piece)
      piece.directions.each do |direction|
        piece.moves(direction).each do |position|
          next if position == []
          row, col = position
          break if @squares[row][col].friendly?(piece) unless piece.is_a? Knight
          unless piece.is_a? Pawn
            @squares[row][col].threats << piece
          else
           if @squares[row][col].empty? || !([:top, :bottom].include?(direction))
              @squares[row][col].threats << piece
           end
          end
          break unless @squares[row][col].empty? unless piece.is_a? Knight
        end
      end
    end

    # Removes piece from the threats attribute of any square it threatens
    def remove_threats(piece)
      row, col = piece.position
      @squares[row][col].threats -= [piece]
      piece.moves.each do |position|
        row, col = position
        @squares[row][col].threats -= [piece]
      end
    end

    # returns true if the square at position is not under threat from an enemy
    # piece
    def threatened?(king, position)
      square = @squares[position[0]][position[1]]
      square.threats.any? { |threat| threat.color == king.enemy_color }
    end

    # returns the direction  of a move from position_1 to position_2
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
          Square.new(Pawn.new(:black, [1, 2])),
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

    # Fails all errors for #move
    def fail_move_errors(position_1, position_2, player)
      direction           = move_direction(position_1, position_2)
      piece               = (@squares[position_1[0]][position_1[1]]).contents
      new_square_contents = (@squares[position_2[0]][position_2[1]]).contents
      fail EmptySquareError    unless piece.is_a? ChessPiece
      fail PieceOwnershipError unless piece.color == player.color
      if new_square_contents.is_a? ChessPiece
        fail TeamKillError if new_square_contents.color == piece.color
      end
      # fail_checked_king_error(player, piece)
      fail IllegalMoveError    unless piece.moves.include?(position_2)
      fail_path_error(piece, direction, position_2) unless piece.is_a? Knight
      fail_pawn_errors(piece, position_2)           if piece.is_a? Pawn
      if piece.is_a? King
        fail ThreatenedSquareError if threatened?(piece, position_2)
      end
    end

    def fail_checked_king_error(player, piece)
      king = pieces[player.color.to_s + '_king']
      fail CheckedKingError if king == checked? && !(piece.is_a? King)
    end

    def fail_pawn_errors(pawn, new_positoin)
      row, col = new_positoin
      if pawn.position[1] != col && (@squares[row][col]).contents == ' '
        fail IllegalMoveError
      elsif @squares[row][col].contents.is_a? ChessPiece
        fail IllegalMoveError if pawn.position[1] - col == 0
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
