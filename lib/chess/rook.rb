module Chess
  # Represents a rook in chess
  class Rook < ChessPiece
    def moves
      (left + top + right + bottom).delete_if(&:empty?)
    end

    # Returns all leftward moves
    def left
      result = []
      row, col = @position
      until col == 0
        col -= 1
        result << [row, col]
      end
      result
    end

    # Returns all upward moves
    def top
      result = []
      row, col = @position
      until row == 0
        row -= 1
        result << [row, col]
      end
      result
    end

    # Returns all rightward moves
    def right
      result = []
      row, col = @position
      until col == 7
        col += 1
        result << [row, col]
      end
      result
    end

    # Returns all downward moves
    def bottom
      result = []
      row, col = @position
      until row == 7
        row += 1
        result << [row, col]
      end
      result
    end
  end
end
