module Chess
  # Represents a square on a chess board.
  class Square
    # The contents of a square (' ' or a ChessPiece)
    attr_accessor :contents
    # Array of the pieces that can currently move to this square
    attr_accessor :threats

    # Creates a new square with the given contents
    # and threatened equal to false
    def initialize(contents = ' ')
      @contents   = contents
      @threats = []
    end

    def to_s
      @contents.to_s
    end

    def empty?
      @contents == ' '
    end

    def friendly?(piece)
      return false if @contents == ' '
      return true  if @contents.color == piece.color
      false
    end

    def enemy_threats(piece = @contents)
      @threats.select { |threat| threat.color == piece.color }
    end

    def threatened?(piece)
      return true if @threats.any? { |threat| threat.color != piece.color }
      false
    end

  end
end
