require_relative 'rook'
require_relative 'bishop'
module Chess
  # Represents a queen in chess
  class Queen < ChessPiece

    def initialize(color, position)
      super(color, position)
      @name = :queen
    end

    def moves(direction = :all)
      if direction == :all
        Rook.new(@color, @position).moves(direction) +
          Bishop.new(@color, @position).moves(direction)
      elsif Rook.directions.include?(direction)
        Rook.new(@color, @position).moves(direction)
      else
        Bishop.new(@color, @position).moves(direction)
      end
    end

    # all directions this piece can move in
    def self.directions
      Rook.new(@color, @position).directions +
        Bishop.new(@color, @position).directions
    end

    def directions
      Queen.directions
    end

    def  to_s
      case @color
      when :black then '♛'
      when :white then '♕'
      end
    end
  end
end
