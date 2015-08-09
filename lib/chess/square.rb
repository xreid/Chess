module Chess
  # Represents a square on a chess board.
  class Square
    # The contents of a square
    attr_accessor :contents
    # The color(s) of the piece(s) a square is threatened by or false if
    # the square is not threatened
    attr_accessor :threatened

    # Creates a new square with the given contents
    # and threatened equal to false
    def initialize(contents = ' ')
      @contents   = contents
      @threatened = false
    end
  end
end
