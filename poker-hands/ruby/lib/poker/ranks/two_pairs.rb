module Poker
  module Ranks
    module TwoPairs
      extend self

      def value
        RANK_VALUES[:two_pairs]
      end

      def match?(cards)
        @cards = cards
        2.times do
          card_value = Pair.match?(@cards)
          return false unless card_value
          @cards = @cards.select { |c| c.value != card_value }
        end
      end
    end
  end
end