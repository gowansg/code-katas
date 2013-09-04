module Poker
  module Ranks
    module Pair
      extend self

      attr_reader :card_value

      def value
        RANK_VALUES[:pair]
      end

      def match?(cards)
        @cards = cards
        @card_value = nil
        cards.each_index do |i| 
          if cards.length - 1 != i && cards[i].value == cards[i + 1].value
            @card_value = cards[i].value
            @cards = cards.select { |c| c.value != @card_value } #remove the pair
            break #stop at the first pair
          end
        end
        !@card_value.nil?
      end

      def high_cards
        Ranks.high_cards(@cards).unshift(@card_value)
      end
    end
  end
end