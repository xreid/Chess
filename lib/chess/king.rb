module Chess
  # Represents a king in chess
  class King < ChessPiece
    # Returns all possible moves a king can make from its current position
    # A king may move one square in any direction
    def moves
      ([left] + [top_left] + [top] + [top_right] +
        [right] + [bottom_right] + [bottom] + [bottom_left]).delete_if(&:empty?)
    end

    private

    # Returns the leftward move or an empty array if the king cannot move left.
    # Only checks boundaries of board, not whether the king is in check.
    def left
      row, col = @position
      return [row, col - 1] unless col - 1 < 0
      []
    end

    # Returns all diagonal moves towards the top left corner of the board
    def top_left
      row, col = @position
      return [row - 1, col - 1] unless row - 1 < 0 || col - 1 < 0
      []
    end

    # Returns all diagonal moves towards the top left corner of the board
    def top
      row, col = @position
      return [row - 1, col] unless row - 1 < 0
      []
    end

    # Returns all diagonal moves towards the top left corner of the board
    def top_right
      row, col = @position
      return [row - 1, col + 1] unless row - 1 < 0 || col + 1 > 7
      []
    end

    # Returns all diagonal moves towards the top left corner of the board
    def right
      row, col = @position
      return [row, col + 1] unless col + 1 > 7
      []
    end

    # Returns all diagonal moves towards the bottom left corner of the board
    def bottom_right
      row, col = @position
      return [row + 1, col + 1] unless row + 1 > 7 || col + 1 > 7
      []
    end

    # Returns all diagonal moves towards the bottom left corner of the board
    def bottom
      row, col = @position
      return [row + 1, col] unless row + 1 > 7
      []
    end

    # Returns all diagonal moves towards the bottom left corner of the board
    def bottom_left
      row, col = @position
      return [row + 1, col - 1] unless row + 1 > 7 || col - 1 < 0
      []
    end
  end
end
