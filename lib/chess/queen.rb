module Chess
  # Represents a queen in chess
  class Queen < ChessPiece
    def moves
      Rook.new(@color, @position).moves + Bishop.new(@color, @position).moves
    end

    def  to_s
      case @color
      when :black then '♛'
      when :white then '♕'
      end
    end
  end
end
