module Chess
  # Superclass for ant chess piece
  class ChessPiece
    attr_accessor :color, :name, :position

    def initialize(color, position)
      @color    = color
      @position = position
    end

    def enemy_color
      @color == :black ? :white : :black
    end
  end
end
