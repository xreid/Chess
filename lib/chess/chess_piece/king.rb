module Chess
  # Represents a king in chess
  class King < ChessPiece

    def initialize(color, position)
      super(color, position)
      @name = :king
    end

    # Returns all possible moves a king can make from its current position
    # A king may move one square in any direction
    def moves(direction = :all)
      case direction
      when :all
      ([left] + [top_left] + [top] + [top_right] +
        [right] + [bottom_right] + [bottom] + [bottom_left]).delete_if(&:empty?)
      when :left         then [left]
      when :top_left     then [top_left]
      when :top          then [top]
      when :top_right    then [top_right]
      when :right        then [right]
      when :bottom_right then [bottom_right]
      when :bottom       then [bottom]
      when :bottom_left  then [bottom_left]
      end
    end

    def directions
      King.directions
    end

    # all directions this piece can move in
    def self.directions
      [
        :left, :top_left, :top, :top_right, :right,
        :bottom_right, :bottom, :bottom_left
      ]
    end

    # Returns the unicode symbol for the chess piece
    def  to_s
      case @color
      when :black then '♚'
      when :white then '♔'
      end
    end

    private

    # Returns the leftward move or an empty array if the king cannot move left.
    # Only checks boundaries of board, not whether the king is in check.
    def left
      row, col = @position
      return [row, col - 1] unless col - 1 < 0
      []
    end

    # Returns the diagonal move to the upper left or an empty array if the king
    # cannot move in that direction.
    # Only checks boundaries of board, not whether the king is in check.
    def top_left
      row, col = @position
      return [row - 1, col - 1] unless row - 1 < 0 || col - 1 < 0
      []
    end

    # Returns the upward move or an empty array if the king cannot move upwards.
    # Only checks boundaries of board, not whether the king is in check.
    def top
      row, col = @position
      return [row - 1, col] unless row - 1 < 0
      []
    end

    # Returns the diagonal move to the upper right or an empty array if the
    # king cannot move in that direction.
    # Only checks boundaries of board, not whether the king is in check.
    def top_right
      row, col = @position
      return [row - 1, col + 1] unless row - 1 < 0 || col + 1 > 7
      []
    end

    # Returns the rightward move or an empty array if the king cannot move right
    # Only checks boundaries of board, not whether the king is in check.
    def right
      row, col = @position
      return [row, col + 1] unless col + 1 > 7
      []
    end

    # Returns the diagonal move to the lower right or an empty array if the
    # king cannot move in that direction.
    # Only checks boundaries of board, not whether the king is in check.
    def bottom_right
      row, col = @position
      return [row + 1, col + 1] unless row + 1 > 7 || col + 1 > 7
      []
    end

    # Returns the downward move or an empty array if the king cannot move down
    # Only checks boundaries of board, not whether the king is in check.
    def bottom
      row, col = @position
      return [row + 1, col] unless row + 1 > 7
      []
    end

    # Returns the diagonal move to the lower left or an empty array if the
    # king cannot move in that direction.
    # Only checks boundaries of board, not whether the king is in check.
    def bottom_left
      row, col = @position
      return [row + 1, col - 1] unless row + 1 > 7 || col - 1 < 0
      []
    end
  end
end
