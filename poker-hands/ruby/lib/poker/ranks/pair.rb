module Poker
  module Ranks
    module Pair
      extend self

      def value
        RANK_VALUES[:pair]
      end

      def match?(cards)
        Ranks.find_repeating_values(cards.collect { |c| c.value }, 2)
      end
    end
  end
end