module Chess
  # Represents a knight in chess
  class Knight < ChessPiece
    def moves(direction = :all)
      case direction
      when :all
        left + top + right + bottom
      when :left   then left
      when :top    then top
      when :right  then right
      when :bototm then bototm
      end
    end

    # all directions this piece can move in
    def directions
      [:left, :top, :right, :bottom]
    end

    # Returns the unicode symbol for the chess piece
    def  to_s
      case @color
      when :black then '♞'
      when :white then '♘'
      end
    end

    private

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
