module Chess
  class MoveError < StandardError
    # Raised when there is an error moving a piece
    def message
      'There was an issue moving this piece'
    end
  end
  # Raised when a player attempts ro move an oponents piece
  class PieceOwnershipError < MoveError
    def message
      "The color of this piece does not match the player's color"
    end
  end
  # Raised when a player attempts to move an empty square
  class EmptySquareError < MoveError
    def message
      'There is no piece in this square'
    end
  end
  # Raised when a player attempts to move to a square containing his/her own
  # piece
  class TeamKillError < MoveError
    def message
      'The specified positions both contain a piece of the same color.'
    end
  end
  # Raised when a player attempts to make an illegal move
  class IllegalMoveError < MoveError
    def message
      'That move is not permitted'
    end
  end
  # Raised when a player attempts to make an illegal move
  class BlockedPathError < MoveError
    def message
      'A chess piece is blocking this move'
    end
  end
end
