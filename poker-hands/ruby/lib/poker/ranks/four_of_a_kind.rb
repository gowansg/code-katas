module Poker
  module Ranks
    module FourOfAKind
      extend self

      def value
        RANK_VALUES[:four_of_a_kind]
      end

      def match?(cards)
        cards.collect { |c| c.value }.dups_in_a_row?(4)
      end
    end
  end
end