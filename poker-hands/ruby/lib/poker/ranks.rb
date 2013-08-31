module Poker
  module Ranks
    RANK_VALUES = { 
      high_card: 1,
      pair: 2, 
      two_pairs: 3, 
      three_of_a_kind: 4,
      straight: 5,
      flush: 6,
      full_house: 7,
      four_of_a_kind: 8,
      straight_flush: 9 
    }

    module HighCard
      extend self

      def match?(hand)
        false
      end

      def value
        RANK_VALUES[:high_card]
      end

      def high_card

      end
    end

    module Pair
      extend self

      def match?(hand)
        true
      end

      def value
        RANK_VALUES[:pair]
      end

      def high_card

      end
    end
  end
end