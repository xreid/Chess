module Chess
  # Represents a rook in chess
  class Pawn < ChessPiece
    attr_accessor :first_move

    def initialize(color, position)
      super(color, position)
      @first_move = true
    end

    # fix for white side
    def moves(direction = :all)
      case @color
      when :black then black_moves(direction)
      when :white then white_moves(direction)
      end
    end

    # all directions this piece can move in
    def directions
      case @color
      when :black then [:bottom, :bottom_left, :bottom_right]
      when :white then [:top, :top_left, :top_right]
      end
    end

    def first_move?
      @first_move
    end

    # Returns the unicode symbol for the chess piece
    def  to_s
      case @color
      when :black then '♟'
      when :white then '♙'
      end
    end

    private

    def black_moves(direction)
      row, col = @position
      row += 1
      result = []
      return result if row > 7
      if direction == :bottom || direction == :all
        result << [row, col]
        result << [row + 1, col] if first_move?
      end
      col -= 1
      if direction == :bottom_left || direction == :all
        result << [row, col] unless col < 0
      end
      col += 2
      if direction == :bottom_right || direction == :all
        result << [row, col] unless col > 7
      end
      result.delete_if(&:empty?)
    end

    def white_moves(direction)
      row, col = @position
      row -= 1
      result = []
      return [] if row < 0
      if direction == :top || direction == :all
        result << [row, col]
        result << [row + - 1, col] if first_move?
      end
      col -= 1
      if direction == :top_left || direction == :all
        result << [row, col] unless col < 0
      end
      col += 2
      if direction == :top_right || direction == :all
        result << [row, col] unless col > 7
      end
      result.delete_if(&:empty?)
    end
  end
end
