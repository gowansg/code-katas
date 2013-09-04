module Poker
  module Ranks
    module TwoPairs
      extend self

      def value
        RANK_VALUES[:two_pairs]
      end

      def match?(cards)
        @cards = cards
        @two_pairs = []
        2.times do
          return false unless Pair.match?(@cards)
          @two_pairs << Pair.card_value
          @cards = cards.select { |c| !@two_pairs.include?(c.value) }
        end
        @two_pairs.length == 2
      end

      def high_cards
        Ranks.high_cards(@cards).unshift(@two_pairs.min).unshift(@two_pairs.max)
      end
    end
  end
end