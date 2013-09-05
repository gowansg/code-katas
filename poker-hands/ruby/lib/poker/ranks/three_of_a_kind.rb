module Poker
  module Ranks
    module ThreeOfAKind
      extend self

      def value
        RANK_VALUES[:three_of_a_kind]
      end

      def match?(cards)
        index = Ranks.find_repeating_values(cards.collect { |c| c.value }, 3)
        return false unless index
        @repeated_value = cards[index].value
        @cards = cards.select { |c| c.value != @repeated_value }
      end

      def high_cards
        Ranks.high_cards(@cards).unshift(@repeated_value)
      end
    end
  end
end