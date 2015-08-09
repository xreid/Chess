module Chess
  # Superclass for ant chess piece
  class ChessPiece
    attr_accessor :color, :position

    def initialize(color, position)
      @color    = color
      @position = position
    end
  end
end
