module Poker
  module Ranks
    module ThreeOfAKind
      extend self

      def value
        RANK_VALUES[:three_of_a_kind]
      end

      def match?(cards)
        @repeated_value = Ranks.find_repeating_values(cards, 3)
        return false unless @repeated_value
        @cards = cards.select { |c| c.value != repeated_value }
      end

      def high_cards
        Rank.high_cards(@cards).unshift(@repeated_value)
      end
    end
  end
end