module Chess
  # Represents a bishop in chess
  class Bishop < ChessPiece
    # Returns all possible moves a bishop can make from its current position
    def moves(direction = :all)
      case direction
      when :all
        (bottom_left + top_left + top_right + bottom_right).delete_if(&:empty?)
      when :bottom_left  then bottom_left
      when :top_left     then top_left
      when :top_right    then top_right
      when :bottom_right then bottom_right
      end
    end

    # all directions this piece can move in
    def directions
      [:bottom_left, :top_left, :top_right, :bottom_right]
    end

    # Returns the unicode symbol for the chess piece
    def  to_s
      case @color
      when :black then '♝'
      when :white then '♗'
      end
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
