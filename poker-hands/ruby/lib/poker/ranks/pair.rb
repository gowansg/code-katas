module Poker
  module Ranks
    module Pair
      extend self
      
      attr_reader :card_value

      def value
        RANK_VALUES[:pair]
      end

      def match?(cards)
        index = Ranks.find_repeating_values(cards.collect { |c| c.value }, 2)
        return false unless index
        @card_value = cards[index].value
        @cards = cards.select { |c| c.value != @card_value }
        true
      end

      def high_cards
        Ranks.high_cards(@cards).unshift(@card_value)
      end
    end
  end
end