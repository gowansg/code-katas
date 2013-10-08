module Poker
  class Game

    def self.simulate(&block)
      sim = Simulation.new(&block)
      winner = sim.winner
      if winner  
        declare_winner(winner[0], winner[1])
      else
        declare_tie
      end
    end
    
    private 

    def self.declare_winner(name, hand)
      "#{name} wins. - with #{hand}"
    end

    def self.declare_tie
      "Tie."
    end

    class Simulation
      include Parser

      attr_writer :num_of_players, :hand_size, :scenario

      def initialize(&block)
        instance_eval(&block)
        @deck = Deck.new
      end

      def winner
        sim = read(scenario)
        sim.keys.each { |k| sim[k] = Hand.new(@deck.deal(sim[k])) }
        sim.sort_by { |player, hand| hand }.last
      end

      def num_of_players(amount = nil)
        return @num_of_players unless amount
        self.num_of_players = amount
      end

      def hand_size(size=nil)
        return @hand_size unless size
        self.hand_size = size
      end      

      def scenario(info = nil)
        return @scenario unless info
        self.scenario = info
      end
    end
  end
end