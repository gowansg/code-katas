module Poker
  module Ranks
    module FullHouse
      extend self

      def value
        RANK_VALUES[:full_house]
      end

      def match?(cards)
        card_value = ThreeOfAKind.match?(cards)
        return false unless card_value
        @cards = cards.select { |c| c.value != card_value }
        Pair.match?(@cards)
      end
    end
  end
end