module Poker
  class Game

    def self.simulate(&block)
      sim = Simulation.new(&block)
      winner = sim.winner
      if winner  
        declare_winner(winner)
      else
        declare_tie
      end
    end

    private 

    def self.declare_winner(winner)
      rank = winner.hand.rank
      rank_name = rank.kind
                      .to_s
                      .split("::")
                      .last
                      .split(/(?=[A-Z])/)
                      .join(" ")
                      .downcase

      card_name = winner.high_card.to_s.split("of").first.capitalize.strip
      formmatted_hand = "#{rank_name}" + \
                        "#{": " + card_name if rank.kind == Ranks::HighCard}"

      "#{winner.name} wins. - with #{formmatted_hand}"
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
        players = sim.collect { |k, v| Player.new(k, Hand.new(@deck.deal(v))) }
        #sort is ascending so reverse to get players in order
        results = players.sort_by { |p| p.hand }.reverse 
        return nil if tied?(results)

        winner = results.first
        card = results.length < 2 || winner.hand.rank == results[1].hand.rank ? 
                 winner.cards.first :
                 find_high_card(results)  

        winner.define_singleton_method(:high_card) { card }
        winner
      end

      def tied?(sim_results)
        return false if sim_results.length < 2
        hands = highest_two_hands(sim_results)
        (hands[0] <=> hands[1]) == 0
      end

      def find_high_card(sim_results)
        hands = highest_two_hands(sim_results)
        hands[0].cards.zip(hands[1].cards).find { |i| i[0] > i[1] }[0]
      end

      def highest_two_hands(sim_results)
        sim_results.slice(-2, 2).collect { |p| p.hand }
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