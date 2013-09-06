module Poker
  module Ranks
    module Pair
      extend self

      def value
        RANK_VALUES[:pair]
      end

      def match?(cards)
        cards.collect { |c| c.value }.dups_in_a_row?(2)
      end
    end
  end
end