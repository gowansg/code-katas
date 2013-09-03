module Poker
  module Ranks
    module HighCard
      extend self

      def match?(cards)
        @cards = cards
        true
      end

      def value
        RANK_VALUES[:high_card]
      end

      def high_cards
        Ranks.high_cards(@cards)
      end
    end
  end
end