module Chess
  # Represents a knight in chess
  class Knight < ChessPiece
    def moves
      left + top + right + bottom
    end

    def left
      result = []
      row, col = @position
      result << [row - 1, col - 2] unless row - 1 < 0 || col - 2 < 0
      result << [row + 1, col - 2] unless row + 1 > 7 || col - 2 < 0
      result
    end

    def top
      result = []
      row, col = @position
      result << [row - 2, col - 1] unless row - 2 < 0 || col - 1 < 0
      result << [row - 2, col + 1] unless row - 2 < 0 || col + 1 > 7
      result
    end

    def right
      result = []
      row, col = @position
      result << [row - 1, col + 2] unless row - 1 < 0 || col + 2 > 7
      result << [row + 1, col + 2] unless row + 1 > 7 || col + 2 > 7
      result
    end

    def bottom
      result = []
      row, col = @position
      result << [row + 2, col + 1] unless row + 2 > 7 || col + 1 > 7
      result << [row + 2, col - 1] unless row + 2 > 7 || col - 1 < 0
      result
    end
  end
end
