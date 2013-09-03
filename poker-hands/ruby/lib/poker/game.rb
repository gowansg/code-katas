module Poker
  class Game
    def self.simulate(&block)
      instance_eval &block if block_given?
    end

    def players(players = [])
      @players = players
    end

    def declare_winner
      "#{winner} wins. - with #{hand}"
    end 
  end
end