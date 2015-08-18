module Chess
  # Represents a rook in chess
  class Pawn < ChessPiece
    attr_accessor :first_move

    def initialize(color, position)
      super(color, position)
      @name = :pawn
      @first_move = true
    end

    # fix for white side
    def moves(direction = :all)
      case @color
      when :black then black_moves(direction)
      when :white then white_moves(direction)
      end
    end

    # all directions this piece can move in
    def self.directions(color)
      case color
      when :black then [:bottom, :bottom_left, :bottom_right]
      when :white then [:top, :top_left, :top_right]
      end
    end

    def directions
      Pawn.directions(@color)
    end

    def first_move?
      @first_move
    end

    # Returns the unicode symbol for the chess piece
    def  to_s
      case @color
      when :black then '♟'
      when :white then '♙'
      end
    end

    private

    def bottom
      result = []
      row, col = @position
      row += 1
      result << [row, col] if row < 8
      row += 1
      result << [row, col] if row < 8 && first_move?
      result
    end

    def bottom_left
      result = []
      row, col = @position
      row += 1
      col -= 1
      result << [row, col] if row < 8 && col >= 0
      result
    end

    def bottom_right
      result = []
      row, col = @position
      row += 1
      col += 1
      result << [row, col] if row < 8 && col < 8
      result
    end

    def top
      result = []
      row, col = @position
      row -= 1
      result << [row, col] if row >= 0
      row -= 1
      result << [row, col] if row >= 0 && first_move?
      result
    end

    def top_left
      result = []
      row, col = @position
      row -= 1
      col -= 1
      result << [row, col] if row >= 0 && col >= 0
      result
    end

    def top_right
      result = []
      row, col = @position
      row -= 1
      col += 1
      result << [row, col] if row >= 0 && col < 8
      result
    end

    def black_moves(direction = :all)
      case direction
      when :all
        (bottom + bottom_left + bottom_right).delete_if(&:empty?)
      when :bottom       then bottom
      when :bottom_left  then bottom_left
      when :bottom_right then bottom_right
      end
    end

    def white_moves(direction = :all)
      case direction
      when :all
        (top + top_left + top_right).delete_if(&:empty?)
      when :top       then top
      when :top_left  then top_left
      when :top_right then top_right
      end
    end

    # def black_moves(direction)
    #   row, col = @position
    #   row += 1
    #   result = []
    #   return result if row > 7
    #   if direction == :bottom || direction == :all
    #     result << [row, col]
    #     result << [row + 1, col] if first_move?
    #   end
    #   col -= 1
    #   if direction == :bottom_left || direction == :all
    #     result << [row, col] unless col < 0
    #   end
    #   col += 2
    #   if direction == :bottom_right || direction == :all
    #     result << [row, col] unless col > 7
    #   end
    #   result.delete_if(&:empty?)
    # end

    # def white_moves(direction)
    #   row, col = @position
    #   row -= 1
    #   result = []
    #   return [] if row < 0
    #   if direction == :top || direction == :all
    #     result << [row, col]
    #     result << [row + - 1, col] if first_move?
    #   end
    #   col -= 1
    #   if direction == :top_left || direction == :all
    #     result << [row, col] unless col < 0
    #   end
    #   col += 2
    #   if direction == :top_right || direction == :all
    #     result << [row, col] unless col > 7
    #   end
    #   result.delete_if(&:empty?)
    # end
  end
end
