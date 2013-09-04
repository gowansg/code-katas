module Poker
  module Ranks
    module ThreeOfAKind
      extend self

      def value
        RANKS[:three_of_a_kind]
      end

      def match?(cards)
        false
      end

      def high_cards
        Rank.high_cards(@cards)
      end
    end
  end
end