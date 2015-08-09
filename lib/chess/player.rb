module Chess
  # A player for a chess game. A player has a name and a color
  class Player
    attr_accessor :name, :color

    def initialize(name, color)
      @name = name
      @color = color
    end
  end
end