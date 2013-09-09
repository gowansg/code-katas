module Poker
  module Ranks
    module Straight
      extend self

      def value
        RANK_VALUES[:straight]
      end

      def match?(cards)
        cards.each_index do |i|
          match = true if i == cards.length - 2
          match = false unless cards[i].value - cards[i+1].value == 1
        end

        if match == false && cards[i] == 14
          @cards = 
        end
      end
    end
  end
end