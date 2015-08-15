module Chess
  # Represents a queen in chess
  class Queen < ChessPiece
    def moves(direction = :all)
      Rook.new(@color, @position).moves(direction) +
        Bishop.new(@color, @position).moves(direction)
    end

    # all directions this piece can move in
    def directions
      Rook.new(@color, @position).directions +
        Bishop.new(@color, @position).rections
    end

    def  to_s
      case @color
      when :black then '♛'
      when :white then '♕'
      end
    end
  end
end
