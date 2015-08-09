module Chess
  # Represents a queen in chess
  class Queen < ChessPiece
    def moves
      Rook.new(@color, @position).moves + Bishop.new(@color, @position).moves
    end
  end
end
