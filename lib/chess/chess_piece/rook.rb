module Chess
  # Represents a rook in chess
  class Rook < ChessPiece

    def initialize(color, position)
      super(color, position)
      @name = :rook
    end

    def moves(direction = :all)
      case direction
      when :all
        (left + top + right + bottom).delete_if(&:empty?)
      when :left   then left
      when :top    then top
      when :right  then right
      when :bottom then bottom
      end
    end

    # all directions this piece can move in
    def self.directions
      [:left, :top, :right, :bottom]
    end

    def directions
      Rook.directions
    end

    def  to_s
      case @color
      when :black then '♜'
      when :white then '♖'
      end
    end

    private

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
