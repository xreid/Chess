module Chess
  # A player for a chess game. A player has a name and a color
  class Player
    attr_accessor :name, :color

    def initialize(name, color)
      @name = name
      @color = color
    end

    def to_s
      @name.to_s
    end

    def enemy_color
      case @color
      when :black then :white
      when :white then :black
      end
    end

  end
end
