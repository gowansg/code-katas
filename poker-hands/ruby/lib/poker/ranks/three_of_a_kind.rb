module Poker
  module Ranks
    module ThreeOfAKind
      extend self

      def value
        RANK_VALUES[:three_of_a_kind]
      end

      def match?(cards)
        cards.collect { |c| c.value }.dups_in_a_row?(3)
      end
    end
  end
end