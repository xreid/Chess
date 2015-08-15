module Chess
  # Represents a square on a chess board.
  class Square
    # The contents of a square
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
  end
end
