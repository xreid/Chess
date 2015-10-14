require_relative 'chess/version'
require_relative 'chess/exceptions'
require_relative 'chess/game'
require_relative 'chess/chess_piece'
require_relative 'chess/chess_piece/bishop'
require_relative 'chess/board'
require_relative 'chess/chess_piece/king'
require_relative 'chess/chess_piece/knight'
require_relative 'chess/chess_piece/pawn'
require_relative 'chess/ai_player'
require_relative 'chess/player'
require_relative 'chess/chess_piece/queen'
require_relative 'chess/chess_piece/rook'
require_relative 'chess/square'

# TODO add support for castling
# TODO add support for en passant
# TODO add support for en pawn promotion
# TODO optimize all methods called from within minimax
# TODO figure out why this board results in a win for black
#     A   B   C   D   E   F   G   H
#    -------------------------------
# 8 | ♜ | ♞ |   | ♚ |   |   |   | ♜ | 8
#   |---+---+---+---+---+---+---+---|
# 7 | ♟ | ♟ | ♟ |   | ♟ |   |   | ♟ | 7
#   |---+---+---+---+---+---+---+---|
# 6 |   |   |   |   |   | ♟ |   | ♙ | 6
#   |---+---+---+---+---+---+---+---|
# 5 |   |   |   |   |   |   | ♟ |   | 5
#   |---+---+---+---+---+---+---+---|
# 4 |   |   |   |   | ♙ |   |   | ♙ | 4
#   |---+---+---+---+---+---+---+---|
# 3 | ♖ | ♙ |   |   | ♙ | ♝ |   |   | 3
#   |---+---+---+---+---+---+---+---|
# 2 |   |   | ♙ | ♙ |   |   |   |   | 2
#   |---+---+---+---+---+---+---+---|
# 1 |   |   | ♗ | ♔ | ♖ |   |   |   | 1
#    -------------------------------
#     A   B   C   D   E   F   G   H
