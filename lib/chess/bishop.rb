module Chess
  # Represents a bishop in chess
  class Bishop < ChessPiece
    # Returns all possible moves a bishop can make from its current position
    def moves
      (bottom_left + top_left + top_right + bottom_right).delete_if(&:empty?)
    end

    private

    # Returns all diagonal moves towards the top left corner of the board
    def top_left
      result = []
      row, col = @position
      until row == 0 || col == 0
        row -= 1
        col -= 1
        result << [row, col]
      end
      result
    end

    # Returns all diagonal moves towards the bottom left corner of the board
    def bottom_left
      result = []
      row, col = @position
      until row == 7 || col == 0
        row += 1
        col -= 1
        result << [row, col]
      end
      result
    end

    # Returns all diagonal moves towards the top right corner of the board
    def top_right
      result = []
      row, col = @position
      until row == 0 || col == 7
        row -= 1
        col += 1
        result << [row, col]
      end
      result
    end

    # Returns all diagonal moves towards the bottom right corner of the board
    def bottom_right
      result = []
      row, col = @position
      until row == 7 || col == 7
        row += 1
        col += 1
        result << [row, col]
      end
      result
    end
  end
end
