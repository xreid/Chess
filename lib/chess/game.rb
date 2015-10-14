require_relative 'board'
require_relative 'player'
module Chess
  class Game
    attr_accessor :board, :players, :turn, :resign, :save, :game_mode
    MAP = { a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7 }

    def initialize(players = nil)
      @board = Board.new
      @turn  = 0
      @resign = false
      @save = false
    end

    def play
      welcome
      @players = get_players
      puts @board
      until @board.check_mate? || slayed_king? || @resign || @save
        player = @players[@turn % 2]
        if player.is_a? AIPlayer
          @board.ai_move(@players[0], @players[1])
        else
          prompt(player)
          get_response(player)
        end
        puts @board
        puts 'Check!' if @board.checked?
        @turn += 1
      end
      if @board.check_mate? || slayed_king?
        winner = @board.winner.color
        player = winner == players[0].color ? players[0] : players[1]
        goodbye(player)
      elsif @resign
        winner = players[turn % 2]
        goodbye(winner)
      elsif @save
      end
    end

    private

    def welcome
      puts "\n"
      puts "CHESS".center(40)
      puts "\nenter two squares separated by a"
      puts "space to move (e.g.'a2 a4' to move the"
      puts "left most white pawn forward two squares)"
      puts "\nR to resign\n"
      printf "1 or 2 players? "
    end

    def goodbye(player)
      puts "Game Over!\n#{player.name} Wins!"
    end

    def get_players
      # TODO only accept ints
      @game_mode = gets.chomp.to_i
      printf "\nPlayer 1 name: "
      p1_name = gets.chomp.downcase
      p1 = Player.new(p1_name, :white)
      if @game_mode == 1
        p2_name = 'ai_player'
        p2 = AIPlayer.new(p2_name, :black)
      else
        printf 'Player 2 name: '
        p2_name = gets.chomp.downcase
        p2 = Player.new(p2_name, :black)
      end
      [p1, p2]
    end

    def prompt(player)
      printf "#{player}, make a move.\n>"
    end

    def get_response(player)
      begin
        response = gets.chomp.downcase
        return @resign = true if response == 'r'
        return @save   = true if response == 's'
        fail InvalidInputError unless response =~ /^[a-h][1-8] [a-h][1-8]$/
        response = route(response)
        @board.move!(response[0], response[1], player)
      rescue StandardError => error
        puts @board
        puts error.message
        retry
      end
    end

    def route(coordinates)
      position_1, position_2 = coordinates.split
      position_1 = position_1.split('')
      position_2 = position_2.split('')
      position_1[0] = MAP[position_1[0].downcase.to_sym]
      position_1[1] = 8 - position_1[1].to_i
      position_1[0], position_1[1] = position_1[1], position_1[0]
      position_2[0] = MAP[position_2[0].downcase.to_sym]
      position_2[1] = 8 - position_2[1].to_i
      position_2[0], position_2[1] = position_2[1], position_2[0]
      [position_1, position_2]
    end

    def slayed_king?
      return :white if @board.pieces['black_king'].nil?
      return :black if @board.pieces['white_king'].nil?
      false
    end
  end
end
