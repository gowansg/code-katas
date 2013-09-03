module Poker
  module Ranks
    module TwoPairs
      extend self

      def match?(cards)
      end

      def value
        RANK_VALUES[:two_pairs]
      end

      def high_cards
        Ranks.high_cards(@cards)
      end
    end
  end
end