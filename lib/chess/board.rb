module Chess
  class Board
    # An array made up of Chess::Square's representing the chess board.
    attr_accessor :squars

    def initialize
      @squares = new_board
    end

    private

    def new_board
      [
        []
      ]
    end
  end
end
