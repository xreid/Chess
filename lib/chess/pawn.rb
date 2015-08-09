module Chess
  # Represents a rook in chess
  class Pawn < ChessPiece
    attr_accessor :first_move

    def initialize(color, position)
      super(color, position)
      @first_move = true
    end

    def moves
      row, col = @position
      row += 1
      return result if row > 7
      result = [[row, col]]
      result << [row + 1, col] if first_move?
      col -= 1
      result << [row, col] unless col < 0
      col += 2
      result << [row, col] unless col > 7
      result.delete_if(&:empty?)
    end

    def first_move?
      @first_move
    end
  end
end
